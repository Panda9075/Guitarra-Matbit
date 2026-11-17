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
def test_strap_button_bosses_are_blind():
    assert float(val("strap_screw_nominal_d"))==3.5
    assert float(val("strap_screw_length"))==25
    assert float(val("strap_boss_h"))>=float(val("strap_pilot_depth"))+5
    assert 2.0<float(val("strap_pilot_d"))<float(val("strap_screw_nominal_d"))
    assert float(val("strap_rear_x"))+float(val("strap_boss_d"))/2<0
    assert float(val("strap_front_x"))>355
    assert "strap_slot" not in SCAD
    assert "strap_pilot(strap_rear_x" in SCAD
    assert "strap_pilot(strap_front_x" in SCAD

def test_wood_socket_and_bolt_constraints():
    assert float(val("wood_width"))==50
    assert float(val("wood_thickness"))==31
    assert float(val("wood_clearance"))>=0.4
    assert float(val("wood_wall"))>=7
    assert int(val("wood_stop"))>=5
    assert int(val("wood_socket_depth"))>=60
    assert val("wood_crossbolt_x")=="[25,51]"
    assert float(val("wood_crossbolt_d"))>=5.2
    assert "crossbolt_bores();" in SCAD
    assert "wood_visual_segment();" in SCAD
    assert int(val("first_joint"))<int(val("second_joint"))
    assert int(val("joint_lap"))>=15

def test_modes():
    for mode in ("mount_left","integrated_root","integrated_mid","integrated_tip",
                 "wood_base_right","wood_socket_cap","wood_fit_coupon",
                 "assembly_integrated","assembly_wood","assembly_wood_visual"):
        assert 'mode=="'+mode+'"' in SCAD

def test_other_screw_groups_are_audited_not_drilled():
    assert val("use_unverified_large_holes")=="false"
    assert val("large_top")=="[[11,8],[125,10],[238,12],[345,9]]"
    assert val("large_middle")=="[[12,110],[238,109],[346,112]]"
    assert val("large_bottom")=="[[10,213],[124,216],[237,215],[348,212]]"
    assert float(val("large_hole_d"))>float(val("small_hole_d"))
    assert "large_mount_candidate_holes(left_large())" in SCAD
    assert "large_mount_candidate_holes(right_large())" in SCAD
    assert int(val("right_x1"))==354

def test_perimeter_support_rails_and_bridges():
    assert "for(y=[10,212])" in SCAD
    assert "for(y=[10,117,162,212])" in SCAD
