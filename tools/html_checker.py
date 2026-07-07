#!/usr/bin/env python3
"""
Simple HTML checker to replace fragile grep-based checks.
Checks:
- Each HTML file parses with an HTML parser.
- Key elements exist: <head>, <body>, <link rel="icon">, presence of main sections.
- Reports missing items and exits with non-zero on failure.
"""
import sys
from pathlib import Path
from html.parser import HTMLParser

class SimpleHTMLInspector(HTMLParser):
    def __init__(self):
        super().__init__()
        self.found = {"head":False, "body":False, "icon":False, "main":False}

    def handle_starttag(self, tag, attrs):
        if tag == 'head':
            self.found['head'] = True
        elif tag == 'body':
            self.found['body'] = True
        elif tag == 'main':
            self.found['main'] = True
        elif tag == 'link':
            attrs = dict(attrs)
            if attrs.get('rel') in ('icon', 'shortcut icon') or attrs.get('type') == 'image/svg+xml':
                self.found['icon'] = True

def inspect_file(path:Path):
    content = path.read_text(encoding='utf-8')
    parser = SimpleHTMLInspector()
    try:
        parser.feed(content)
    except Exception as e:
        return False, f"Parse error: {e}"
    missing = [k for k,v in parser.found.items() if not v]
    if missing:
        return False, f"Missing elements: {', '.join(missing)}"
    return True, 'OK'


def main():
    root = Path('.')
    html_files = list(root.glob('*.html'))
    failures = []
    for f in html_files:
        ok,msg = inspect_file(f)
        print(f"{f}: {msg}")
        if not ok:
            failures.append((f,msg))
    if failures:
        print(f"\n{len(failures)} files failed checks.")
        sys.exit(2)
    print('\nAll HTML files passed basic structural checks.')

if __name__ == '__main__':
    main()
