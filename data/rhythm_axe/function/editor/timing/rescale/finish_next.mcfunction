# 缩放收尾（④ 全部跑完后调用）：谱面级字段 → 取消待续跑 → commit → 解锁 → 反馈 → 下一刻重建视觉
# ★ 这里是「接管」的落点：调用方在 run 返回后不会再 commit（见 run 的调用约定）。
# ★★ 必须先做 ④谱面级字段（end_time / 播放头）再做别的 —— 它们也要用 #rs_num/#rs_den/#rs_a/#rs_delta，
#   一旦下面清了计分板就改不了了。（2026-10-29 踩坑：重构时漏搬 ④，导致 end_time/playhead 不缩放）
# ★★ 再 schedule clear resume：否则已排队的续跑下一刻会拿着已清空的上下文再跑一遍
#   （踩坑：#rs_rounds 涨到 761 的死循环就是这么来的）。
function rhythm_axe:editor/timing/rescale/map_fields
schedule clear rhythm_axe:editor/timing/rescale/resume
function rhythm_axe:editor/file/commit
data remove storage rhythm_axe:maps.editor rescale
data remove storage rhythm_axe:prop rescale
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop i
scoreboard players reset #rs_i editor
scoreboard players reset #rs_phase editor
scoreboard players reset #rs_chunk editor
scoreboard players reset #rs_done editor
scoreboard players reset #rs_off editor
scoreboard players reset #rs_rounds editor
scoreboard players reset #rs_own editor
scoreboard players reset #rs_any editor
execute if score #rs_count editor matches 1.. as @a[tag=editor_active] run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"已按 tpb 变化同步缩放：音符 ","color":"green"},{"score":{"name":"#rs_count","objective":"editor"},"color":"aqua"},{"text":" 个、事件点 ","color":"green"},{"score":{"name":"#rs_ev","objective":"editor"},"color":"aqua"},{"text":" 个","color":"green"}]
execute if score #rs_count editor matches 1.. run schedule function rhythm_axe:editor/timing/rescale/refresh_next 1t
