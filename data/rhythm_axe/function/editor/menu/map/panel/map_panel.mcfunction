# 谱面设置面板：显示暂存副本 panel_temp 的值 + 编辑按钮；修改只动暂存，【保存设置】才写回并进历史
# 文本组件 26.x 命名：click_event（run_command 用 command）、hover_event（show_text 用 value）
# ★ 清屏：默认自己清 10 行；调用方若已自己清过（`maps.editor.skip_clear`）则跳过 ——
#   用于「清屏 → 反馈 → 面板」这种把反馈排在十行换行下面的排版（见 map_title_display_copy 的复制成功提示）
execute unless data storage rhythm_axe:maps.editor skip_clear run function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
tellraw @s [{"text":"====谱面设置====","color":"gold","bold":true}]
tellraw @s [\
{"text":"谱面id：","color":"gray"},\
{"nbt":"mapid","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑文本]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 10401"},"hover_event":{"action":"show_text","value":"编辑谱面 id"}}\
]
# 标题复制到 prop 暂存 → 由 utilization/title_comp 生成"标题组件" title_comp 供宏注入
# （JSON 组件字符串直接注入；裸纯文本合成字面组件；复合/列表交给 nbt+interpret 解析）
data remove storage rhythm_axe:prop title
data modify storage rhythm_axe:prop title set from storage rhythm_axe:maps.editor panel_temp.title
# 兜底：title 缺失/为空时给占位，避免标题行空白
execute unless data storage rhythm_axe:prop title run data modify storage rhythm_axe:prop title set value "(无标题)"
execute if data storage rhythm_axe:prop {title:""} run data modify storage rhythm_axe:prop title set value "(无标题)"
data modify storage rhythm_axe:prop src set value "rhythm_axe:prop"
execute if data storage rhythm_axe:prop title run function rhythm_axe:utilization/title_comp with storage rhythm_axe:prop
function rhythm_axe:editor/menu/map/panel/map_panel_title with storage rhythm_axe:prop
data remove storage rhythm_axe:prop title
data remove storage rhythm_axe:prop title_comp
# 曲师（artist，音乐作者）
tellraw @s [\
{"text":"曲师：","color":"gray"},\
{"nbt":"panel_temp.artist","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑文本]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 10101"},"hover_event":{"action":"show_text","value":"编辑曲师"}}\
]
# 谱面作者（charter，做这张谱面的人）
tellraw @s [\
{"text":"谱面作者：","color":"gray"},\
{"nbt":"panel_temp.charter","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑文本]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 10102"},"hover_event":{"action":"show_text","value":"编辑谱面作者"}}\
]
tellraw @s [\
{"text":"音乐文件：","color":"gray"},\
{"nbt":"panel_temp.music","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑文本]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 10201"},"hover_event":{"action":"show_text","value":"编辑音乐文件"}}\
]
# 预览起点 / 预览时长（刻度；大厅总表的 ▶️ 按钮用：从第几刻起播、播多少刻）
# ★ 2026-10-01 取代原「预览音频」字符串字段（那个字段从没有消费者）
#   值：行103 六个按钮 10301/10302 起点 ∓10 刻（0.5 秒）、10303/10304 时长 ∓1 刻（0.05 秒）、
#       10305【使用当前时间】、10306【截到播放头】
#   行尾换成换算后的时间（1 刻 = 50ms）：起点 分:秒.百分秒、时长 秒.百分秒
#   到下限/上限时对应按钮变红（红色仍带 click，处理端会钳制，只是点了不再变）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.preview_start
function rhythm_axe:editor/util/tick_to_time {"src":"#temp","dst":"#tz","unit_ms":"50"}
data modify storage rhythm_axe:prop label set value "预览起点："
data modify storage rhythm_axe:prop tz_kind set value "start"
data modify storage rhythm_axe:prop m_val set value 10301
data modify storage rhythm_axe:prop p_val set value 10302
data modify storage rhythm_axe:prop m_color set value "green"
execute if score #temp editor matches 0 run data modify storage rhythm_axe:prop m_color set value "red"
data modify storage rhythm_axe:prop p_color set value "green"
execute if score #temp editor matches 100000.. run data modify storage rhythm_axe:prop p_color set value "red"
function rhythm_axe:editor/menu/map/panel/map_preview_row with storage rhythm_axe:prop
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.preview_len
function rhythm_axe:editor/util/tick_to_time {"src":"#temp","dst":"#tz","unit_ms":"50"}
data modify storage rhythm_axe:prop label set value "预览时长："
data modify storage rhythm_axe:prop tz_kind set value "len"
data modify storage rhythm_axe:prop m_val set value 10303
data modify storage rhythm_axe:prop p_val set value 10304
data modify storage rhythm_axe:prop m_color set value "green"
execute if score #temp editor matches ..1 run data modify storage rhythm_axe:prop m_color set value "red"
data modify storage rhythm_axe:prop p_color set value "green"
execute if score #temp editor matches 12000.. run data modify storage rhythm_axe:prop p_color set value "red"
function rhythm_axe:editor/menu/map/panel/map_preview_row with storage rhythm_axe:prop
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.teleport
execute if score #temp editor matches 1 run tellraw @s [\
{"text":"传送玩家：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10601"},"hover_event":{"action":"show_text","value":"设为不传送"}},\
{"text":" 是 ","color":"white"},\
{"text":"[+]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10602"},"hover_event":{"action":"show_text","value":"已开启传送"}},\
{"text":"  【传送到谱面初始位置】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 10603"},"hover_event":{"action":"show_text","value":"无条件传送到谱面初始位置"}}\
]
execute unless score #temp editor matches 1 run tellraw @s [\
{"text":"传送玩家：","color":"gray"},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10601"},"hover_event":{"action":"show_text","value":"已关闭传送"}},\
{"text":" 否 ","color":"white"},\
{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10602"},"hover_event":{"action":"show_text","value":"设为传送"}},\
{"text":"  【传送到谱面初始位置】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 10603"},"hover_event":{"action":"show_text","value":"无条件传送到谱面初始位置"}}\
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

