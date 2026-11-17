# Registro de auditoría geométrica — V4, alojamiento SIN mástil

Los controles siguientes son pruebas concretas y no trabajo ficticio de subagentes. El entorno de esta conversación no tiene ejecución delegada multiagente independiente.

| Área revisada | Evidencia disponible | Pendiente |
|---|---|---|
| Especificación | Fuente cad/keytar.scad: no se define ni exporta mástil, ni como visualización | Medir el listón físico (50 × 31 mm nominal) |
| Fijaciones del teclado | 8 coordenadas exactas del propietario, preservadas en tests | Confirmar origen, altura, diámetro, cabeza y longitud; 11 estimaciones pendientes |
| Cuna | OpenSCAD emite base cerrada en U, tope interior, dos pasos M5, tapa desmontable | Ajuste real, comprobación contra vetas/rajado, apriete y arandelas |
| Correa | Dos bosses con piloto ciego y sin ranura para cinta | Verificar tornillos #6, refuerzo independiente y ensayos de carga |
| Uniones | 4 clips/8 alojamientos ciegos para insertos M3 propuestos | Confirmar dimensiones del inserto y montaje real |
| Imprimibilidad | Mallas STL individuales cerradas, 1 shell; áreas proyectadas dentro de 216 × 216 mm | Brim, contracción, laminador, orientación según carga |
| Conjunto | STL de assembly_socket sin mástil y tapa/clips separados para inspección | No imprimir conjunto como bloque; comprobar interferencias en el MiniLab |
| GitHub CI | Fallo histórico V3 identificado: trimesh.split() sin motor de grafos; se añadió dependencia networkx | Comprobar nueva ejecución exitosa en GitHub y disponibilidad de los nuevos STL |

## Control local anterior a publicar

OpenSCAD, pytest, trimesh revisaron la nueva geometría: 6 pruebas de parámetros aprobadas, seis piezas cerradas y un conjunto cerrado (varias piezas separadas para visualización). Dimensiones de las dos bases: 208 × 214 mm y 209,6 × 214 mm. **No se han hecho pruebas físicas de ajuste o resistencia**.

## Prioridad para la siguiente iteración física

1. Plantilla y medición de todos los tornillos del teclado, cabezas y distancias a patas.
2. Cupón de madera y tornillería; decidir holgura, longitud de inserción y tuercas.
3. Ensayos de carga de anclajes: no confiar en la carcasa inferior de plástico hasta demostración.
4. Revisar el reparto de masas, altura de montaje y conectores con el instrumento real.
