.. highlight:: shell

============
Contributing
============

Contributions are welcome, and they are greatly appreciated! Every little bit
helps, and credit will always be given.

You can contribute in many ways:

Types of Contributions
----------------------

Report Bugs
~~~~~~~~~~~

Report bugs at `helixal-thread issues`_

If you are reporting a bug, please include:

* Your operating system name and version.
* Any details about your local setup that might be helpful in troubleshooting.
* Detailed steps to reproduce the bug.

Fix Bugs
~~~~~~~~

Look through the GitHub issues for bugs. Anything tagged with "bug" and "help
wanted" is open to whoever wants to implement it.

Implement Features
~~~~~~~~~~~~~~~~~~

Look through the GitHub issues for features. Anything tagged with "enhancement"
and "help wanted" is open to whoever wants to implement it.

Write Documentation
~~~~~~~~~~~~~~~~~~~

helical_thread could always use more documentation, whether as part of the
official helical_thread docs, in docstrings, or even on the web in blog posts,
articles, and such.

Submit Feedback
~~~~~~~~~~~~~~~

The best way to send feedback is to file an issue at `helixal-thread issues`_

If you are proposing a feature:

* Explain in detail how it would work.
* Keep the scope as narrow as possible, to make it easier to implement.
* Remember that this is a volunteer-driven project, and that contributions
  are welcome :)

Get Started!
------------

Ready to contribute? Here's how to set up `helixal-thread`_ for local development.

1. Fork the `helical_thread` repo on GitHub.
2. Clone your fork locally:

.. prompt:: bash

    git clone git@github.com:your_name_here/helical_thread.git

3. Instantiate an (virtual) enviorment which supports python3.7,
   isort, black, flake8 and bump2version. Using `make install-dev` will
   install appropriate development dependencies:

.. prompt:: bash

    <instantiate your virtual environment if necessary>
    cd helical_thread/
    make install-dev

4. Create a branch for local development:

.. prompt:: bash

    git checkout -b name-of-your-bugfix-or-feature

   Now you can make your changes locally.

5. When you're done making changes, check that your changes are formantted
   correctly and pass the tests:

.. prompt:: bash

    make format
    make test

6. Commit your changes and push your branch to GitHub:

.. prompt:: bash

    git add .
    git commit -m "Your detailed description of your changes."
    git push origin name-of-your-bugfix-or-feature

7. Submit a pull request through the GitHub website.

Pull Request Guidelines
-----------------------

Before you submit a pull request, check that it meets these guidelines:

1. The pull request should include tests.
2. If the pull request adds functionality, the docs should be updated. Put
   your new functionality into a function with a docstring, and add the
   feature to the list in README.rst.
3. The pull request should work for Python 3.7 and 3.8.


Deploying
---------

A reminder for the maintainers on how to deploy.
Make sure all your changes are committed.
Then run and validate that `test.pypi.org`_
is good:

.. prompt:: bash

    bump2version patch # possible: major / minor / patch
    git push
    make push-tags
    make release-testpypi


Finally, assuming `test.pypi.org`_ is good, push to pypi.org_:

.. prompt:: bash

    make release

.. _helixal-thread: https://github.com/winksaville/py-helixal-thread.git
.. _helixal-thread issues: https://github.com/winksaville/py-helixal-thread/issues
.. _test.pypi.org: https://test.pypi.org/project/helical-thread/
.. _pypi.org: https://test.pypi.org/project/helical-thread/
