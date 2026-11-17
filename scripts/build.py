#!/usr/bin/env python3
"""Export ONLY current V4 socket parts and the neck-free assembly. Mechanical prototype."""
from pathlib import Path
import argparse
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'cad' / 'keytar.scad'
PARTS = ('mount_left', 'socket_base_right', 'socket_cap', 'join_clip',
         'wood_fit_coupon', 'screw_fit_coupon')
ASSEMBLIES = ('assembly_socket',)
PREVIEWS = ('preview_socket',)


def export(mode: str, target: Path) -> None:
    if not shutil.which('openscad'):
        raise RuntimeError('Instala OpenSCAD para generar el CAD real')
    target.parent.mkdir(parents=True, exist_ok=True)
    cmd = ['openscad', '-o', str(target), '-D', f'mode="{mode}"']
    if target.suffix == '.png':
        cmd += ['--imgsize=1280,900', '--viewall', '--autocenter',
                '--projection=ortho']
        if shutil.which('xvfb-run'):
            cmd = ['xvfb-run', '-a'] + cmd
    cmd.append(str(SOURCE))
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode or not target.exists() or target.stat().st_size < 100:
        raise RuntimeError(f'OpenSCAD {mode}: {result.stderr[-4000:]}')
    if 'ERROR:' in result.stderr:
        raise RuntimeError(result.stderr[-4000:])
    print(f'{mode:20} {target.stat().st_size:>10,} bytes', flush=True)


def main() -> None:
    p = argparse.ArgumentParser()
    p.add_argument('--all', action='store_true')
    p.add_argument('--preview', action='store_true')
    p.add_argument('--mode', choices=PARTS + ASSEMBLIES + PREVIEWS)
    p.add_argument('--out', type=Path, default=ROOT / 'output')
    args = p.parse_args()
    if not (args.all or args.preview or args.mode):
        p.error('Indica --all, --preview o --mode')
    stls = PARTS + ASSEMBLIES if args.all else (args.mode,) if args.mode in PARTS + ASSEMBLIES else ()
    pngs = PREVIEWS if args.preview else (args.mode,) if args.mode in PREVIEWS else ()
    for mode in stls:
        export(mode, args.out / f'{mode}.stl')
    for mode in pngs:
        export(mode, args.out / f'{mode}.png')


if __name__ == '__main__':
    main()
