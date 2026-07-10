# Guía: Entrega del toolkit Code Compacter

Esta guía documenta cómo funciona el flujo de descarga, cubriendo tanto el caso JS activo como el fallback sin JS.

## Cómo funciona actualmente

### Caso 1 — JS activo (flujo AJAX)

El formulario `id="puppyteach-capture-form"` en `toolkit.html` está wired al SDK de Formspree.
Al enviar con éxito, el bloque `data-fs-success` se hace visible mostrando un botón de descarga directa:

```
https://github.com/ukoquique-proves/favoriteDevPage/releases/download/v0.1.0/Code_Compacter.tar.gz
```

El visitante descarga el archivo sin salir de la página. Importante: el sitio no envía automáticamente el `.tar.gz` como adjunto de email; el flujo actual ofrece un enlace de descarga directa tras el envío.

### Caso 2 — JS bloqueado o falla (fallback nativo)

El formulario incluye un campo `_next` que redirige a `gracias.html`, que contiene el mismo botón de descarga directa. El visitante llega a una página con el mismo estilo visual y puede descargar el archivo.

## Archivos relevantes

| Archivo | Rol |
|---|---|
| `toolkit.html` | Página del toolkit: copy, características, formulario de captura |
| `gracias.html` | Fallback no-JS: confirmación + botón de descarga |

## Actualizar la versión del release

Si publicas una nueva versión del archivo, actualiza la URL del asset en dos lugares:

1. El bloque `data-fs-success` en `toolkit.html`
2. El botón de descarga en `gracias.html`

La URL sigue el patrón:
```
https://github.com/ukoquique-proves/favoriteDevPage/releases/download/<tag>/Code_Compacter.tar.gz
```

## Nota de arquitectura

El formulario actual usa Formspree únicamente para capturar el lead y registrar el envío. No se usa Formspree para entregar el archivo como adjunto ni para enviar un autorrespondedor con el paquete.

La experiencia actual ya resuelve la entrega en la misma página:

- vía JS: el bloque de éxito muestra el botón de descarga inmediatamente;
- vía fallback: `gracias.html` ofrece el mismo botón si el navegador no ejecuta JS.

Si en el futuro se quiere un respaldo por email sin depender de Formspree, la opción más simple sería usar Zapier o Make con un webhook o notificación del envío y enviar un mensaje de seguimiento con el enlace. Hoy no es necesario para el flujo principal.
