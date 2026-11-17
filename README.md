# Guitarra-Matbit — conversión de Arturia MiniLab MkII a keytar

**Versión V3 — BORRADOR TÉCNICO, NO APROBADO PARA IMPRIMIR NI UTILIZAR CON CORREA.**

Objetivo: fijar un soporte tipo guitarra al teclado Arturia MiniLab MkII sin perforar la carcasa original. Dos variantes de mástil comparten la base inferior. Se ha reemplazado la antigua ranura de cinta por un soporte macizo para strap buttons #6 x 25 mm, y la variante externa utiliza madera de sección 50 × 31 mm.

## Ver la revisión

- [Código CAD editable](cad/keytar.scad) (paramétrico en OpenSCAD).
- [Mapa de tornillos: medidos vs. estimados](docs/mapa-tornillos.svg).
- [Criterios de montaje y problemas sin resolver](docs/medidas-y-montaje.md).
- [Revisión detallada de tornillos](docs/revision-tornillos.md).
- [Acción de GitHub: STL y vistas](../../actions/workflows/cad.yml): archivos en **Artifacts** cuando termine la acción del pull request.

**Los STL de `main` siguen siendo la revisión anterior** hasta validar y fusionar estos cambios. No usar los enlaces anteriores como piezas definitivas.

## Piezas nuevas

**Comunes**: `mount_left` (culata y strap button trasero), `join_clip` ×4, `fit_coupon`. La base usa cuatro raíles; los ocho agujeros interiores conservan sus coordenadas. Los 11 candidatos de tornillos periféricos **se muestran como referencia, pero no se perforan hasta medirlos** (`use_unverified_large_holes=false`).

**Variante 1, mástil impreso**: `integrated_root` + `integrated_mid` + `integrated_tip` (solapes), y anclaje frontal integrado.

**Variante 2, mástil de madera**: `wood_base_right` (cuna abierta tipo U de 50 × 31 mm + holgura), `wood_socket_cap` (tapa), `wood_fit_coupon` (probeta de encaje) y **dos pernos M5 transversales** que atraviesan soporte y madera (habrá que taladrar la madera según una plantilla real). Profundidad de inserción inicial `wood_socket_depth=70` mm, **sujeta a revisión**. Los cuatro pequeños tornillos de la tapa son secundarios: no sustituyen los pernos pasantes.

**Correa**: dos refuerzos macizos con taladros piloto ciegos para los tornillos tipo madera #6 de 25 mm. Los botones metálicos son piezas compradas y no se imprimen; **el anclaje impreso y la carcasa no tienen ensayos de resistencia**. Evitar colgar el teclado hasta realizar una prueba de carga y verificar que las fuerzas no deterioren la tapa.

## Generar

Instala OpenSCAD, Python 3.11 y las dependencias de `requirements-dev.txt`.

```bash
python -m pip install -r requirements-dev.txt
python -m pytest -q
python scripts/build.py --all --preview
python scripts/validate.py
```

En OpenSCAD selecciona `mode="preview_integrated"` o `mode="preview_wood"` y pulsa F5. Los archivos `assembly_wood_visual.stl` incluyen una madera **solamente ilustrativa**: no debe imprimirse como si fuera plástico.
