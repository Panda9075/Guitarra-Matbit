#!/usr/bin/env python3
"""Export 3D models and view renders from OpenSCAD. No mechanical safety guarantee."""
import argparse
from pathlib import Path
import shutil, subprocess, sys
ROOT=Path(__file__).resolve().parents[1]
SCAD=ROOT/"cad"/"keytar.scad"
OUT=ROOT/"output"
PARTS=("mount_left","join_clip","integrated_root","integrated_mid","integrated_tip","wood_base_right","wood_socket_cap","wood_fit_coupon","fit_coupon")
ASSEMBLIES=("assembly_integrated","assembly_wood","assembly_wood_visual")
EXTRA=("integrated_full_right",)
PREVIEWS=("preview_integrated","preview_wood")
ALL_STL=PARTS+ASSEMBLIES+EXTRA

def export(mode,path):
    if not shutil.which("openscad"):
        raise RuntimeError("OpenSCAD not installed")
    path.parent.mkdir(parents=True,exist_ok=True)
    cmd=["openscad","-o",str(path),"-D",'mode="'+mode+'"']
    if path.suffix==".png":
        cmd+=["--imgsize=1400,850","--viewall","--autocenter","--projection=ortho"]
        if shutil.which("xvfb-run"): cmd=["xvfb-run","-a"]+cmd
    cmd.append(str(SCAD))
    run=subprocess.run(cmd,text=True,capture_output=True)
    if run.returncode or not path.exists() or path.stat().st_size<100:
        raise RuntimeError(f"Export failed: {mode}\n{run.stderr}")
    print(f"{mode:24} -> {path.name} ({path.stat().st_size:,} bytes)",flush=True)

def main():
    p=argparse.ArgumentParser()
    p.add_argument("--all",action="store_true")
    p.add_argument("--preview",action="store_true")
    p.add_argument("--mode",choices=ALL_STL+PREVIEWS)
    p.add_argument("--out",type=Path,default=OUT)
    args=p.parse_args()
    if not(args.all or args.preview or args.mode): p.print_help();return 2
    for mode in (ALL_STL if args.all else ([args.mode] if args.mode in ALL_STL else [])):
        export(mode,args.out/(mode+".stl"))
    if args.preview or args.mode in PREVIEWS:
        for mode in (PREVIEWS if args.preview else [args.mode]):
            export(mode,args.out/(mode+".png"))
    return 0
if __name__=="__main__":sys.exit(main())
