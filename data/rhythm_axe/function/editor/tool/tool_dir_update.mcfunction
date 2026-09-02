# @s = 编辑器激活玩家，手持方向工具（custom_data 含 editor_tool_fwd/editor_tool_bwd/editor_tool_model/editor_tool_state）。
# 读取当前蹲下状态，与上次记录的 editor_tool_state 比对；不一致才重写物品名（【前进XX】/【快退XX】）并更新 state。
# 前进工具：站立=前进、蹲下=快退。快退工具：站立=快退、蹲下=快进。两种 tool 均用 tool_dir_write 重写。
# 前置：已由 tool_regular_apply 确认手持方向工具。

# 当前蹲下状态：0=站立 1=蹲下
scoreboard players set #tool_sneak editor 0
execute if entity @s[predicate=rhythm_axe:sneaking] run scoreboard players set #tool_sneak editor 1
# 上次记录状态
execute store result score #tool_state editor run data get entity @s SelectedItem.components."minecraft:custom_data".editor_tool_state 1
execute if score #tool_sneak editor = #tool_state editor run return fail

# 状态变化 → 按工具类型 + 蹲下状态重写（站立 shown=fwd/hint=蹲下以快退；蹲下 shown=bwd/hint=站立以快进）
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timeline_next_tick if score #tool_sneak editor matches 0 run function rhythm_axe:editor/tool/tool_dir_write {marker:"editor_tool_timeline_next_tick",model:"minecraft:gold_ingot",fwd:"前进一刻",bwd:"快退一刻",shown:"前进一刻",hint:"蹲下以快退",state:0}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timeline_next_tick if score #tool_sneak editor matches 1 run function rhythm_axe:editor/tool/tool_dir_write {marker:"editor_tool_timeline_next_tick",model:"minecraft:gold_ingot",fwd:"前进一刻",bwd:"快退一刻",shown:"快退一刻",hint:"站立以快进",state:1}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timeline_next_beat if score #tool_sneak editor matches 0 run function rhythm_axe:editor/tool/tool_dir_write {marker:"editor_tool_timeline_next_beat",model:"minecraft:iron_ingot",fwd:"前进一拍",bwd:"快退一拍",shown:"前进一拍",hint:"蹲下以快退",state:0}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timeline_next_beat if score #tool_sneak editor matches 1 run function rhythm_axe:editor/tool/tool_dir_write {marker:"editor_tool_timeline_next_beat",model:"minecraft:iron_ingot",fwd:"前进一拍",bwd:"快退一拍",shown:"快退一拍",hint:"站立以快进",state:1}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timeline_next_bar if score #tool_sneak editor matches 0 run function rhythm_axe:editor/tool/tool_dir_write {marker:"editor_tool_timeline_next_bar",model:"minecraft:copper_ingot",fwd:"前进一小节",bwd:"快退一小节",shown:"前进一小节",hint:"蹲下以快退",state:0}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timeline_next_bar if score #tool_sneak editor matches 1 run function rhythm_axe:editor/tool/tool_dir_write {marker:"editor_tool_timeline_next_bar",model:"minecraft:copper_ingot",fwd:"前进一小节",bwd:"快退一小节",shown:"快退一小节",hint:"站立以快进",state:1}
# ===== 快退工具（站立=快退，蹲下=快进）=====
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timeline_prev_tick if score #tool_sneak editor matches 0 run function rhythm_axe:editor/tool/tool_dir_write {marker:"editor_tool_timeline_prev_tick",model:"minecraft:gold_ingot",fwd:"快退一刻",bwd:"快进一刻",shown:"快退一刻",hint:"蹲下以快进",state:0}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timeline_prev_tick if score #tool_sneak editor matches 1 run function rhythm_axe:editor/tool/tool_dir_write {marker:"editor_tool_timeline_prev_tick",model:"minecraft:gold_ingot",fwd:"快退一刻",bwd:"快进一刻",shown:"快进一刻",hint:"站立以快退",state:1}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timeline_prev_beat if score #tool_sneak editor matches 0 run function rhythm_axe:editor/tool/tool_dir_write {marker:"editor_tool_timeline_prev_beat",model:"minecraft:iron_ingot",fwd:"快退一拍",bwd:"快进一拍",shown:"快退一拍",hint:"蹲下以快进",state:0}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timeline_prev_beat if score #tool_sneak editor matches 1 run function rhythm_axe:editor/tool/tool_dir_write {marker:"editor_tool_timeline_prev_beat",model:"minecraft:iron_ingot",fwd:"快退一拍",bwd:"快进一拍",shown:"快进一拍",hint:"站立以快退",state:1}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timeline_prev_bar if score #tool_sneak editor matches 0 run function rhythm_axe:editor/tool/tool_dir_write {marker:"editor_tool_timeline_prev_bar",model:"minecraft:copper_ingot",fwd:"快退一小节",bwd:"快进一小节",shown:"快退一小节",hint:"蹲下以快进",state:0}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_timeline_prev_bar if score #tool_sneak editor matches 1 run function rhythm_axe:editor/tool/tool_dir_write {marker:"editor_tool_timeline_prev_bar",model:"minecraft:copper_ingot",fwd:"快退一小节",bwd:"快进一小节",shown:"快进一小节",hint:"站立以快退",state:1}
