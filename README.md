# PuppyTeach | Desarrollo Senior Ultra-Eficiente

🌐 **Sitio en vivo:** [https://ukoquique-proves.github.io/fastDevPage/](https://ukoquique-proves.github.io/fastDevPage/)

Sitio web estático para la Fase 2 de Teledígitos / PuppyTeach. Dirigido a desarrolladores senior que valoran precisión técnica, métricas reales y cero overhead innecesario.

## Filosofía del Proyecto

Construido bajo la mentalidad **"Antihumo"**: HTML/CSS estático, sin frameworks pesados, sin rastreadores, carga instantánea.

## Estructura del proyecto

```
index.html                        # Landing page principal
toolkit.html                      # Página del toolkit Code Compacter (detalle + formulario)
gracias.html                      # Página de confirmación post-formulario (fallback no-JS)
lista-espera-gracias.html         # Confirmación de la lista de espera si el navegador no ejecuta JS
curso-1-hardware-secundario.html  # Detalle del Curso 1
curso-2-savefiles.html            # Detalle del Curso 2
curso-3-pipeline-trixieretro.html # Detalle del Curso 3
styles.css                        # Hoja de estilos compartida por todas las páginas
serve.sh                          # Levanta servidor local y abre el browser automáticamente
check.sh                          # Verifica consistencia del proyecto antes de hacer push
push.sh                           # Ejecuta check.sh y sube los cambios a GitHub
```

## Formulario integrado con Formspree

Los formularios envían a Formspree (`https://formspree.io/f/mnjyeeod`). Históricamente se intentó una integración AJAX con el SDK de Formspree, pero esa vía resultó poco fiable para la entrega del toolkit en este sitio estático. Actualmente el flujo recomendado es:

- El formulario se envía mediante el flujo estándar del navegador (POST) hacia Formspree.
- `forms.js` se encarga de fijar el `action` de los formularios al endpoint configurado como mejora progresiva.
- Formulario de descarga toolkit: `id="puppyteach-capture-form"` en `toolkit.html`
- Formulario de lista de espera: `id="puppyteach-waitlist-form"` en `index.html`
- Feedback inline con `data-fs-success` / `data-fs-error` cuando el navegador procesa la respuesta.
- Fallback no-JS: `gracias.html` para el toolkit y `lista-espera-gracias.html` para la lista de espera (estas páginas están intencionadamente excluidas de `sitemap.xml`).

Importante: revisa el panel de Formspree para comprobar que el formulario está activo y que las notificaciones están configuradas correctamente.

## Despliegue en GitHub Pages

1. En GitHub, ve a **Settings > Pages**.
2. Selecciona la rama `main` y la carpeta `/ (root)`.
3. Guarda. El sitio estará en `https://ukoquique-proves.github.io/fastDevPage/`.

## Desarrollo local

Levanta el servidor y abre el browser automáticamente:

```bash
./serve.sh
```

El script espera a que el servidor responda antes de abrir `http://localhost:8080`. Si lo ejecutas en un entorno sin interfaz gráfica, mostrará la URL sin intentar abrir el navegador.

## Subir cambios a GitHub

Usa `push.sh` en lugar de `git push` directamente. Ejecuta todas las validaciones antes de subir y aborta si algo falla:

```bash
./push.sh "mensaje del commit"
```

Si no pasas el mensaje como argumento, lo pedirá de forma interactiva.
El script usa el remoto `origin` y la autenticación Git ya configurada en tu máquina, sin incrustar tokens en la URL del push.
Además, hace `git add -A` para no dejar fuera archivos nuevos o borrados por accidente y aborta si no hay cambios reales para commitear.

## Validación de consistencia

Para correr las comprobaciones sin hacer push:

```bash
./check.sh
```

Valida existencia de archivos, nav links, assets compartidos, placement de formularios, cobertura en README, placeholders sin completar e integridad de links internos.

## Mantenimiento

- **Benchmark**: edita la sección `.benchmark` en `index.html` con nuevos valores de `htop` o `free -m`.
- **Toolkit copy**: edita `toolkit.html`. El formulario de captura vive ahí, no en `index.html`.
- **Cursos**: cada curso tiene su propio archivo HTML independiente.

---
**Desarrollado por Teledígitos** | *Sin humo, solo métricas.*
