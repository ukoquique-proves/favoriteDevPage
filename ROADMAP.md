# ROADMAP

# ROADMAP

## Estado actual

La hoja se centra ahora en las mejoras pendientes más relevantes para la estrategia de producto y el mantenimiento del sitio.

## Posicionamiento y narrativa (prioridad: alta)

- [ ] Reescribir el hero para pasar de una propuesta centrada en hardware/ram a una narrativa de control arquitectónico, determinismo y reducción de deuda técnica generada por IA.
- [ ] Rediseñar el catálogo de cursos/workshops para que refleje los tres ejes del orquestador propuesto: loops cerrados con compilador, Arquitectura Hexagonal y DDD, y soberanía tecnológica/ejecución local.
- [ ] Estructurar el contenido interno de los programas de estudio en cada una de las páginas individuales de los cursos, con módulos, objetivos y entregables claros.
- [ ] Reposicionar el toolkit como un "Extractor de Contexto Arquitectónico Seguro" en lugar de un simple alimentador para agentes de IA.
- [ ] Ajustar la tabla de trade-off para hablar del dolor del CTO (deuda técnica silenciosa, arquitectura limpia y control del código generado por IA) en lugar de enfatizar solo el ahorro de RAM.

## Flujo del formulario (prioridad: alta)

- [x] **Whitelistear dominio en Formspree**: en formspree.io → form `mnjyeeod` → Settings → añadir `ukoquique-proves.github.io` a los dominios permitidos. Sin esto el `fetch()` en `toolkit.html` recibirá un 403 y el bloque `#form-success` no aparecerá.
- [x] **Subir release `v0.1.0` en `favoriteDevPage`**: crear el release en github.com/ukoquique-proves/favoriteDevPage → Releases → Draft new release → tag `v0.1.0` → subir `Code_Compacter.tar.gz`. Hasta entonces el botón de descarga en el bloque `#form-success` de `toolkit.html` dará 404.
- [ ] Ejecutar una prueba de extremo a extremo contra el sitio publicado y verificar que Formspree recibe las entradas y que el flujo de éxito llega a la página correcta.
- [ ] Revisar y estandarizar los CTA del sitio para que describan con precisión su destino y su valor de negocio.

## Accesibilidad y SEO (prioridad: medium)

- [ ] Preparar y publicar una imagen social compartida y revisar el favicon para asegurar vistas previas correctas.
- [ ] Añadir metadatos consistentes por página: `canonical`, `og:image`, `twitter:image`, `author`, `theme-color` y `JSON-LD` básico.

## Arquitectura y mantenimiento (prioridad: media/baja)

- [ ] Sustituir las comprobaciones frágiles basadas en `grep` por una validación basada en un parser HTML.
- [ ] Mejorar el checker para validar estructura, enlaces, anclas y ubicación de formularios con mayor robustez frente a cambios de formato HTML.
- [ ] Dividir `styles.css` en módulos más pequeños (`base.css`, `layout.css`, `forms.css`, `buttons.css`, `hero.css`, `cards.css`, `tradeoff.css`, `utilities.css`).
- [ ] Reducir la duplicación de header/footer mediante plantillas, un paso de build o un generador estático ligero.

## Lanzamiento y distribución

- [ ] Publicar el outreach inicial en Dev.to o Reddit para ampliar alcance y captar interés.
- [ ] Preparar una checklist breve de release para futuras actualizaciones en GitHub Pages.
