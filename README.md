# Guitarra-Matbit — Arturia MiniLab MkII → keytar

Modelo CAD paramétrico **V2 EN REVISIÓN**, para Arturia MiniLab MkII. Incluye los 8 tornillos interiores entregados por el propietario y **11 ubicaciones adicionales estimadas visualmente**; las estimaciones NO se taladran en el prototipo. Incluye **culata trasera y dos anclajes de correa textil**, con dos opciones de mástil.

## Revisión de tornillos pequeños y grandes
Las 8 medidas iniciales no se han cambiado. Las nuevas cabezas de tornillos observadas en la periferia se marcaron como **candidatos** en amarillo, pero no se perforan hasta confirmarlas con calibre o regla (`use_unverified_large_holes=false`). Los diámetros de ambos tipos también son provisionales.

- [Mapa preliminar de tornillos](docs/mapa-tornillos.svg) — azul: originales; dorado: aproximaciones.
- [Lista de medidas pendientes](docs/revision-tornillos.md) — no usar de plantilla de taladrado.

## Ver online y girar el 3D sin instalar programas

GitHub tiene un visor 3D nativo para los ficheros STL. Entra en uno de estos archivos (con sesión iniciada, este repo es privado):

- **[Mástil 3D integrado — montaje](models/stl/assembly_integrated.stl)**
- **[Mástil metálico — montaje COMPLETO con perfil ilustrativo](models/stl/assembly_metal_visual.stl)**
- **[Culata trasera / anclaje de correa](models/stl/mount_left.stl)**
- **[Soporte para mástil metálico](models/stl/metal_base_right.stl)**

**Arrastra para girar, rueda para zoom y clic derecho+arrastrar para mover.** Los STL se publican automáticamente al terminar **Actions → Generar STL y revisar CAD**. Si aún no aparecen los enlaces, descarga el Artifact `STL-y-vistas-Matbit` de esa ejecución. El mástil metálico de la vista completa es ilustrativo y no debe imprimirse; la versión de piezas impresas sin metal se encuentra en [assembly_metal.stl](models/stl/assembly_metal.stl).

## Dos diseños

1. **Mástil integrado:** `integrated_root` contiene la base derecha y el arranque del mástil en un solo sólido, unido a `integrated_mid` y `integrated_tip` por solapes con 4 tornillos M4 externos. `integrated_full_right` es la versión conceptual de una sola pieza, demasiado larga para una impresora 220×220.
2. **Mástil metálico:** `metal_base_right` incorpora una canaleta con tope interno y `metal_socket_cap` la cierra con tornillos externos. El perfil rectangular **25×3 mm es solo un ejemplo**, no se ha medido el metal real.

Ambas versiones incluyen `mount_left` con una **culata trasera de ~41 mm**, el anclaje frontal cerca del mástil y **dos** `join_clip` para ensamblar las bases. Los ojos de 24×7 mm están fuera de la carcasa original, y permiten pasar una cinta textil de unos 20 mm.

**ALERTA:** la correa y el mástil NO están certificados para soportar cargas. No suspendas el teclado ni lo uses de pie hasta confirmar roscas, interferencias y resistencia de los anclajes. Más detalles en [medidas y montaje](docs/medidas-y-montaje.md) y [revisiones](docs/revisiones.md).

## Código, piezas y pruebas

- [CAD OpenSCAD](cad/keytar.scad) — cambiar `mode="preview_integrated"` o `mode="preview_metal"` para ver un teclado esquemático coloreado.
- [Guía de medidas](docs/medidas-y-montaje.md)
- [Auditoría / pendientes](docs/revisiones.md)
- [Issue #1](../../issues/1) — validación física pendiente.

```bash
python -m pip install -r requirements-dev.txt
python -m pytest -q
python scripts/build.py --all --preview
python scripts/validate.py
```

Se requieren OpenSCAD y Python 3.11+. GitHub Actions repite las pruebas y publica STL al repositorio si tiene permiso de escritura.
