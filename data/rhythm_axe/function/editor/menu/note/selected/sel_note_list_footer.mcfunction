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
data modify storage rhythm_axe:prop b4 set value "{\"text\":\"【清空选中并返回】\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11402\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"清空 selection 与音符高亮并返回主菜单\"}}"
data modify storage rhythm_axe:prop b5 set value "{\"text\":\"【返回】\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11401\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"返回主菜单（保留选择）\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop b1 set value "{\"text\":\"【批量编辑】\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11403\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"对选中的音符批量编辑（相对增量）\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop b2 set value "{\"text\":\"【批量复制】\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11404\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把选中音符的字段存入剪贴板\"}}"
execute if data storage rhythm_axe:maps.editor clipboard.notes[0] run data modify storage rhythm_axe:prop b3 set value "{\"text\":\"【批量粘贴】\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11405\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把剪贴板音符粘贴到播放头\"}}"
# —— 第二行：镜像翻转组 ——：【翻转时间】| 镜像翻转音符[X][Y][Z][S]【镜像判定位置】
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
data modify storage rhythm_axe:prop f2 set value "{\"text\":\"[X]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11502\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"X轴镜像 关：点击开启。开启后点【翻转】会关于 YZ 平面镜像判定位置 position.x（绕包围盒中心 x，new=2×center−old）\"}}"
execute if score #mirror_x editor matches 1 run data modify storage rhythm_axe:prop f2 set value "{\"text\":\"[X]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11502\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"X轴镜像 开：点击关闭。开启后点【翻转】会关于 YZ 平面镜像判定位置 position.x（绕包围盒中心 x）\"}}"
# f3 Y 开关
data modify storage rhythm_axe:prop f3 set value "{\"text\":\"[Y]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11503\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"Y轴镜像 关：点击开启。开启后点【翻转】会关于 XZ 平面镜像判定位置 position.y（绕包围盒中心 y，new=2×center−old）\"}}"
execute if score #mirror_y editor matches 1 run data modify storage rhythm_axe:prop f3 set value "{\"text\":\"[Y]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11503\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"Y轴镜像 开：点击关闭。开启后点【翻转】会关于 XZ 平面镜像判定位置 position.y（绕包围盒中心 y）\"}}"
# f4 Z 开关
data modify storage rhythm_axe:prop f4 set value "{\"text\":\"[Z]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11504\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"Z轴镜像 关：点击开启。开启后点【翻转】会关于 XY 平面镜像判定位置 position.z（绕包围盒中心 z，new=2×center−old）\"}}"
execute if score #mirror_z editor matches 1 run data modify storage rhythm_axe:prop f4 set value "{\"text\":\"[Z]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11504\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"Z轴镜像 开：点击关闭。开启后点【翻转】会关于 XY 平面镜像判定位置 position.z（绕包围盒中心 z）\"}}"
# f5 S 开关（同时翻转起始位置）
data modify storage rhythm_axe:prop f5 set value "{\"text\":\"[S]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11505\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"同时翻起始 关：点击开启。开启后点【翻转】会按已开X/Y/Z轴让起始位置 start_pos 绕判定位置做对应轴镜像（start_pos.axis=−start_pos.axis）\"}}"
execute if score #mirror_s editor matches 1 run data modify storage rhythm_axe:prop f5 set value "{\"text\":\"[S]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11505\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"同时翻起始 开：点击关闭。开启后点【翻转】会按已开X/Y/Z轴让起始位置 start_pos 绕判定位置做对应轴镜像\"}}"
# f6 执行翻转（默认灰，有选中启用）
data modify storage rhythm_axe:prop f6 set value "{\"text\":\"【镜像判定位置】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop f6 set value "{\"text\":\"【镜像判定位置】\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11506\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"根据开启的镜像开关，对选中音符执行空间镜像翻转\"}}"
# f7/f8/f9 旋转按钮（灰=无选中；有选中启用；点击按 [X][Y][Z] 开关绕包围盒中心轴旋转）
data modify storage rhythm_axe:prop f7 set value "{\"text\":\"【15°】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop f7 set value "{\"text\":\"【15°】\",\"color\":\"gold\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11507\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"按开启的 X/Y/Z 轴，把选中音符判定位置绕包围盒中心旋转 15°（S 开则同旋转起始位置）\"}}"
data modify storage rhythm_axe:prop f8 set value "{\"text\":\"【45°】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop f8 set value "{\"text\":\"【45°】\",\"color\":\"gold\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11508\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"按开启的 X/Y/Z 轴，把选中音符判定位置绕包围盒中心旋转 45°（S 开则同旋转起始位置）\"}}"
data modify storage rhythm_axe:prop f9 set value "{\"text\":\"【90°】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"需要先选中音符\"}}"
execute if score #sel_total editor matches 1.. run data modify storage rhythm_axe:prop f9 set value "{\"text\":\"【90°】\",\"color\":\"gold\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 11509\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"按开启的 X/Y/Z 轴，把选中音符判定位置绕包围盒中心旋转 90°（S 开则同旋转起始位置）\"}}"
# 输出两行 + 清理临时组件
function rhythm_axe:editor/menu/note/selected/sel_note_list_bottom with storage rhythm_axe:prop
function rhythm_axe:editor/menu/note/list/note_flip_bottom with storage rhythm_axe:prop
data remove storage rhythm_axe:prop b1
data remove storage rhythm_axe:prop b2
data remove storage rhythm_axe:prop b3
data remove storage rhythm_axe:prop b4
data remove storage rhythm_axe:prop b5
data remove storage rhythm_axe:prop f1
data remove storage rhythm_axe:prop f2
data remove storage rhythm_axe:prop f3
data remove storage rhythm_axe:prop f4
data remove storage rhythm_axe:prop f5
data remove storage rhythm_axe:prop f6
data remove storage rhythm_axe:prop f7
data remove storage rhythm_axe:prop f8
data remove storage rhythm_axe:prop f9
