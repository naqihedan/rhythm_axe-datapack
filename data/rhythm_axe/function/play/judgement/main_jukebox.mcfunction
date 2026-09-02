# 唱片机判定核心（@s = 唱片机交互实体；每 tick 由 active_note/active_note 调用）
# M2-E：唱片机 = 进阶版音符盒，通过左右键交互判定（NBT 时间戳检测）
# 规则：
#   - 包括 bad、good、perfect、miss 所有种类判定（按点击时的寿命换算等级）
#   - 左右键点击唱片机交互实体 → interaction 实体的 interaction.timestamp / attack.timestamp
#     更新（游戏 tick）→ 每 tick 比对时间戳变化 → 打通用点击标记 interacted
#   - 音符每刻自检：有标记且寿命在判定窗口内（[3x, -2x]）→ 判定；
#     标记存在但寿命不在窗口内（过早/过晚点击）→ 忽略并清除标记
#   - 判定保护（最后一刻兜底）：goodL 最后一刻（寿命==-2x）仍无点击判定 →
#     玩家视线与唱片机相交 → good_late；相离 → miss
# ⚠️ 为什么用 NBT 而不用 advancement：26.x 中 advancement 的完成记录持久化、revoke 无法清除，
#    start 的 grant 永远"获得即完成即失去"（玩家历史交互过 interaction）→ advancement 无法重新
#    激活。NBT 时间戳是纯原生、确定性的点击检测（advancement 保留仅作辅助双保险，不依赖）。
scoreboard players operation #life play_state = @s note_life

# 有通用点击标记 → 点击判定（消费 interacted）
# ⚠️ 玩家按住/连点右键会每 tick 触发点击检测 → 每 tick 打 interacted。
#   若视线兜底用 interacted==0 才调用，则 jukebox_late 会被永久跳过 → 无视线兜底、全 miss。
#   因此视线兜底无条件执行（已判定实体在 clicked_check 中已被删除，不会重复判定）。
execute if score @s interacted matches 1.. run function rhythm_axe:play/judgement/jukebox_clicked_check
# 最后一刻视线兜底（goodL 末刻；不论 interacted——点击过早/过晚或从未点击都兜底）
# ⚠️ 直接 function 调用（main_jukebox 本身由 execute as @e at @s run 调用，@s 上下文已继承）；
#   不能用 execute function <名> 简写（26.x 解析失败 → 整个函数加载失败 → 全 miss）
function rhythm_axe:play/judgement/jukebox_late
