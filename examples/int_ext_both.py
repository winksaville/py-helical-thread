#!/usr/bin/env python3

from sys import argv
from typing import List

import plotly.graph_objs as go
from numpy import linspace
from parameters import Parameters
from taperable_helix import HelixLocation

from helical_thread import ThreadHelixes, helical_thread


def add_traces(
    name: str,
    fig: go.Figure,
    ths: ThreadHelixes,
    helix_locations: List[HelixLocation],
    vert_offset: float = 0,
) -> None:

    # Loop through and add a trace for each thread
    for i, hl in enumerate(helix_locations):
        f = ths.ht.helix(hl)
        points = list(
            map(f, linspace(ths.ht.first_t, ths.ht.last_t, num=500, dtype=float))
        )

        if vert_offset != 0:
            points = [(x, y, z + vert_offset) for x, y, z in points]

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

    if (params.int_ext_both == "int") or (params.int_ext_both == "both"):
        add_traces("int", fig, ths, ths.int_helixes)

    if (params.int_ext_both == "ext") or (params.int_ext_both == "both"):
        # When doing set the vert_offset to pitch / s so we see the thread alignment
        vert_offset = ths.ht.pitch / 2 if params.int_ext_both == "both" else 0
        add_traces("ext", fig, ths, ths.ext_helixes, vert_offset)

    fig.show()

    if params.write:
        try:
            fname = "data/int_ext_both.webp"
            fig.write_image(fname)
            print(f"wrote: {fname}")
        except Exception as e:
            print(f"Unable to write files; maybe run from project root: e={e}")
