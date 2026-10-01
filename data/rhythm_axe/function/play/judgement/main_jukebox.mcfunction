# 唱片机判定核心（@s = 唱片机交互实体；每 tick 由 active_note/active_note 调用）
# M2-E：唱片机 = 进阶版音符盒，通过左右键交互判定（advancement 触发 + UUID 匹配）
# 规则：
#   - 包括 bad、good、perfect、miss 所有种类判定（按点击时的寿命换算等级）
#   - 左右键点击唱片机交互实体 → player_interacted_with_entity / player_hurt_entity advancement
#     触发 → 捕获玩家 UUID → 遍历唱片机交互实体按 interaction.player / attack.player 匹配 → 打 interacted
#     （照编辑器 note_deselect / note_click 同款，见 jukebox_clicked_* / jukebox_clicked_match_*）
#   - 音符每刻自检：有标记且寿命在判定窗口内（[3x, -2x]）→ 判定；
#     标记存在但寿命不在窗口内（过早/过晚点击）→ 忽略并清除标记
#   - 判定保护（★ 2026-09-29 放宽为「窗口内相交过」）：goodL 最后一刻（寿命==-2x）仍无点击判定 →
#     判定窗口 [3x, -2x] 内任一刻玩家视线与唱片机相交过 → good_late；全程未相交过 → miss
scoreboard players operation #life play_state = @s note_life

# ★ 判定保护记录（2026-09-29）：判定窗口 [3x, -2x] 内任一刻视线与唱片机相交 → 打 note_jb_seen
#   （末刻兜底 jukebox_late 依据它放 good_late：中途看过、末刻移开也算；全程没相交过才 miss）
#   ⚠️ 唱片机不走 same_tick 的命中检测（点击天然单目标、不参与同刻配额），故这里自己扫谓词；
#     只在本刻尚未记录时才扫（记上后 tag 命中即短路，不再做谓词扫描）
scoreboard players operation #tn2 play_state = #judgement_scale play_state
scoreboard players operation #tn2 play_state *= -2 const
scoreboard players operation #tn3 play_state = #judgement_scale play_state
scoreboard players operation #tn3 play_state *= 3 const
execute if entity @s[tag=!note_jb_seen] if score #life play_state >= #tn2 play_state if score #life play_state <= #tn3 play_state run function rhythm_axe:play/judgement/jukebox_seen

# 有通用点击标记 → 点击判定（消费 interacted）
# ⚠️ 玩家按住/连点右键会每 tick 触发点击检测 → 每 tick 打 interacted。
#   若视线兜底用 interacted==0 才调用，则 jukebox_late 会被永久跳过 → 无视线兜底、全 miss。
#   因此视线兜底无条件执行（已判定实体在 clicked_check 中已被删除，不会重复判定）。
execute if score @s interacted matches 1.. run function rhythm_axe:play/judgement/jukebox_clicked_check
# 最后一刻视线兜底（goodL 末刻；不论 interacted——点击过早/过晚或从未点击都兜底）
# ⚠️ 直接 function 调用（main_jukebox 本身由 execute as @e at @s run 调用，@s 上下文已继承）；
#   不能用 execute function <名> 简写（26.x 解析失败 → 整个函数加载失败 → 全 miss）
function rhythm_axe:play/judgement/jukebox_late
