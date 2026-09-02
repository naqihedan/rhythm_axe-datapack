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
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 301"},"hover_event":{"action":"show_text","value":"最少 0 刻"}},\
{"nbt":"editing.temp.time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 302"},"hover_event":{"action":"show_text","value":"时间 +1 刻"}},\
{"text":"【使用当前时间】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 303"},"hover_event":{"action":"show_text","value":"时间设为播放头位置"}}\
]
execute if score #temp editor matches 1.. run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 301"},"hover_event":{"action":"show_text","value":"时间 -1 刻"}},\
{"nbt":"editing.temp.time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 302"},"hover_event":{"action":"show_text","value":"时间 +1 刻"}},\
{"text":"【使用当前时间】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 303"},"hover_event":{"action":"show_text","value":"时间设为播放头位置"}}\
]
# BPM 行（对话框输入小数，三位小数显示去 f）
execute store result score #v editor run data get storage rhythm_axe:maps.editor editing.temp.bpm 1000
data modify storage rhythm_axe:prop label set value "BPM："
function rhythm_axe:editor/util/show_val3 with storage rhythm_axe:prop
data remove storage rhythm_axe:prop label
tellraw @s [{"text":"  [编辑数值]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 304"},"hover_event":{"action":"show_text","value":"对话框输入小数（如 175.000）"}}]
# 拍号行（下限 1）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.bpb
execute if score #temp editor matches ..1 run tellraw @s [\
{"text":"拍号：","color":"gray"},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 305"},"hover_event":{"action":"show_text","value":"最少 1 拍"}},\
{"nbt":"editing.temp.bpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 306"},"hover_event":{"action":"show_text","value":"拍号 +1"}}\
]
execute if score #temp editor matches 2.. run tellraw @s [\
{"text":"拍号：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 305"},"hover_event":{"action":"show_text","value":"拍号 -1"}},\
{"nbt":"editing.temp.bpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 306"},"hover_event":{"action":"show_text","value":"拍号 +1"}}\
]
# 每拍刻数行（下限 1）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.tpb
execute if score #temp editor matches ..1 run tellraw @s [\
{"text":"每拍刻数：","color":"gray"},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 307"},"hover_event":{"action":"show_text","value":"最少 1 刻"}},\
{"nbt":"editing.temp.tpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 308"},"hover_event":{"action":"show_text","value":"每拍刻数 +1"}}\
]
execute if score #temp editor matches 2.. run tellraw @s [\
{"text":"每拍刻数：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 307"},"hover_event":{"action":"show_text","value":"每拍刻数 -1"}},\
{"nbt":"editing.temp.tpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 308"},"hover_event":{"action":"show_text","value":"每拍刻数 +1"}}\
]
# 判定缩放行（下限 1）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.judgement_scale
execute if score #temp editor matches ..1 run tellraw @s [\
{"text":"判定缩放倍数：","color":"gray"},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 311"},"hover_event":{"action":"show_text","value":"最少 1 倍"}},\
{"nbt":"editing.temp.judgement_scale","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 312"},"hover_event":{"action":"show_text","value":"判定缩放 +1"}}\
]
execute if score #temp editor matches 2.. run tellraw @s [\
{"text":"判定缩放倍数：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 311"},"hover_event":{"action":"show_text","value":"判定缩放 -1"}},\
{"nbt":"editing.temp.judgement_scale","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 312"},"hover_event":{"action":"show_text","value":"判定缩放 +1"}}\
]
# 颜色行（读计算好的 editing.is_red；新增面板无此键，跳过）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.is_red
execute if score #temp editor matches 1 run tellraw @s [{"text":"颜色：R（红线）","color":"red"}]
execute unless score #temp editor matches 1 run tellraw @s [{"text":"颜色：G（绿线）","color":"green"}]
# 上一个/下一个时间点（存在绿色，不存在红色）
function rhythm_axe:editor/menu/timing/panel/timing_panel_nav
# 底部按钮（按模式：新增面板无 is_new 键）
execute unless data storage rhythm_axe:maps.editor editing.is_new run function rhythm_axe:editor/menu/timing/panel/timing_panel_bottom
execute if data storage rhythm_axe:maps.editor editing.is_new run tellraw @s [\
{"text":"【取消】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 320"},"hover_event":{"action":"show_text","value":"丢弃修改并返回列表"}},\
{"text":"  【确认新增】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 319"},"hover_event":{"action":"show_text","value":"在指定时间新增时间点"}},\
{"text":"  【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 322"},"hover_event":{"action":"show_text","value":"复制正在编辑的时间点信息"}},\
{"text":"  【粘贴】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 323"},"hover_event":{"action":"show_text","value":"粘贴剪贴板信息到正在编辑的时间点"}}\
]
