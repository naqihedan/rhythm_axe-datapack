# 失控保护：中止缩放并清理（#rs_i 超过硬上限时由 resume 调用）
# ★ 数据可能已部分缩放 —— 可选：提示用户撤销。这里只做「停 + 解锁 + 清状态」，不 commit
#   （未 commit 意味着工作副本仍是 begin 之前的快照内容 → 撤销一次即可回到原状）。
data remove storage rhythm_axe:maps.editor rescale
data remove storage rhythm_axe:prop rescale
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop i
scoreboard players reset #rs_i editor
scoreboard players reset #rs_phase editor
scoreboard players reset #rs_chunk editor
scoreboard players reset #rs_done editor
scoreboard players reset #rs_off editor
scoreboard players reset #rs_own editor
scoreboard players reset #rs_any editor
# ★ 必须是 `execute as ... run ...`：单独写 `as ... run ...` 不是合法命令
#   （`as` 只是 execute 的子命令），整个文件会加载失败 ⇒ 失控保护形同虚设。
execute as @a[tag=editor_active] run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"同步缩放已中止（遍历异常）","color":"red"},{"text":"建议点【撤销】恢复","color":"yellow"}]
