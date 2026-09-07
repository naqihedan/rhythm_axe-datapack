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
# ★ 2026-09-07 修复：先预计算"数组存活序"（alive_seq[index]），供 row2 用数组存活序做按钮值，
#   修复"选中置底后显示序≠数组存活序、点按钮定位错音符"的 bug。
function rhythm_axe:editor/menu/note/list/note_list_alive_seq
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
# —— 第二行：镜像翻转组 ——：【翻转时间】| 镜像翻转音符[X][Y][Z][S]【翻转】
# f1=翻转时间(909,即时) / f2/f3/f4/f5=X/Y/Z/S开关(910/914/915/916,点击仅切换状态不翻转) / f6=执行翻转(917,按开关执行)
# ★ 首次打开列表时初始化镜像开关（S 默认开）
execute unless data storage rhythm_axe:maps.editor mirror run data modify storage rhythm_axe:maps.editor mirror set value {x:0b,y:0b,z:0b,s:1b}
execute store result score #mirror_x editor run data get storage rhythm_axe:maps.editor mirror.x
execute store result score #mirror_y editor run data get storage rhythm_axe:maps.editor mirror.y
execute store result score #mirror_z editor run data get storage rhythm_axe:maps.editor mirror.z
execute store result score #mirror_s editor run data get storage rhythm_axe:maps.editor mirror.s
# f1 翻转时间（默认灰，有选中启用）
data modify storage rhythm_axe:prop f1 set value "{\"text\":\"【翻转时间】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop f1 set value "{\"text\":\"【翻转时间】\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 909\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"让音符的判定时间在时间轴上镜像反转\"}}"
# f2 X 开关（颜色=状态：灰=关/绿=开；点击仅切换，不翻转）
data modify storage rhythm_axe:prop f2 set value "{\"text\":\"[X]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 910\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"X轴镜像 关：点击开启。开启后点【翻转】会关于 YZ 平面镜像判定位置 position.x（绕包围盒中心 x，new=2×center−old）\"}}"
execute if score #mirror_x editor matches 1 run data modify storage rhythm_axe:prop f2 set value "{\"text\":\"[X]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 910\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"X轴镜像 开：点击关闭。开启后点【翻转】会关于 YZ 平面镜像判定位置 position.x（绕包围盒中心 x）\"}}"
# f3 Y 开关
data modify storage rhythm_axe:prop f3 set value "{\"text\":\"[Y]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 914\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"Y轴镜像 关：点击开启。开启后点【翻转】会关于 XZ 平面镜像判定位置 position.y（绕包围盒中心 y，new=2×center−old）\"}}"
execute if score #mirror_y editor matches 1 run data modify storage rhythm_axe:prop f3 set value "{\"text\":\"[Y]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 914\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"Y轴镜像 开：点击关闭。开启后点【翻转】会关于 XZ 平面镜像判定位置 position.y（绕包围盒中心 y）\"}}"
# f4 Z 开关
data modify storage rhythm_axe:prop f4 set value "{\"text\":\"[Z]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 915\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"Z轴镜像 关：点击开启。开启后点【翻转】会关于 XY 平面镜像判定位置 position.z（绕包围盒中心 z，new=2×center−old）\"}}"
execute if score #mirror_z editor matches 1 run data modify storage rhythm_axe:prop f4 set value "{\"text\":\"[Z]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 915\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"Z轴镜像 开：点击关闭。开启后点【翻转】会关于 XY 平面镜像判定位置 position.z（绕包围盒中心 z）\"}}"
# f5 S 开关（同时翻转起始位置）
data modify storage rhythm_axe:prop f5 set value "{\"text\":\"[S]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 916\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"同时翻起始 关：点击开启。开启后点【翻转】会按已开X/Y/Z轴让起始位置 start_pos 绕判定位置做对应轴镜像（start_pos.axis=−start_pos.axis）\"}}"
execute if score #mirror_s editor matches 1 run data modify storage rhythm_axe:prop f5 set value "{\"text\":\"[S]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 916\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"同时翻起始 开：点击关闭。开启后点【翻转】会按已开X/Y/Z轴让起始位置 start_pos 绕判定位置做对应轴镜像\"}}"
# f6 执行翻转（默认灰，有选中启用）
data modify storage rhythm_axe:prop f6 set value "{\"text\":\"【翻转】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop f6 set value "{\"text\":\"【翻转】\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 917\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"根据开启的镜像开关，对选中音符执行空间镜像翻转\"}}"
# 输出两行 + 清理临时组件
function rhythm_axe:editor/menu/note/list/note_list_bottom with storage rhythm_axe:prop
function rhythm_axe:editor/menu/note/list/note_flip_bottom with storage rhythm_axe:prop
data remove storage rhythm_axe:prop b1
data remove storage rhythm_axe:prop b2
data remove storage rhythm_axe:prop b3
data remove storage rhythm_axe:prop b4
data remove storage rhythm_axe:prop b5
data remove storage rhythm_axe:prop b6
data remove storage rhythm_axe:prop f1
data remove storage rhythm_axe:prop f2
data remove storage rhythm_axe:prop f3
data remove storage rhythm_axe:prop f4
data remove storage rhythm_axe:prop f5
data remove storage rhythm_axe:prop f6
