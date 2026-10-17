# 编辑器主菜单行 110 的 [🎶] 音符击打音效开关（值 11006）：翻转 options.hitsound_on + 提示 + 重绘主菜单
#   与设置面板页 0 的 [🎶]（12706）操作同一项设置（options.hitsound_on）
#   @s = 触发点击的玩家
scoreboard players set #hs_tmp editor 1
execute if score hitsound_on options matches 1 run scoreboard players set #hs_tmp editor 0
scoreboard players operation hitsound_on options = #hs_tmp editor
execute if score hitsound_on options matches 1 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"音符打击音：启用","color":"aqua"}]
execute if score hitsound_on options matches 0 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"音符打击音：禁用","color":"red"},{"text":"（音符判定/生成不播音效；粒子与事件不受影响）","color":"gray"}]
schedule function rhythm_axe:editor/menu/main_next 1t