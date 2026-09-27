#arg:type,last,skin
# 定格在最后一帧：写最后一帧的 item_model（#swing_alt=0 → A，=1 → B）
# A / B 两份外观完全相同、只有 item_model ID 不同；每刻交替写 → 客户端一直认为「物品在变」，
#   于是保持在下坠状态，正好和帧里预加的 +COMPENSATION_Y 抵消
# ★ 不要改成「每刻重写同一个模型」：那样客户端不下坠了，+10 就会把斧头顶到悬空
$execute if score #swing_alt play_state matches 0 run item modify entity @s weapon.mainhand rhythm_axe:swing/$(type)_$(last)_$(skin)
$execute if score #swing_alt play_state matches 1 run item modify entity @s weapon.mainhand rhythm_axe:swing/$(type)_$(last)_$(skin)b
# ★ 诊断（debug_output >= 1）：打印定格这一兑实际写的是哪一份，以及交替标志
$execute if score debug_output options matches 1.. run tellraw @a [{"text":"[挥砍] 定格写 ","color":"gold"},{"text":"$(type)_$(last)_$(skin)","color":"white"},{"text":" alt=","color":"gray"},{"score":{"name":"#swing_alt","objective":"play_state"}}]
