#!/usr/bin/env python

"""The setup script."""

from typing import List

from setuptools import find_packages, setup

with open("README.md", "r") as fh:
    long_description = fh.read()

requirements: List[str] = [
    "taperable-helix",
]

setup_requirements: List[str] = [
    "pytest-runner",
]

test_requirements: List[str] = [
    "pytest>=3.7",
]


setup(
    name="helical_thread",
    version="0.1.0",
    url="https://github.com/winksaville/py-helical-thread",
    license="MIT",
    author="Wink Saville",
    author_email="wink@saville.com",
    description="Creates a helical thread",
    python_requires=">=3.7",
    platforms=["any"],
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
    # entry_points={"console_scripts": ["helicalthread=helical_thread.command_line:main"],},
    long_description=long_description,
    long_description_content_type="text/markdown",
    packages=find_packages(),
    install_requires=requirements,
    setup_requires=setup_requirements,
    platform="any",
    tests_require=test_requirements,
    test_suite="tests",
)
