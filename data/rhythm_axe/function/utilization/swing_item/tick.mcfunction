# 手持挥砍动画：每 tick 驱动（由 #minecraft:tick 对 @a[tag=Swing] 执行）
# 预热期（帧号 -3..-1）：交替写「最后一帧 / 孪生副本」，占住原版会忽略的那 3 刻，
#   同时让物品保持「一直在变」→ 第 4 刻开始写动画帧就能立即生效，一帧不丢、也不额外拖后
# 播放期（帧号 0..swing_max-1）：每刻一帧
# 定格期（帧号 >= swing_max）：每刻交替写最后一帧的 A / B 两份
# ★ 核心：定格也**不能**写「相同的」模型——写同一个模型客户端不会下坠，
#   这会和帧里预加的 +COMPENSATION_Y 失去抵消，斧头会被顶到悬空
# ★ 预热同理：那几刻也要保持“在变”
# 手持物品不再是斧头（中途换物品）→ 立即收尾并终止本 tick
execute unless items entity @s weapon.mainhand *[minecraft:custom_data~{rhythm_axe:1}] run return run function rhythm_axe:utilization/swing_item/end
# ★ 诊断（debug_output >= 1）：每刻打印 帧号/总帧数/定格交替标志，用来判断定格到底有没有在写
#   开： /scoreboard players set debug_output options 1    关： set ... 0
#   伴随提醒：定格期会一直刷屏，看几秒就关掉
#   也行：手里物品当前模型可直接用  /data get entity @s SelectedItem.components."minecraft:item_model"
execute if score debug_output options matches 1.. run tellraw @a [{"text":"[挥砍] ","color":"gold"},{"text":"f=","color":"gray"},{"score":{"name":"@s","objective":"swing_frame"}},{"text":"/","color":"dark_gray"},{"score":{"name":"@s","objective":"swing_max"}},{"text":" par=","color":"gray"},{"score":{"name":"@s","objective":"swing_par"}},{"text":" alt=","color":"gray"},{"score":{"name":"#swing_alt","objective":"play_state"}}]
# —— 预热期：写最后一帧与它的孪生副本，帧号 +1，本 tick 结束 ——
execute if score @s swing_frame matches ..-1 run scoreboard players operation #swing_last play_state = @s swing_max
execute if score @s swing_frame matches ..-1 run scoreboard players remove #swing_last play_state 1
execute if score @s swing_frame matches ..-1 run execute store result storage rhythm_axe:prop swing.last int 1 run scoreboard players get #swing_last play_state
execute if score @s swing_frame matches -3 run function rhythm_axe:utilization/swing_item/warm_a with storage rhythm_axe:prop swing
execute if score @s swing_frame matches -2 run function rhythm_axe:utilization/swing_item/warm_b with storage rhythm_axe:prop swing
execute if score @s swing_frame matches -1 run function rhythm_axe:utilization/swing_item/warm_a with storage rhythm_axe:prop swing
execute if score @s swing_frame matches ..-1 run scoreboard players add @s swing_frame 1
execute if score @s swing_frame matches ..-1 run return 0
# —— 播放期：写当前帧并推进 ——
execute store result storage rhythm_axe:prop swing.frame int 1 run scoreboard players get @s swing_frame
execute if score @s swing_frame < @s swing_max run function rhythm_axe:utilization/swing_item/tick_ with storage rhythm_axe:prop swing
# —— 定格期：交替写最后一帧的 A / B，保持下坠状态 ——
execute if score @s swing_frame >= @s swing_max run scoreboard players add @s swing_par 1
execute if score @s swing_frame >= @s swing_max if score @s swing_par matches 2.. run scoreboard players set @s swing_par 0
execute if score @s swing_frame >= @s swing_max run scoreboard players operation #swing_last play_state = @s swing_max
execute if score @s swing_frame >= @s swing_max run scoreboard players remove #swing_last play_state 1
execute if score @s swing_frame >= @s swing_max run execute store result storage rhythm_axe:prop swing.last int 1 run scoreboard players get #swing_last play_state
execute if score @s swing_frame >= @s swing_max run scoreboard players operation #swing_alt play_state = @s swing_par
execute if score @s swing_frame >= @s swing_max run function rhythm_axe:utilization/swing_item/hold with storage rhythm_axe:prop swing
