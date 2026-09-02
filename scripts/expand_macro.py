# -*- coding: utf-8 -*-
# 宏展开检查：把宏函数的所有 $ 行用测试值展开成普通命令，写入数据包 _macro_check/ 目录。
# /reload 后游戏会加载这些展开版函数——若有语法错误会在 latest.log 报 "Failed to load function"，
# 从而用"游戏本身"做宏命令的语法检查（$ 行的错误平时藏在宏里不会被检查）。
# 用法：python scripts/expand_macro.py <mcfunction路径>
import re, io, os, sys

path = sys.argv[1]
content = io.open(path, encoding='utf-8').read()
lines = content.split('\n')

# 拼合续行
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

# #arg 声明
arglist = []
for l in logical:
    m = re.match(r'^\s*#arg\s*:\s*(.+)$', l)
    if m:
        arglist = [x.strip() for x in m.group(1).split(',') if x.strip()]
        break

# 测试值：字符串→test（裸值，模拟真实宏展开后的值）、浮点→0.0、其余数字→0
# 注意字符串必须用裸值（无引号）：真实宏展开 $(mapid) 得 "test"（无引号），
# 若测试值带引号会产生 maps."test" / set value ""test"" 之类的假错误
# 命令类参数（cur_cmd 等会被 run $(x) 执行）→ 用合法命令 "say x"，否则展开版 run test 加载失败
CMD_KEYS = {'cur_cmd'}
STR_KEYS = {'mapid','title','artist','music','preview','list_name','kind','direction',
            'clip_action','custom_tag','field_name','label','old_mapid','new_mapid',
            'value','fb','cmd_value','he_cmd','command','insert_mode',
            'type_name','name','spawn','prev','line','text'}
FLOAT_KEYS = {'bpm','speed','size','position_x','position_y','position_z','start_x',
              'start_y','start_z','spawn_x','spawn_y','spawn_z','spawn_yaw','spawn_pitch',
              'min','max','tpb','offset'}

def testval(name):
    if name in CMD_KEYS:
        return 'say x'
    if name in STR_KEYS:
        return 'test'
    if name in FLOAT_KEYS:
        return '0.0'
    return '0'

out_lines = []
for l in logical:
    if re.match(r'^\s*#', l):          # 注释保留
        out_lines.append(l)
        continue
    if l.lstrip().startswith('$'):
        body = l.lstrip()[1:].lstrip()
        for name in arglist:
            body = body.replace('$(' + name + ')', testval(name))
        out_lines.append(body)
    else:
        out_lines.append(l)

# 写展开版到数据包 _macro_check/ 目录（reload 时被游戏加载做语法检查）
base = os.path.dirname(path)
# 向上找到 data/rhythm_axe/function
func_root = None
p = base
while os.path.basename(p) != 'function' and os.path.dirname(p) != p:
    p = os.path.dirname(p)
func_root = p
outdir = os.path.join(func_root, '_macro_check')
os.makedirs(outdir, exist_ok=True)
name = os.path.basename(path).replace('.mcfunction', '_expanded.mcfunction')
out = os.path.join(outdir, name)
io.open(out, 'w', encoding='utf-8', newline='\n').write('\n'.join(out_lines) + '\n')
print('expanded ->', out)
