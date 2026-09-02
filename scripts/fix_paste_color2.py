# -*- coding: utf-8 -*-
# 修复：每个 if-note_clip 块缺 ] 闭合（在 unless 块头前补 ]）
import re, io

path = r"D:\Program Files (x86)\Minecrafts\PCL 正式版 2.10.3 (1)\.minecraft\versions\节奏地图 高版本重制版\saves\节奏地图模板2026\datapacks\rhythm_axe\data\rhythm_axe\function\editor\menu\note\list\note_list_line.mcfunction"
content = io.open(path, encoding='utf-8').read()

# 在 "\<换行>$execute ... unless data ..." 处，于 "\ 后补 "]"
pat = re.compile(
    r'(\\\n)(\$execute if score #note_type editor matches \d unless data storage rhythm_axe:maps.editor note_clip run tellraw @s \[\\\n)')
new, count = pat.subn(lambda m: m.group(1) + ']\n' + m.group(2), content)
io.open(path, 'w', encoding='utf-8', newline='\n').write(new)
print('fixed missing ] :', count)
