# PuppyTeach | Desarrollo Senior Ultra-Eficiente

🌐 **Sitio en vivo:** [https://ukoquique-proves.github.io/fastDevPage/](https://ukoquique-proves.github.io/fastDevPage/)

Sitio web minimalista y de alto rendimiento diseñado para la Fase 2 de Teledígitos / PuppyTeach. Este proyecto sirve como la landing page oficial para desarrolladores senior, enfocada en métricas reales y optimización extrema de recursos.

## 🚀 Filosofía del Proyecto

Este sitio ha sido construido bajo el concepto **"Antihumo"**:
- **Minimalismo Técnico**: Sin frameworks pesados, sin rastreadores innecesarios.
- **Velocidad Extrema**: HTML/CSS estático para carga instantánea.
- **Autoridad Técnica**: Diseño orientado a datos (benchmarks) y eficiencia (RAM).

## 🛠️ Estructura del Sitio

El proyecto se basa en un único archivo [index.html](index.html) que incluye:
- **Hero Section**: Propuesta de valor cruda y técnica.
- **Benchmark Real**: Comparativa de consumo de RAM (Puppy Linux vs Docker).
- **Catálogo de Cursos**:
  1. Resurrección de Hardware Secundario para Agentes de IA.
  2. Entornos Inmutables con Save-Files (Nativo).
  3. Optimización Pipeline TrixieRetro.
- **Lead Magnet**: Sección para descarga de `Code Compacter CLI & Desktop`.

## 📦 Despliegue en GitHub Pages

Para poner este sitio en producción:

1. Asegúrate de que el archivo [index.html](index.html) esté en la raíz de tu repositorio.
2. Ve a **Settings** en tu repositorio de GitHub.
3. Navega a **Pages** en el menú lateral.
4. En **Build and deployment**, selecciona la rama `main` (o la que estés usando) y la carpeta `/ (root)`.
5. Haz clic en **Save**. El sitio estará disponible en `https://<tu-usuario>.github.io/<nombre-repo>/`.

## 🔧 Personalización

### Integración de Email Marketing
Para activar el formulario de captura:
1. Obtén el código de inserción (embed code) de tu proveedor (ConvertKit, MailerLite, etc.).
2. Reemplaza el botón en la sección `#lead-magnet` dentro de `index.html` con el código proporcionado por tu plataforma de email.

### Actualización de Métricas
Si realizas nuevos benchmarks, puedes actualizar los valores en la clase `.benchmark` dentro de `index.html` para reflejar los datos más recientes de `htop` o `free -m`.

---
**Desarrollado por Teledígitos** | *Sin humo, solo métricas.*
