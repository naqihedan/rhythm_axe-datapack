# 已选定音符列表：渲染完成后收尾 —— 翻页/总数/批量/返回 + 清理 prop
# 翻页行（上一页/下一页按可用性显示红绿；页码显示用专用计分项防被遍历破坏）
scoreboard players operation #sel_page_show editor = #sel_page editor
scoreboard players add #sel_page_show editor 1
scoreboard players operation #sel_t40 editor = #sel_pages editor
scoreboard players remove #sel_t40 editor 1
execute if score #sel_page editor matches 1.. if score #sel_page editor < #sel_t40 editor run tellraw @s [\
{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11601"},"hover_event":{"action":"show_text","value":"上一页"}},\
{"text":" ","color":"white"},{"score":{"name":"#sel_page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#sel_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#sel_total","objective":"editor"},"color":"white"},{"text":"个已选","color":"gray"},\
{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11602"},"hover_event":{"action":"show_text","value":"下一页"}}\
]
execute if score #sel_page editor matches 1.. unless score #sel_page editor < #sel_t40 editor run tellraw @s [\
{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11601"},"hover_event":{"action":"show_text","value":"上一页"}},\
{"text":" ","color":"white"},{"score":{"name":"#sel_page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#sel_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#sel_total","objective":"editor"},"color":"white"},{"text":"个已选","color":"gray"},\
{"text":" 【下一页】","color":"red"}\
]
execute unless score #sel_page editor matches 1.. if score #sel_page editor < #sel_t40 editor run tellraw @s [\
{"text":"【上一页】","color":"red"},\
{"text":" ","color":"white"},{"score":{"name":"#sel_page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#sel_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#sel_total","objective":"editor"},"color":"white"},{"text":"个已选","color":"gray"},\
{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11602"},"hover_event":{"action":"show_text","value":"下一页"}}\
]
execute unless score #sel_page editor matches 1.. unless score #sel_page editor < #sel_t40 editor run tellraw @s [\
{"text":"【上一页】","color":"red"},\
{"text":" ","color":"white"},{"score":{"name":"#sel_page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#sel_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#sel_total","objective":"editor"},"color":"white"},{"text":"个已选","color":"gray"},\
{"text":" 【下一页】","color":"red"}\
]
tellraw @s [\
{"text":"【批量编辑】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 11403"},"hover_event":{"action":"show_text","value":"对选中的音符批量编辑（相对增量）"}},\
{"text":" ","color":"white"},\
{"text":"【批量复制】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11404"},"hover_event":{"action":"show_text","value":"把选中音符的字段存入剪贴板"}},\
{"text":" ","color":"white"},\
{"text":"【批量粘贴】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 11405"},"hover_event":{"action":"show_text","value":"把剪贴板音符粘贴到播放头"}},\
{"text":" ","color":"white"},\
{"text":"【取消选中并返回】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 11402"},"hover_event":{"action":"show_text","value":"清空 selection 与音符高亮并返回主菜单"}},\
{"text":" ","color":"white"},\
{"text":"【返回】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 11401"},"hover_event":{"action":"show_text","value":"返回主菜单（保留选择）"}}\
]
# 清理 prop（异步期间 prop.cursor/sel_index 等被占用）
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop sel_index
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop edit_val
data remove storage rhythm_axe:prop copy_val
data remove storage rhythm_axe:prop paste_val
data remove storage rhythm_axe:prop delete_val
data remove storage rhythm_axe:prop sel_val
data remove storage rhythm_axe:prop checkbox
