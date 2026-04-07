import os

source_file = 'c:/Users/ZYAD_/OneDrive/سطح المكتب/تحصيلي.txt'
with open(source_file, 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Common parts for each page
# Header part (up to <style> tag)
page_header = '''<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<title>تحصيلي — UI Prototype</title>
<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;500;600;700;800;900&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="phone-frame">
  <div class="dynamic-island"></div>
'''

page_footer = '''
</div>
<script src="app.js"></script>
</body>
</html>'''

# Ranges according to markers
# index = line_number - 1
ranges = [
    ('splash', 1328, 1346, 'index.html'),
    ('login', 1346, 1379, 'login.html'),
    ('onboarding', 1379, 1423, 'onboarding.html'),
    ('home', 1423, 1543, 'home.html'),
    ('session', 1543, 1596, 'session.html'),
    ('result', 1596, 1664, 'result.html'),
    ('progress', 1664, 1818, 'progress.html'),
    ('settings', 1818, 1945, 'settings.html'),
    ('coming', 1945, 2002, 'coming-soon.html')
]

for name, start, end, filename in ranges:
    body_content = "".join(lines[start:end])
    # The extracted content has "screen" class. We should make it "screen active"
    # because in standalone files, the screen is always visible.
    body_content = body_content.replace('class="screen"', 'class="screen active"')
    
    # Special fix for the splash screen - it needs to be "active" to show up first
    if filename == 'index.html' and 'class="screen"' not in body_content:
        # Fallback if the replace didn't work for any reason
        body_content = body_content.replace('id="splash"', 'id="splash" class="screen active"')

    with open(filename, 'w', encoding='utf-8') as pf:
        pf.write(page_header + body_content + page_footer)

# Update app.js for navigation
js_file = 'app.js'
with open(js_file, 'r', encoding='utf-8') as f:
    js_content = f.read()

# Define the routing table
routing_logic = '''const pages_map = {
    'splash': 'index.html',
    'login': 'login.html',
    'onboarding': 'onboarding.html',
    'home': 'home.html',
    'session': 'session.html',
    'result': 'result.html',
    'progress-screen': 'progress.html',
    'settings': 'settings.html',
    'coming': 'coming-soon.html'
  };'''

import re
pattern = r'function goTo\(screenId\) \{.*?\}'
replacement = '''function goTo(screenId) {
  ''' + routing_logic + '''
  if (pages_map[screenId]) {
    window.location.href = pages_map[screenId];
  } else {
    // Fallback for internal elements if needed
    document.querySelectorAll('.screen').forEach(s => {
      s.classList.remove('active');
      s.style.display = 'none';
    });
    const target = document.getElementById(screenId);
    if (target) {
      target.style.display = 'flex';
      requestAnimationFrame(() => {
        target.classList.add('active');
      });
    }
  }
}'''

new_js = re.sub(pattern, replacement, js_content, flags=re.DOTALL)

with open(js_file, 'w', encoding='utf-8') as f:
    f.write(new_js)

print("Project architecture updated successfully!")
