.. highlight:: shell

============
Installation
============


Stable release
--------------

To install helical-thread, run this command in your terminal:

.. prompt:: bash

   pip install helical-thread

This is the preferred method to install helical-thread, as it will always
installs the most recent stable release.

If you don't have `pip`_ installed, this `Python installation guide`_ can guide
you through the process.

Test release from testpypi
--------------------------

To install helical-thread from testpypi, run this command in your terminal:

.. prompt:: bash

   pip install --index-url https://test.pypi.org/simple/ helical-thread

From sources
------------

The sources for helical_thread can be downloaded from the `Github repo`_.

  You can either clone the public repository:

.. prompt:: bash

   git clone git://github.com/winksaville/py-helical-thread helical-thread
   cd helical-thread

Or download the tarball
  
.. prompt:: bash
   :substitutions:
  
   curl -OJL https://github.com/winksaville/py-helical-thread/releases/v|ver|.tar.gz

Once you have a copy of the source, you can install it with:

.. prompt:: bash

   python setup.py install

Or if you want to install in editable mode for development:

.. prompt:: bash

   make install-dev

.. prompt:: bash

   pip install -e . -r dev-requirements.txt

Uninstall
---------

.. prompt:: bash

   pip uninstall helical-thread


.. _Github repo: https://github.com/winksaville/helical_thread
.. _pip: https://pip.pypa.io
.. _Python installation guide: http://docs.python-guide.org/en/latest/starting/installation/
