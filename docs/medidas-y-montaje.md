# Medidas, tolerancias y seguridad — Arturia MiniLab MkII

> **Revisión V3, NO validada físicamente.** No perforar la carcasa original. No suspender el instrumento por la correa, ni por el mástil, antes de ensayos.

## Cuerpo y puntos de atornillado

Cuerpo: 355 mm de largo × 221 mm de ancho aproximado; origen X=0, Y=0 en esquina superior izquierda de la **vista inferior**. La orientación debe cotejarse físicamente.

**Ocho puntos aportados por el propietario** (mm):
- Arriba Y=117: (23,117), (125,117), (225,117), (310,117).
- Abajo Y=162: (25,162), (126,162), (225,162), (311,162).

También están marcados **11 candidatos de tornillos periféricos** a partir de las fotos, documentados en [la revisión de tornillos](revision-tornillos.md). Son puntos aproximados: no se taladran en el CAD por defecto (`use_unverified_large_holes=false`). Diferenciar tornillos y patas de goma.

Los diámetros nominales de paso `small_hole_d=5.5` y `large_hole_d=6.5` son **provisionales**. Una cabeza de 5 mm no significa rosca de 5 mm. El usuario sí ha confirmado el Arturia MiniLab MkII, no las dimensiones de todas las fijaciones. La base tiene espesor 4.5 mm, por lo que hay que verificar longitud de enganche si se conservan o cambian los tornillos.

## Correa: dos strap buttons con tornillos #6 de 25 mm

La antigua **ranura rectangular de 24 × 7 mm se ha eliminado**. Se han añadido:
- Dos bosses circulares macizos de 23 mm de diámetro y 33 mm de altura desde la cara inferior del soporte.
- Agujeros piloto ciegos de ejemplo **2.7 mm de diámetro × 27 mm de profundidad** para tornillo #6 (~3.5 mm de diámetro) de **25 mm de longitud**, dejando ~6 mm de fondo; ajustar según material y perfil real de tornillo.
- Un boss en la culata trasera (X=-29, Y=145); otro junto a la zona de mástil (X=359, Y=139). Los dos quedan fuera del área de 355 mm en el centro del tornillo, pero la geometría total se conecta a la placa.

El piloto no es una rosca validada. La resistencia del plástico impreso al arrancamiento, los esfuerzos de palanca y la tapa original pueden fallar. Considerar fijación metálica independiente después de medir y ensayar. No colgar el instrumento por estos puntos durante las pruebas dimensionales.

## Mástil de madera: sección 50 × 31 mm

El segundo diseño ya NO usa el canal para perfil metálico de 25 × 3 mm. En su lugar hay una cuna rectangular de perfil abierto en U, con tapa desmontable:
- `wood_width=50` mm; `wood_thickness=31` mm.
- `wood_clearance=0.6` mm por lado (aproximación, calibrar con `wood_fit_coupon`).
- `wood_socket_depth=70` mm (inserción provisional; cambiar tras medir largo disponible).
- `wood_wall=8` mm, `wood_floor=8` mm, tope interno de 7 mm.
- Dos pasos M5 de **5.5 mm** a posiciones longitudinales locales 25 y 51 mm. Hay que **taladrar la madera** para que los pernos pasen completamente de lado a lado; usar arandelas y tuercas autofrenantes.
- Tapa de 6 mm con cuatro agujeros de 4.5 mm para tornillos M4; la tapa evita que la madera se levante, pero los M5 previenen que el mástil se deslice.

Verificar que el sentido de los agujeros transversales no debilite demasiado la madera, que la pared no tenga grietas y que no se cargue directamente una tapa electrónica flexible. Madera, tornillos, orientación y profundidad NO tienen todavía pruebas estructurales.

## Impresión y procedimiento seguro

1. Imprimir **solo** `fit_coupon` y `wood_fit_coupon`. Medir con calibre dimensiones finales, agujeros y holguras de la madera real.
2. Medir ubicación y tipo de **todos** los tornillos originales en un sistema de coordenadas uniforme; revisar que los raíles no interfieran con pies, nervaduras ni puertos USB.
3. Confirmar encaje sin forzar, sobre una superficie acolchada y con el MiniLab desconectado.
4. Perforar únicamente la madera para los pasadores M5, usando una plantilla a escala verificada; nunca perforar el teclado.
5. Hacer cálculo y ensayo de cargas en una fijación portante independiente antes de usar correa o levantar del mástil.

Los chequeos de GitHub Actions validan geometría y cotas de fabricación aproximadas, **no la seguridad para tocar de pie**.
