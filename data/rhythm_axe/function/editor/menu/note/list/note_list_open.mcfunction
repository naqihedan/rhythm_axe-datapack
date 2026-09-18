# 音符列表：只显示当前存活的音符（每行 4 按钮；按钮值规范 v2 = 100000 + 页内序×100 + 列码 3/5/6/7，见 note_list_row2）
# 剪贴板会话：只有「从面板外进入列表」时才清空（判定 = 进入前 current_panel 不是 10）。
# ★ 2026-09-17：原来无条件清空，导致面板内任何一次原地刷新（翻页/勾选/全选/取消选中/翻转开关/批量操作收尾，
#   以及暂停继续·调速·跳转触发的 resume 重绘）都会顺手把刚复制的 note_clip 清掉 → 现在一律保留。
#   本函数稍后会把 current_panel 置 10，故必须先判定；离开列表（回主菜单、进面板 11 等）后 current_panel 不再是 10
#   → 再次进入即失效；退出编辑器时由 clear_state 清空。
scoreboard players reset #clip_panel editor
execute store result score #clip_panel editor run data get storage rhythm_axe:maps.editor current_panel
execute unless score #clip_panel editor matches 10 run data remove storage rhythm_axe:maps.editor note_clip
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
{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11601"},"hover_event":{"action":"show_text","value":"上一页"}},\
{"text":" ","color":"white"},{"score":{"name":"#page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#note_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#note_alive","objective":"editor"},"color":"white"},{"text":"个音符","color":"gray"},\
{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11602"},"hover_event":{"action":"show_text","value":"下一页"}},{"text":" 【返回】","color":"dark_aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 1"},"hover_event":{"action":"show_text","value":"返回主菜单"}}\
]
execute if score #note_page editor matches 1.. unless score #note_page editor < #temp_playhead editor run tellraw @s [\
{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11601"},"hover_event":{"action":"show_text","value":"上一页"}},\
{"text":" ","color":"white"},{"score":{"name":"#page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#note_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#note_alive","objective":"editor"},"color":"white"},{"text":"个音符","color":"gray"},\
{"text":" 【下一页】","color":"red"},{"text":" 【返回】","color":"dark_aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 1"},"hover_event":{"action":"show_text","value":"返回主菜单"}}\
]
execute unless score #note_page editor matches 1.. if score #note_page editor < #temp_playhead editor run tellraw @s [\
{"text":"【上一页】","color":"red"},\
{"text":" ","color":"white"},{"score":{"name":"#page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#note_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#note_alive","objective":"editor"},"color":"white"},{"text":"个音符","color":"gray"},\
{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11602"},"hover_event":{"action":"show_text","value":"下一页"}},{"text":" 【返回】","color":"dark_aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 1"},"hover_event":{"action":"show_text","value":"返回主菜单"}}\
]
execute unless score #note_page editor matches 1.. unless score #note_page editor < #temp_playhead editor run tellraw @s [\
{"text":"【上一页】","color":"red"},\
{"text":" ","color":"white"},{"score":{"name":"#page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#note_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#note_alive","objective":"editor"},"color":"white"},{"text":"个音符","color":"gray"},\
{"text":" 【下一页】","color":"red"},{"text":" 【返回】","color":"dark_aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 1"},"hover_event":{"action":"show_text","value":"返回主菜单"}}\
]
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop edit_val
data remove storage rhythm_axe:prop copy_val
data remove storage rhythm_axe:prop paste_val
data remove storage rhythm_axe:prop delete_val
data remove storage rhythm_axe:prop sel_val
# 底部按钮（两行）：第一行 批量编辑—批量复制—批量粘贴—批量删除；第二行 全部选中—取消选中—粘贴并选中
#   返回按钮已挪到上面的翻页行（【下一页】右侧）；最下面一行仍是翻转/镜像/旋转组
# 默认灰色（禁用＝无 click_event）
data modify storage rhythm_axe:prop b1 set value "{\"text\":\"【批量编辑】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
data modify storage rhythm_axe:prop b2 set value "{\"text\":\"【批量复制】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
data modify storage rhythm_axe:prop b3 set value "{\"text\":\"【批量粘贴】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"剪贴板为空，先批量复制\"}}"
data modify storage rhythm_axe:prop b4 set value "{\"text\":\"【全部选中】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前没有可选的音符\"}}"
data modify storage rhythm_axe:prop b5 set value "{\"text\":\"【取消选中】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"没有已选中的音符\"}}"
data modify storage rhythm_axe:prop b6 set value "{\"text\":\"【粘贴并选中】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"剪贴板为空，先批量复制\"}}"
data modify storage rhythm_axe:prop b7 set value "{\"text\":\"【批量删除】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
data modify storage rhythm_axe:prop b8 set value "{\"text\":\"【批量剪切】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
# 有选中 → 启用 批量编辑/批量复制/取消选中/批量删除
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop b1 set value "{\"text\":\"【批量编辑】\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11301\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"对选中的音符批量编辑（相对增量）\"}}"
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop b2 set value "{\"text\":\"【批量复制】\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11302\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把选中音符的字段存入剪贴板\"}}"
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop b5 set value "{\"text\":\"【取消选中】\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11305\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"取消所有选中（不退出列表）\"}}"
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop b7 set value "{\"text\":\"【批量删除】\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11307\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"直接删除所有选中的音符（不弹二次确认，可撤销）\"}}"
# 批量剪切 = 复制 + 删除：选中音符进剪贴板的同时从谱面移除
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop b8 set value "{\"text\":\"【批量剪切】\",\"color\":\"gold\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11308\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"剪切=复制到剪贴板+删除原音符（剪贴板保留，可撤销）\"}}"
# 已批量复制（剪贴板有内容）→ 启用 批量粘贴 / 粘贴并选中
execute if data storage rhythm_axe:maps.editor clipboard.notes[0] run data modify storage rhythm_axe:prop b3 set value "{\"text\":\"【批量粘贴】\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11303\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把剪贴板音符粘贴到播放头\"}}"
execute if data storage rhythm_axe:maps.editor clipboard.notes[0] run data modify storage rhythm_axe:prop b6 set value "{\"text\":\"【粘贴并选中】\",\"color\":\"gold\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11306\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"粘贴到播放头，并清空原选中、把粘贴出来的音符设为选中\"}}"
# 有存活音符 → 启用 全部选中
execute if entity @e[type=item_display,tag=editor_note] run data modify storage rhythm_axe:prop b4 set value "{\"text\":\"【全部选中】\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11304\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"选中当前所有存活音符\"}}"
# —— 最后一行：镜像翻转组 ——：【翻转时间】| 镜像翻转音符[X][Y][Z][S]【镜像判定位置】
# f1=翻转时间(11501,即时) / f2/f3/f4/f5=X/Y/Z/S开关(11502/11503/11504/11505,点击仅切换状态不翻转) / f6=执行翻转(11506,按开关执行)
# ★ 首次打开列表时初始化镜像开关（S 默认开）
execute unless data storage rhythm_axe:maps.editor mirror run data modify storage rhythm_axe:maps.editor mirror set value {x:0b,y:0b,z:0b,s:1b}
execute store result score #mirror_x editor run data get storage rhythm_axe:maps.editor mirror.x
execute store result score #mirror_y editor run data get storage rhythm_axe:maps.editor mirror.y
execute store result score #mirror_z editor run data get storage rhythm_axe:maps.editor mirror.z
execute store result score #mirror_s editor run data get storage rhythm_axe:maps.editor mirror.s
# f1 翻转时间（默认灰，有选中启用）
data modify storage rhythm_axe:prop f1 set value "{\"text\":\"【翻转时间】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop f1 set value "{\"text\":\"【翻转时间】\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11501\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"让音符的判定时间在时间轴上镜像反转\"}}"
# f2 X 开关（颜色=状态：灰=关/绿=开；点击仅切换，不翻转）
data modify storage rhythm_axe:prop f2 set value "{\"text\":\"[X]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11502\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"为镜像与旋转操作启用X轴\"}}"
execute if score #mirror_x editor matches 1 run data modify storage rhythm_axe:prop f2 set value "{\"text\":\"[X]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11502\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"为镜像与旋转操作启用X轴\"}}"
# f3 Y 开关
data modify storage rhythm_axe:prop f3 set value "{\"text\":\"[Y]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11503\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"为镜像与旋转操作启用Y轴\"}}"
execute if score #mirror_y editor matches 1 run data modify storage rhythm_axe:prop f3 set value "{\"text\":\"[Y]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11503\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"为镜像与旋转操作启用Y轴\"}}"
# f4 Z 开关
data modify storage rhythm_axe:prop f4 set value "{\"text\":\"[Z]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11504\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"为镜像与旋转操作启用Z轴\"}}"
execute if score #mirror_z editor matches 1 run data modify storage rhythm_axe:prop f4 set value "{\"text\":\"[Z]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11504\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"为镜像与旋转操作启用Z轴\"}}"
# f5 S 开关（同时翻转起始位置）
data modify storage rhythm_axe:prop f5 set value "{\"text\":\"[S]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11505\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"启用对每个音符起始位置的镜像与旋转操作\"}}"
execute if score #mirror_s editor matches 1 run data modify storage rhythm_axe:prop f5 set value "{\"text\":\"[S]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11505\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"启用对每个音符起始位置的镜像与旋转操作\"}}"
# f6 执行翻转（默认灰，有选中启用）
data modify storage rhythm_axe:prop f6 set value "{\"text\":\"【镜像判定位置】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop f6 set value "{\"text\":\"【镜像判定位置】\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11506\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"根据开启的镜像开关，对选中音符执行空间镜像翻转\"}}"
# f7/f8/f9 旋转按钮（灰=无选中；有选中启用；点击按 [X][Y][Z] 开关绕锚点轴旋转）
data modify storage rhythm_axe:prop f7 set value "{\"text\":\"【15°】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop f7 set value "{\"text\":\"【15°】\",\"color\":\"gold\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11507\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"按开启的 X/Y/Z 轴，把选中音符判定位置绕锚点旋转 15°（S 开则同旋转起始位置）\"}}"
data modify storage rhythm_axe:prop f8 set value "{\"text\":\"【45°】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop f8 set value "{\"text\":\"【45°】\",\"color\":\"gold\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11508\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"按开启的 X/Y/Z 轴，把选中音符判定位置绕锚点旋转 45°（S 开则同旋转起始位置）\"}}"
data modify storage rhythm_axe:prop f9 set value "{\"text\":\"【90°】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop f9 set value "{\"text\":\"【90°】\",\"color\":\"gold\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11509\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"按开启的 X/Y/Z 轴，把选中音符判定位置绕锚点旋转 90°（S 开则同旋转起始位置）\"}}"
# f10 锚点重置【⌖】（任何时候可点）：红=锚点自动跟随中（= 包围盒中心）/ 蓝=锚点已被手动改过
data modify storage rhythm_axe:prop f10 set value "{\"text\":\"【⌖】\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11510\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"重置锚点位置（镜像/旋转的中心回到选中音符判定位置的包围盒中心）\"}}"
execute if entity @e[tag=editor_anchor_manual] run data modify storage rhythm_axe:prop f10 set value "{\"text\":\"【⌖】\",\"color\":\"blue\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11510\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"锚点已被改过（蓝色）——点击重置回选中音符判定位置的包围盒中心\"}}"
# f11 应用锚点变换（2026-09-18，无选中时灰）：把锚点的「旋转 + 相对包围盒中心的位移」当刚体变换套到选中音符判定位置上
#   悬停写全说明（按你定的「按钮文字=选项 2、hover 用选项 3 的完整说明」）
data modify storage rhythm_axe:prop f11 set value "{\"text\":\"【应用锚点变换】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_count editor matches 1.. run data modify storage rhythm_axe:prop f11 set value "{\"text\":\"【应用锚点变换】\",\"color\":\"light_purple\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11511\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"以锚点变换数据更改音符判定位置：把锚点的缩放、旋转与位移当成一个整体变换套到选中音符上 —— 以包围盒中心为中心，按「锚点旋转」旋转、按「锚点 scale 三轴各自×4」（可各轴不同比例）缩放，再按「锚点位置 − 包围盒中心」平移；[S] 开则起始位置跟着一起转+缩放（来向跟着变）\"}}"
# 输出两行 + 清理临时组件
function rhythm_axe:editor/menu/note/list/note_list_bottom with storage rhythm_axe:prop
function rhythm_axe:editor/menu/note/list/note_flip_bottom with storage rhythm_axe:prop
data remove storage rhythm_axe:prop b1
data remove storage rhythm_axe:prop b2
data remove storage rhythm_axe:prop b3
data remove storage rhythm_axe:prop b4
data remove storage rhythm_axe:prop b5
data remove storage rhythm_axe:prop b6
data remove storage rhythm_axe:prop b7
data remove storage rhythm_axe:prop b8
data remove storage rhythm_axe:prop f1
data remove storage rhythm_axe:prop f2
data remove storage rhythm_axe:prop f3
data remove storage rhythm_axe:prop f4
data remove storage rhythm_axe:prop f5
data remove storage rhythm_axe:prop f6
data remove storage rhythm_axe:prop f7
data remove storage rhythm_axe:prop f8
data remove storage rhythm_axe:prop f9
data remove storage rhythm_axe:prop f10
data remove storage rhythm_axe:prop f11
