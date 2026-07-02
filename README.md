# PuppyTeach | Desarrollo Senior Ultra-Eficiente

🌐 **Sitio en vivo:** [https://ukoquique-proves.github.io/fastDevPage/](https://ukoquique-proves.github.io/fastDevPage/)

Una landing page minimalista y rápida para la Fase 2 de Teledígitos / PuppyTeach. Está pensada para desarrolladores senior que prefieren precisión técnica, claridad y comportamiento real por encima de efectos llamativos.

## 🚀 Filosofía del Proyecto

Este sitio se sostiene en la mentalidad **"Antihumo"**:
- **Minimalismo técnico**: HTML/CSS estático, sin frameworks innecesarios y sin dependencias pesadas.
- **Carga rápida**: la página debe entrar en pantalla al mismo ritmo que un `cat` desde la terminal.
- **Transparencia real**: métricas visibles, benchmark honesto y un mensaje directo.

## 🛠️ Qué contiene

Todo está en un único archivo: [index.html](index.html).

- **Hero Section**: propuesta de valor dirigida a ingenieros senior.
- **Benchmark real**: comparación de consumo de RAM entre Puppy Linux y Docker.
- **Catálogo de cursos**:
  1. Resurrección de hardware secundario para agentes de IA.
  2. Entornos inmutables con Save-Files nativos.
  3. Optimización de pipeline TrixieRetro.
- **Lead Magnet**: formulario para capturar email y entregar `Code Compacter`.

## 📧 Formulario integrado con Formspree

El formulario ya está configurado para funcionar con Formspree y AJAX, sin recarga de página.

- Endpoint: `https://formspree.io/f/mnjyeeod`
- Formulario en `index.html` con `id="puppyteach-capture-form"`
- Manejo de estados con `data-fs-success` y `data-fs-error`
- Inicialización usando una versión fija del CDN de `@formspree/ajax` con SRI y `crossorigin`

Esto significa que el usuario sigue en la misma página y el formulario puede mostrar éxito o error de forma inmediata.

## 📦 Despliegue en GitHub Pages

Para publicar:

1. Coloca [index.html](index.html) en la raíz del repositorio.
2. En GitHub, ve a **Settings > Pages**.
3. Selecciona la rama `main` (o la que uses) y la carpeta `/ (root)`.
4. Guarda.
5. El sitio quedará disponible en `https://<tu-usuario>.github.io/<nombre-repo>/`.

## 🔧 Mantenimiento y ajustes

### Actualizar datos del benchmark
Edita la sección `.benchmark` en `index.html` con los nuevos valores obtenidos de `htop` o `free -m`.

### Ajustar el lead magnet
Puedes cambiar el copy y el estilo visual del bloque del formulario sin tocar la lógica, siempre que mantengas el `id` y la inicialización de Formspree.

---
**Desarrollado por Teledígitos** | *Exactitud técnica con un toque humano.*
