"""Owner's measurements, neck-free requirement and CAD source regression checks."""
from pathlib import Path
import re
SCAD = (Path(__file__).resolve().parents[1] / 'cad/keytar.scad').read_text()

def param(key):
    found = re.search(r'(?m)(?:^|;)\s*' + re.escape(key) + r'=([^;]+);', SCAD)
    assert found, f'No existe el parámetro {key}'
    return found.group(1).strip()

def test_user_measured_dimensions_and_screws():
    assert param('keyboard_x') == '355'
    assert param('keyboard_y') == '221'
    assert param('mount_top') == '[[23,117],[125,117],[225,117],[310,117]]'
    assert param('mount_bottom') == '[[25,162],[126,162],[225,162],[311,162]]'

def test_estimated_screws_disabled():
    assert param('use_unverified_large_holes') == 'false'
    assert param('large_top') == '[[11,8],[125,10],[238,12],[345,9]]'
    assert param('large_middle') == '[[12,110],[238,109],[346,112]]'
    assert param('large_bottom') == '[[10,213],[124,216],[237,215],[348,212]]'

def test_neck_is_not_present_even_as_illustration():
    assert 'neck_prism' not in SCAD
    assert 'neck_piece' not in SCAD
    assert 'wood_visual_segment' not in SCAD
    assert 'integrated_root' not in SCAD
    assert 'mode=="assembly_socket"' in SCAD
    assert 'mode=="preview_socket"' in SCAD

def test_socket_50_by_31_and_bolts():
    assert param('wood_width') == '50'
    assert param('wood_thickness') == '31'
    assert float(param('wood_clearance')) == 0.6
    assert param('wood_socket_depth') == '70'
    assert param('wood_stop') == '7'
    assert param('wood_crossbolt_x') == '[27,50]'
    assert param('wood_crossbolt_d') == '5.5'
    assert 'socket_bolt_bores();' in SCAD
    assert 'socket_lid_pilots();' in SCAD
    assert 'socket_placed() socket_cradle()' in SCAD

def test_strap_button_not_slot_and_blind_pilot():
    assert param('strap_screw_length') == '25'
    assert param('strap_screw_nominal_d') == '3.5'
    assert float(param('strap_boss_h')) > float(param('strap_pilot_depth')) + 5
    assert float(param('strap_pilot_d')) < float(param('strap_screw_nominal_d'))
    assert 'strap_slot' not in SCAD
    assert 'boss_pilot(strap_rear_x,strap_rear_y)' in SCAD
    assert 'boss_pilot(strap_front_x,strap_front_y)' in SCAD

def test_clip_boss_insert_and_reduced_plate_footprint():
    assert param('rail_rows') == '[12,117,162,209]'
    assert float(param('join_boss_h')) >= 8
    assert float(param('join_pilot_depth')) <= float(param('join_boss_h'))
    assert 'join_insert_pilot' in SCAD
    assert param('plate_t') == '5.5'
