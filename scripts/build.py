#!/usr/bin/env python3
"""Generate STL files and PNG CAD previews with OpenSCAD."""
import argparse
from pathlib import Path
import shutil
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[1]
SCAD=ROOT/"cad"/"keytar.scad"
OUT=ROOT/"output"
PARTS=["mount_left","join_clip","integrated_root","integrated_mid","integrated_tip","metal_base_right","metal_socket_cap","fit_coupon"]
EXTRA=["integrated_full_right"]
PREVIEWS=["preview_integrated","preview_metal"]

def export(mode,path):
    if not shutil.which("openscad"):
        raise RuntimeError("OpenSCAD is not installed or not on PATH")
    path.parent.mkdir(parents=True,exist_ok=True)
    cmd=["openscad","-o",str(path),"-D",'mode="'+mode+'"']
    if path.suffix==".png":
        cmd+=["--imgsize=1400,850","--viewall","--autocenter","--projection=ortho"]
        if shutil.which("xvfb-run"):
            cmd=["xvfb-run","-a"]+cmd
    cmd.append(str(SCAD))
    run=subprocess.run(cmd,text=True,capture_output=True)
    if run.returncode or not path.exists() or path.stat().st_size<100:
        raise RuntimeError(f"Export failed: {mode}\n{run.stderr}")
    print(f"{mode:22s} -> {path} ({path.stat().st_size:,} bytes)")

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--all",action="store_true")
    parser.add_argument("--preview",action="store_true")
    parser.add_argument("--mode",choices=PARTS+EXTRA+PREVIEWS)
    parser.add_argument("--out",type=Path,default=OUT)
    args=parser.parse_args()
    if not(args.all or args.preview or args.mode):
        parser.print_help(); return 2
    for mode in (PARTS+EXTRA if args.all else ([args.mode] if args.mode else [])):
        export(mode,args.out/(mode+".stl"))
    if args.preview:
        for mode in PREVIEWS:
            export(mode,args.out/(mode+".png"))
    return 0

if __name__=="__main__": sys.exit(main())
