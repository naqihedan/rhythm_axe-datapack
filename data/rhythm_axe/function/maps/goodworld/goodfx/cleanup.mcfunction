# 清场：计分项 / 本套 storage 键全部清空（可重复调用，不报错）
#   ★ 实体不用这里 kill：每组自己的 gN_d 在出生后 16 刻自删（字面量架构，互不牵连）
#   ★ 计分板只在 storage on 标记存在时才 remove ⇒ 重复调用静默跳过，不会刷「无此计分板」报错
execute if data storage rhythm_axe:gfx_good on run scoreboard objectives remove gfx
data remove storage rhythm_axe:gfx_good on
data remove storage rhythm_axe:gfx_good pick
data remove storage rhythm_axe:gfx_good n
