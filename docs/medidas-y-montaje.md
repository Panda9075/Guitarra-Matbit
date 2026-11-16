# Medidas y montaje — prototipo V0

## Referencia geométrica

Mirando la **tapa inferior** como en la foto del propietario: X de izquierda a derecha, Y de arriba hacia abajo, origen en la esquina superior izquierda. Todas las unidades en mm.

- Carcasa: **355 mm de largo**, **221 mm de ancho medido** (ficha comercial ~220 mm); altura nominal ~50 mm.
- Tornillos pequeños, fila superior Y=117: **(23,117), (125,117), (225,117), (310,117)**.
- Fila inferior Y=162: **(25,162), (126,162), (225,162), (311,162)**.
- Los puntos **no están verificados con calibre**. Verificar cuál es la esquina origen y qué agujero corresponde en la tapa real. Los apoyos grandes de goma NO son puntos de montaje.
- La foto marcada `0.5 cm` es insuficiente para saber diámetro de rosca, tornillo, cabeza o agujero. `mount_hole_d=5.5` es **valor inicial a calibrar, no dato confirmado**.

## Lista de piezas

| Ambos diseños | Mástil 3D integrado | Mástil de metal |
|---|---|---|
| `mount_left` ×1 | `integrated_root` ×1 | `metal_base_right` ×1 |
| `join_clip` ×2 | `integrated_mid` ×1 | `metal_socket_cap` ×1 |
| `fit_coupon` ×1 (ensayo) | `integrated_tip` ×1 | Perfil metálico real (no incluido) |

Adicionales **solo externos**: 4 tornillos + tuercas M3 para clips; 4 tornillos + tuercas M4 para empalmes del mástil integrado o para abrazadera metálica; arandelas. Ajustar longitudes al material final.

El `integrated_full_right` representa la versión monolítica conceptual de base + mástil; el diseño dividido es para facilitar la impresión y **sus uniones son puntos críticos de resistencia**.

## Antes de imprimir o montar

1. Imprimir `fit_coupon.stl` para comparar agujeros nominales de 3, 3.5, 4, 4.5, 5 y 5.5 mm.
2. Con calibre, medir **cada tornillo original**: diámetro del vástago, diámetro de cabeza, paso de rosca, longitud y profundidad segura. Si se intercambia por otro más largo, validar que no pueda tocar electrónica, membranas o teclas. La placa roba ~4.5 mm de longitud de acople.
3. Hacer una plantilla a escala real y comprobar las **8 posiciones**; la perspectiva de las fotos puede distorsionar centros.
4. Revisar que los raíles en Y=117 y Y=162 mm no coincidan con patas, nervaduras, etiqueta, salientes ni puertos. No bloquear USB, pedal o respiración.
5. Medir ancho y espesor reales del **perfil metálico**, su forma (rectangular o redonda) y el largo útil. El alojamiento actual acepta una sección rectangular de ejemplo de 25 × 3 mm; **si es cilíndrica requiere rediseño**.
6. Ensayar la combinación metal-plástico y la distribución de esfuerzos. El montaje atornillado a la tapa electrónica no está evaluado para cargas laterales ni esfuerzos por palanca.

## Impresión y seguridad

PETG recomendado **solo para pruebas iniciales**, 4–6 perímetros y 30–40 % relleno como punto de partida, sujeto a ensayos. Las bases y tramos se imprimen planos. Por costo, el diseño metálico usa menos plástico. Los STL son geometrías CAD; **no son una certificación de resistencia**.

Probar en mesa acolchada y sin alimentación USB. No colgar de correa, no cargar el peso del teclado del mástil ni tocar de pie hasta probar una fijación portante independiente y comprobar cargas. La representación conceptual de guitarra no implica que la correa del dibujo sea segura.
