# 已选定音符列表（面板 18）：显示被选区选中的音符（selection[]，按 time 升序），每行复用 note_list_line（按钮值 1400 段）
# 打开即确认选择内容；【返回】(1560) 清空 selection + 音符高亮
# ★ 2026-09-04 分页：每页 40，sel_page 存页号（缺省 0）；翻页 1684/1685 与活跃列表共用触发值
# ★ 顺序匹配防溢出：不逐个 find_by_id（O(n²) 会 200000 超限），改单遍顺序遍历 notes 匹配 selection
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 18
tellraw @s [{"text":"=====已选定音符列表=====","color":"gold","bold":true}]
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
# 页号缺省 0
execute unless data storage rhythm_axe:maps.editor sel_page run data modify storage rhythm_axe:maps.editor sel_page set value 0
# 当前页
execute store result score #sel_page editor run data get storage rhythm_axe:maps.editor sel_page
# 页起点 = 页号*40
scoreboard players operation #sel_page_start editor = #sel_page editor
scoreboard players set #sel_t40 editor 40
scoreboard players operation #sel_page_start editor *= #sel_t40 editor
# 选中总数（供分页/页数计算；selection 空则 0）
scoreboard players set #sel_total editor 0
execute if data storage rhythm_axe:maps.editor selection run execute store result score #sel_total editor run data get storage rhythm_axe:maps.editor selection
# 渲染当前页：顺序遍历 notes，用 #sel_i 游标匹配 selection
scoreboard players set #sel_i editor 0
data modify storage rhythm_axe:prop sel_i set value 0
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/menu/note/selected/sel_note_list_drive
# 总页数 = ceil(选中数/40)
scoreboard players operation #sel_pages editor = #sel_total editor
scoreboard players add #sel_pages editor 39
scoreboard players set #sel_t40 editor 40
scoreboard players operation #sel_pages editor /= #sel_t40 editor
execute if score #sel_pages editor matches ..0 run scoreboard players set #sel_pages editor 1
# 页越界：钳制到最后一页并重跑一次
scoreboard players set #sel_clamped editor 0
execute if score #sel_page editor >= #sel_pages editor run scoreboard players set #sel_clamped editor 1
execute if score #sel_clamped editor matches 1 run function rhythm_axe:editor/menu/note/selected/sel_note_page_clamp
execute if score #sel_clamped editor matches 1 run execute store result score #sel_page editor run data get storage rhythm_axe:maps.editor sel_page
execute if score #sel_clamped editor matches 1 run scoreboard players operation #sel_page_start editor = #sel_page editor
execute if score #sel_clamped editor matches 1 run scoreboard players set #sel_t40 editor 40
execute if score #sel_clamped editor matches 1 run scoreboard players operation #sel_page_start editor *= #sel_t40 editor
execute if score #sel_clamped editor matches 1 run scoreboard players set #sel_i editor 0
execute if score #sel_clamped editor matches 1 run data modify storage rhythm_axe:prop sel_i set value 0
execute if score #sel_clamped editor matches 1 run data modify storage rhythm_axe:prop index set value 0
execute if score #sel_clamped editor matches 1 run function rhythm_axe:editor/menu/note/selected/sel_note_list_drive
# 翻页行（上一页/下一页按可用性显示红绿；页码显示用专用计分项防被遍历破坏）
scoreboard players operation #sel_page_show editor = #sel_page editor
scoreboard players add #sel_page_show editor 1
scoreboard players operation #sel_t40 editor = #sel_pages editor
scoreboard players remove #sel_t40 editor 1
execute if score #sel_page editor matches 1.. if score #sel_page editor < #sel_t40 editor run tellraw @s [\
{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 1684"},"hover_event":{"action":"show_text","value":"上一页"}},\
{"text":" ","color":"white"},{"score":{"name":"#sel_page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#sel_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#sel_total","objective":"editor"},"color":"white"},{"text":"个已选","color":"gray"},\
{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 1685"},"hover_event":{"action":"show_text","value":"下一页"}}\
]
execute if score #sel_page editor matches 1.. unless score #sel_page editor < #sel_t40 editor run tellraw @s [\
{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 1684"},"hover_event":{"action":"show_text","value":"上一页"}},\
{"text":" ","color":"white"},{"score":{"name":"#sel_page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#sel_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#sel_total","objective":"editor"},"color":"white"},{"text":"个已选","color":"gray"},\
{"text":" 【下一页】","color":"red"}\
]
execute unless score #sel_page editor matches 1.. if score #sel_page editor < #sel_t40 editor run tellraw @s [\
{"text":"【上一页】","color":"red"},\
{"text":" ","color":"white"},{"score":{"name":"#sel_page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#sel_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#sel_total","objective":"editor"},"color":"white"},{"text":"个已选","color":"gray"},\
{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 1685"},"hover_event":{"action":"show_text","value":"下一页"}}\
]
execute unless score #sel_page editor matches 1.. unless score #sel_page editor < #sel_t40 editor run tellraw @s [\
{"text":"【上一页】","color":"red"},\
{"text":" ","color":"white"},{"score":{"name":"#sel_page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#sel_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#sel_total","objective":"editor"},"color":"white"},{"text":"个已选","color":"gray"},\
{"text":" 【下一页】","color":"red"}\
]
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop sel_i
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop edit_val
data remove storage rhythm_axe:prop copy_val
data remove storage rhythm_axe:prop paste_val
data remove storage rhythm_axe:prop delete_val
data remove storage rhythm_axe:prop sel_val
data remove storage rhythm_axe:prop checkbox
# 底部按钮一行（语义同面板10：无选中/未复制时对应按钮变灰；返回与清空选中恒可用）
data modify storage rhythm_axe:prop b1 set value "{\"text\":\"【批量编辑】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
data modify storage rhythm_axe:prop b2 set value "{\"text\":\"【批量复制】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
data modify storage rhythm_axe:prop b3 set value "{\"text\":\"【批量粘贴】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"剪贴板为空，先批量复制\"}}"
data modify storage rhythm_axe:prop b4 set value "{\"text\":\"【清空选中并返回】\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 1561\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"清空 selection 与音符高亮并返回主菜单\"}}"
data modify storage rhythm_axe:prop b5 set value "{\"text\":\"【返回】\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 1560\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"返回主菜单（保留选择）\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop b1 set value "{\"text\":\"【批量编辑】\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 1562\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"对选中的音符批量编辑（相对增量）\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop b2 set value "{\"text\":\"【批量复制】\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 1563\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把选中音符的字段存入剪贴板\"}}"
execute if data storage rhythm_axe:maps.editor clipboard.notes[0] run data modify storage rhythm_axe:prop b3 set value "{\"text\":\"【批量粘贴】\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 1564\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把剪贴板音符粘贴到播放头\"}}"
function rhythm_axe:editor/menu/note/selected/sel_note_list_bottom with storage rhythm_axe:prop
data remove storage rhythm_axe:prop b1
data remove storage rhythm_axe:prop b2
data remove storage rhythm_axe:prop b3
data remove storage rhythm_axe:prop b4
data remove storage rhythm_axe:prop b5
