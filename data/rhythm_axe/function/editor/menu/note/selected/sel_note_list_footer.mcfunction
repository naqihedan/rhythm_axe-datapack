# 已选定音符列表收尾：翻页行 + 底部两行按钮 + 清理 prop（由 sel_note_list_open 渲染完本页后调用）
# 前置：#sel_page / #sel_pages / #sel_total 计分项已由 sel_note_list_open 设置
# ★ 2026-09-11：从 sel_note_list_open 抽出（原同步渲染的尾部），方便将来如需改分刻渲染时复用同一收尾。
# 翻页行（上一页/下一页按可用性显示红绿；页码显示用专用计分项防被遍历破坏）
scoreboard players operation #sel_page_show editor = #sel_page editor
scoreboard players add #sel_page_show editor 1
scoreboard players operation #sel_t40 editor = #sel_pages editor
scoreboard players remove #sel_t40 editor 1
execute if score #sel_page editor matches 1.. if score #sel_page editor < #sel_t40 editor run tellraw @s [\
{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11601"},"hover_event":{"action":"show_text","value":"上一页"}},\
{"text":" ","color":"white"},{"score":{"name":"#sel_page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#sel_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#sel_total","objective":"editor"},"color":"white"},{"text":"个已选","color":"gray"},\
{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11602"},"hover_event":{"action":"show_text","value":"下一页"}},{"text":" 【返回】","color":"dark_aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 11401"},"hover_event":{"action":"show_text","value":"返回主菜单（保留选择）"}}\
]
execute if score #sel_page editor matches 1.. unless score #sel_page editor < #sel_t40 editor run tellraw @s [\
{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11601"},"hover_event":{"action":"show_text","value":"上一页"}},\
{"text":" ","color":"white"},{"score":{"name":"#sel_page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#sel_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#sel_total","objective":"editor"},"color":"white"},{"text":"个已选","color":"gray"},\
{"text":" 【下一页】","color":"red"},{"text":" 【返回】","color":"dark_aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 11401"},"hover_event":{"action":"show_text","value":"返回主菜单（保留选择）"}}\
]
execute unless score #sel_page editor matches 1.. if score #sel_page editor < #sel_t40 editor run tellraw @s [\
{"text":"【上一页】","color":"red"},\
{"text":" ","color":"white"},{"score":{"name":"#sel_page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#sel_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#sel_total","objective":"editor"},"color":"white"},{"text":"个已选","color":"gray"},\
{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11602"},"hover_event":{"action":"show_text","value":"下一页"}},{"text":" 【返回】","color":"dark_aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 11401"},"hover_event":{"action":"show_text","value":"返回主菜单（保留选择）"}}\
]
execute unless score #sel_page editor matches 1.. unless score #sel_page editor < #sel_t40 editor run tellraw @s [\
{"text":"【上一页】","color":"red"},\
{"text":" ","color":"white"},{"score":{"name":"#sel_page_show","objective":"editor"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#sel_pages","objective":"editor"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#sel_total","objective":"editor"},"color":"white"},{"text":"个已选","color":"gray"},\
{"text":" 【下一页】","color":"red"},{"text":" 【返回】","color":"dark_aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 11401"},"hover_event":{"action":"show_text","value":"返回主菜单（保留选择）"}}\
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
# 底部按钮（两行）：第一行 批量编辑—批量复制—批量粘贴—批量删除；第二行 清空选中并返回—粘贴并选中
#   返回按钮(11401) 已挪到上面的翻页行（【下一页】右侧）
data modify storage rhythm_axe:prop b1 set value "{\"text\":\"【批量编辑】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
data modify storage rhythm_axe:prop b2 set value "{\"text\":\"【批量复制】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
data modify storage rhythm_axe:prop b3 set value "{\"text\":\"【批量粘贴】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"剪贴板为空，先批量复制\"}}"
data modify storage rhythm_axe:prop b4 set value "{\"text\":\"【清空选中并返回】        \",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11402\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"清空 selection 与音符高亮并返回主菜单\"}}"
data modify storage rhythm_axe:prop b5 set value "{\"text\":\"【粘贴并选中】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"剪贴板为空，先批量复制\"}}"
data modify storage rhythm_axe:prop b6 set value "{\"text\":\"【批量删除】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
data modify storage rhythm_axe:prop b7 set value "{\"text\":\"【批量剪切】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop b1 set value "{\"text\":\"【批量编辑】\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11403\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"对选中的音符批量编辑（相对增量）\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop b2 set value "{\"text\":\"【批量复制】\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11404\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把选中音符的字段存入剪贴板\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop b6 set value "{\"text\":\"【批量删除】\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11407\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"直接删除所有选中的音符（不弹二次确认，可撤销）\"}}"
# 批量剪切 = 复制 + 删除：选中音符进剪贴板的同时从谱面移除（剪贴板保留 → 之后可【批量粘贴】）
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop b7 set value "{\"text\":\"【批量剪切】\",\"color\":\"gold\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11408\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"剪切=复制到剪贴板+删除原音符（剪贴板保留，可撤销）\"}}"
execute if data storage rhythm_axe:maps.editor clipboard.notes[0] run data modify storage rhythm_axe:prop b3 set value "{\"text\":\"【批量粘贴】\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11405\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把剪贴板音符粘贴到播放头\"}}"
execute if data storage rhythm_axe:maps.editor clipboard.notes[0] run data modify storage rhythm_axe:prop b5 set value "{\"text\":\"【粘贴并选中】\",\"color\":\"gold\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11406\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"粘贴到播放头，并清空原选中、把粘贴出来的音符设为选中\"}}"
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
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop f1 set value "{\"text\":\"【翻转时间】\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11501\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"让音符的判定时间在时间轴上镜像反转\"}}"
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
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop f6 set value "{\"text\":\"【镜像判定位置】\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11506\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"根据开启的镜像开关，对选中音符执行空间镜像翻转\"}}"
# f7/f8/f9 旋转按钮（灰=无选中；有选中启用；点击按 [X][Y][Z] 开关绕锚点轴旋转）
data modify storage rhythm_axe:prop f7 set value "{\"text\":\"【15°】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop f7 set value "{\"text\":\"【15°】\",\"color\":\"gold\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11507\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"按开启的 X/Y/Z 轴，把选中音符判定位置绕锚点旋转 15°（S 开则同旋转起始位置）\"}}"
data modify storage rhythm_axe:prop f8 set value "{\"text\":\"【45°】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop f8 set value "{\"text\":\"【45°】\",\"color\":\"gold\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11508\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"按开启的 X/Y/Z 轴，把选中音符判定位置绕锚点旋转 45°（S 开则同旋转起始位置）\"}}"
data modify storage rhythm_axe:prop f9 set value "{\"text\":\"【90°】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop f9 set value "{\"text\":\"【90°】\",\"color\":\"gold\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11509\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"按开启的 X/Y/Z 轴，把选中音符判定位置绕锚点旋转 90°（S 开则同旋转起始位置）\"}}"
# f10 锚点重置【⌖】（任何时候可点）：红=锚点自动跟随中（= 包围盒中心）/ 蓝=锚点已被手动改过
data modify storage rhythm_axe:prop f10 set value "{\"text\":\"【⌖】\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11510\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"重置锚点位置（镜像/旋转的中心回到选中音符判定位置的包围盒中心）\"}}"
execute if entity @e[tag=editor_anchor_manual] run data modify storage rhythm_axe:prop f10 set value "{\"text\":\"【⌖】\",\"color\":\"blue\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11510\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"锚点已被改过（蓝色）——点击重置回选中音符判定位置的包围盒中心\"}}"
# f11 应用锚点变换（2026-09-18，无选中时灰）：把锚点的「旋转 + 相对包围盒中心的位移」当刚体变换套到选中音符判定位置上
data modify storage rhythm_axe:prop f11 set value "{\"text\":\"【应用锚点变换】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop f11 set value "{\"text\":\"【应用锚点变换】\",\"color\":\"light_purple\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11511\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"以锚点变换数据更改音符判定位置：把锚点的缩放、旋转与位移当成一个整体变换套到选中音符上 —— 以包围盒中心为中心，按「锚点旋转」旋转、按「锚点 scale 三轴各自×4」（可各轴不同比例）缩放，再按「锚点位置 − 包围盒中心」平移；[S] 开则起始位置跟着一起转+缩放（来向跟着变）\"}}"
# 输出两行 + 清理临时组件
function rhythm_axe:editor/menu/note/selected/sel_note_list_bottom with storage rhythm_axe:prop
function rhythm_axe:editor/menu/note/list/note_flip_bottom with storage rhythm_axe:prop
data remove storage rhythm_axe:prop b1
data remove storage rhythm_axe:prop b2
data remove storage rhythm_axe:prop b3
data remove storage rhythm_axe:prop b4
data remove storage rhythm_axe:prop b5
data remove storage rhythm_axe:prop b6
# ★ 2026-09-12 补：b7（批量剪切）与漏清的 b6
data remove storage rhythm_axe:prop b7
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