# 行108【整理音符顺序】：已于 2026-09-15 迁到主菜单（值不变仍为 10801，发射点见 main.mcfunction，分支见 panel1）
#   原因：它是「数据维护」而非谱面设置，且保存谱面时已会自动执行一遍

# 初始角度（偏航）：一行 标签 [-] 值 [+]（±180°，按值域钳制红绿；★ 整数显示）
# ★ 修负数值颠倒/补数：绝对值拆分 + 独立符号。角度只存整数（±1° 步进），不再显示小数位
execute store result score #v editor run data get storage rhythm_axe:maps.editor panel_temp.spawn_yaw 1000
scoreboard players set #vneg editor 0
execute if score #v editor matches ..-1 run scoreboard players set #vneg editor 1
scoreboard players operation #vi editor = #v editor
execute if score #vi editor matches ..-1 run scoreboard players operation #vi editor *= -1 const
scoreboard players operation #vi editor /= 1000 const
execute if score #vneg editor matches 1 run scoreboard players operation #vi editor *= -1 const
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.spawn_yaw 100
execute if score #temp editor matches ..-18000 run tellraw @s [{"text":"初始角度（偏航）：","color":"gray"},{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10901"},"hover_event":{"action":"show_text","value":"最少 -180°"}},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10902"},"hover_event":{"action":"show_text","value":"偏航 +1°"}}]
execute if score #temp editor matches 18000.. run tellraw @s [{"text":"初始角度（偏航）：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10901"},"hover_event":{"action":"show_text","value":"偏航 -1°"}},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":" [+]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10902"},"hover_event":{"action":"show_text","value":"最多 180°"}}]
execute if score #temp editor matches -17999..17999 run tellraw @s [{"text":"初始角度（偏航）：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10901"},"hover_event":{"action":"show_text","value":"偏航 -1°"}},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10902"},"hover_event":{"action":"show_text","value":"偏航 +1°"}}]
# 初始角度（俯仰）：一行（±90°；★ 整数显示，同偏航）
# ★ 修负数值颠倒/补数：绝对值拆分 + 独立符号。
execute store result score #v editor run data get storage rhythm_axe:maps.editor panel_temp.spawn_pitch 1000
scoreboard players set #vneg editor 0
execute if score #v editor matches ..-1 run scoreboard players set #vneg editor 1
scoreboard players operation #vi editor = #v editor
execute if score #vi editor matches ..-1 run scoreboard players operation #vi editor *= -1 const
scoreboard players operation #vi editor /= 1000 const
execute if score #vneg editor matches 1 run scoreboard players operation #vi editor *= -1 const
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.spawn_pitch 100
execute if score #temp editor matches ..-9000 run tellraw @s [{"text":"初始角度（俯仰）：","color":"gray"},{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10903"},"hover_event":{"action":"show_text","value":"最少 -90°"}},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10904"},"hover_event":{"action":"show_text","value":"俯仰 +1°"}}]
execute if score #temp editor matches 9000.. run tellraw @s [{"text":"初始角度（俯仰）：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10903"},"hover_event":{"action":"show_text","value":"俯仰 -1°"}},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":" [+]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10904"},"hover_event":{"action":"show_text","value":"最多 90°"}}]
execute if score #temp editor matches -8999..8999 run tellraw @s [{"text":"初始角度（俯仰）：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10903"},"hover_event":{"action":"show_text","value":"俯仰 -1°"}},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10904"},"hover_event":{"action":"show_text","value":"俯仰 +1°"}}]
# 【使用玩家位置】写入的坐标只保留 1 位小数、【使用玩家角度】的角度只保留整数（四舍五入，见 map/ops/map_use_player_*）
tellraw @s [{"text":"【使用玩家位置】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 11301"},"hover_event":{"action":"show_text","value":"初始位置设为玩家当前位置（保留 1 位小数）"}},{"text":"  【使用玩家角度】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 11302"},"hover_event":{"action":"show_text","value":"角度设为玩家当前朝向（保留整数）"}},{"text":"  【对齐方块中心（XZ）】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 11303"},"hover_event":{"action":"show_text","value":"初始位置 X/Z 对齐到所在方块中心，Y 不变"}}]
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.player_count
execute if score #temp editor matches ..1 run tellraw @s [\
{"text":"最大人数：","color":"gray"},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 11001"},"hover_event":{"action":"show_text","value":"最少 1 人"}},\
{"nbt":"panel_temp.player_count","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11002"},"hover_event":{"action":"show_text","value":"人数 +1"}}\
]
execute if score #temp editor matches 2.. run tellraw @s [\
{"text":"最大人数：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11001"},"hover_event":{"action":"show_text","value":"人数 -1"}},\
{"nbt":"panel_temp.player_count","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11002"},"hover_event":{"action":"show_text","value":"人数 +1"}}\
]
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.health
execute if score #temp editor matches ..1 run tellraw @s [\
{"text":"初始血量：","color":"gray"},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 11101"},"hover_event":{"action":"show_text","value":"最少 1 点"}},\
{"nbt":"panel_temp.health","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11102"},"hover_event":{"action":"show_text","value":"血量 +1"}}\
]
execute if score #temp editor matches 2.. run tellraw @s [\
{"text":"初始血量：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11101"},"hover_event":{"action":"show_text","value":"血量 -1"}},\
{"nbt":"panel_temp.health","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11102"},"hover_event":{"action":"show_text","value":"血量 +1"}}\
]
tellraw @s [\
{"text":"结束时间：","color":"gray"},\
{"nbt":"panel_temp.end_time","storage":"rhythm_axe:maps.editor","color":"gold"},\
{"text":" [编辑文本]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 10501"},"hover_event":{"action":"show_text","value":"编辑结束时间（-1=未定义）"}}\
]
# 进度条颜色（0白 1粉 2蓝 3红 4绿 5黄 6紫；bossbar 支持色）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.progress_color
execute if score #temp editor matches 0 run tellraw @s [{"text":"进度条颜色：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11201"},"hover_event":{"action":"show_text","value":"颜色 -1（循环）"}},{"text":" 白 ","color":"white"},{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11202"},"hover_event":{"action":"show_text","value":"颜色 +1（循环）"}}]
execute if score #temp editor matches 1 run tellraw @s [{"text":"进度条颜色：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11201"},"hover_event":{"action":"show_text","value":"颜色 -1（循环）"}},{"text":" 粉 ","color":"light_purple"},{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11202"},"hover_event":{"action":"show_text","value":"颜色 +1（循环）"}}]
execute if score #temp editor matches 2 run tellraw @s [{"text":"进度条颜色：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11201"},"hover_event":{"action":"show_text","value":"颜色 -1（循环）"}},{"text":" 蓝 ","color":"blue"},{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11202"},"hover_event":{"action":"show_text","value":"颜色 +1（循环）"}}]
execute if score #temp editor matches 3 run tellraw @s [{"text":"进度条颜色：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11201"},"hover_event":{"action":"show_text","value":"颜色 -1（循环）"}},{"text":" 红 ","color":"red"},{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11202"},"hover_event":{"action":"show_text","value":"颜色 +1（循环）"}}]
execute if score #temp editor matches 4 run tellraw @s [{"text":"进度条颜色：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11201"},"hover_event":{"action":"show_text","value":"颜色 -1（循环）"}},{"text":" 绿 ","color":"green"},{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11202"},"hover_event":{"action":"show_text","value":"颜色 +1（循环）"}}]
execute if score #temp editor matches 5 run tellraw @s [{"text":"进度条颜色：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11201"},"hover_event":{"action":"show_text","value":"颜色 -1（循环）"}},{"text":" 黄 ","color":"yellow"},{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11202"},"hover_event":{"action":"show_text","value":"颜色 +1（循环）"}}]
execute if score #temp editor matches 6 run tellraw @s [{"text":"进度条颜色：","color":"gray"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11201"},"hover_event":{"action":"show_text","value":"颜色 -1（循环）"}},{"text":" 紫 ","color":"dark_purple"},{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11202"},"hover_event":{"action":"show_text","value":"颜色 +1（循环）"}}]
# 行114：11401 保存设置 / 11402 取消 / 11403 重置谱面标题（弹原生确认框）
# 【重置谱面标题】放在【保存设置】右边：标题若存了无法解析的内容，标题行整条 tellraw 会被破坏而消失
#   （那一行的按钮也跟着没了）⇒ 救援按钮必须挂在这一行，见 editor/menu/map/ops/map_title_reset_ask
tellraw @s [{"text":"【取消】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 11402"},"hover_event":{"action":"show_text","value":"丢弃修改并返回主菜单"}},{"text":"  【保存设置】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11401"},"hover_event":{"action":"show_text","value":"把修改写回谱面（可撤销）"}},{"text":"  【重置谱面标题】","color":"gold","click_event":{"action":"run_command","command":"/trigger editor_click set 11403"},"hover_event":{"action":"show_text","value":"如果你没有在主菜单/bossbar/谱面设置面板中找到标题行设置，说明这张谱面的标题行可能存储了无法正常解析的内容。点这个按钮重置谱面标题"}}]
tellraw @s [{"text":"（修改暂存于面板，保存前不生效）","color":"gray","italic":true}]
