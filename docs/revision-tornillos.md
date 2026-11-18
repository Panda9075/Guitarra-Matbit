# Auditoría de tornillos — BLOQUEO de fabricación (18 noviembre 2026)

> **SOLO tornillos. No se modifican otros elementos ni se declara terminado el soporte.** El CAD V4 NO está validado contra la tornillería real del Arturia MiniLab MkII. No taladrar el teclado, ni utilizar un STL como plantilla de perforación.

## Resultado del examen del código actual

| Categoría | Cantidad | En el CAD | Estado |
|---|---:|---|---|
| Tornillos originales del teclado, coordenadas aportadas por el propietario | 8 | Agujeros de paso Ø5,5 mm en V4 | Centro y diámetro **pendientes de verificación física** |
| Candidatos detectados visualmente en fotos de la tapa inferior | 11 | Marcadores de referencia, agujeros desactivados `use_unverified_large_holes=false` | **Solo estimaciones: no perforar** |
| Tornillos de unión entre mitades impresas | 8 (M3 propuestos) | Cuatro `join_clip`, dos apoyos por clip | **NO son tornillos del teclado**; geometría de insertos M3 no ensayada |
| Tornillos de tapa del alojamiento de madera | 4 (M3 propuestos) | Tapa separada | No son puntos de fijación al teclado |
| Pernos transversales para madera | 2 (M5 propuestos) | En el alojamiento de madera | **Solo madera y soporte, nunca la carcasa** |
| Tornillos para los dos botones de correa | 2 (#6 × 25 mm, dato del propietario) | Pilotos ciegos | No confundir con la tornillería del MiniLab; aún sin ensayo |

**Problema crítico:** el diámetro `small_hole_d=5.5` es un valor de prueba, NO la medición real del tornillo ni de la cabeza. Si la cabeza es menor, una abertura tan grande podría impedir sujetar la pieza con el tornillo original; si es mayor, podría interferir. Se necesita diferenciar diámetro del vástago, diámetro de cabeza, forma de apoyo, longitud, profundidad de rosca y grosor del soporte (V4: `plate_t=5.5 mm`). No asumir que "0,5 cm" de una fotografía describe la rosca.

## 8 coordenadas que constan en el CAD (aportadas anteriormente)

**Sistema de referencia propuesto:** vista de la tapa INFERIOR mirando desde abajo; X de izquierda a derecha, Y de arriba hacia abajo; teclado de referencia 355 × 221 mm. **Aún falta comprobar físicamente si este origen/orientación corresponde a la foto y al instrumento.**

| ID | X (mm) | Y (mm) | Validación |
|---|---:|---:|---|
| P1 | 23 | 117 | Pendiente |
| P2 | 125 | 117 | Pendiente |
| P3 | 225 | 117 | Pendiente |
| P4 | 310 | 117 | Pendiente |
| P5 | 25 | 162 | Pendiente |
| P6 | 126 | 162 | Pendiente |
| P7 | 225 | 162 | Pendiente |
| P8 | 311 | 162 | Pendiente |

## 11 posibles puntos que NO se deben tomar por medidas

| ID | X estimada | Y estimada | Origen |
|---|---:|---:|---|
| E1 | 11 | 8 | Foto |
| E2 | 125 | 10 | Foto |
| E3 | 238 | 12 | Foto |
| E4 | 345 | 9 | Foto |
| E5 | 12 | 110 | Foto |
| E6 | 238 | 109 | Foto |
| E7 | 346 | 112 | Foto |
| E8 | 10 | 213 | Foto |
| E9 | 124 | 216 | Foto |
| E10 | 237 | 215 | Foto |
| E11 | 348 | 212 | Foto |

**Estos números E son referencias visuales de búsqueda**, no posiciones de mecanizado. Puede haber más tornillos aún no identificados. No se deben confundir tornillos con patas redondas de goma, etiquetas o relieves.

## Plantillas para comprobar centros (NO para taladrar)

- **[A3 completo a escala 1:1](plantilla_tornillos_A3.svg)** — hoja A3 horizontal, dibujo de cuerpo 355 × 221 mm.
- **[A4 izquierda](plantilla_tornillos_A4_izquierda.svg)** + **[A4 derecha](plantilla_tornillos_A4_derecha.svg)** — imprimir cada una al 100 %, sin "ajustar a página"; ambas se solapan 15 mm con cruces verdes de registro.
- **[Registro de medidas por tornillo](registro-tornillos.csv)** — campos vacíos intencionales para diámetro, cabeza, rosca y longitud.

**Azul = ocho posiciones comunicadas por el propietario, pero no cotejadas. Naranja discontinuo = once estimaciones fotográficas, sin medir.** Ninguno tiene autorización de taladrado.

Procedimiento:
1. Desconectar el MiniLab. Fotografiar la parte inferior completa **perpendicularmente**, con una regla milimetrada en el mismo plano y sin ocultar los tornillos. Indicar inequívocamente hacia qué lado está el puerto USB para resolver espejado/giro.
2. Imprimir la plantilla adecuada al **100 %** (sin escala automática). Medir con una regla la barra impresa de 50 mm. Si no mide 50 mm, desechar esa impresión.
3. Colocar la plantilla junto al instrumento, sin forzar ni perforar. Comparar P1–P8 y localizar E1–E11. Anotar puntos desplazados con su X/Y **real**, desde el mismo origen. Marcar cualquier tornillo adicional como NUEVO.
4. Para cada tipo de tornillo existente, medir con calibre cabeza y vástago, identificar tipo de rosca y longitud útil. **No alargar ni sustituir tornillos del teclado sin comprobar la profundidad interna**; puede dañar componentes electrónicos.
5. Registrar interferencias de patas de goma, ribetes, nervios y zonas sin apoyo en el recorrido de la base. Tomar fotos de detalle de tornillos de tamaños distintos.
6. Solo entonces actualizar `cad/keytar.scad`, reconstruir STL, cotejar centros 1:1 y efectuar una prueba de encaje sin forzar. Las pruebas automáticas del repositorio **no comprueban el encaje físico**.

## Criterio para desbloquear el trabajo

**BLOQUEADO:** todavía faltan coordenadas comprobadas, clasificación de cada tornillo, diámetros, apoyo de cabeza, tornillería y comprobación del acceso en la base real. Se mantiene la V4 como prototipo; **no he desplazado ningún agujero a ojo**. Después de recibir datos físicos, se corregirá únicamente el patrón de montaje y se verificará de nuevo antes de cualquier otra mejora.
