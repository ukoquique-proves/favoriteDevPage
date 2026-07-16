#!/usr/bin/env python3
"""
Simple static site generator for Teledígitos landing page.
Injects partials (head, header, footer), environment variables, and per-page metadata.
"""
import os
import sys
from pathlib import Path

# Centralized per-page metadata
PAGE_METADATA = {
    'index.html.template': {
        'PAGE_TITLE': 'Teledígitos | Arquitectura determinista para detener la deuda técnica',
        'PAGE_DESCRIPTION': 'Arquitectura de Software enfocada en soberanía tecnológica, control riguroso y reducción de deuda técnica en entornos de IA.',
        'PAGE_CANONICAL': ''
    },
    'toolkit.html.template': {
        'PAGE_TITLE': 'Toolkit | Extractor de Contexto Arquitectónico Seguro',
        'PAGE_DESCRIPTION': 'Descarga el extractor de contexto diseñado para equipos que quieren controlar el contexto de los modelos de IA y evitar ruido.',
        'PAGE_CANONICAL': 'toolkit.html'
    },
    'curso-1-loops-compilador.html.template': {
        'PAGE_TITLE': 'Curso 1: Loops cerrados con compilador | Teledígitos',
        'PAGE_DESCRIPTION': 'Construye flujos deterministas donde cada cambio se valida de inmediato y los agentes de IA ayudan sin romper la arquitectura.',
        'PAGE_CANONICAL': 'curso-1-loops-compilador.html'
    },
    'curso-2-arquitectura-hexagonal.html.template': {
        'PAGE_TITLE': 'Curso 2: Arquitectura Hexagonal y DDD | Teledígitos',
        'PAGE_DESCRIPTION': 'Aprende a separar el dominio de la infraestructura para que el código generado por IA no entierre la lógica de negocio.',
        'PAGE_CANONICAL': 'curso-2-arquitectura-hexagonal.html'
    },
    'curso-3-soberania-local.html.template': {
        'PAGE_TITLE': 'Curso 3: Soberanía tecnológica y ejecución local | Teledígitos',
        'PAGE_DESCRIPTION': 'Domina el despliegue de modelos locales y entornos reproducibles. Recupera el control total de tu stack arquitectónico.',
        'PAGE_CANONICAL': 'curso-3-soberania-local.html'
    },
    'lista-espera-gracias.html.template': {
        'PAGE_TITLE': 'Inscripción Confirmada | Teledígitos',
        'PAGE_DESCRIPTION': 'Gracias por inscribirte en la lista de espera prioritaria para los próximos cursos de Teledígitos.',
        'PAGE_CANONICAL': 'lista-espera-gracias.html'
    }
}

DEFAULT_METADATA = {
    'PAGE_TITLE': 'Teledígitos | Arquitectura determinista',
    'PAGE_DESCRIPTION': 'Arquitectura de Software y soberanía tecnológica.',
    'PAGE_CANONICAL': ''
}

def main():
    root_dir = Path(__file__).parent.parent
    partials_dir = root_dir / 'partials'
    
    # Load partials
    try:
        head_partial = (partials_dir / 'head.html').read_text(encoding='utf-8')
        header_partial = (partials_dir / 'header.html').read_text(encoding='utf-8')
        footer_partial = (partials_dir / 'footer.html').read_text(encoding='utf-8')
    except Exception as e:
        print(f"Error loading partials: {e}")
        sys.exit(1)
        
    toolkit_url = os.environ.get("TOOLKIT_DOWNLOAD_URL", "")
    
    # Process all .html.template files
    template_files = list(root_dir.glob('*.html.template'))
    
    if not template_files:
        print("No .html.template files found.")
        sys.exit(0)
        
    for template_path in template_files:
        content = template_path.read_text(encoding='utf-8')
        
        # Prepare metadata for this specific template
        meta = PAGE_METADATA.get(template_path.name, DEFAULT_METADATA)
        
        # Inject metadata into the HEAD partial BEFORE injecting HEAD into the main content
        current_head = head_partial
        for key, value in meta.items():
            current_head = current_head.replace(f"{{{{{key}}}}}", value)
            
        # Inject partials
        content = content.replace("{{HEAD}}", current_head)
        content = content.replace("{{HEADER}}", header_partial)
        content = content.replace("{{FOOTER}}", footer_partial)
        
        # Inject variables
        if "{{TOOLKIT_DOWNLOAD_URL}}" in content:
            if not toolkit_url:
                print(f"Error: TOOLKIT_DOWNLOAD_URL environment variable is not set, but required by {template_path.name}")
                sys.exit(1)
            content = content.replace("{{TOOLKIT_DOWNLOAD_URL}}", toolkit_url)
            
        # Write to output file (remove .template extension)
        output_name = template_path.name[:-9] # remove '.template'
        output_path = root_dir / output_name
        
        output_path.write_text(content, encoding='utf-8')
        print(f"Built {output_name} from {template_path.name}")

if __name__ == '__main__':
    main()
