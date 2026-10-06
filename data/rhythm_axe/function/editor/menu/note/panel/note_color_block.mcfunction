# 颜色行（面板 11）：★ 2026-10-06 用户定 —— 挪到「音符类型」下面，行内不再带"颜色："标签
#   原样从 note_panel 拆出来的「构建 16 个颜色按钮 → 渲染 → 清理」整块，逻辑未变，只是调用位置提前。
#   ⚠️ 必须在调 note_color_row 宏叶子之前把所有参数都写进 prop！$(xcomp) 少一个 ⇒ MC 直接**拒绝实例化整个函数**、
#     颜色行会**静默消失**（不写日志、不报错）。
# ★ 2026-10-07 用户定：**所有音符类型都显示颜色行**（原先只有 3 混凝土 / 4 染色玻璃）——
#   因为 0/1/2（音符盒/木板/唱片机）的颜色现在决定**它们生成的引导线颜色**
#   （见 editor/visual/guide_spawn_、play/note/guide/spawn → utilization/guide_color_set）。
# 当前颜色 #cv = temp.color（0 / 越界 = 没选定 ⇒ 0/1/2 型显示成【青】、3/4 型一个都不高亮；
#   缺字段也归 0，防读到上一次渲染的残留值）
scoreboard players set #cv editor 0
execute store result score #cv editor run data get storage rhythm_axe:maps.editor editing.temp.color
# 已修改标志（单音符=temp.color≠orig.color；批量=batch_set.color）
scoreboard players set #mod_c editor 0
execute if score #batch_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.color run scoreboard players set #mod_c editor 1
execute if score #batch_mode editor matches 0 run execute store result score #ov_c editor run data get storage rhythm_axe:maps.editor editing.orig.color
execute if score #batch_mode editor matches 0 unless score #cv editor = #ov_c editor run scoreboard players set #mod_c editor 1
# [x] 组件（红=已修改，点击 14015 重置；灰=未修改）
data modify storage rhythm_axe:prop xcomp set value "{\"text\":\"[x]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"未修改：此项暂未更改\"}}"
execute if score #mod_c editor matches 1 run data modify storage rhythm_axe:prop xcomp set value "{\"text\":\"[x]\",\"color\":\"red\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 14015\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"取消本项修改（重置为未修改）\"}}"
# 要高亮的颜色号 #cur_c：单音符 = 实际颜色；批量 = **只在改过时**才高亮（未修改 → -1 = 都不亮）
scoreboard players set #cur_c editor -1
execute if score #batch_mode editor matches 0 if score #cv editor matches 1..16 run scoreboard players operation #cur_c editor = #cv editor
execute if score #batch_mode editor matches 1 if score #mod_c editor matches 1 if score #cv editor matches 1..16 run scoreboard players operation #cur_c editor = #cv editor
# ★ 2026-10-07 用户定：0/1/2 型的「未设置」（color = 0 / 缺字段）在**显示上**等同默认青 11 ——
#   只影响这一行的高亮，**绝不写数据**：音符仍保持 0 = 未设置，继承/保存/谱面存储都照旧；
#   引导线本来就没设置时也是青色，所以观感一致。用户真去点【青】才会把 11 存进音符（那时 [x] 变红=已修改）
scoreboard players set #cy editor -1
execute store result score #cy editor run data get storage rhythm_axe:maps.editor editing.temp.type
execute if score #batch_mode editor matches 0 unless score #cv editor matches 1..16 if score #cy editor matches 0..2 run scoreboard players set #cur_c editor 11
# 16 个按钮组件：默认 [名]（字色 = 该颜色）
data modify storage rhythm_axe:prop col1 set value "{\"text\":\"[白]\",\"color\":\"#ffffff\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12301\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 白\"}}"
data modify storage rhythm_axe:prop col2 set value "{\"text\":\"[灰]\",\"color\":\"#aaaaaa\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12302\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 灰\"}}"
data modify storage rhythm_axe:prop col3 set value "{\"text\":\"[淡灰]\",\"color\":\"#9b9b99\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12303\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 淡灰\"}}"
data modify storage rhythm_axe:prop col4 set value "{\"text\":\"[黑]\",\"color\":\"#000000\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12304\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 黑\"}}"
data modify storage rhythm_axe:prop col5 set value "{\"text\":\"[棕]\",\"color\":\"#67594e\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12305\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 棕\"}}"
data modify storage rhythm_axe:prop col6 set value "{\"text\":\"[红]\",\"color\":\"#c39090\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12306\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 红\"}}"
data modify storage rhythm_axe:prop col7 set value "{\"text\":\"[橙]\",\"color\":\"#ac886a\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12307\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 橙\"}}"
data modify storage rhythm_axe:prop col8 set value "{\"text\":\"[黄]\",\"color\":\"#c3c390\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12308\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 黄\"}}"
data modify storage rhythm_axe:prop col9 set value "{\"text\":\"[黄绿]\",\"color\":\"#778c5a\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12309\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 黄绿\"}}"
data modify storage rhythm_axe:prop col10 set value "{\"text\":\"[绿]\",\"color\":\"#90c390\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12310\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 绿\"}}"
data modify storage rhythm_axe:prop col11 set value "{\"text\":\"[青]\",\"color\":\"#456d6d\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12311\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 青\"}}"
data modify storage rhythm_axe:prop col12 set value "{\"text\":\"[淡蓝]\",\"color\":\"#7296a2\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12312\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 淡蓝\"}}"
data modify storage rhythm_axe:prop col13 set value "{\"text\":\"[蓝]\",\"color\":\"#9090c3\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12313\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 蓝\"}}"
data modify storage rhythm_axe:prop col14 set value "{\"text\":\"[紫]\",\"color\":\"#7b6189\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12314\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 紫\"}}"
data modify storage rhythm_axe:prop col15 set value "{\"text\":\"[品红]\",\"color\":\"#9d789a\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12315\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 品红\"}}"
data modify storage rhythm_axe:prop col16 set value "{\"text\":\"[粉]\",\"color\":\"#a6599f\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12316\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"把颜色设为 粉\"}}"
# 命中的那个换成 【名】+ 加粗
execute if score #cur_c editor matches 1 run data modify storage rhythm_axe:prop col1 set value "{\"text\":\"【白】\",\"color\":\"white\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12301\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：白\"}}"
execute if score #cur_c editor matches 2 run data modify storage rhythm_axe:prop col2 set value "{\"text\":\"【灰】\",\"color\":\"gray\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12302\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：灰\"}}"
execute if score #cur_c editor matches 3 run data modify storage rhythm_axe:prop col3 set value "{\"text\":\"【淡灰】\",\"color\":\"#9d9d97\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12303\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：淡灰\"}}"
execute if score #cur_c editor matches 4 run data modify storage rhythm_axe:prop col4 set value "{\"text\":\"【黑】\",\"color\":\"black\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12304\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：黑\"}}"
execute if score #cur_c editor matches 5 run data modify storage rhythm_axe:prop col5 set value "{\"text\":\"【棕】\",\"color\":\"#835432\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12305\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：棕\"}}"
execute if score #cur_c editor matches 6 run data modify storage rhythm_axe:prop col6 set value "{\"text\":\"【红】\",\"color\":\"red\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12306\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：红\"}}"
execute if score #cur_c editor matches 7 run data modify storage rhythm_axe:prop col7 set value "{\"text\":\"【橙】\",\"color\":\"#f9801d\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12307\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：橙\"}}"
execute if score #cur_c editor matches 8 run data modify storage rhythm_axe:prop col8 set value "{\"text\":\"【黄】\",\"color\":\"yellow\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12308\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：黄\"}}"
execute if score #cur_c editor matches 9 run data modify storage rhythm_axe:prop col9 set value "{\"text\":\"【黄绿】\",\"color\":\"#80c71f\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12309\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：黄绿\"}}"
execute if score #cur_c editor matches 10 run data modify storage rhythm_axe:prop col10 set value "{\"text\":\"【绿】\",\"color\":\"green\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12310\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：绿\"}}"
execute if score #cur_c editor matches 11 run data modify storage rhythm_axe:prop col11 set value "{\"text\":\"【青】\",\"color\":\"#169c9c\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12311\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：青\"}}"
execute if score #cur_c editor matches 12 run data modify storage rhythm_axe:prop col12 set value "{\"text\":\"【淡蓝】\",\"color\":\"#3ab3da\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12312\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：淡蓝\"}}"
execute if score #cur_c editor matches 13 run data modify storage rhythm_axe:prop col13 set value "{\"text\":\"【蓝】\",\"color\":\"blue\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12313\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：蓝\"}}"
execute if score #cur_c editor matches 14 run data modify storage rhythm_axe:prop col14 set value "{\"text\":\"【紫】\",\"color\":\"#8932b8\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12314\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：紫\"}}"
execute if score #cur_c editor matches 15 run data modify storage rhythm_axe:prop col15 set value "{\"text\":\"【品红】\",\"color\":\"#c74ebd\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12315\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：品红\"}}"
execute if score #cur_c editor matches 16 run data modify storage rhythm_axe:prop col16 set value "{\"text\":\"【粉】\",\"color\":\"#ff00ea\",\"bold\":true,\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 12316\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前颜色：粉\"}}"
# 渲染（★ 2026-10-07：所有类型一律显示，批量模式同样显示）
function rhythm_axe:editor/menu/note/panel/note_color_row with storage rhythm_axe:prop
# 清理
data remove storage rhythm_axe:prop xcomp
data remove storage rhythm_axe:prop col1
data remove storage rhythm_axe:prop col2
data remove storage rhythm_axe:prop col3
data remove storage rhythm_axe:prop col4
data remove storage rhythm_axe:prop col5
data remove storage rhythm_axe:prop col6
data remove storage rhythm_axe:prop col7
data remove storage rhythm_axe:prop col8
data remove storage rhythm_axe:prop col9
data remove storage rhythm_axe:prop col10
data remove storage rhythm_axe:prop col11
data remove storage rhythm_axe:prop col12
data remove storage rhythm_axe:prop col13
data remove storage rhythm_axe:prop col14
data remove storage rhythm_axe:prop col15
data remove storage rhythm_axe:prop col16
