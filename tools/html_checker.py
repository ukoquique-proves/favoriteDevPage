#!/usr/bin/env python3
"""
Robust HTML checker to replace fragile grep-based checks.
Validates structure, specific forms, and internal link integrity.
"""
import sys
import urllib.parse
from pathlib import Path
from html.parser import HTMLParser

class RobustHTMLInspector(HTMLParser):
    def __init__(self, filename):
        super().__init__()
        self.filename = filename
        
        self.found = {
            "head": False, 
            "body": False, 
            "main": False, 
            "footer": False
        }
        
        # Track IDs (for anchor validation and form checks)
        self.ids = set()
        
        # Track links and references
        self.links = [] # list of href strings from <a>
        self.stylesheets = set() # list of href strings for css
        self.icons = set() # list of href strings for icons
        
    def handle_starttag(self, tag, attrs):
        attrs_dict = dict(attrs)
        
        if 'id' in attrs_dict:
            self.ids.add(attrs_dict['id'])
            
        if tag in self.found:
            self.found[tag] = True
            
        if tag == 'a' and 'href' in attrs_dict:
            self.links.append(attrs_dict['href'])
            
        if tag == 'link':
            rel = attrs_dict.get('rel', '')
            href = attrs_dict.get('href', '')
            if href:
                if 'stylesheet' in rel:
                    self.stylesheets.add(href.split('/')[-1])
                elif 'icon' in rel or attrs_dict.get('type') == 'image/svg+xml':
                    self.icons.add(href.split('/')[-1])

def check_files(root: Path):
    html_files = list(root.glob('*.html'))
    failures = []
    file_data = {}
    
    # Pass 1: Parse all files
    for f in html_files:
        content = f.read_text(encoding='utf-8')
        parser = RobustHTMLInspector(f.name)
        try:
            parser.feed(content)
            file_data[f.name] = parser
        except Exception as e:
            failures.append(f"[{f.name}] Parse error: {e}")
            continue

    # Pass 2: Per-file checks
    for f in html_files:
        fname = f.name
        if fname not in file_data:
            continue
        parser = file_data[fname]
        
        # Basic structure
        for key in ["head", "body", "footer"]:
            if not parser.found[key]:
                failures.append(f"[{fname}] Missing <{key}> tag")
                
        if fname not in {"lista-espera-gracias.html"} and not parser.found["main"]:
            failures.append(f"[{fname}] Missing <main> tag")

        # CSS and Icons
        if "base.css" not in parser.stylesheets:
            failures.append(f"[{fname}] Missing reference to base.css")
        if "favicon.svg" not in parser.icons:
            failures.append(f"[{fname}] Missing reference to favicon.svg")
            
        # Header nav back to index (must link to index.html directly)
        if fname != "index.html":
            has_index_link = any(urllib.parse.urlparse(href).path in ("index.html", "") and not href.startswith(('http', 'mailto')) for href in parser.links)
            if not has_index_link:
                 failures.append(f"[{fname}] Missing nav link back to index.html")
                     
        # Form placement based on IDs
        has_purchase_modal = "purchase-modal" in parser.ids
        has_buy_panel = "buy-panel" in parser.ids
        has_collaborator_panel = "collaborator-panel" in parser.ids
        has_waitlist = "puppyteach-waitlist-form" in parser.ids
        
        if fname == "toolkit.html":
            if not has_purchase_modal: failures.append(f"[{fname}] Missing purchase-modal")
            if not has_buy_panel: failures.append(f"[{fname}] Missing buy-panel")
            if not has_collaborator_panel: failures.append(f"[{fname}] Missing collaborator-panel")
            if has_waitlist: failures.append(f"[{fname}] Contains puppyteach-waitlist-form (should only be in index.html)")
        elif fname == "index.html":
            if not has_waitlist: failures.append(f"[{fname}] Missing puppyteach-waitlist-form")
            if has_purchase_modal or has_buy_panel or has_collaborator_panel:
                failures.append(f"[{fname}] Contains toolkit modal IDs (should only be in toolkit.html)")
        else:
            if has_purchase_modal or has_buy_panel or has_collaborator_panel:
                failures.append(f"[{fname}] Contains toolkit modal IDs")
            if has_waitlist: failures.append(f"[{fname}] Contains puppyteach-waitlist-form")

    # Pass 3: Link Integrity
    for fname, parser in file_data.items():
        for href in parser.links:
            # Skip external links and mailto
            if href.startswith(('http://', 'https://', 'mailto:')):
                continue
                
            # Parse href
            parsed = urllib.parse.urlparse(href)
            target_file = parsed.path
            anchor = parsed.fragment
            
            # If path is empty, it refers to the current file
            if not target_file:
                target_file = fname
            elif target_file == '/':
                target_file = 'index.html'
                
            # Internal HTML file?
            if target_file.endswith('.html') or target_file == 'index.html':
                if target_file not in file_data:
                    failures.append(f"[{fname}] Links to missing file: {target_file}")
                else:
                    # Check anchor
                    if anchor and anchor not in file_data[target_file].ids:
                        failures.append(f"[{fname}] Links to missing anchor '#{anchor}' in {target_file}")

    # Pass 4: Cross-page consistency checks
    import re
    header_contents = {}
    for f in html_files:
        content = f.read_text(encoding='utf-8')
        header_match = re.search(r'(?s)<header>.*?</header>', content)
        if header_match:
            header_contents[f.name] = header_match.group(0)
            
    if header_contents:
        first_header = list(header_contents.values())[0]
        for fname, header in header_contents.items():
            if header != first_header:
                failures.append(f"[{fname}] <header> content is not identical to other pages (inconsistent partial)")

    if failures:
        print(f"✗ {len(failures)} HTML validation errors found:\n")
        for fail in failures:
            print(f"  {fail}")
        sys.exit(2)
        
    print("✓ All parser-based HTML structural and link integrity checks passed.")

if __name__ == '__main__':
    root_dir = Path(__file__).parent.parent
    check_files(root_dir)
