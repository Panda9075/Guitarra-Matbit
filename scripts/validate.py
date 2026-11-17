#!/usr/bin/env python3
"""Static checks of the V4 printable STLs. NOT a mechanical safety certificate."""
from pathlib import Path
import math
import sys
import trimesh

OUT = Path(__file__).resolve().parents[1] / 'output'
PARTS = ('mount_left', 'socket_base_right', 'socket_cap', 'join_clip',
         'wood_fit_coupon', 'screw_fit_coupon')
MODELS = PARTS + ('assembly_socket',)
BED = 220.0
# 2 mm edge allowance per side (brim may need more; verify in slicer).
PRINT_ENVELOPE = 216.0


def validate() -> int:
    failures = []
    for name in MODELS:
        path = OUT / (name + '.stl')
        if not path.is_file():
            failures.append(f'{name}: STL inexistente')
            continue
        mesh = trimesh.load_mesh(path, force='mesh')
        x, y, z = [float(v) for v in mesh.extents]
        volume = float(mesh.volume)
        count = len(mesh.split(only_watertight=False))
        print(f'{name:20} {x:6.1f} x {y:6.1f} x {z:5.1f} mm | '
              f'vol={volume / 1000:7.1f} cm³ | shells={count} | watertight={mesh.is_watertight}')
        if not (mesh.is_watertight and mesh.is_winding_consistent and volume > 1):
            failures.append(f'{name}: malla abierta/invertida o volumen nulo')
        if not all(math.isfinite(float(q)) for q in mesh.bounds.flatten()):
            failures.append(f'{name}: límites no finitos')
        if name in PARTS:
            # Rotating a piece 90 degrees in the XY print plane is permitted.
            if max(x, y) > PRINT_ENVELOPE or min(x, y) > PRINT_ENVELOPE:
                failures.append(f'{name}: superficie {x:.1f} x {y:.1f} mayor a {PRINT_ENVELOPE} mm')
            if count != 1:
                failures.append(f'{name}: contiene {count} piezas desconectadas; revisar uniones CAD')
        if name == 'assembly_socket' and (x < 370 or x > 460):
            failures.append('assembly_socket: extensión total inesperada')
    if failures:
        print('ERRORES:\n' + '\n'.join(failures), file=sys.stderr)
        return 1
    print('OK: validación geométrica automatizada; montaje y resistencia física PENDIENTES')
    return 0


if __name__ == '__main__':
    sys.exit(validate())
