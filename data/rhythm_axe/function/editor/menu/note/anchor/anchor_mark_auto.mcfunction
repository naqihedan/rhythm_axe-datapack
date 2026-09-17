# 把「本次自动摆放的位置」记到锚点实体上（data.anchor_cx/cy/cz，int ×100）并清掉「已手动改过」标记
# 为什么需要：判定「用户有没有动过锚点」的基准必须是**上次自动摆放的位置**，
#   不能拿「当前包围盒中心」当基准 —— 选区一变中心就变、锚点还停在旧中心，会被误判成「动过」
#   （2026-09-17 用户实测：选完第一个音符再选第二个就被判成动过）。
# 记录写在实体上（自定义字段一律进 `data.` 复合，本库约定）⇒ 不占 storage，reload / 区块重载都不丢。
# 前置：#rc0/#rc1/#rc2（本次自动摆放的中心，×100）；通常在 anchor_put 之后调用
tag @e[tag=editor_anchor] remove editor_anchor_manual
execute as @e[tag=editor_anchor,type=item_display] run execute store result entity @s data.anchor_cx int 1 run scoreboard players get #rc0 editor
execute as @e[tag=editor_anchor,type=item_display] run execute store result entity @s data.anchor_cy int 1 run scoreboard players get #rc1 editor
execute as @e[tag=editor_anchor,type=item_display] run execute store result entity @s data.anchor_cz int 1 run scoreboard players get #rc2 editor
