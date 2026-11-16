"""Regression tests: owner measurements and mechanical constraints."""
import re
from pathlib import Path
SCAD=(Path(__file__).resolve().parents[1]/"cad"/"keytar.scad").read_text()
def val(key):
    m=re.search(r"(?:^|;)\s*"+re.escape(key)+r"\s*=\s*([^;]+);",SCAD,re.M)
    assert m, "Missing "+key
    return m.group(1).strip()
def test_owner_coordinates():
    assert [int(val(k)) for k in ("keyboard_x","keyboard_y","keyboard_z")]==[355,221,50]
    assert val("mount_top")=="[[23,117],[125,117],[225,117],[310,117]]"
    assert val("mount_bottom")=="[[25,162],[126,162],[225,162],[311,162]]"
def test_anchors_outside_keyboard():
    d=float(val("strap_slot_w"))
    assert float(val("strap_rear_x"))+d/2<0
    assert float(val("strap_front_x"))-d/2>355
    assert 20<=float(val("strap_slot_length"))<=30
    assert "rear_horn();" in SCAD and "front_horn();" in SCAD
def test_socket_and_joint_safety_invariants():
    assert (float(val("socket_wall"))-float(val("lap_hole_d")))/2>=2
    assert 5<=int(val("socket_stop_t"))<int(val("socket_len"))
    assert int(val("first_joint"))<int(val("second_joint"))
    assert int(val("joint_lap"))>=15
    assert int(val("seam_x"))==170
def test_modes():
    for option in ("mount_left","integrated_root","integrated_mid","integrated_tip",
                   "metal_base_right","metal_socket_cap","assembly_integrated","assembly_metal"):
        assert 'mode=="'+option+'"' in SCAD
