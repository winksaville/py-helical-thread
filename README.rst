==============
Helical Thread
==============

..
  TODO: eventually we'll enable the badges
  .. image:: https://img.shields.io/travis/winksaville/helical_thread.svg
          :target: https://travis-ci.com/winksaville/helical_thread

..
  .. image:: https://img.shields.io/pypi/v/helical_thread.svg
     :target: https://pypi.python.org/pypi/helical_thread

..
  .. image:: https://readthedocs.org/projects/helical-thread/badge/?version=latest
      :target: https://helical-thread.readthedocs.io/en/latest/?badge=latest
      :alt: Documentation Status

Create helical threads

* GitHub repo: https://github.com/winksaville/py-helical-thread/
* Documentation: https://helical-thread.readthedocs.io/
* PyPi package: https://pypi.org/project/helical-thread/
* Test PyPi package: https://test.pypi.org/project/helical-thread/
* Free software: MIT license
* Source: `helicalthread.py`_


Examples
--------

* `int_ext_both.py`_

.. code-block:: python

        def add_traces(
            name: str,
            fig: go.Figure,
            ths: ThreadHelixes,
            helix_locations: List[HelixLocation],
            vert_offset: float = 0,
        ) -> None:

            # Loop over each of the helexis adding a trace for each
            for i, hl in enumerate(helix_locations):
                # Create the helix funtion
                f = ths.ht.helix(hl)

                # Create a list of points using map to invoke "f"
                # over 500 points between first_t and last_t inclusive.
                points = list(
                    map(f, linspace(ths.ht.first_t, ths.ht.last_t, num=500, dtype=float))
                )

                # Check if we should offset the points
                if vert_offset != 0:
                    points = [(x, y, z + vert_offset) for x, y, z in points]

                # Add a trace decomposing points into three separate lists
                fig.add_trace(
                    go.Scatter3d(
                        # Extract x, y, z
                        x=[x for x, _, _ in points],
                        y=[y for _, y, _ in points],
                        z=[z for _, _, z in points],
                        mode="lines",
                        name=f"{name}{i}",
                    )
                )


        if __name__ == "__main__":
            params = Parameters(argv[1:])
            ths: ThreadHelixes = helical_thread(params.ht)

            # Create a plotly figure
            fig = go.Figure(
                # layout_title_text="Helical Triangle",
                layout_scene_camera_projection_type="orthographic",
            )

            # Add the traces for internal/external or both

            if (params.int_ext_both == "int") or (params.int_ext_both == "both"):
                add_traces("int", fig, ths, ths.int_helixes)

            if (params.int_ext_both == "ext") or (params.int_ext_both == "both"):
                # When doing set the vert_offset to pitch / s so we see the thread alignment
                vert_offset = ths.ht.pitch / 2 if params.int_ext_both == "both" else 0
                add_traces("ext", fig, ths, ths.ext_helixes, vert_offset)

            # Show the figure
            fig.show()

            if params.write:
                # Write the image is requested
                try:
                    fname = "data/int_ext_both.webp"
                    fig.write_image(fname)
                    print(f"wrote: {fname}")
                except Exception as e:
                    print(f"Unable to write files; maybe run from project root: e={e}")


.. image:: https://raw.githubusercontent.com/winksaville/py-helical-thread/main/data/int_ext_both.webp


Prerequisites
-------------

Using
#####

* python >= 3.7


Development and Examples
########################

See `dev-requirements.in`_ for most up to date list:

* pip-tools
* bump2version
* wheel
* isort
* black
* flake8
* tox
* tox-conda
* coverage
* Sphinx>=3.2
* sphinx_rtd_theme
* sphinx-autodoc-typehints
* sphinx-prompt
* sphinx_substitution_extensions>=2020.09.30, <2021.12.00
* taperable-helix
* twine
* pytest
* pytest-runner
* kaleido
* plotly
* psutil
* numpy
* pandas

.. _`helicalthread.py`: https://github.com/winksaville/py-helical-thread/blob/main/helical_thread/helicalthread.py
.. _`int_ext_both.py`: https://github.com/winksaville/py-helical-thread/blob/main/examples/int_ext_both.py
.. _`dev-requirements.in`: https://github.com/winksaville/py-helical-thread/blob/main/dev-requirements.in
