# ROADMAP

## Estado actual

La hoja se centra ahora en las mejoras pendientes más relevantes para la estrategia de producto y el mantenimiento del sitio.

## Posicionamiento y narrativa (prioridad: alta)

- [x] Reescribir el hero para pasar de una propuesta centrada en hardware/ram a una narrativa de control arquitectónico, determinismo y reducción de deuda técnica generada por IA.
- [x] Rediseñar el catálogo de cursos/workshops para que refleje los tres ejes del orquestador propuesto: loops cerrados con compilador, Arquitectura Hexagonal y DDD, y soberanía tecnológica/ejecución local.
- [ ] Estructurar el contenido interno de los programas de estudio en cada una de las páginas individuales de los cursos, con módulos, objetivos y entregables claros.
- [x] Reposicionar el toolkit como un "Extractor de Contexto Arquitectónico Seguro" en lugar de un simple alimentador para agentes de IA.
- [x] Ajustar la tabla de trade-off para hablar del dolor del CTO (deuda técnica silenciosa, arquitectura limpia y control del código generado por IA) en lugar de enfatizar solo el ahorro de RAM.

## Flujo del formulario (prioridad: alta)

- [x] **Whitelistear dominio en Formspree**: en formspree.io → form `mnjyeeod` → Settings → añadir `ukoquique-proves.github.io` a los dominios permitidos. Sin esto el `fetch()` en `toolkit.html` recibirá un 403 y no se completará el envío.
- [ ] Ejecutar una prueba de extremo a extremo contra el sitio publicado y verificar que Formspree recibe las entradas y que el flujo de éxito llega a la página correcta.
- [ ] Revisar y estandarizar los CTA del sitio para que describan con precisión su destino y su valor de negocio.
- [ ] **Detalle de seguridad a tener presente (no bloqueante, pero avisemos):** el hash SHA-256 sin sal sigue expuesto en el JS público, así que alguien con conocimientos técnicos podría, en teoría, extraer la contraseña real por fuerza bruta offline sin pasar por el formulario. Como ya se documenta en el `README.md`, esto es aceptable si la contraseña solo es una barrera liviana para colaboradores de confianza y no un control de acceso real; pero si el paquete tiene valor comercial, vale la pena saberlo explícitamente: alguien que rompa el hash localmente obtiene el link/paquete sin que quede ningún registro en Formspree, porque la descarga ya no depende de esa llamada.
  - A futuro, la única forma robusta de cerrarlo sería mover la verificación de contraseña a un backend o una función serverless que sea quien entregue el link, pero eso ya no es "landing estática sin backend" y probablemente no valga la pena para el caso de uso actual.

## Accesibilidad y SEO (prioridad: medium)

- [ ] Preparar y publicar una imagen social compartida y revisar el favicon para asegurar vistas previas correctas.
- [x] Añadir metadatos consistentes por página: `canonical`, `og:image`, `twitter:image`, `author` y `theme-color` — hecho vía `PAGE_METADATA` en `tools/build.py` e inyectado en `partials/head.html`.
- [ ] Añadir `JSON-LD` básico (`Organization`/`WebSite`) por página — pendiente, no incluido en la migración de metadatos anterior.

## Arquitectura y mantenimiento (prioridad: media/baja)

- [x] Sustituir las comprobaciones frágiles basadas en `grep` por una validación basada en un parser HTML — hecho: `tools/html_checker.py` valida estructura, formularios, anclas y enlaces; `check.sh` solo conserva existencia de archivos, cobertura en README y placeholders.
- [x] Mejorar el checker para validar estructura, enlaces, anclas y ubicación de formularios con mayor robustez frente a cambios de formato HTML — cubierto por `RobustHTMLInspector` en `tools/html_checker.py`.
- [x] Dividir `styles.css` en módulos más pequeños — hecho: `base.css` (variables, reset, tipografía, layout global), `components.css` (botones, formularios, tarjetas, badges, banner, benchmark), `pages.css` (hero, lead-magnet, inscripciones, tradeoff, cta).
- [x] Reducir la duplicación de header/footer mediante plantillas, un paso de build o un generador estático ligero — hecho: `tools/build.py` + `partials/` (`head.html`, `header.html`, `footer.html`), aplicado de forma consistente en las seis plantillas `.html.template`.

## Lanzamiento y distribución

- [ ] Publicar el outreach inicial en Dev.to o Reddit para ampliar alcance y captar interés.
- [ ] Preparar una checklist breve de release para futuras actualizaciones en GitHub Pages.

### Observaciones operativas (desde `OBSERVACIONES.md`)

- [ ] **INTEG** Catalogar `SimpleHTMLInspector` como recurso de infraestructura invocable por `ops-core`:
	- Añadir o exponer un `check.sh` en el repo que llame a `SimpleHTMLInspector`.
	- Documentar en `README.md` del sitio cómo `ops-core` debe invocar ese `check.sh`.
	- **Aceptación:** `ops-core` puede invocar el check y recibe un código de salida claro.

- [ ] **FIX** Revisar la entrega manual del toolkit:
	- Si se vuelve a introducir un botón o enlace de descarga directa, debe gestionarse de forma explícita en el build o en una variable de entorno.
	- **Aceptación:** El flujo actual de compra/acceso queda documentado, y cualquier futura descarga directa debe ser declarada explícitamente en la documentación y no quedar implícita en el HTML.
