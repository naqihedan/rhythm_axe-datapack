# 手持挥砍动画：收尾（把 item_model 恢复成斧头默认模型、清状态）
# swing_frame 不在这里清零：留着 = swing_max，保证 tick 里 end 之后不会再触发 tick_；下次 start 会重新 set 0
# restore 走宏 restore_（按 swing.skin 恢复对应皮肤；只有手持物品还是斧头时才 restore）
function rhythm_axe:utilization/swing_item/restore_ with storage rhythm_axe:prop swing
tag @s remove Swing
data remove storage rhythm_axe:prop swing
