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
curso-1-hardware-secundario.html  # Detalle del Curso 1
curso-2-savefiles.html            # Detalle del Curso 2
curso-3-pipeline-trixieretro.html # Detalle del Curso 3
styles.css                        # Hoja de estilos compartida por todas las páginas
serve.sh                          # Script de desarrollo local
```

## Formulario integrado con Formspree

Ambos formularios usan Formspree AJAX (`@formspree/ajax@1.1.5`) sin recarga de página.

- Endpoint: `https://formspree.io/f/mnjyeeod`
- Formulario de descarga toolkit: `id="puppyteach-capture-form"` en `toolkit.html`
- Formulario de lista de espera: `id="puppyteach-waitlist-form"` en `index.html`
- Feedback inline con `data-fs-success` / `data-fs-error`

> Formspree debe estar configurado desde el panel para que los emails lleguen correctamente.

## Despliegue en GitHub Pages

1. En GitHub, ve a **Settings > Pages**.
2. Selecciona la rama `main` y la carpeta `/ (root)`.
3. Guarda. El sitio estará en `https://ukoquique-proves.github.io/fastDevPage/`.

## Desarrollo local

Corre `serve.sh` desde cualquier carpeta para levantar el servidor y abrir el browser automáticamente:

```bash
./serve.sh
```

El script espera a que el servidor responda antes de abrir `http://localhost:8080`.

## Mantenimiento

- **Benchmark**: edita la sección `.benchmark` en `index.html` con nuevos valores de `htop` o `free -m`.
- **Toolkit copy**: edita `toolkit.html`. El formulario de captura vive ahí, no en `index.html`.
- **Cursos**: cada curso tiene su propio archivo HTML independiente.

---
**Desarrollado por Teledígitos** | *Sin humo, solo métricas.*
