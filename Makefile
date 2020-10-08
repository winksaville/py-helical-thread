# Simple Makefile for this package
#
# My test.pypi.org and pypi.org API tokens are stored in 1Password in TestPyPi-token
# and PyPi-token respectively.  When making 'release' or 'release-test' set username
# to __token__ and then get and paste the token from 1Password.

# Script which automatically create the help test from '##' comments after a target
define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

# List of files that are "built" and copied to dist/
SRCS= \
 Makefile \
 README.md \
 LICENSE \
 setup.py \
 helical_thread/__init__.py \
 helical_thread/command_line.py \
 helical_thread/hello.py \
 tests/__init__.py \
 tests/test_helical_thread.py

#format_srcs=setup.py helical_thread/ tests/ examples/
format_srcs=setup.py helical_thread/ tests/

# Default target
.PHONY: help
help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)


.PHONY: build
build: build/completed_ts ## Build the distribution

build/completed_time_stamp: ${SRCS}
	python3 setup.py sdist bdist_wheel
	touch build/completed_time_stamp

.PHONY: release
release: build/completed_ts ## Upload a release to pypi.org
	python3 -m twine upload dist/*

.PHONY: release-test
release-test: build/completed_ts ## Upload a releas to test.pypi.org
	python3 -m twine upload --repository-url https://test.pypi.org/legacy/ dist/*

.PHONY: f, format
f: format ## format, lint py files with isort, black and flake8
format: ## format, lint py files with isort, black and flake8
	isort ${format_srcs}
	black ${format_srcs}
	flake8 ${format_srcs}

.PHONY: mypy
mypy: ## Run mpy on sources
	mypy ${format_srcs}

.PHONY: coverage
coverage: ## check code coverage quickly with the default Python
	coverage run --source helical_thread -m pytest
	coverage report -m
	# coverage html
	# $(BROWSER) htmlcov/index.html

.PHONY: push-tags
push-tags: ## Push tags to github creates "Releases & Tags" and zipped srcs
	git push --tags

.PHONY: bumpver-patch
bumpver-patch: ## Bump patch field of current_version
	bump2version patch

.PHONY: bumpver-minor
bumpver-minor: ## Bump minor field of current_version
	bump2version minor

.PHONY: bumpver-major
bumpver-major: ## Bump major field of current_version
	bump2version major

.PHONY: test, t
t: test
test: ## Test
	pytest tests

.PHONY: test-all
test-all: ## Run tests on every Python version with tox
	tox

.PHONY: install-dev
install-dev: ## Developement install in editable mode
	#pip install -e .
	pip install -e . -r dev-requirements.txt

# Update dependencies, used by update
# Note: You can not use --generate-hashes parameter with editable installs
.PHONY: update-deps
update-deps:
	# No requirements in setup.py so skip
	# pip-compile --upgrade --allow-unsafe --output-file requirments.txt
	# pip install --upgrade -r requirements.txt
	pip-compile --upgrade --allow-unsafe --output-file dev-requirements.txt dev-requirements.in
	pip install --upgrade -r dev-requirements.txt

# Besure pip-tools is installed, used by update
.PHONY: update-init
update-init:
	pip install pip-tools

# Invoke update when you want to update the dev-requirments.
# See: https://stackoverflow.com/a/33685899
#
.PHONY: update-dev
update-dev: clean update-init update-deps install-dev ## Update dev-requirements

.PHONY: clean
clean:
	rm -f .coverage
	rm -rf .tox/
	rm -rf build dist helical_thread.egg-info ./helical_thread/__pycache__ ./tests/__pycache__
	rm -rf .mypy_cache .pytest_cache
