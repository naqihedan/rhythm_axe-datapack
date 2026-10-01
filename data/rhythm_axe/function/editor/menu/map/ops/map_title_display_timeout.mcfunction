# 标题展示实体 60 秒到期（由 map_title_display_spawn 用 schedule 调度，1200t = 60 秒）
# 实体还在 → 删掉并提示；已被【复制】或关闭面板清掉 → 整段静默无事
execute if entity @e[tag=rhythm_axe_title_display] if entity @a[tag=editor_active] run tellraw @a[tag=editor_active] [{"text":"[编辑器] ","color":"green"},{"text":"展示实体已消失（60 秒到期），如未复制文字请重新点【生成文本展示实体】","color":"yellow"}]
execute if entity @e[tag=rhythm_axe_title_display] run kill @e[tag=rhythm_axe_title_display]
