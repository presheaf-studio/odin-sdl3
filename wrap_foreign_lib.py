#!/usr/bin/env python3
import re
import sys
from pathlib import Path

def wrap_foreign_lib_blocks(file_path):
    """Wrap foreign lib blocks with when/else for wasm."""
    with open(file_path, 'r') as f:
        content = f.read()

    # Pattern to match foreign lib blocks with their attributes
    # Captures: (attributes)(foreign lib {)(body)(})
    pattern = r'(@\([^)]+\)\s*\n)(foreign lib \{)(\n(?:.*\n)*?)(\})'

    def replace_block(match):
        attributes = match.group(1)
        body = match.group(3)

        # Create the when/else wrapper
        wasm_block = f"""when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {{
    {attributes.strip()}
    foreign {{
{body}    }}
}} else {{
    {attributes.strip()}
    foreign lib {{
{body}    }}
}}"""
        return wasm_block

    new_content = re.sub(pattern, replace_block, content)

    # Handle cases without attributes
    pattern_no_attr = r'(^)(foreign lib \{)(\n(?:.*\n)*?)(\})'

    def replace_block_no_attr(match):
        body = match.group(3)

        wasm_block = f"""when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {{
    foreign {{
{body}    }}
}} else {{
    foreign lib {{
{body}    }}
}}"""
        return wasm_block

    new_content = re.sub(pattern_no_attr, replace_block_no_attr, new_content, flags=re.MULTILINE)

    if new_content != content:
        with open(file_path, 'w') as f:
            f.write(new_content)
        return True
    return False

if __name__ == '__main__':
    # Find all .odin files with foreign lib blocks
    sdl_dir = Path('/Users/evaporei/studio/vendor/sdl')

    for odin_file in sdl_dir.rglob('*.odin'):
        with open(odin_file, 'r') as f:
            if 'foreign lib {' in f.read():
                print(f"Processing {odin_file}...")
                if wrap_foreign_lib_blocks(odin_file):
                    print(f"  Updated {odin_file}")
