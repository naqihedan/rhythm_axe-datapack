# 时间点设置面板：显示暂存 editing.temp 的值 + 操作按钮（能按绿色，值域限制红色）
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
# 先按暂存值计算红线/绿线（每次刷新即时判定），再显示面板
execute unless data storage rhythm_axe:maps.editor editing.is_new run function rhythm_axe:editor/menu/timing/panel/timing_panel_color
tellraw @s [{"text":"====时间点设置====","color":"gold","bold":true}]
# 时间行（下限 0）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.time
execute if score #temp editor matches ..0 run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10001"},"hover_event":{"action":"show_text","value":"最少 0 刻"}},\
{"nbt":"editing.temp.time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10002"},"hover_event":{"action":"show_text","value":"时间 +1 刻"}},\
{"text":"【使用当前时间】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 10003"},"hover_event":{"action":"show_text","value":"时间设为播放头位置"}}\
]
execute if score #temp editor matches 1.. run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10001"},"hover_event":{"action":"show_text","value":"时间 -1 刻"}},\
{"nbt":"editing.temp.time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10002"},"hover_event":{"action":"show_text","value":"时间 +1 刻"}},\
{"text":"【使用当前时间】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 10003"},"hover_event":{"action":"show_text","value":"时间设为播放头位置"}}\
]
# BPM 行（对话框输入小数，三位小数显示去 f）
execute store result score #v editor run data get storage rhythm_axe:maps.editor editing.temp.bpm 1000
data modify storage rhythm_axe:prop label set value "BPM："
function rhythm_axe:editor/util/show_val3 with storage rhythm_axe:prop
data remove storage rhythm_axe:prop label
tellraw @s [{"text":"  [编辑数值]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 10101"},"hover_event":{"action":"show_text","value":"对话框输入小数（如 175.000）"}}]
# 拍号行（下限 1）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.bpb
execute if score #temp editor matches ..1 run tellraw @s [\
{"text":"拍号：","color":"gray"},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10201"},"hover_event":{"action":"show_text","value":"最少 1 拍"}},\
{"nbt":"editing.temp.bpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10202"},"hover_event":{"action":"show_text","value":"拍号 +1"}}\
]
execute if score #temp editor matches 2.. run tellraw @s [\
{"text":"拍号：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10201"},"hover_event":{"action":"show_text","value":"拍号 -1"}},\
{"nbt":"editing.temp.bpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10202"},"hover_event":{"action":"show_text","value":"拍号 +1"}}\
]
# 每拍刻数行（下限 1）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.tpb
execute if score #temp editor matches ..1 run tellraw @s [\
{"text":"每拍刻数：","color":"gray"},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10301"},"hover_event":{"action":"show_text","value":"最少 1 刻"}},\
{"nbt":"editing.temp.tpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10302"},"hover_event":{"action":"show_text","value":"每拍刻数 +1"}}\
]
execute if score #temp editor matches 2.. run tellraw @s [\
{"text":"每拍刻数：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10301"},"hover_event":{"action":"show_text","value":"每拍刻数 -1"}},\
{"nbt":"editing.temp.tpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10302"},"hover_event":{"action":"show_text","value":"每拍刻数 +1"}}\
]
# 判定缩放行（下限 1）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.judgement_scale
execute if score #temp editor matches ..1 run tellraw @s [\
{"text":"判定缩放倍数：","color":"gray"},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10401"},"hover_event":{"action":"show_text","value":"最少 1 倍"}},\
{"nbt":"editing.temp.judgement_scale","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10402"},"hover_event":{"action":"show_text","value":"判定缩放 +1"}}\
]
execute if score #temp editor matches 2.. run tellraw @s [\
{"text":"判定缩放倍数：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10401"},"hover_event":{"action":"show_text","value":"判定缩放 -1"}},\
{"nbt":"editing.temp.judgement_scale","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10402"},"hover_event":{"action":"show_text","value":"判定缩放 +1"}}\
]
# 颜色行（读计算好的 editing.is_red；新增面板无此键，跳过）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.is_red
execute if score #temp editor matches 1 run tellraw @s [{"text":"颜色：R（红线）","color":"red"}]
execute unless score #temp editor matches 1 run tellraw @s [{"text":"颜色：G（绿线）","color":"green"}]
# 行107【同步缩放】开关组（★ 2026-10-29）：改 tpb 时把谱面内容按 tps 比值换算，保持它与音乐对齐
#   两行两列排版：
#     同步缩放： [判定时间：开]  [持续时长和判定密度：开]
#               [基础寿命：开]  [时间点和事件点：开]
#   10701 判定时间（含时间点自身 time、end_time）/ 10702 持续时长和判定密度 /
#   10703 基础寿命 / 10704 时间点和事件点（= events[]，时间点 time 不归它管）
execute unless data storage rhythm_axe:maps.editor editing.is_new run tellraw @s [{"text":"同步缩放：","color":"gray","extra":[{"text":"（改 tpb 时换算下列内容，保持与音乐对齐）","color":"dark_gray","italic":true}]}]

