# ========== 示例装饰（decor/example）：收掉 ==========
# 幂等，可反复调用（start 里也做同样三件事）。
# ★ 顺序：先停自链，再清实体与时钟。
#   /reload 不清 schedule ⇒ 不停链的话，tick 里那条 `matches 1..` 守卫此时仍成立，
#   链会继续每刻唤醒，虽然后面时钟被清空后它会自行闭嘴，但白白空转一刻且靠运气。
schedule clear rhythm_axe:decor/example/tick
kill @e[tag=decor_example]
# 时钟清零：0 = 「未启动」哨兵 ⇒ 自链守卫不再成立，彻底停演。
scoreboard players reset #decor_example decor_t