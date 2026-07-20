# Guía: Entrega del toolkit Code Compacter

## Cómo funciona actualmente

El flujo del toolkit en `toolkit.html` usa un modal con paneles de compra y colaborador, ambos enviados con `fetch()` AJAX. No hay redirección de página, ni Formspree SDK, ni `gracias.html`.

Al enviar con éxito, el flujo muestra un estado de confirmación interna en el modal y deja la solicitud pendiente para cumplimiento manual por parte del operador. En el camino de colaborador, una vez que la contraseña es correcta se muestra inmediatamente un botón de descarga del paquete; la vía de compra sigue siendo manual.

El modal también ofrece una vía para colaboradores con validación ligera de contraseña y una vía de compra directa; ambas terminan enviando la solicitud a Formspree para revisión manual, pero la entrega para colaboradores ya no depende de que esa llamada a Formspree tenga éxito.

## Archivos relevantes

| Archivo | Rol |
|---|---|
| `toolkit.html` | Página del toolkit: copy, características y flujo modal de compra/acceso |
| `toolkit.html.template` | Plantilla fuente usada para generar el HTML final |

## Configuración de Formspree

En el panel de Formspree para el form `mnjyeeod`, verifica que las notificaciones estén activas. El formulario notifica al propietario de la cuenta y deja la entrega/manual fulfillment fuera del HTML.
