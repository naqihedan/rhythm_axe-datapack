# -*- coding: utf-8 -*-
# 全项目扫描宏函数：展开 $ 行后检查 `data modify storage <id> <action>` 缺 target 路径
# （26.x 的 <path> 不能省略，根要用 {}，缺了会在实例化时报 "错误的命令参数 at <action>"）
import re, io, os

ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'data', 'rhythm_axe', 'function')

STR_KEYS = {'mapid','title','artist','music','preview','list_name','kind','direction',
            'clip_action','custom_tag','field_name','label','old_mapid','new_mapid',
            'value','fb','cmd_value','he_cmd','command','insert_mode','cur_cmd',
            'type_name','name','spawn','prev','line','text'}
FLOAT_KEYS = {'bpm','speed','size','position_x','position_y','position_z','start_x',
              'start_y','start_z','spawn_x','spawn_y','spawn_z','spawn_yaw','spawn_pitch',
              'min','max','tpb','offset'}
def testval(name):
    if name in STR_KEYS:
        return 'test'
    if name in FLOAT_KEYS:
        return '0.0'
    return '0'

# data modify storage <id> <action>（缺 path）检测
ACTION_RE = re.compile(r'^data modify storage [A-Za-z0-9_.:]+ (set|merge|remove|append|insert|prepend)\b')

hits = []
total_files = 0
for dirpath, dirs, files in os.walk(ROOT):
    if '_macro_check' in dirpath:
        continue
    for fn in files:
        if not fn.endswith('.mcfunction'):
            continue
        f = os.path.join(dirpath, fn)
        rel = os.path.relpath(f, ROOT)
        total_files += 1
        content = io.open(f, encoding='utf-8').read()
        lines = content.split('\n')
        # 拼续行
        logical = []
        buf = ''
        for l in lines:
            if l.rstrip().endswith('\\'):
                buf += l.rstrip()[:-1] + ' '
            else:
                buf += l
                logical.append(buf)
                buf = ''
        if buf:
            logical.append(buf)
        # #arg
        arglist = []
        for l in logical:
            m = re.match(r'^\s*#arg\s*:\s*(.+)$', l)
            if m:
                arglist = [x.strip() for x in m.group(1).split(',') if x.strip()]
                break
        # 展开 $ 行（仅宏函数）
        for i, l in enumerate(logical):
            body = l.strip()
            if body.startswith('$') and arglist:
                body = body[1:].strip()
                for name in arglist:
                    body = body.replace('$(' + name + ')', testval(name))
            if body.startswith('#'):
                continue
            if ACTION_RE.match(body):
                hits.append((rel, i + 1, body))

print('scanned files:', total_files)
if hits:
    print('FOUND data modify missing target path:')
    for rel, ln, body in hits:
        print('  %s line %d: %s' % (rel, ln, body))
else:
    print('no missing-target-path found')
