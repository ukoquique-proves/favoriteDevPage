# Guía: Entrega del toolkit Code Compacter

## Cómo funciona actualmente

El formulario `id="puppyteach-capture-form"` en `toolkit.html` usa `fetch()` con AJAX. No hay redirección de página, ni Formspree SDK, ni `gracias.html`.

Al enviar con éxito, el bloque `#form-success` se hace visible mostrando el botón de descarga directa:

```
https://github.com/ukoquique-proves/favoriteDevPage/releases/download/v0.1.0/Code_Compacter.tar.gz
```

El formulario también muestra un enlace a la lista de espera de la cohorte de Octubre 2026.

## Archivos relevantes

| Archivo | Rol |
|---|---|
| `toolkit.html` | Página del toolkit: copy, características, formulario de captura y bloque de éxito inline |

## Actualizar la versión del release

Si publicas una nueva versión del archivo, actualiza la URL del asset en el bloque `#form-success` dentro de `toolkit.html`:

```
https://github.com/ukoquique-proves/favoriteDevPage/releases/download/<tag>/Code_Compacter.tar.gz
```

## Configuración de Formspree

En el panel de Formspree para el form `mnjyeeod`, verifica que las notificaciones estén activas. El formulario notifica al propietario de la cuenta — no envía ningún email al visitante que descarga el archivo.
