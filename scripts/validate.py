#!/usr/bin/env python3
"""Smoke test exported CAD solids. NOT a strength / mechanical safety proof."""
import sys
from pathlib import Path
import trimesh
OUT=Path(__file__).resolve().parents[1]/"output"
BOUNDS={"mount_left":(210,100),"join_clip":(70,50),
"integrated_root":(235,165),"integrated_mid":(225,125),
"integrated_tip":(225,125),"metal_base_right":(235,165),
"metal_socket_cap":(105,65),"fit_coupon":(110,30)}
def validate():
    issues=[]
    for name,(mx,my) in BOUNDS.items():
        p=OUT/(name+".stl")
        if not p.exists(): issues.append("Missing "+p.name); continue
        m=trimesh.load_mesh(p,force="mesh")
        x,y,z=map(float,m.extents)
        print(f"{name:22} {x:7.2f} x {y:7.2f} x {z:6.2f} mm; watertight={m.is_watertight}; V={m.volume/1000:.1f} cm3")
        if not m.is_watertight or not m.is_winding_consistent or m.volume<=0: issues.append(name+" invalid solid")
        if x>mx or y>my or z>40: issues.append(name+f" exceeds assumed printer envelope: {(x,y,z)}")
    if issues:
        print("FAILED: "+"; ".join(issues),file=sys.stderr)
        return 1
    print("PASS: basic mesh geometry and export dimensions (not physical fit).")
    return 0
if __name__=="__main__": sys.exit(validate())
