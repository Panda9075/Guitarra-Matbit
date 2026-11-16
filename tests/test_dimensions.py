import re
from pathlib import Path

SCAD=(Path(__file__).resolve().parents[1]/"cad"/"keytar.scad").read_text()
def value(key):
    m=re.search(r"^"+key+r"\s*=\s*(.*?);",SCAD,re.M)
    assert m, f"Missing {key}"
    return m.group(1)
def test_envelope():
    assert value("keyboard_x")=="355"
    assert value("keyboard_y")=="221"
    assert value("keyboard_z")=="50"
def test_owner_screw_pattern():
    assert value("mount_top")=="[[23,117],[125,117],[225,117],[310,117]]"
    assert value("mount_bottom")=="[[25,162],[126,162],[225,162],[311,162]]"
def test_parameters():
    for key in ("mount_hole_d","metal_bar_w","metal_bar_t","metal_clearance","neck_angle","socket_wall","first_joint","second_joint"):
        assert value(key)
def test_segment_joint_constraints():
    assert int(value("first_joint"))<int(value("second_joint"))
    assert int(value("joint_lap"))>=15
    assert int(value("seam_x"))==170
