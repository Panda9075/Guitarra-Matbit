# Auditoría preliminar de tornillos — Arturia MiniLab MkII

**Estado: pendiente de mediciones. No usar las coordenadas estimadas para perforar ni fabricar una fijación final.**

## Medidos y facilitados por el propietario (8 interiores)

Tapa inferior vista desde abajo; X izquierda→derecha, Y arriba→abajo, en mm, sobre 355 × 221 mm.

- Fila 1 Y=117: (23,117), (125,117), (225,117), (310,117).
- Fila 2 Y=162: (25,162), (126,162), (225,162), (311,162).

Conservados exactamente. Aunque son datos del usuario, la orientación de las fotos y los centros deben contrastarse con la tapa real.

## Observados en fotos, NO medidos (11 candidatos)

Estas posiciones son **bocetos ilustrativos para localizarlos**, con margen de error desconocido:

| Zona | Posiciones estimadas, mm |
|---|---|
| Borde superior | (11,8), (125,10), (238,12), (345,9) |
| Zona media | (12,110), (238,109), (346,112) |
| Borde inferior | (10,213), (124,216), (237,215), (348,212) |

Puede faltar algún tornillo; un tornillo en el centro y el de la esquina superior derecha se ven parcialmente cubiertos por los trazos de la foto. **Las patas redondas de goma no son fijaciones.** La distinción *grande vs. pequeño* es visual, no una medida de cabeza ni de rosca.

En el CAD `use_unverified_large_holes=false`: se ven como marcas doradas de referencia en vistas previas, pero **no se perforan**. Los diámetros programados 5.5 y 6.5 mm tampoco están confirmados. El dato fotografiado de «0.5 cm» no permite inferir rosca, cabeza ni largo seguro.

## Antes de corregir el montaje

1. Obtener foto perpendicular de la tapa completa **sin marcas encima de las cabezas**, con regla de escala.
2. Medir X/Y de cada tornillo adicional desde el **mismo origen** de los ocho interiores.
3. Medir para cada tipo de tornillo: cabeza, vástago, paso de rosca, largo y profundidad disponible; comprobar si al añadir base de 4.5 mm sigue engranando.
4. Medir patas de goma y nervaduras salientes; las vías de apoyo no deben bloquearse.
5. Recibir las condiciones adicionales de ergonomía, mástil y correa antes de cerrar el diseño.
6. Volver a exportar, testear y probar un cupón o plantilla; sin pruebas de tracción no usar correa ni levantarlo por el mástil.

El mapa [SVG](mapa-tornillos.svg) es un esquema, **no una plantilla 1:1**.
