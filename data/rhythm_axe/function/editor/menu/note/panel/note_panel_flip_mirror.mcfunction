# 执行镜像翻转（按钮 917，底部第二行【翻转】按钮）：按 #mirror_x/y/z 开关对选中音符 position 绕包围盒中心镜像；#mirror_s 开时按 X/Y/Z 对 start_pos 绕判定位置镜像
# 四个开关仅在点击翻转前切换状态（910/914/915/916），本函数读取开关状态执行。
# 前置：selection；#from=current_panel；prop.cursor 指向工作副本
# ★ 2026-09-12 分刻 + 提示（处理音符数 > 50 时在聊天栏提示当前操作）：
#   同一条命令链里的 tellraw 会和重活一起被客户端渲染 ⇒ 玩家看不到「正在…」就先卡住了，所以 > 50 时：
#   本刻只发提示 + schedule 到下一刻；≤ 50 直接执行 <本文件>_go，不引入任何延迟。
execute unless data storage rhythm_axe:maps.editor selection[0] run tellraw @s [{"text":"[编辑器] 没有选中的音符","color":"red"}]
execute unless data storage rhythm_axe:maps.editor selection[0] run return fail
scoreboard players set #op_count editor 0
execute store result score #op_count editor run data get storage rhythm_axe:maps.editor selection
data modify storage rhythm_axe:prop op_label set value "镜像判定位置"
function rhythm_axe:editor/util/op_announce with storage rhythm_axe:prop
execute if score #op_big editor matches 1 run schedule function rhythm_axe:editor/menu/note/panel/note_panel_flip_mirror_next 1t
execute if score #op_big editor matches 0 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_mirror_go