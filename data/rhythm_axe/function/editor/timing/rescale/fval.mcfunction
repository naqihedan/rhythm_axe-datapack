# 刻坐标映射 f(#rs_t) → #rs_ft（普通函数，无宏）
# 前置：#rs_t、#rs_a（段起点）、#rs_has_b、#rs_b（下一个时间点）、#rs_delta、#rs_num/#rs_den
# 规则（ratio = num/den）：
#   t <  A                       → t                        （段前不动）
#   A ≤ t < B（或 P 是最后一点）  → A + round((t−A)×ratio)    （段内按比例缩放，锚 = A）
#   t ≥  B                       → t + delta                （段后整体平移）
# ★ 单调不减 ⇒ notes[] 缩放后仍按 time 升序，无需重排。
# ★ 播放头可能为负（延迟起播）⇒ 负数 / 段前一律原样返回，绝不进 scale。
#
# ⚠️⚠️ 本函数**绝对不能出现 return**（2026-10-29 实测踩坑）：
#   `/return` 会终止**整条函数调用栈**，不只是当前函数 ——
#   在 notes_leaf 里 `function fval` 后，fval 一旦 return，notes_leaf 剩下的命令全部不执行，
#   表现为「#rs_i 不推进 + 永不越界 + 死循环」。
#   所以这里改用「两段式」：先用守卫把 #rs_skip 置 1，只在 skip=0 时才做换算。
scoreboard players set #rs_skip editor 0
scoreboard players operation #rs_ft editor = #rs_t editor
# 段前 / 负数 → 原样（标记跳过）
execute if score #rs_t editor < #rs_a editor run scoreboard players set #rs_skip editor 1
# 段后 → 平移
scoreboard players set #rs_use_delta editor 0
execute if score #rs_skip editor matches 0 if score #rs_has_b editor matches 1 if score #rs_t editor >= #rs_b editor run scoreboard players set #rs_use_delta editor 1
execute if score #rs_use_delta editor matches 1 run scoreboard players operation #rs_ft editor += #rs_delta editor
execute if score #rs_use_delta editor matches 1 run scoreboard players set #rs_skip editor 1
# 段内 → 缩放（锚 = #rs_a）
execute if score #rs_skip editor matches 0 run scoreboard players operation #rs_off editor = #rs_t editor
execute if score #rs_skip editor matches 0 run scoreboard players operation #rs_off editor -= #rs_a editor
execute if score #rs_skip editor matches 0 run function rhythm_axe:editor/timing/rescale/scale
execute if score #rs_skip editor matches 0 run scoreboard players operation #rs_ft editor = #rs_out editor
execute if score #rs_skip editor matches 0 run scoreboard players operation #rs_ft editor += #rs_a editor
