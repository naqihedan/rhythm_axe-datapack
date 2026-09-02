# 谱面设置面板：显示暂存副本 panel_temp 的值 + 编辑按钮；修改只动暂存，【保存设置】才写回并进历史
# 文本组件 26.1 命名：click_event（run_command 用 command）、hover_event（show_text 用 value）
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
tellraw @s [{"text":"====谱面设置====","color":"gold","bold":true}]
tellraw @s [\
{"text":"谱面id：","color":"gray"},\
{"nbt":"mapid","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑文本]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 106"},"hover_event":{"action":"show_text","value":"编辑谱面 id"}}\
]
# 标题用宏传（26.x nbt interpret 不解析，会显示原始 JSON；title 存字符串=JSON 组件）
data modify storage rhythm_axe:prop title set from storage rhythm_axe:maps.editor panel_temp.title
# ★ title 若为复合 {text:...}，宏 $(title) 传不了（标题行不显示）→ 清洗为字符串（与 main_header 一致）
execute if data storage rhythm_axe:prop title.text run data modify storage rhythm_axe:prop title set from storage rhythm_axe:prop title.text
function rhythm_axe:editor/menu/map/panel/map_panel_title with storage rhythm_axe:prop
data remove storage rhythm_axe:prop title
tellraw @s [\
{"text":"作者：","color":"gray"},\
{"nbt":"panel_temp.artist","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑文本]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 102"},"hover_event":{"action":"show_text","value":"编辑作者"}}\
]
tellraw @s [\
{"text":"音乐文件：","color":"gray"},\
{"nbt":"panel_temp.music","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑文本]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 103"},"hover_event":{"action":"show_text","value":"编辑音乐文件"}}\
]
tellraw @s [\
{"text":"预览音频：","color":"gray"},\
{"nbt":"panel_temp.preview","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑文本]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 104"},"hover_event":{"action":"show_text","value":"编辑预览音频"}}\
]
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.teleport
execute if score #temp editor matches 1 run tellraw @s [\
{"text":"传送玩家：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 105"},"hover_event":{"action":"show_text","value":"设为不传送"}},\
{"text":" 是 ","color":"white"},\
{"text":"[+]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 129"},"hover_event":{"action":"show_text","value":"已开启传送"}},\
{"text":"  【传送到谱面初始位置】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 130"},"hover_event":{"action":"show_text","value":"无条件传送到谱面初始位置"}}\
]
execute unless score #temp editor matches 1 run tellraw @s [\
{"text":"传送玩家：","color":"gray"},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 105"},"hover_event":{"action":"show_text","value":"已关闭传送"}},\
{"text":" 否 ","color":"white"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 129"},"hover_event":{"action":"show_text","value":"设为传送"}},\
{"text":"  【传送到谱面初始位置】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 130"},"hover_event":{"action":"show_text","value":"无条件传送到谱面初始位置"}}\
]
# 初始位置一行三轴（一位小数显示，去 d 后缀；负零加前导 -）
# ★ 修负数值颠倒/补数：/= 向下取整、%= floorMod，直接拆分负数会错位；改为绝对值拆分 + 独立符号。
execute store result score #vx editor run data get storage rhythm_axe:maps.editor panel_temp.spawn_x 1000
execute store result score #vy editor run data get storage rhythm_axe:maps.editor panel_temp.spawn_y 1000
execute store result score #vz editor run data get storage rhythm_axe:maps.editor panel_temp.spawn_z 1000
scoreboard players set #vxneg editor 0
execute if score #vx editor matches ..-1 run scoreboard players set #vxneg editor 1
scoreboard players operation #vxi editor = #vx editor
execute if score #vxi editor matches ..-1 run scoreboard players operation #vxi editor *= -1 const
scoreboard players operation #vxf editor = #vxi editor
scoreboard players operation #vxi editor /= 1000 const
scoreboard players operation #vxf editor %= 1000 const
scoreboard players operation #vxf editor /= 100 const
scoreboard players set #nx editor 0
execute if score #vxneg editor matches 1 if score #vxi editor matches 0 run scoreboard players set #nx editor 1
execute if score #vxneg editor matches 1 run scoreboard players operation #vxi editor *= -1 const
scoreboard players set #vyneg editor 0
execute if score #vy editor matches ..-1 run scoreboard players set #vyneg editor 1
scoreboard players operation #vyi editor = #vy editor
execute if score #vyi editor matches ..-1 run scoreboard players operation #vyi editor *= -1 const
scoreboard players operation #vyf editor = #vyi editor
scoreboard players operation #vyi editor /= 1000 const
scoreboard players operation #vyf editor %= 1000 const
scoreboard players operation #vyf editor /= 100 const
scoreboard players set #ny editor 0
execute if score #vyneg editor matches 1 if score #vyi editor matches 0 run scoreboard players set #ny editor 1
execute if score #vyneg editor matches 1 run scoreboard players operation #vyi editor *= -1 const
scoreboard players set #vzneg editor 0
execute if score #vz editor matches ..-1 run scoreboard players set #vzneg editor 1
scoreboard players operation #vzi editor = #vz editor
execute if score #vzi editor matches ..-1 run scoreboard players operation #vzi editor *= -1 const
scoreboard players operation #vzf editor = #vzi editor
scoreboard players operation #vzi editor /= 1000 const
scoreboard players operation #vzf editor %= 1000 const
scoreboard players operation #vzf editor /= 100 const
scoreboard players set #nz editor 0
execute if score #vzneg editor matches 1 if score #vzi editor matches 0 run scoreboard players set #nz editor 1
execute if score #vzneg editor matches 1 run scoreboard players operation #vzi editor *= -1 const
function rhythm_axe:editor/menu/map/ops/map_spawn_row
# 初始角度（偏航）：一行 标签 [-] 值 [+]（±180°，按值域钳制红绿，一位小数负零加前导 -）
# ★ 修负数值颠倒/补数：绝对值拆分 + 独立符号。
execute store result score #v editor run data get storage rhythm_axe:maps.editor panel_temp.spawn_yaw 1000
scoreboard players set #vneg editor 0
execute if score #v editor matches ..-1 run scoreboard players set #vneg editor 1
scoreboard players operation #vi editor = #v editor
execute if score #vi editor matches ..-1 run scoreboard players operation #vi editor *= -1 const
scoreboard players operation #vf editor = #vi editor
scoreboard players operation #vi editor /= 1000 const
scoreboard players operation #vf editor %= 1000 const
scoreboard players operation #vf editor /= 100 const
scoreboard players set #nz editor 0
execute if score #vneg editor matches 1 if score #vi editor matches 0 run scoreboard players set #nz editor 1
execute if score #vneg editor matches 1 run scoreboard players operation #vi editor *= -1 const
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.spawn_yaw 100
execute if score #temp editor matches ..-18000 if score #nz editor matches 0 run tellraw @s [{"text":"初始角度（偏航）：","color":"gray"},{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 120"},"hover_event":{"action":"show_text","value":"最少 -180°"}},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 121"},"hover_event":{"action":"show_text","value":"偏航 +1°"}}]
execute if score #temp editor matches ..-18000 if score #nz editor matches 1 run tellraw @s [{"text":"初始角度（偏航）：","color":"gray"},{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 120"},"hover_event":{"action":"show_text","value":"最少 -180°"}},{"text":"-","color":"white"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 121"},"hover_event":{"action":"show_text","value":"偏航 +1°"}}]
execute if score #temp editor matches 18000.. if score #nz editor matches 0 run tellraw @s [{"text":"初始角度（偏航）：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 120"},"hover_event":{"action":"show_text","value":"偏航 -1°"}},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},{"text":" [+]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 121"},"hover_event":{"action":"show_text","value":"最多 180°"}}]
execute if score #temp editor matches 18000.. if score #nz editor matches 1 run tellraw @s [{"text":"初始角度（偏航）：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 120"},"hover_event":{"action":"show_text","value":"偏航 -1°"}},{"text":"-","color":"white"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},{"text":" [+]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 121"},"hover_event":{"action":"show_text","value":"最多 180°"}}]
execute if score #temp editor matches -17999..17999 if score #nz editor matches 0 run tellraw @s [{"text":"初始角度（偏航）：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 120"},"hover_event":{"action":"show_text","value":"偏航 -1°"}},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 121"},"hover_event":{"action":"show_text","value":"偏航 +1°"}}]
execute if score #temp editor matches -17999..17999 if score #nz editor matches 1 run tellraw @s [{"text":"初始角度（偏航）：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 120"},"hover_event":{"action":"show_text","value":"偏航 -1°"}},{"text":"-","color":"white"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 121"},"hover_event":{"action":"show_text","value":"偏航 +1°"}}]
# 初始角度（俯仰）：一行（±90°）
# ★ 修负数值颠倒/补数：绝对值拆分 + 独立符号。
execute store result score #v editor run data get storage rhythm_axe:maps.editor panel_temp.spawn_pitch 1000
scoreboard players set #vneg editor 0
execute if score #v editor matches ..-1 run scoreboard players set #vneg editor 1
scoreboard players operation #vi editor = #v editor
execute if score #vi editor matches ..-1 run scoreboard players operation #vi editor *= -1 const
scoreboard players operation #vf editor = #vi editor
scoreboard players operation #vi editor /= 1000 const
scoreboard players operation #vf editor %= 1000 const
scoreboard players operation #vf editor /= 100 const
scoreboard players set #nz editor 0
execute if score #vneg editor matches 1 if score #vi editor matches 0 run scoreboard players set #nz editor 1
execute if score #vneg editor matches 1 run scoreboard players operation #vi editor *= -1 const
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.spawn_pitch 100
execute if score #temp editor matches ..-9000 if score #nz editor matches 0 run tellraw @s [{"text":"初始角度（俯仰）：","color":"gray"},{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 122"},"hover_event":{"action":"show_text","value":"最少 -90°"}},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 123"},"hover_event":{"action":"show_text","value":"俯仰 +1°"}}]
execute if score #temp editor matches ..-9000 if score #nz editor matches 1 run tellraw @s [{"text":"初始角度（俯仰）：","color":"gray"},{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 122"},"hover_event":{"action":"show_text","value":"最少 -90°"}},{"text":"-","color":"white"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 123"},"hover_event":{"action":"show_text","value":"俯仰 +1°"}}]
execute if score #temp editor matches 9000.. if score #nz editor matches 0 run tellraw @s [{"text":"初始角度（俯仰）：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 122"},"hover_event":{"action":"show_text","value":"俯仰 -1°"}},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},{"text":" [+]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 123"},"hover_event":{"action":"show_text","value":"最多 90°"}}]
execute if score #temp editor matches 9000.. if score #nz editor matches 1 run tellraw @s [{"text":"初始角度（俯仰）：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 122"},"hover_event":{"action":"show_text","value":"俯仰 -1°"}},{"text":"-","color":"white"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},{"text":" [+]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 123"},"hover_event":{"action":"show_text","value":"最多 90°"}}]
execute if score #temp editor matches -8999..8999 if score #nz editor matches 0 run tellraw @s [{"text":"初始角度（俯仰）：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 122"},"hover_event":{"action":"show_text","value":"俯仰 -1°"}},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 123"},"hover_event":{"action":"show_text","value":"俯仰 +1°"}}]
execute if score #temp editor matches -8999..8999 if score #nz editor matches 1 run tellraw @s [{"text":"初始角度（俯仰）：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 122"},"hover_event":{"action":"show_text","value":"俯仰 -1°"}},{"text":"-","color":"white"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"},{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 123"},"hover_event":{"action":"show_text","value":"俯仰 +1°"}}]
tellraw @s [{"text":"【使用玩家位置】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 117"},"hover_event":{"action":"show_text","value":"初始位置设为玩家当前位置"}},{"text":"  【使用玩家角度】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 127"},"hover_event":{"action":"show_text","value":"角度设为玩家当前朝向"}}]
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.player_count
execute if score #temp editor matches ..1 run tellraw @s [\
{"text":"最大人数：","color":"gray"},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 113"},"hover_event":{"action":"show_text","value":"最少 1 人"}},\
{"nbt":"panel_temp.player_count","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 114"},"hover_event":{"action":"show_text","value":"人数 +1"}}\
]
execute if score #temp editor matches 2.. run tellraw @s [\
{"text":"最大人数：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 113"},"hover_event":{"action":"show_text","value":"人数 -1"}},\
{"nbt":"panel_temp.player_count","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 114"},"hover_event":{"action":"show_text","value":"人数 +1"}}\
]
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.health
execute if score #temp editor matches ..1 run tellraw @s [\
{"text":"初始血量：","color":"gray"},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 115"},"hover_event":{"action":"show_text","value":"最少 1 点"}},\
{"nbt":"panel_temp.health","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 116"},"hover_event":{"action":"show_text","value":"血量 +1"}}\
]
execute if score #temp editor matches 2.. run tellraw @s [\
{"text":"初始血量：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 115"},"hover_event":{"action":"show_text","value":"血量 -1"}},\
{"nbt":"panel_temp.health","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 116"},"hover_event":{"action":"show_text","value":"血量 +1"}}\
]
tellraw @s [\
{"text":"结束时间：","color":"gray"},\
{"nbt":"panel_temp.end_time","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [编辑文本]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 124"},"hover_event":{"action":"show_text","value":"编辑结束时间（-1=未定义）"}}\
]
# 进度条颜色（0白 1粉 2蓝 3红 4绿 5黄 6紫；bossbar 支持色）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.progress_color
execute if score #temp editor matches 0 run tellraw @s [{"text":"进度条颜色：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 125"},"hover_event":{"action":"show_text","value":"颜色 -1（循环）"}},{"text":" 白 ","color":"white"},{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 126"},"hover_event":{"action":"show_text","value":"颜色 +1（循环）"}}]
execute if score #temp editor matches 1 run tellraw @s [{"text":"进度条颜色：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 125"},"hover_event":{"action":"show_text","value":"颜色 -1（循环）"}},{"text":" 粉 ","color":"light_purple"},{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 126"},"hover_event":{"action":"show_text","value":"颜色 +1（循环）"}}]
execute if score #temp editor matches 2 run tellraw @s [{"text":"进度条颜色：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 125"},"hover_event":{"action":"show_text","value":"颜色 -1（循环）"}},{"text":" 蓝 ","color":"blue"},{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 126"},"hover_event":{"action":"show_text","value":"颜色 +1（循环）"}}]
execute if score #temp editor matches 3 run tellraw @s [{"text":"进度条颜色：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 125"},"hover_event":{"action":"show_text","value":"颜色 -1（循环）"}},{"text":" 红 ","color":"red"},{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 126"},"hover_event":{"action":"show_text","value":"颜色 +1（循环）"}}]
execute if score #temp editor matches 4 run tellraw @s [{"text":"进度条颜色：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 125"},"hover_event":{"action":"show_text","value":"颜色 -1（循环）"}},{"text":" 绿 ","color":"green"},{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 126"},"hover_event":{"action":"show_text","value":"颜色 +1（循环）"}}]
execute if score #temp editor matches 5 run tellraw @s [{"text":"进度条颜色：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 125"},"hover_event":{"action":"show_text","value":"颜色 -1（循环）"}},{"text":" 黄 ","color":"yellow"},{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 126"},"hover_event":{"action":"show_text","value":"颜色 +1（循环）"}}]
execute if score #temp editor matches 6 run tellraw @s [{"text":"进度条颜色：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 125"},"hover_event":{"action":"show_text","value":"颜色 -1（循环）"}},{"text":" 紫 ","color":"dark_purple"},{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 126"},"hover_event":{"action":"show_text","value":"颜色 +1（循环）"}}]
tellraw @s [{"text":"【取消】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 119"},"hover_event":{"action":"show_text","value":"丢弃修改并返回主菜单"}},{"text":"  【保存设置】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 118"},"hover_event":{"action":"show_text","value":"把修改写回谱面（可撤销）"}}]
tellraw @s [{"text":"（修改暂存于面板，保存前不生效）","color":"gray","italic":true}]
