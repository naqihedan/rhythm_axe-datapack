# 交互实体字段填充：@s = 刚生成的 editor_n_<nid> interaction（由 summon_ 调用）
# ★ 2026-09-14 性能重构：原先 4 条 `@e[tag=editor_n_$(nid),type=interaction,limit=1]` 选择器命令
#   （width / height / note_id / idx）合并为「调用方 1 次选择器 + 本函数全 @s」。
# ★ 本文件【不得】出现宏行（$ 开头）：由调用方以普通 function 调用。
# 前置：display_calc #nsz；storage rhythm_axe:prop nid / idx
execute store result entity @s width float 0.01 run scoreboard players get #nsz display_calc
execute store result entity @s height float 0.01 run scoreboard players get #nsz display_calc
execute store result score #fi_tmp editor run data get storage rhythm_axe:prop nid
scoreboard players operation @s note_id = #fi_tmp editor
execute store result score #fi_tmp editor run data get storage rhythm_axe:prop idx
scoreboard players operation @s editor_n_idx = #fi_tmp editor
