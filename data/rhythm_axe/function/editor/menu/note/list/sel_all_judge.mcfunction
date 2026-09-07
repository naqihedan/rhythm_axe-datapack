#arg:cursor,i,nid
# 全部选中：一个音符若存活（有交互实体）且未选中（交互实体无 editor_note_selected tag）→ 按时间序追加 {id:$(nid), idx:$(i)} 到 selection，并打 tag + 补高亮
# 遍历 notes 是时间序 → 生成结果天然有序（O(1) selector 匹配实体，O(n) 不爆）
scoreboard players set #sel_hit editor 0
$execute if entity @e[tag=editor_n_$(nid),type=interaction] unless entity @e[tag=editor_n_$(nid),type=interaction,tag=editor_note_selected] run scoreboard players set #sel_hit editor 1
$execute if score #sel_hit editor matches 1 run data modify storage rhythm_axe:maps.editor selection append value {id:$(nid),idx:$(i)}
$execute if score #sel_hit editor matches 1 run execute as @e[type=interaction,tag=editor_n_$(nid)] run tag @s add editor_note_selected
$execute if score #sel_hit editor matches 1 run execute as @e[tag=editor_n_$(nid),type=item_display] run data modify entity @s Glowing set value 1b
$execute if score #sel_hit editor matches 1 run execute as @e[tag=editor_n_$(nid),type=item_display] run data modify entity @s glow_color_override set value 16776960
