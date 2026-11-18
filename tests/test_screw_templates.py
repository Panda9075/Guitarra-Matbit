"""La plantilla de tornillos nunca debe diferir de las posiciones del CAD."""
import re
from pathlib import Path
from xml.etree import ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
SCAD = (ROOT / "cad/keytar.scad").read_text(encoding="utf-8")

def setting(name):
    m = re.search(r"(?:^|;)\s*" + re.escape(name) + r"\s*=\s*([^;]+);", SCAD, re.M)
    assert m, name
    return m.group(1).strip()

def points(name):
    return [(int(x), int(y)) for x, y in
            re.findall(r"\[(\d+),(\d+)\]", setting(name))]

def check_page(filename):
    root = ET.parse(ROOT / "docs" / filename).getroot()
    groups = {}
    for group in ["usuario", "foto-estimada"]:
        groups[group] = {(int(el.attrib["data-x"]), int(el.attrib["data-y"]))
                         for el in root.iter() if el.attrib.get("data-source") == group}
    return root, groups["usuario"], groups["foto-estimada"]

def test_photo_only_screws_not_drilled():
    assert setting("use_unverified_large_holes") == "false"

def test_a3_size_and_coordinates():
    root, measured, photo = check_page("plantilla_tornillos_A3.svg")
    assert root.attrib["width"] == "420mm" and root.attrib["height"] == "297mm"
    assert measured == set(points("mount_top") + points("mount_bottom"))
    assert photo == set(points("large_top") + points("large_middle") + points("large_bottom"))
    assert len(measured) == 8 and len(photo) == 11

def test_a4_overlap_and_same_points():
    left, lm, le = check_page("plantilla_tornillos_A4_izquierda.svg")
    right, rm, re_ = check_page("plantilla_tornillos_A4_derecha.svg")
    assert left.attrib["width"] == right.attrib["width"] == "210mm"
    assert left.attrib["height"] == right.attrib["height"] == "297mm"
    assert lm | rm == set(points("mount_top") + points("mount_bottom"))
    assert le | re_ == set(points("large_top") + points("large_middle") + points("large_bottom"))
    for page in [left, right]:
        assert sum(el.attrib.get("data-registration") is not None for el in page.iter()) == 6
