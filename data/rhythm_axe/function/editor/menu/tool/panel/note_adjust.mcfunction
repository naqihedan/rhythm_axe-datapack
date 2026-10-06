# 音符工具设置调整（面板 23）：221xx = X 轴 / 222xx = Y 轴 / 223xx = Z 轴
#   列码 1 = 开关  2 = −1  3 = −0.1  4 = +0.1  5 = +1  6 = 使用注视位置  7 = 对齐方块中心
# 值计分项存 ×10（一位小数）；开关/值键见 编辑器.md 面板 23 trigger 表。

# —— 解析：轴号 #axis（0/1/2）+ 列码 #act（1..7）——
scoreboard players operation #ax editor = #click_value editor
scoreboard players remove #ax editor 22100
scoreboard players operation #axis editor = #ax editor
scoreboard players operation #axis editor /= 100 const
scoreboard players operation #act editor = #ax editor
scoreboard players operation #act editor %= 100 const

# —— 开关（列码 1）——
execute if score #act editor matches 1 if score #axis editor matches 0 run function rhythm_axe:editor/menu/tool/panel/toggle {key:"note_lock_x"}
execute if score #act editor matches 1 if score #axis editor matches 1 run function rhythm_axe:editor/menu/tool/panel/toggle {key:"note_lock_y"}
execute if score #act editor matches 1 if score #axis editor matches 2 run function rhythm_axe:editor/menu/tool/panel/toggle {key:"note_lock_z"}
# 打开时在该轴的"固定坐标平面"上撒 dust 粒子
execute if score #act editor matches 1 run scoreboard players operation #fx_axis editor = #axis editor
execute if score #act editor matches 1 if score #axis editor matches 0 if score note_lock_x tool_opt matches 1 run function rhythm_axe:editor/menu/tool/panel/axis_fx
execute if score #act editor matches 1 if score #axis editor matches 1 if score note_lock_y tool_opt matches 1 run function rhythm_axe:editor/menu/tool/panel/axis_fx
execute if score #act editor matches 1 if score #axis editor matches 2 if score note_lock_z tool_opt matches 1 run function rhythm_axe:editor/menu/tool/panel/axis_fx

# —— 数值增减（列码 2..5）：2 = −1、3 = −0.1、4 = +0.1、5 = +1（值 ×10）——
execute if score #act editor matches 2 if score #axis editor matches 0 run scoreboard players remove note_lock_x_val tool_opt 10
execute if score #act editor matches 3 if score #axis editor matches 0 run scoreboard players remove note_lock_x_val tool_opt 1
execute if score #act editor matches 4 if score #axis editor matches 0 run scoreboard players add note_lock_x_val tool_opt 1
execute if score #act editor matches 5 if score #axis editor matches 0 run scoreboard players add note_lock_x_val tool_opt 10
execute if score #act editor matches 2 if score #axis editor matches 1 run scoreboard players remove note_lock_y_val tool_opt 10
execute if score #act editor matches 3 if score #axis editor matches 1 run scoreboard players remove note_lock_y_val tool_opt 1
execute if score #act editor matches 4 if score #axis editor matches 1 run scoreboard players add note_lock_y_val tool_opt 1
execute if score #act editor matches 5 if score #axis editor matches 1 run scoreboard players add note_lock_y_val tool_opt 10
execute if score #act editor matches 2 if score #axis editor matches 2 run scoreboard players remove note_lock_z_val tool_opt 10
execute if score #act editor matches 3 if score #axis editor matches 2 run scoreboard players remove note_lock_z_val tool_opt 1
execute if score #act editor matches 4 if score #axis editor matches 2 run scoreboard players add note_lock_z_val tool_opt 1
execute if score #act editor matches 5 if score #axis editor matches 2 run scoreboard players add note_lock_z_val tool_opt 10

# —— 使用注视位置（列码 6）：视线前方 4 格方块中心的坐标（与 note/place 同款定位），读对应轴 ×100 → 四舍五入 → ×10 ——
#   ★ 必须 `at @s`：consume 是从 tick 里 `as @a[...] run` 过来的，只 as 不带 at 时 `^ ^ ^4` 用的是**命令源位置**（世界出生点），不是玩家。
execute if score #act editor matches 6 run execute at @s anchored eyes positioned ^ ^ ^4 align xyz positioned ~0.5 ~0.5 ~0.5 run summon marker ~ ~ ~ {Tags:["editor_tool_look_pos"]}
execute if score #act editor matches 6 run data modify storage rhythm_axe:prop look_x set from entity @e[tag=editor_tool_look_pos,limit=1] Pos[0]
execute if score #act editor matches 6 run data modify storage rhythm_axe:prop look_y set from entity @e[tag=editor_tool_look_pos,limit=1] Pos[1]
execute if score #act editor matches 6 run data modify storage rhythm_axe:prop look_z set from entity @e[tag=editor_tool_look_pos,limit=1] Pos[2]
execute if score #act editor matches 6 run kill @e[tag=editor_tool_look_pos]
scoreboard players set #lk editor 0
execute if score #act editor matches 6 if score #axis editor matches 0 run execute store result score #lk editor run data get storage rhythm_axe:prop look_x 100
execute if score #act editor matches 6 if score #axis editor matches 1 run execute store result score #lk editor run data get storage rhythm_axe:prop look_y 100
execute if score #act editor matches 6 if score #axis editor matches 2 run execute store result score #lk editor run data get storage rhythm_axe:prop look_z 100
execute if score #act editor matches 6 run scoreboard players add #lk editor 5
execute if score #act editor matches 6 run scoreboard players operation #lk editor /= 10 const
execute if score #act editor matches 6 if score #axis editor matches 0 run scoreboard players operation note_lock_x_val tool_opt = #lk editor
execute if score #act editor matches 6 if score #axis editor matches 1 run scoreboard players operation note_lock_y_val tool_opt = #lk editor
execute if score #act editor matches 6 if score #axis editor matches 2 run scoreboard players operation note_lock_z_val tool_opt = #lk editor
data remove storage rhythm_axe:prop look_x
data remove storage rhythm_axe:prop look_y
data remove storage rhythm_axe:prop look_z

# —— 对齐方块中心（列码 7）：把当前值吸附到所在方块的中心 = floor(v/10)×10 + 5（×10 尺度）——
scoreboard players set #cv editor 0
execute if score #act editor matches 7 if score #axis editor matches 0 run execute store result score #cv editor run scoreboard players get note_lock_x_val tool_opt
execute if score #act editor matches 7 if score #axis editor matches 1 run execute store result score #cv editor run scoreboard players get note_lock_y_val tool_opt
execute if score #act editor matches 7 if score #axis editor matches 2 run execute store result score #cv editor run scoreboard players get note_lock_z_val tool_opt
execute if score #act editor matches 7 run scoreboard players operation #cv editor /= 10 const
execute if score #act editor matches 7 run scoreboard players operation #cv editor *= 10 const
execute if score #act editor matches 7 run scoreboard players add #cv editor 5
execute if score #act editor matches 7 if score #axis editor matches 0 run scoreboard players operation note_lock_x_val tool_opt = #cv editor
execute if score #act editor matches 7 if score #axis editor matches 1 run scoreboard players operation note_lock_y_val tool_opt = #cv editor
execute if score #act editor matches 7 if score #axis editor matches 2 run scoreboard players operation note_lock_z_val tool_opt = #cv editor

# 重绘本面板
function rhythm_axe:editor/menu/tool/panel/note
