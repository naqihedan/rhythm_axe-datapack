# 音符列表：只显示当前存活的音符（每行 4 按钮，按钮值按存活序 600/640/680/720+序）
# 剪贴板会话：打开列表即清空本面板剪贴板（复制内容只在本会话内有效，离开面板再进入即失效）
data remove storage rhythm_axe:maps.editor note_clip
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 10
tellraw @s [{"text":"=====当前活跃音符列表=====","color":"gold","bold":true}]
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
# 页号缺省 0
execute unless data storage rhythm_axe:maps.editor notes_page run data modify storage rhythm_axe:maps.editor notes_page set value 0
# 当前页
execute store result score #note_page editor run data get storage rhythm_axe:maps.editor notes_page
# 页起点 = 页号*40
scoreboard players operation #page_start editor = #note_page editor
scoreboard players set #temp_playhead editor 40
scoreboard players operation #page_start editor *= #temp_playhead editor
# 渲染当前页（两次遍历：先未选中，再选中置底）
function rhythm_axe:editor/menu/note/list/note_list_render
# 总页数 = ceil(存活数/40)
scoreboard players operation #note_pages editor = #note_alive editor
scoreboard players add #note_pages editor 39
scoreboard players set #temp_playhead editor 40
scoreboard players operation #note_pages editor /= #temp_playhead editor
execute if score #note_pages editor matches ..0 run scoreboard players set #note_pages editor 1
# 页越界：钳制到最后一页并重跑一次
scoreboard players set #page_clamped editor 0
execute if score #note_page editor >= #note_pages editor run scoreboard players set #page_clamped editor 1
execute if score #note_page editor >= #note_pages editor run function rhythm_axe:editor/menu/note/list/note_list_page_clamp
execute if score #page_clamped editor matches 1 run execute store result score #note_page editor run data get storage rhythm_axe:maps.editor notes_page
execute if score #page_clamped editor matches 1 run scoreboard players operation #page_start editor = #note_page editor
execute if score #page_clamped editor matches 1 run scoreboard players set #temp_playhead editor 40
execute if score #page_clamped editor matches 1 run scoreboard players operation #page_start editor *= #temp_playhead editor
execute if score #page_clamped editor matches 1 run function rhythm_axe:editor/menu/note/list/note_list_render
# 翻页行（上一页/下一页按可用性显示红绿；页码显示用专用计分项防被遍历破坏）
scoreboard players operation #page_show editor = #note_page editor
scoreboard players add #page_show editor 1
scoreboard players operation #temp_playhead editor = #note_pages editor
scoreboard players remove #temp_playhead editor 1
execute if score #note_page editor matches 1.. if score #note_page editor < #temp_playhead editor run tellraw @s [\
{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 1684"},"hover_event":{"action":"show_text","value":"上一页"}},\
{"text":" ","color":"white"},{"score":{"name":"#page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#note_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#note_alive","objective":"editor"},"color":"white"},{"text":"个音符","color":"gray"},\
{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 1685"},"hover_event":{"action":"show_text","value":"下一页"}}\
]
execute if score #note_page editor matches 1.. unless score #note_page editor < #temp_playhead editor run tellraw @s [\
{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 1684"},"hover_event":{"action":"show_text","value":"上一页"}},\
{"text":" ","color":"white"},{"score":{"name":"#page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#note_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#note_alive","objective":"editor"},"color":"white"},{"text":"个音符","color":"gray"},\
{"text":" 【下一页】","color":"red"}\
]
execute unless score #note_page editor matches 1.. if score #note_page editor < #temp_playhead editor run tellraw @s [\
{"text":"【上一页】","color":"red"},\
{"text":" ","color":"white"},{"score":{"name":"#page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#note_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#note_alive","objective":"editor"},"color":"white"},{"text":"个音符","color":"gray"},\
{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 1685"},"hover_event":{"action":"show_text","value":"下一页"}}\
]
execute unless score #note_page editor matches 1.. unless score #note_page editor < #temp_playhead editor run tellraw @s [\
{"text":"【上一页】","color":"red"},\
{"text":" ","color":"white"},{"score":{"name":"#page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#note_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#note_alive","objective":"editor"},"color":"white"},{"text":"个音符","color":"gray"},\
{"text":" 【下一页】","color":"red"}\
]
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop edit_val
data remove storage rhythm_axe:prop copy_val
data remove storage rhythm_axe:prop paste_val
data remove storage rhythm_axe:prop delete_val
# 底部按钮（一行）：批量编辑—批量复制—批量粘贴—全部选中—取消选中—返回；无选中/未复制/无可选时对应按钮变灰（不隐藏）
execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
# 默认灰色（禁用＝无 click_event）
data modify storage rhythm_axe:prop b1 set value "{\"text\":\"【批量编辑】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
data modify storage rhythm_axe:prop b2 set value "{\"text\":\"【批量复制】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
data modify storage rhythm_axe:prop b3 set value "{\"text\":\"【批量粘贴】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"剪贴板为空，先批量复制\"}}"
data modify storage rhythm_axe:prop b4 set value "{\"text\":\"【全部选中】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前没有可选的音符\"}}"
data modify storage rhythm_axe:prop b5 set value "{\"text\":\"【取消选中】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"没有已选中的音符\"}}"
data modify storage rhythm_axe:prop b6 set value "{\"text\":\"【返回】\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 1\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"返回主菜单\"}}"
# 有选中 → 启用 批量编辑/批量复制/取消选中
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop b1 set value "{\"text\":\"【批量编辑】\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 1562\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"对选中的音符批量编辑（相对增量）\"}}"
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop b2 set value "{\"text\":\"【批量复制】\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 1641\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把选中音符的字段存入剪贴板\"}}"
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop b5 set value "{\"text\":\"【取消选中】\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 1640\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"取消所有选中（不退出列表）\"}}"
# 已批量复制（剪贴板有内容）→ 启用 批量粘贴
execute if data storage rhythm_axe:maps.editor clipboard.notes[0] run data modify storage rhythm_axe:prop b3 set value "{\"text\":\"【批量粘贴】\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 1642\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把剪贴板音符粘贴到播放头\"}}"
# 有存活音符 → 启用 全部选中
execute if entity @e[type=item_display,tag=editor_note] run data modify storage rhythm_axe:prop b4 set value "{\"text\":\"【全部选中】\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 1683\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"选中当前所有存活音符\"}}"
# 拼到一行输出，并清理临时组件
function rhythm_axe:editor/menu/note/list/note_list_bottom with storage rhythm_axe:prop
data remove storage rhythm_axe:prop b1
data remove storage rhythm_axe:prop b2
data remove storage rhythm_axe:prop b3
data remove storage rhythm_axe:prop b4
data remove storage rhythm_axe:prop b5
data remove storage rhythm_axe:prop b6
