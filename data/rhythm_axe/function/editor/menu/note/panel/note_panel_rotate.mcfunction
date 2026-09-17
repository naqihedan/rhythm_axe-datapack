# 旋转（按钮 11507=15° / 11508=45° / 11509=90°）：按 [X][Y][Z] 开关（作旋转轴）绕经过**锚点**的轴旋转 position
#   ★ 2026-09-17：中心 = 锚点（默认 = 选中音符包围盒中心，可被手动挪动），多轴时统一绕同一个点
#   S 开关开启时，对每个开启轴同时把 start_pos 绕判定位置旋转
#   右手定则（逆时针）；#rot_cos/#rot_sin 由 consume 按角度写入（×10000）
# 前置：selection；prop.rotate_cos / prop.rotate_sin；#from=current_panel
# ★ 2026-09-12 分刻 + 提示（处理音符数 > 50 时在聊天栏提示当前操作）：
#   同一条命令链里的 tellraw 会和重活一起被客户端渲染 ⇒ 玩家看不到「正在…」就先卡住了，所以 > 50 时：
#   本刻只发提示 + schedule 到下一刻；≤ 50 直接执行 <本文件>_go，不引入任何延迟。
execute unless data storage rhythm_axe:maps.editor selection[0] run tellraw @s [{"text":"[编辑器] 没有选中的音符","color":"red"}]
execute unless data storage rhythm_axe:maps.editor selection[0] run return fail
scoreboard players set #op_count editor 0
execute store result score #op_count editor run data get storage rhythm_axe:maps.editor selection
data modify storage rhythm_axe:prop op_label set value "旋转音符"
function rhythm_axe:editor/util/op_announce with storage rhythm_axe:prop
execute if score #op_big editor matches 1 run schedule function rhythm_axe:editor/menu/note/panel/note_panel_rotate_next 1t
execute if score #op_big editor matches 0 run function rhythm_axe:editor/menu/note/panel/note_panel_rotate_go