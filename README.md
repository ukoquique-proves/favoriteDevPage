# PuppyTeach | Ingeniería Inusual para IA Segura

🌐 **Sitio en vivo:** [https://ukoquique-proves.github.io/favoriteDevPage/](https://ukoquique-proves.github.io/favoriteDevPage/)

Sitio web estático para la Fase 2 de Teledígitos / PuppyTeach. Dirigido a equipos que quieren arquitectura determinista, contexto auditable y ejecución local sin perder control sobre el código generado por IA.

## Filosofía del Proyecto

Construido bajo la mentalidad **"Antihumo"**: HTML/CSS estático, sin frameworks pesados, sin rastreadores, carga instantánea.

## Estructura del proyecto

```
# Páginas generadas
index.html                           # Landing page principal
toolkit.html                         # Toolkit Code Compacter: detalle, copy y modal de compra/acceso
lista-espera-gracias.html            # Confirmación de lista de espera (fallback no-JS)
curso-1-loops-compilador.html        # Detalle del Curso 1
curso-2-arquitectura-hexagonal.html  # Detalle del Curso 2
curso-3-soberania-local.html         # Detalle del Curso 3

# Plantillas y partials
*.html.template                      # Plantillas fuente usadas por el generador estático
partials/head.html                  # Partial reutilizable para <head>
partials/header.html                # Partial reutilizable para el header
partials/footer.html                # Partial reutilizable para el footer

# Estilos y assets
base.css                             # Reset, variables y estilos base compartidos
components.css                       # Estilos de componentes reutilizables (botones, formularios, tarjetas)
pages.css                            # Estilos específicos de secciones/páginas concretas
favicon.svg                          # Favicon del sitio
robots.txt                           # Directivas para crawlers
sitemap.xml                          # Mapa del sitio para SEO

# Build y checks
build.sh                             # Ejecuta el generador estático
serve.sh                             # Levanta servidor local y abre el browser automáticamente
check.sh                             # Verifica consistencia del proyecto antes de hacer push
push.sh                              # Ejecuta check.sh y sube los cambios a GitHub
tools/build.py                       # Generador estático que inyecta partials y metadata
tools/html_checker.py                # Validador HTML estructural usado por check.sh

# Documentación
README.md                            # Este archivo
CHANGELOG.md                         # Historial de cambios
ROADMAP.md                           # Tareas pendientes y dirección del producto
TROUBLESHOOTING.md                   # Diagnóstico de problemas conocidos
VISITORS_GIFT.md                     # Guía del flujo de entrega del toolkit
consejos_formato.md                  # Guía de estilo de copy para el sitio

# Configuración
.env                                 # Credenciales locales (gitignored)
.env.example                         # Plantilla de variables de entorno
.gitignore                           # Archivos excluidos del repositorio
```

## Formulario integrado con Formspree

Los formularios envían a Formspree (`https://formspree.io/f/mnjyeeod`):

- Flujo de compra/acceso del toolkit en `toolkit.html`: un modal con paneles de compra y colaborador, ambos enviados por `fetch()` AJAX. El panel de colaborador valida una contraseña de acceso ligera en el navegador y luego envía la solicitud a Formspree.
- Formulario de lista de espera: `id="puppyteach-waitlist-form"` en `index.html`

Importante: revisa el panel de Formspree para comprobar que el formulario está activo y que las notificaciones están configuradas correctamente.

## Validación ligera de contraseña de colaborador

El flujo de acceso gratuito del toolkit incluye una comprobación local muy simple basada en SHA-256:

1. El valor introducido en la contraseña se convierte a un hash SHA-256 en el navegador.
2. La página almacena el hash de la contraseña esperada en el propio JavaScript, no la contraseña en texto plano.
3. El navegador compara ambos hashes y solo permite continuar si coinciden.
4. Si la contraseña es correcta, el panel de colaborador muestra inmediatamente un botón de descarga del paquete; además, se intenta registrar la solicitud en Formspree como best effort para auditoría manual.

Este mecanismo sirve como una barrera ligera para no dejar la contraseña visible en el código fuente y para mantener el flujo simple en una landing page estática. No debe considerarse un sistema seguro de control de acceso: cualquiera que inspeccione el HTML/JS puede ver la función de hash y el hash esperado, y por tanto reproducir la comprobación. Si necesitas un acceso real y privado, la validación debe moverse a un backend o a un servicio que no exponga la lógica al usuario.

## Despliegue en GitHub Pages

1. En GitHub, ve a **Settings > Pages**.
2. Selecciona la rama `main` y la carpeta `/ (root)`.
3. Guarda. El sitio estará en `https://ukoquique-proves.github.io/favoriteDevPage/`.

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

Valida existencia de archivos, nav links, assets compartidos, placement de formularios, cobertura en README, placeholders sin completar e integridad de links internos. Además, si Playwright está instalado, ejecuta un smoke test real del modal del toolkit en un navegador Chromium para comprobar los flujos de abrir/cerrar, ir a colaborador, volver a compra y cerrar con backdrop/Escape.

El chequeo de Playwright es opcional por diseño: instala un binario de Chromium de tamaño considerable y no siempre está presente en máquinas locales de desarrollo. Por eso `check.sh` lo omite con un aviso si no está disponible, en vez de convertirlo en un requisito obligatorio para `push.sh` o para todos los desarrolladores. En CI reproducible (por ejemplo GitHub Actions) tiene sentido hacerlo obligatorio porque el entorno se crea desde cero y se puede instalar de forma determinista.

### Smoke test del modal del toolkit

Requisitos:

```bash
pip install playwright --break-system-packages
playwright install chromium
```

Ejecución:

```bash
python3 tools/test_toolkit_modal.py
```

Por defecto apunta a `toolkit.html` en la raíz del repositorio mediante `file://`, así que no requiere tener el servidor levantado; también acepta una URL si querés probarlo sobre `http://127.0.0.1:8080/toolkit.html`.

## Mantenimiento

- **Contenido de benchmark**: si se reintroduce una sección de benchmark en el diseño, debe añadirse en la plantilla y en los estilos correspondientes; hoy no existe una sección `.benchmark` en el HTML generado.
- **Toolkit copy**: edita la plantilla `toolkit.html.template` o el HTML generado `toolkit.html` para ajustar el copy y el flujo del modal de compra/acceso.
- **Cursos**: cada curso tiene su propio archivo HTML independiente.

---
**Desarrollado por Teledígitos** | *Sin humo, solo métricas.*
