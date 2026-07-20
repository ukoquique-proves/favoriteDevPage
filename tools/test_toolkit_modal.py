#!/usr/bin/env python3
"""
Browser-level smoke test for the toolkit purchase/collaborator modal.

Catches bugs where JS toggles the `hidden` attribute but CSS keeps the
element visible anyway (e.g. `display: flex` on the same element
overriding the browser's built-in `[hidden] { display: none }` rule).
tools/html_checker.py cannot catch this: it only checks structure/IDs,
never what actually renders after a click.

Requires Playwright:
    pip install playwright --break-system-packages
    playwright install chromium

Usage:
    python3 tools/test_toolkit_modal.py                # uses toolkit.html in repo root
    python3 tools/test_toolkit_modal.py path/to/file.html
    python3 tools/test_toolkit_modal.py http://localhost:8080/toolkit.html
"""
import sys
from pathlib import Path

try:
    from playwright.sync_api import sync_playwright
except ImportError:
    print("Playwright no está instalado. Instalar con:")
    print("  pip install playwright --break-system-packages")
    print("  playwright install chromium")
    sys.exit(1)


def run(url: str) -> int:
    failures = []

    with sync_playwright() as p:
        browser = p.chromium.launch()
        page = browser.new_page()
        page.goto(url)

        modal = page.locator("#purchase-modal")
        collab_panel = page.locator("#collaborator-panel")
        buy_panel = page.locator("#buy-panel")

        # --- Abrir modal ---
        page.click("#request-package-btn")
        page.wait_for_timeout(50)
        if not modal.is_visible():
            failures.append("El modal no aparece al hacer clic en 'Solicitar paquete'.")

        # --- Cerrar con el botón X ---
        page.click(".modal__close")
        page.wait_for_timeout(100)
        if modal.is_visible():
            failures.append(
                "El modal sigue visible tras clic en 'Cerrar' "
                "(probable conflicto CSS display vs. atributo [hidden])."
            )

        # --- Reabrir e ir al panel de colaborador ---
        page.click("#request-package-btn")
        page.wait_for_timeout(50)
        page.click("#free-option-link")
        page.wait_for_timeout(50)
        if not collab_panel.is_visible():
            failures.append("El panel de colaborador no aparece tras '¿Eres colaborador?'.")

        # --- Volver a compra ---
        page.click("#back-to-buy")
        page.wait_for_timeout(100)
        if collab_panel.is_visible():
            failures.append(
                "El panel de colaborador sigue visible tras 'Volver a compra' "
                "(probable conflicto CSS display vs. atributo [hidden])."
            )
        if not buy_panel.is_visible():
            failures.append("El panel de compra no reaparece tras 'Volver a compra'.")

        # --- Cerrar haciendo clic en el backdrop ---
        page.click(".modal__backdrop", position={"x": 5, "y": 5})
        page.wait_for_timeout(100)
        if modal.is_visible():
            failures.append("El modal sigue visible tras hacer clic fuera del panel (backdrop).")

        # --- Cerrar con la tecla Escape ---
        page.click("#request-package-btn")
        page.wait_for_timeout(50)
        page.keyboard.press("Escape")
        page.wait_for_timeout(100)
        if modal.is_visible():
            failures.append("El modal sigue visible tras presionar Escape.")

        browser.close()

    if failures:
        print(f"✗ {len(failures)} fallo(s) de comportamiento del modal en {url}:\n")
        for f in failures:
            print(f"  - {f}")
        return 2

    print(f"✓ El modal del toolkit abre y cierra correctamente en {url}.")
    return 0


if __name__ == "__main__":
    if len(sys.argv) > 1:
        target = sys.argv[1]
        if not target.startswith("http"):
            target = Path(target).resolve().as_uri()
    else:
        target = Path("toolkit.html").resolve().as_uri()

    sys.exit(run(target))
