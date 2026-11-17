# Guitarra-Matbit V4: medidas, montaje y límites de seguridad

**Estado:** proyecto CAD de prototipo. **Mástil no incluido** a petición del propietario; el soporte deja exclusivamente el hueco para una madera externa de 50 × 31 mm. No modificar la carcasa del teclado.

## Geometría conocida y pendiente

| Elemento | CAD / dato | Confianza |
|---|---|---|
| Instrumento | Arturia MiniLab MkII, no MiniLab 3 | Identificación del propietario |
| Carcasa, vista inferior | 355 × 221 mm | Comunicada por propietario |
| Altura de carcasa | 32 mm en anotación fotográfica | **Pendiente medir**; la antigua vista CAD usaba 50 mm |
| Ocho centros de tornillo interiores | (23,117), (125,117), (225,117), (310,117), (25,162), (126,162), (225,162), (311,162) mm | Medidas comunicadas; verificar origen y orientación |
| Otros once centros, sin medida | Ver revision-tornillos.md | Estimaciones por foto: **no perforados** |
| Paso de tornillos de teclado | 5,5 mm provisional en CAD | **Sin diámetro/cabeza/rosca/longitud confirmados** |
| Listón de madera | 50 × 31 mm | Proporcionado por el propietario; verificar ovalización/radios |
| Hueco útil de cuna | 51,2 × 32,2 mm | Tolerancia de impresión estimada, no verificada |
| Cuna | 70 mm total, 7 mm de tope | **Profundidad provisional**, madera entra ~63 mm |
| Pasadores que cruzan madera | Dos M5 propuestos, pasos Ø5,5, local x=27/50 mm | **Propuesta**, requieren comprobar veta y acceso a tuerca |
| Tapa y clips | 4 tornillos M3 en tapa; 8 M3 con insertos para 4 clips | **Propuesta**, insertos compatibles por medir |
| Strap buttons | 2 tornillos #6 × 25 mm | Dato del propietario; geometría del piloto provisional |
| Cama de impresión | 220 × 220 mm | Hipótesis; requiere espacio para borde y brim |

## Ensamblaje físico sugerido (no autorizado para carga)

1. Verificar las ocho coordenadas reales con plantilla 1:1, medir los **otros once candidatos**, las cabezas de tornillo, longitud de rosca disponible, patas, relieves y conectores. No taladrar el MiniLab.
2. Imprimir primero wood_fit_coupon.stl y screw_fit_coupon.stl con el material, orientación y laminador previstos; medir la madera real y la impresión. Ajustar wood_clearance, diámetros y profundidad antes de imprimir piezas grandes.
3. Presentar las dos bases bajo el teclado **desconectado**, sin forzar ni fijar hasta comprobar pies, USB y apoyos. La base tiene 5,5 mm; los tornillos originales pueden no tener enganche suficiente con esa separación.
4. Si los insertos M3 elegidos encajan y la geometría deja espesor seguro, instalarlos en los ocho resaltes de unión. Usar los **cuatro clips** en los resaltes. No instalar insertos térmicos cerca del instrumento.
5. Comprobar que el listón de madera entra por la boca abierta hasta el tope **sin deformar las paredes**. La tapa se atornilla con cuatro tornillos M3 de longitud adecuada.
6. **Antes de perforar la madera**, presentar y transferir al listón las posiciones de ambos pasos M5 desde el alojamiento real, confirmar veta y acceso a dos tuercas/arandelas. Introducir pernos pasantes que impidan que la madera se salga; no depender del pegamento ni de fricción. No hay listón 3D en ningún STL.
7. Instalar los dos strap buttons metálicos reales únicamente después de probar el diámetro y la longitud de sus tornillos #6, la orientación, la resistencia al arrancamiento y una **ruta de carga segura que no dañe la tapa electrónica**.
8. **No colgar el instrumento de una correa ni tirar del listón** hasta completar ensayos físicos de carga estática, impactos, fatiga y confirmación de la sujeción a una estructura portante adecuada.

## Limitaciones no resueltas

- No se han recibido fotos originales como archivos en esta revisión; el resumen describe imágenes previas, pero no sustituye mediciones reales.
- La base debe comprobar su apoyo sin bloquear conectores USB, pies, etiquetas, nervaduras o electrónica interna.
- Las paredes de la cuna y los montajes de correa son solo geometría CAD: volumen, malla cerrada y orientación de impresión no certifican su resistencia.
- La cuna está abierta hacia el extremo exterior; los pernos M5 son su retención axial propuesta. La tapa impide levantamiento, no es sustituto de pasadores.
- La profundidad total 70 mm, el ángulo -18° y el centro x301/y86 pueden alterarse al medir alcance y ergonomía.
- La separación de la tapa (1 mm) y clips (0,6 mm) en assembly_socket.stl es **solo para el visor online**. Los STL individuales se imprimen por separado.
