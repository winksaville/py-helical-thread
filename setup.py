#!/usr/bin/env python

"""The setup script."""

from typing import List

from setuptools import find_packages, setup

with open("README.md", "r") as fh:
    long_description = fh.read()

requirements: List[str] = [
    "markdown",
]

setup_requirements: List[str] = [
    "pytest-runner",
]

test_requirements: List[str] = [
    "pytest>=3.7",
]


setup(
    author="Wink Saville",
    author_email="wink@saville.com",
    python_requires=">=3.7",
    classifiers=[
        "Development Status :: 2 - Pre-Alpha",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Natural Language :: English",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
    ],
    keywords="helical helix thread",
    name="helical-thread",  # Replace with your own username
    # entry_points={"console_scripts": ["helicalthread=helical_thread.command_line:main"],},
    version="0.1.0",
    license="MIT",
    description="Creates a helical thread",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/winksaville/helical-thread",
    packages=find_packages(),
    install_requires=requirements,
    setup_requires=setup_requirements,
    tests_require=test_requirements,
    test_suite="tests",
)
