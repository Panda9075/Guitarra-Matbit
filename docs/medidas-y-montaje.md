# Medidas y montaje V2 — borrador, no aprobado para impresión definitiva

## Sistema de coordenadas

En la **tapa inferior** del teclado, X izquierda→derecha, Y arriba→abajo. Origen en esquina superior izquierda de la vista inferior, pendiente de confirmar en el objeto real. Todas las unidades son milímetros.

- Instrumento Arturia MiniLab MkII: 355×221 mm en planta según foto/medición; altura de referencia 50 mm.
- Tornillos fila alta Y=117: (23,117), (125,117), (225,117), (310,117).
- Tornillos fila baja Y=162: (25,162), (126,162), (225,162), (311,162).
- Diámetros de paso provisionales `small_hole_d=5.5` mm y `large_hole_d=6.5` mm: **SIN VALIDAR**. La anotación fotográfica «0.5 cm» NO identifica tipo de tornillo ni rosca.
- Perfil metálico ejemplificativo rectangular **25×3 mm**; debe medirse. Un perfil redondo exigiría cambiar el diseño.

## Tornillos adicionales fotografiados
Además de los 8 tornillos centrales medidos, hay múltiples fijaciones del perímetro y de la parte central. Un mapa provisional está en [mapa-tornillos.svg](mapa-tornillos.svg). Las 11 ubicaciones propuestas son **estimaciones de foto**, no medidas con calibre, y `use_unverified_large_holes=false` impide taladrarlas en el STL. No se garantiza que estén todos los tornillos visibles. Las cuatro patas de goma no deben confundirse con fijaciones.

Se añadieron raíles provisionales junto a Y=10 y Y=212 mm y travesaños hasta esos raíles para estudiar los tornillos del perímetro. **Comprobar interferencias con patas, ranuras, nervaduras y otros componentes.** Las piezas de base usan ahora casi toda la altura de una cama 220×220 mm, por lo que el brim podría no caber.

## Correa: dos ojos impresos fuera del teclado

- **Culata trasera:** pieza única con `mount_left`, se prolonga ~41 mm a la izquierda. Centro de ojo (-25,145).
- **Oreja frontal:** integrada en ambas bases derechas junto al origen del mástil. Centro de ojo (359,139).
- Ojos de 24×7 mm para una cinta de aproximadamente 20 mm, no para strap-buttons convencionales.
- Se transfieren esfuerzos a los cuatro tornillos de cada sector de la tapa. **No se ha probado si la tapa, el plástico, los tornillos y la correa pueden soportar la carga del teclado y la palanca del mástil. NO colgar el instrumento** hasta prueba específica; probablemente convenga una fijación portante envolvente independiente.

## Antes de imprimir o montar

1. Hacer plantilla a escala real de los 8 centros y verificar orientación X/Y con calibre.
2. Imprimir primero `fit_coupon.stl`, comprobar diámetro de agujeros y encaje; identificar **cada** tornillo original (cabeza, rosca, diámetro, profundidad y longitud de enganche).
3. La base añade 4.5 mm bajo la carcasa: los tornillos originales podrían quedar cortos; nunca poner otros más largos sin conocer profundidad del alojamiento y evitar daño a electrónica/teclas.
4. Comprobar patas de goma, nervaduras, puertos, USB, etiquetas y cables para descartar interferencias.
5. Unir las dos bases en X=170 mediante cuatro `join_clip` con 4 fijaciones M3 externas y tuercas; no confundirlas con tornillos del teclado.
6. Para mástil 3D, usar dos empalmes solapados con un total de cuatro tornillos M4 externos; comprobar flexión y grietas.
7. Para perfil metálico, el alojamiento usa pared de 9 mm y tope interior de 7 mm, con tapa de 4 tornillos M4. **Sigue faltando retención positiva contra deslizamiento hacia afuera**; no confiar la carga a la fricción del apriete.
8. Probar en mesa acolchada, desconectado, sin levantarlo por mástil o correa. Revisar fisuras/holgura tras ensayos.

## Impresión / límites

Para primeras pruebas: PETG 4–6 perímetros, relleno 30–40% orientativo, condicionado a ensayos. Todas las **piezas separadas** caben teóricamente en cama 220×220 mm (sin margen para brim); el mástil monolítico conceptual no cabe. La versión de mástil metálico utiliza menos polímero.

El éxito de GitHub Actions garantiza **solamente** que el CAD genera mallas cerradas con medidas dentro del límite, NO validación de fabricación, encaje, ergonomía ni resistencia estructural.
