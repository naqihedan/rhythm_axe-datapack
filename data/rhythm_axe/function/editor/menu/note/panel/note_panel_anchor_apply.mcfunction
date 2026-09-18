# 应用锚点变换（按钮 11511）：把锚点的「缩放 + 旋转 + 相对包围盒中心的位移」当成一个整体变换套到选中音符的判定位置上
#   P' = R·S·(P − C) + A   （C = 选中判定位置包围盒中心、A = 锚点位置、R = 锚点 left_rotation 的旋转矩阵、
#                           S = diag(sx,sy,sz)，s_axis = 锚点 scale[axis] × 4 —— **三轴独立缩放**）
#   · 只转不移（A=C、S=I）→ 就是「绕包围盒中心旋转」（= 现在的旋转按钮，但支持任意角度）
#   · 只移不转（R=I、S=I）→ 整体平移 Δ = A − C
#   · 加上缩放（S≠I）→ 以 C 为中心整体放大/缩小，三轴可不同比例（S 按列折进矩阵，见 anchor_matrix）
#   · 三者叠加 → 缩放 + 转，再把选区中心搬到锚点处
#   [S] 开关开 → 同时把 start_pos 绕**各音符自己的判定位置**旋转 + 三轴缩放（与其它旋转按钮一致，来向跟着变）
#   [X][Y][Z] 开关**不参与**（锚点变换是完整 3D 变换，按轴拆开会失真）
#   应用后锚点**完全重置**（位置回新的包围盒中心 + 旋转归零 + scale 回 0.25 + 清 manual 标记）→ 面板上【⌖】变回红
# 前置：selection 非空；#from=current_panel
# ★ 与其它重操作一致：> 50 音符先提示、下一刻再干活
execute unless data storage rhythm_axe:maps.editor selection[0] run tellraw @s [{"text":"[编辑器] 没有选中的音符","color":"red"}]
execute unless data storage rhythm_axe:maps.editor selection[0] run return fail
scoreboard players set #op_count editor 0
execute store result score #op_count editor run data get storage rhythm_axe:maps.editor selection
data modify storage rhythm_axe:prop op_label set value "应用锚点变换"
function rhythm_axe:editor/util/op_announce with storage rhythm_axe:prop
execute if score #op_big editor matches 1 run schedule function rhythm_axe:editor/menu/note/panel/note_panel_anchor_apply_next 1t
execute if score #op_big editor matches 0 run function rhythm_axe:editor/menu/note/panel/note_panel_anchor_apply_go
