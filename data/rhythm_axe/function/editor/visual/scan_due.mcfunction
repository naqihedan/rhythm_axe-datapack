# ★ 播放中「补扫出生」（2026-09-21 新增）：把队首之后、本刻恰好出生的音符也生成出来
#
# 为什么需要：notes 按 time 升序，但**出生刻 birth = time − note_base_life×16/note_speed 在 base_life 不统一时不单调**
#   （如 base_life 12 的玻璃排在 base_life 32 的唱片机前面 → 后者出生更早）。
#   只靠「队首未出生就停」的游标走法（tick_birth_*），排在后面、但前导更长的音符会被压到挡路音符出生后才生成：
#   症状 = 音符只剩后半程才出现、一出现就已经走过一半（用户 2026-09-21 报「判定前 ~16 刻才出现，已经跑到一半」；
#   实测 lament_rain：1424 音符里 61 个被延迟 1~24 刻）。
#   （快进/快退「逐刻看没问题」是因为它们走 refresh 全表重建，不看顺序。）
#
# 本补扫把这类音符按各自的出生刻正常生成；游标走法同步改为「出生当刻生成、过出生刻只推进」，
# 两条路都只认「birth == playhead」精确一刻 ⇒ 每个音符只生成一次，不重复召唤（不会重置判定状态）。
#
# 窗口上界 = 全谱最大前导 vis_lead_max（refresh 时统计，见 spawn_one_）：lead 更大的音符才可能更早出生，
#   所以「time − playhead > lead_max」之后一定没有本刻出生者。
# 前置：#playhead 已同步；仅在播放中（visual/tick）调用
scoreboard players set #due_stop editor 0
scoreboard players set #due_max editor 240
execute store result score #due_max editor run data get storage rhythm_axe:editor.runtime vis_lead_max
execute store result score #due_i editor run scoreboard players get #vis_next editor
scoreboard players add #due_i editor 1
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/visual/scan_due_drive
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop note_idx
data remove storage rhythm_axe:prop note
