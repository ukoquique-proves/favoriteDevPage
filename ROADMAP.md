# ROADMAP

## Estado actual

Se han aplicado múltiples mejoras menores, accesibilidad y flujo de entrega del toolkit. Para evitar ruido, las tareas completas han sido retiradas de la sección principal — el foco ahora pasa a las mejoras de mantenimiento y calidad a continuación.

## Flujo del formulario (prioridad: alta)

- [ ] Ejecutar una prueba de extremo a extremo contra el sitio publicado y verificar que Formspree recibe las entradas (aceptación: registro visible en el panel de Formspree y llegada de notificaciones al inbox configurado).
- [ ] Revisar y estandarizar los CTA del sitio para que describan con precisión su destino (aceptación: cada CTA tiene texto claro y un `title`/atributo `aria-label` cuando procede).

## Accesibilidad y SEO (prioridad: medium)

- [ ] Preparar y publicar una imagen social compartida y revisar el favicon para asegurar vistas previas correctas (aceptación: `og:image` válida y preview aceptable en la herramienta de depuración de redes sociales).
- [ ] Añadir metadatos consistentes por página: `canonical`, `og:image`, `twitter:image`, `author`, `theme-color` y `JSON-LD` básico (aceptación: cada página principal tiene `canonical` y al menos `og:title`/`og:description`).

## Contenido y credibilidad

- [x] Añadir una nota breve de metodología para los benchmarks de RAM y latencia.
- [ ] Revisar el copy principal y reescribir cualquier afirmación que suene absoluta para que quede alineada con resultados medidos.

## Arquitectura y mantenimiento (priority: high → low)

- [ ] Replace fragile grep checks with a parser-based validator (quick win): implement a small HTML parse check that verifies file parseability and presence of critical elements. (acceptance: new `tools/html_checker.py` runs without crashing and reports missing critical items).
- [ ] Improve the checker to validate structural items (links, anchors, form placement) using the parser instead of regexes (acceptance: equivalent checks pass for current site and are robust to attribute ordering/whitespace).
- [ ] Split `styles.css` into modular files (`base.css`, `layout.css`, `forms.css`, `buttons.css`, `hero.css`, `cards.css`, `tradeoff.css`, `utilities.css`) and update pages to load the modular CSS (acceptance: visual parity maintained and `check.sh` still passes).
- [ ] Remove header/footer duplication by introducing a simple build step or adopting a lightweight SSG (Eleventy/Astro/Hugo) — evaluate cost/benefit first and implement a prototype if agreed (acceptance: template approach generates identical HTML pages and reduces duplication).

## Lanzamiento y distribución

- [ ] Publicar el outreach inicial en Dev.to o Reddit para ampliar alcance y captar interés.
- [ ] Preparar una checklist breve de release para futuras actualizaciones en GitHub Pages.
