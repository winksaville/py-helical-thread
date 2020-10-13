# Simple Makefile for this package
#
# My test.pypi.org and pypi.org API tokens are stored in 1Password in TestPyPi-token
# and PyPi-token respectively.  When making 'release' or 'release-test' set username
# to __token__ and then get and paste the token from 1Password.

define BROWSER_PYSCRIPT
import os, webbrowser, sys

from urllib.request import pathname2url

webbrowser.open("file://" + pathname2url(os.path.abspath(sys.argv[1])))
endef
export BROWSER_PYSCRIPT

BROWSER := python -c "$$BROWSER_PYSCRIPT"

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

format_srcs=setup.py helical_thread/ tests/ examples/

# Default target
.PHONY: help
help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)


.PHONY: dist
dist: clean docs ## builds source and wheel package
	python setup.py sdist
	python setup.py bdist_wheel
	ls -l dist

.PHONY: install
install: clean-no-docs ## Install from pypi.org
	pip install helical-thread

.PHONY: install-test
install-test: clean ## Install from test.pypi.org
	pip install taperable-helix

.PHONY: install-dev
install-dev: ## Install from the sources for developemeent
	#pip install -e .
	pip install -e . -r dev-requirements.txt

.PHONY: release
release: dist ## Upload a release to pypi.org
	python3 -m twine upload dist/*

.PHONY: release-test
release-test: dist ## Upload a release to test.pypi.org
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

.PHONY: clean-docs
clean-docs: ## remove doc artifacts
	$(MAKE) -C docs clean

# Currently not used
.PHONY: apidocs
apidocs:
	rm -f docs/helical_thread.rst
	rm -f docs/modules.rst
	sphinx-apidoc -o docs/ helical_thread

.PHONY: docs
docs: clean-docs ## generate Sphinx HTML documentation, including API docs
	$(MAKE) -C docs html

.PHONY: showdocs
showdocs: ## Use the browser to show the docs
	$(BROWSER) docs/_build/html/index.html

.PHONY: servedocs
servedocs: docs ## compile the docs watching for changes
	watchmedo shell-command -p '*.rst' -c '$(MAKE) -C docs html' -R -D .

.PHONY: push-with-tags
push-with-tags: ## Push origin master with tags with zipped srcs on github
	git push origin main --tags

.PHONY: bumpver-patch
bumpver-patch: ## Bump patch field of current_version
	bump2version patch

.PHONY: bumpver-minor
bumpver-minor: ## Bump minor field of current_version
	bump2version minor

.PHONY: bumpver-major
bumpver-major: ## Bump major field of current_version
	bump2version major

.PHONY: clean-test
clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache
	find . -name '.mypy_cache' -exec rm -fr {} +

.PHONY: test, t
t: test
test: ## Test
	pytest tests

.PHONY: test-all
test-all: ## Run tests on every Python version with tox
	tox

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

.PHONY: clean-no-docs
clean-no-docs: clean-test
	rm -rf build dist helical_thread.egg-info ./helical_thread/__pycache__ ./tests/__pycache__
	rm -rf .mypy_cache .pytest_cache

.PHONY: clean
clean: clean-no-docs clean-docs
