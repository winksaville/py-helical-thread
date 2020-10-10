#!/usr/bin/env python3

import plotly.graph_objs as go
from typing import List
from numpy import linspace

from helical_thread import HelicalThread, ThreadHelixes, helical_thread
from taperable_helix import HelixLocation


def threadHelixes() -> ThreadHelixes:

    # Define a helical thread
    ht = HelicalThread(
        height=10,
        pitch=1,
        radius=8 / 2,
        angle_degs=45,
        inset_offset=1,
        ext_clearance=0.1,
        taper_out_rpos=0.03,
        taper_in_rpos=0.97,
        major_cutoff=0,
        minor_cutoff=0,
        thread_overlap=0.001,
    )

    # Create the helixes
    ths: ThreadHelixes = helical_thread(ht)

    return ths

def show(ths: ThreadHelixes, helix_locations: List[HelixLocation]) -> None:
    # Create a plotly figure
    fig = go.Figure(
        # layout_title_text="Helical Triangle",
        layout_scene_camera_projection_type="orthographic",
    )

    # Loop through and add a trace for each thread
    for i, hl in enumerate(helix_locations):
        f = ths.ht.helix(hl)
        points = list(
            map(f, linspace(ths.ht.first_t, ths.ht.last_t, num=500, dtype=float))
        )

        fig.add_trace(
            go.Scatter3d(
                # Extract x, y, z
                x=[x for x, _, _ in points],
                y=[y for _, y, _ in points],
                z=[z for _, _, z in points],
                mode="lines",
                name=f"helix{i}",
            )
        )

    # Show the figure
    fig.show()


if __name__ == "__main__":
    ths: ThreadHelixes = threadHelixes()
    show(ths, ths.int_helixes)
