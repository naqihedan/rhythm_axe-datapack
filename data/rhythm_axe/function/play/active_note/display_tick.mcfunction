# 展示实体统一每 tick 处理（@s = note_display 展示实体，at 其位置）
# ★ 合并 @e 遍历（2026-08-09）：原 active_note 对展示实体 3 次全量遍历
#   （concrete/tick + glass/tick + move）→ 合并为 1 次，减少全量实体扫描。
#   顺序与原一致：先驱动（写 NBT 视觉位置）再 move（读 NBT 存 note_prev_*）。
# 混凝土段推进 + 交互跟随（视觉由 display_animation 三段驱动：拉伸→平移→收缩，2026-08-09 回退）
execute if entity @s[tag=note_concrete] run function rhythm_axe:play/note/concrete/tick
# 非线性玻璃段推进（线性玻璃由客户端插值驱动，跳过本函数）
execute if entity @s[tag=note_stained_glass] unless entity @s[tag=note_linear] run function rhythm_axe:play/note/glass/tick
# 移动：交互实体跟随展示实体视觉位置（所有 note_display；混凝土 move 内部 return fail 提前退出）
function rhythm_axe:play/active_note/move
# 调试（lv.2）：播放系统所有音符展示实体的 trans/scale（验证长度/锚定/缓动；seg=混凝土段）
execute if score debug_output options matches 2.. run tellraw @a ["",{"text":"[调试.lv2][note]","color":"gray"},{"text":" ","color":"yellow"},{"nbt":"CustomName","entity":"@s","interpret":true},{"text":" seg=","color":"gray"},{"score":{"name":"@s","objective":"note_c_seg"}},{"text":" trans=","color":"gray"},{"nbt":"transformation.translation","entity":"@s"},{"text":" scale=","color":"gray"},{"nbt":"transformation.scale","entity":"@s"}]
