# ========== 示例装饰（decor/example）：驱动器（自链）==========
# 每刻由上一刻 schedule 自己唤起（
# 三段顺序不能动：① 推进时钟 ② 回环归位 ③ 下发本刻关键帧。
# ★ 回环必须在 frames 之前：第 41 刻归到 1 之后立刻让 frames 认出「第 1 帧」；
#   若把 frames 放在回环之前，那一刻会按 41 匹配（没有帧）擦身而过，
#   而下一 tick 时钟已是 2 ⇒ 第 1 帧永不再触发（循环接不上）。
# ★ 回环用 set 1，【绝不能用 set 0 / reset】：
#   0 是「未启动」哨兵 —— 一旦时钟落进 0，下面的自链守卫不成立，链就断（装饰停摆，且无报错）。
# 周期 = 40 刻：t = 1..40 演出（4 帧 × 10 刻），t = 41 归位并重演第 1 帧。
scoreboard players add #decor_example decor_t 1
execute if score #decor_example decor_t matches 41.. run scoreboard players set #decor_example decor_t 1
function rhythm_axe:decor/example/frames

# 自链：只在自己【正在演】时接着排下一刻 ⇒ clear 后（时钟 0）自然终止，不会空转
# ★ 所以清场时必须先 schedule clear（见 clear.mcfunction），否则残留的链会一直空转下去。
execute if score #decor_example decor_t matches 1.. run schedule function rhythm_axe:decor/example/tick 1t