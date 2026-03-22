import os
import re

dir_path = r'd:\github\SmartHotel\Hotelll\web'

def fix_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. UPGRADE TINY FONTS OVER 400 OCCURENCES
    content = re.sub(r'text-\[8px\]', 'text-xs', content)
    content = re.sub(r'text-\[9px\]', 'text-sm', content)
    content = re.sub(r'text-\[10px\]', 'text-sm', content)
    content = re.sub(r'text-\[11px\]', 'text-base', content)
    content = re.sub(r'text-\[12px\]', 'text-base', content)
    content = re.sub(r'text-\[14px\]', 'text-lg', content)

    # 2. FIX BUTTON SIZES AND PADDINGS
    content = re.sub(r'h-12', 'h-14', content)
    content = re.sub(r'h-14', 'h-16', content) 
    
    # 3. FIX MOBILE CLIPPING ISSUES
    content = re.sub(r'h-screen overflow-hidden', 'min-h-screen overflow-y-auto lg:overflow-hidden', content)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

count = 0
for root, dirs, files in os.walk(dir_path):
    for name in files:
        if name.endswith('.jsp') or name.endswith('.jspf'):
            fix_file(os.path.join(root, name))
            count += 1
print(f"Done fixing UI classes across {count} files!")
