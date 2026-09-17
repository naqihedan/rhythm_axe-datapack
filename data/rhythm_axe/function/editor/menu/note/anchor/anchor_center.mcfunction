# 计算「选中集合」判定位置的包围盒中心 → #rc0/#rc1/#rc2（×100 定点，与旋转中心同口径）
# 中心 = (min+max)/2，与旧实现（note_panel_flip_pos_scan / note_panel_rotate_scan）逐点等价；
#   区别：这里**一次遍历同时读三轴**（旧实现每轴各扫一遍 = 3 趟）→ 省 2/3 遍历。
# 前置：selection 非空；prop.cursor 必须已指向工作副本（本函数只读、不设置/删除它，便于被镜像/旋转复用）
# 成本 ∝ 选中数（每个选中音符 1 次宏叶子 + 3 条 data get），与点一次【镜像】同量级
scoreboard players set #ac_min0 editor 2147483647
scoreboard players set #ac_max0 editor -2147483648
scoreboard players set #ac_min1 editor 2147483647
scoreboard players set #ac_max1 editor -2147483648
scoreboard players set #ac_min2 editor 2147483647
scoreboard players set #ac_max2 editor -2147483648
scoreboard players set #ac_i editor 0
execute store result score #ac_total editor run data get storage rhythm_axe:maps.editor selection
data modify storage rhythm_axe:prop anc_cursor set value 0
function rhythm_axe:editor/menu/note/anchor/anchor_center_drive
data remove storage rhythm_axe:prop anc_cursor
scoreboard players operation #rc0 editor = #ac_min0 editor
scoreboard players operation #rc0 editor += #ac_max0 editor
scoreboard players operation #rc0 editor /= 2 const
scoreboard players operation #rc1 editor = #ac_min1 editor
scoreboard players operation #rc1 editor += #ac_max1 editor
scoreboard players operation #rc1 editor /= 2 const
scoreboard players operation #rc2 editor = #ac_min2 editor
scoreboard players operation #rc2 editor += #ac_max2 editor
scoreboard players operation #rc2 editor /= 2 const
