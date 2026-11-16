#!/usr/bin/env python3
"""Check all generated STL solids. Not a proof of screw fit, fatigue or suspension."""
import sys
from pathlib import Path
import trimesh
OUT=Path(__file__).resolve().parents[1]/"output"
BOUNDS={"mount_left":(220,160),"join_clip":(60,40),
"integrated_root":(220,160),"integrated_mid":(220,80),
"integrated_tip":(220,80),"metal_base_right":(220,160),
"metal_socket_cap":(110,80),"fit_coupon":(110,40)}
ASSEMBLIES=("assembly_integrated","assembly_metal","assembly_metal_visual")
def validate():
    issues=[]
    for name in (*BOUNDS,*ASSEMBLIES):
        path=OUT/(name+".stl")
        if not path.exists(): issues.append("Missing "+path.name);continue
        m=trimesh.load_mesh(path,force="mesh")
        x,y,z=[float(v) for v in m.extents]
        print(f"{name:22} {x:6.1f} x {y:6.1f} x {z:5.1f} mm; closed={m.is_watertight}; volume={m.volume/1000:.1f} cm3")
        if not m.is_watertight or not m.is_winding_consistent or m.volume<=0:
            issues.append(name+" invalid mesh")
        if name in BOUNDS:
            limx,limy=BOUNDS[name]
            if x>limx+.05 or y>limy+.05 or z>40: issues.append(name+" exceeds 220mm bed assumptions")
        if name=="mount_left" and not m.bounds[0,0]<-39:issues.append("rear strap extension missing")
        if name in ("integrated_root","metal_base_right") and not m.bounds[1,0]>370:issues.append(name+" front strap extension missing")
    if issues:
        print("ERRORS:\n"+"\n".join(issues),file=sys.stderr);return 1
    print("PASS geometric checks; physical installation and strap loads are NOT validated.")
    return 0
if __name__=="__main__":sys.exit(validate())
