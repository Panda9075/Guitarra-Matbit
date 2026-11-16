# Guitarra-Matbit 🎹 → 🎸

Diseño paramétrico para convertir un **Arturia MiniLab MkII** en una *keytar*, utilizando los **ocho tornillos existentes de la tapa inferior**. Se busca reducir el material de impresión, sin perforar la carcasa original.

**Estado: prototipo V0. Diseño no certificado para colgarse con correa ni tocar de pie.** Las dimensiones de tornillos, tipo de rosca, tolerancia de asiento y sección del mástil metálico están pendientes de medición física. No imprimas piezas finales antes de revisar [las medidas y precauciones](docs/medidas-y-montaje.md).

## Dos variantes

- **Mástil integrado impreso:** `integrated_root.stl` (base derecha y raíz del mástil como una pieza), más `integrated_mid.stl` y `integrated_tip.stl` (tramos unidos con solape y tornillos externos M4). También se genera `integrated_full_right.stl` como concepto de mástil monolítico, grande para muchas camas.
- **Mástil metálico económico:** `metal_base_right.stl` (base + canal U) y `metal_socket_cap.stl` (tapa con cuatro tornillos externos M4). El perfil metálico **no se incluye**. Los valores de ejemplo `metal_bar_w=25` y `metal_bar_t=3` mm NO son medidas verificadas; ajústalos.

Ambas usan la placa `mount_left.stl` y **dos** `join_clip.stl` para unir las mitades. La estructura emplea raíles, travesaños y una cartela, en vez de una placa maciza bajo el teclado.

## Estructura

| Ruta | Contenido |
|---|---|
| [cad/keytar.scad](cad/keytar.scad) | Geometría paramétrica, todas las variantes |
| [docs/medidas-y-montaje.md](docs/medidas-y-montaje.md) | Coordenadas, mediciones y montaje seguro |
| [scripts/build.py](scripts/build.py) | Exportación STL y vistas PNG |
| [scripts/validate.py](scripts/validate.py) | Verificaciones de geometría, tamaños y mallas |
| [tests/test_dimensions.py](tests/test_dimensions.py) | Pruebas sobre cotas y coordenadas |
| [.github/workflows/cad.yml](.github/workflows/cad.yml) | Pruebas automáticas de GitHub Actions + piezas descargables |

## Ejecutar

Instalar [OpenSCAD](https://openscad.org/) y Python 3.11+. Abrir `cad/keytar.scad`, cambiar `mode` y pulsar F5/F6; o generar todo:

```bash
python -m pip install -r requirements-dev.txt
python -m pytest -q
python scripts/build.py --all --preview
python scripts/validate.py
```

Para un STL individual: `python scripts/build.py --mode metal_base_right`. Todas las exportaciones van a `output/`, carpeta ignorada en Git. En GitHub Actions están en **Actions → Build & validate CAD → Artifacts**.

**Fuentes de referencia:** fotografías y medidas aportadas por el propietario; [soporte oficial Arturia MiniLab MkII](https://www.arturia.com/support/downloads-manuals/product/minilab-mkII). Los planos de tornillos proceden exclusivamente de las medidas del propietario, no de Arturia.
