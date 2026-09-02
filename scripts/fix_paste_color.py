# -*- coding: utf-8 -*-
# note_list_line: 每个类型块拆成 if/unless note_clip 两版，粘贴按钮有剪贴板黄、无剪贴板红
import re, io

path = r"D:\Program Files (x86)\Minecrafts\PCL 正式版 2.10.3 (1)\.minecraft\versions\节奏地图 高版本重制版\saves\节奏地图模板2026\datapacks\rhythm_axe\data\rhythm_axe\function\editor\menu\note\list\note_list_line.mcfunction"
content = io.open(path, encoding='utf-8').read()

# 块：$execute if score #note_type editor matches N run tellraw @s [\ ... \n]
block_re = re.compile(
    r'(\$execute if score #note_type editor matches (\d) run tellraw @s \[\\\n)(.*?)(\n\])',
    re.DOTALL)

def repl(m):
    header = m.group(1)   # ends with run tellraw @s [\
    body = m.group(3)
    # 有剪贴板版：if data note_clip，粘贴保持黄色
    v1_header = header.replace('run tellraw @s [\\', 'if data storage rhythm_axe:maps.editor note_clip run tellraw @s [\\', 1)
    # 无剪贴板版：unless data note_clip，粘贴改红色
    v2_header = header.replace('run tellraw @s [\\', 'unless data storage rhythm_axe:maps.editor note_clip run tellraw @s [\\', 1)
    v2_body = body.replace('{"text":"【粘贴】","color":"yellow"', '{"text":"【粘贴】","color":"red"')
    v2_body = v2_body.replace('"value":"粘贴到该时间"', '"value":"剪贴板为空，先复制一个音符"')
    return v1_header + body + '\n' + v2_header + v2_body + m.group(4)

new, count = block_re.subn(repl, content)
io.open(path, 'w', encoding='utf-8', newline='\n').write(new)
print('blocks replaced:', count)