# ── 第 1 行：10701 判定时间 + 10702 持续时长和判定密度 ──
execute if score editor_scale_time options matches 1 run data modify storage rhythm_axe:prop rs_a set value '{"text":"[判定时间：开]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10701"},"hover_event":{"action":"show_text","value":"✔ 缩放时间点作用范围内音符的判定时间，平移时间点作用范围后音符的判定时间；同时缩放作用范围后时间点的时间、事件点时间与谱面结束时间\n（时间点自身的时间必须跟着改，否则音符会溢出到下一段）\n\n点击关闭"}}'
execute unless score editor_scale_time options matches 1 run data modify storage rhythm_axe:prop rs_a set value '{"text":"[判定时间：关]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10701"},"hover_event":{"action":"show_text","value":"✘ 不调整音符判定时间 / 时间点时间 / 事件点时间 / 谱面结束时间\n关掉后改 tpb 会让谱面与音乐错位\n\n点击开启"}}'
execute if score editor_scale_hold options matches 1 run data modify storage rhythm_axe:prop rs_b set value '{"text":"[持续时长和判定密度：开]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10702"},"hover_event":{"action":"show_text","value":"✔ 按比例缩放时间点作用范围内混凝土和玻璃的持续时长，以及混凝土的判定密度（保持判定点间距）\n\n点击关闭"}}'
execute unless score editor_scale_hold options matches 1 run data modify storage rhythm_axe:prop rs_b set value '{"text":"[持续时长和判定密度：关]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10702"},"hover_event":{"action":"show_text","value":"✘ 不调整混凝土/玻璃的持续时长与混凝土的判定密度\n\n点击开启"}}'
data modify storage rhythm_axe:prop rs_prefix set value "          "
function rhythm_axe:editor/menu/timing/panel/timing_scale_row with storage rhythm_axe:prop

# ── 第 2 行：10703 基础寿命 + 10704 时间点和事件点 ──
execute if score editor_scale_life options matches 1 run data modify storage rhythm_axe:prop rs_a set value '{"text":"[基础寿命：开]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10703"},"hover_event":{"action":"show_text","value":"✔ 按比例缩放时间点作用范围内音符的基础寿命（出生→判定的现实时长不变，长条视觉长度也不变）\n\n点击关闭"}}'
execute unless score editor_scale_life options matches 1 run data modify storage rhythm_axe:prop rs_a set value '{"text":"[基础寿命：关]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10703"},"hover_event":{"action":"show_text","value":"✘ 不调整基础寿命\ntpb 变大后音符会飞得更快\n\n点击开启"}}'
execute if score editor_scale_event options matches 1 run data modify storage rhythm_axe:prop rs_b set value '{"text":"[时间点和事件点：开]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10704"},"hover_event":{"action":"show_text","value":"✔ 缩放时间点作用范围内的事件点时间，平移时间点作用范围后的事件点时间\n（时间点自身的时间由【判定时间】处理，不在此开关控制）\n\n点击关闭"}}'
execute unless score editor_scale_event options matches 1 run data modify storage rhythm_axe:prop rs_b set value '{"text":"[时间点和事件点：关]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10704"},"hover_event":{"action":"show_text","value":"✘ 不调整事件点时间（事件会与音乐错位）\n（时间点自身的时间仍由【判定时间】处理）\n\n点击开启"}}'
data modify storage rhythm_axe:prop rs_prefix set value "          "
function rhythm_axe:editor/menu/timing/panel/timing_scale_row with storage rhythm_axe:prop
# 上一个/下一个时间点（存在绿色，不存在红色）
function rhythm_axe:editor/menu/timing/panel/timing_panel_nav
# 底部按钮（按模式：新增面板无 is_new 键）
execute unless data storage rhythm_axe:maps.editor editing.is_new run function rhythm_axe:editor/menu/timing/panel/timing_panel_bottom
execute if data storage rhythm_axe:maps.editor editing.is_new run tellraw @s [\
{"text":"【取消】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10608"},"hover_event":{"action":"show_text","value":"丢弃修改并返回列表"}},\
{"text":"  【确认新增】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10603"},"hover_event":{"action":"show_text","value":"在指定时间新增时间点"}},\
{"text":"  【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 10606"},"hover_event":{"action":"show_text","value":"复制正在编辑的时间点信息"}},\
{"text":"  【粘贴】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 10607"},"hover_event":{"action":"show_text","value":"粘贴剪贴板信息到正在编辑的时间点"}}\
]
