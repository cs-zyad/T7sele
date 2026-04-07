import os

file_path = 'index.html'
with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

# CSS Extraction (Lines 9-1319 in 1-indexed are indices 8 to 1319)
# Wait, let's look at the findstr result again:
# 8: <style>
# 1320: </style>
# 2007: <script>
# 2271: </script>
# So indices:
# index 8: line 9
# index 1319: line 1320 (this is </style>)
# Therefore index 8 to 1319 is line 9 to 1320.
# We want lines 9 to 1319 (indices 8 to 1319).
css_content = "".join(lines[8:1319])

# JS Extraction (Lines 2008 to 2270)
# indices 2007 to 2270.
js_content = "".join(lines[2007:2270])

# HTML reconstruction
new_html_lines = lines[0:7]
new_html_lines.append('<link rel="stylesheet" href="style.css">\n')
new_html_lines.extend(lines[1320:2006])
new_html_lines.append('<script src="app.js"></script>\n')
new_html_lines.extend(lines[2271:])

with open('style.css', 'w', encoding='utf-8') as f:
    f.write(css_content)

with open('app.js', 'w', encoding='utf-8') as f:
    f.write(js_content)

with open('index.html', 'w', encoding='utf-8') as f:
    f.writelines(new_html_lines)

print("Split completed successfully!")
