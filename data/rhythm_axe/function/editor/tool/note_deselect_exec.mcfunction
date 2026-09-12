# 匹配到被右击的音符交互实体（@s = 实体）
execute if score debug_output options matches 1.. run tellraw @a[tag=editor_active] [{"text":"[调试.lv1][右键]","color":"gray"},{"text":" 匹配到并进入 exec","color":"green"}]
# 清除 interaction.player，防止残留匹配（修复「点第二个音符误触第一个」的 bug）
data remove entity @s interaction
# 仅当该音符已选中才取消选中（否则右击无事发生）
execute unless entity @s[tag=editor_note_selected] run return fail
scoreboard players operation #nc_id editor = @s note_id
tag @s remove editor_note_selected
# 以玩家身份执行：蹲下 → 取消所有选中（可撤销）；站立 → 取消单个选中（熄灭高亮 + 从 selection 移除 + 打开已选定音符列表）
execute as @a[tag=editor_active] if entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/tool/note_deselect_all
execute as @a[tag=editor_active] unless entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/tool/note_deselect_do
