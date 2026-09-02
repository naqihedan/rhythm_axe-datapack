# 事件列表：分页显示（每页 5 个）
# 剪贴板会话：打开列表即清空本面板剪贴板（复制内容只在本会话内有效，离开面板再进入即失效）
data remove storage rhythm_axe:maps.editor event_clip
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 5
tellraw @s [{"text":"====事件列表====","color":"gold","bold":true}]
# 事件总数 → #event_total；总页数 #event_pages = ceil(n/5)，n=0 视为 1 页
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/event/list/event_list_count with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
scoreboard players operation #event_pages editor = #event_total editor
scoreboard players add #event_pages editor 4
scoreboard players set #temp_playhead editor 5
scoreboard players operation #event_pages editor /= #temp_playhead editor
execute if score #event_pages editor matches ..0 run scoreboard players set #event_pages editor 1
# 当前页缺省 0，越界钳制到最后一页（页号用专用计分项 #event_page）
execute unless data storage rhythm_axe:maps.editor events_page run data modify storage rhythm_axe:maps.editor events_page set value 0
execute store result score #event_page editor run data get storage rhythm_axe:maps.editor events_page
execute if score #event_page editor >= #event_pages editor run function rhythm_axe:editor/menu/event/list/event_list_page_clamp
execute store result score #event_page editor run data get storage rhythm_axe:maps.editor events_page
# 遍历参数：start = page*5、end = start+4
scoreboard players operation #temp_playhead editor = #event_page editor
scoreboard players set #temp_cursor editor 5
scoreboard players operation #temp_playhead editor *= #temp_cursor editor
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp_playhead editor
scoreboard players add #temp_playhead editor 4
execute store result storage rhythm_axe:prop end int 1 run scoreboard players get #temp_playhead editor
execute store result storage rhythm_axe:prop page int 1 run scoreboard players get #event_page editor
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/event/list/event_list_row with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop end
data remove storage rhythm_axe:prop page
data remove storage rhythm_axe:prop edit_val
data remove storage rhythm_axe:prop copy_val
data remove storage rhythm_axe:prop paste_val
data remove storage rhythm_axe:prop delete_val
# 翻页行（上一页/下一页按可用性显示红绿；页码显示用专用计分项防被遍历破坏）
scoreboard players operation #page_show editor = #event_page editor
scoreboard players add #page_show editor 1
scoreboard players operation #temp_playhead editor = #event_pages editor
scoreboard players remove #temp_playhead editor 1
execute if score #event_page editor matches 1.. if score #event_page editor < #temp_playhead editor run tellraw @s [\
{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 481"},"hover_event":{"action":"show_text","value":"上一页"}},\
{"text":" ","color":"white"},{"score":{"name":"#page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#event_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#event_total","objective":"editor"},"color":"white"},{"text":"个事件","color":"gray"},\
{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 482"},"hover_event":{"action":"show_text","value":"下一页"}}\
]
execute if score #event_page editor matches 1.. unless score #event_page editor < #temp_playhead editor run tellraw @s [\
{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 481"},"hover_event":{"action":"show_text","value":"上一页"}},\
{"text":" ","color":"white"},{"score":{"name":"#page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#event_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#event_total","objective":"editor"},"color":"white"},{"text":"个事件","color":"gray"},\
{"text":" 【下一页】","color":"red"}\
]
execute unless score #event_page editor matches 1.. if score #event_page editor < #temp_playhead editor run tellraw @s [\
{"text":"【上一页】","color":"red"},\
{"text":" ","color":"white"},{"score":{"name":"#page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#event_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#event_total","objective":"editor"},"color":"white"},{"text":"个事件","color":"gray"},\
{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 482"},"hover_event":{"action":"show_text","value":"下一页"}}\
]
execute unless score #event_page editor matches 1.. unless score #event_page editor < #temp_playhead editor run tellraw @s [\
{"text":"【上一页】","color":"red"},\
{"text":" ","color":"white"},{"score":{"name":"#page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#event_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#event_total","objective":"editor"},"color":"white"},{"text":"个事件","color":"gray"},\
{"text":" 【下一页】","color":"red"}\
]
# 新增 + 返回
tellraw @s [\
{"text":"【新增一个事件点】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 480"},"hover_event":{"action":"show_text","value":"在播放头位置新增事件"}},\
{"text":"  【返回】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 1"},"hover_event":{"action":"show_text","value":"返回主菜单"}}\
]
