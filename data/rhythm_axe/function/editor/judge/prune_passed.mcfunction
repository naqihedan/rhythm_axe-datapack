# 暂停清理（单实体；@s = 编辑器音符展示实体，由 playback/pause 遍历调用）
# 静默清掉「已过判定位置且尚未判定」的音符：0/1/2 按寿命 < 0；长条(3) 按尾端时间（见文件末）。
# 为什么需要：暂停后时间冻结，这些音符既不会再被判定、也不会自己消失 ——
#   · 真实判定模式：窗口被延长到 miss 时刻，暂停时若还没到 miss 就不会触发收尾；
#   · 自动预览模式：tick 停摆，本来靠 tick_kill（playhead > end）清理的也停在那儿。
#   它们会一直挂在判定位置上，所以暂停时一并放弃（不播 miss 反馈，与木板超窗的"静默清除"一致）。
# ★ 处理 0/1/2 + 长条(3)：
#   · 0/1/2 判据 = 已过判定位置（寿命 < 0）且未判定；
#   · 3 混凝土长条（2026-09-21 补）：尾端时间（= 判定时间 + 持续时长）已过播放头 → 清掉。
#     此时长条已彻底走完（长度收缩到 0），纯计分板比较，不读实体 NBT。
#   · 玻璃(4) 零反馈，仍不归本机制管（其判定未搬，见 todo）。
# ★ 前置：#playhead 已由 pause 同步（读 maps.editor.playhead）。
# ★ 已判定过的（tag editor_n_triggered）不清：它们在判定模式下命中后已被 tick_kill 移除，
#   这里只兜住「自动预览模式下正好停在判定时刻那一刻」的形态，保持它可见。
scoreboard players operation #ed_life editor = @s editor_n_time
scoreboard players operation #ed_life editor -= #playhead editor
execute if score @s editor_n_type matches 0..2 if score #ed_life editor matches ..-1 unless entity @s[tag=editor_n_triggered] run function rhythm_axe:editor/visual/tick_kill
# ---- 长条（混凝土 3）：尾端时间已过播放头 → 静默清掉 ----
#   尾端时间 = 判定时间 + 持续时长（editor_n_time + editor_n_dur）= 尾端追上头端的时刻
#   （place_concrete：头端在 birth+lt 停住，尾端延后 dur 刻走完剩下的 d+s，此刻长度收缩到 0）
#   尾端时间 < 播放头 ⇒ 长条已彻底走完 ⇒ 暂停时清掉（纯计分板，不读实体 NBT）
scoreboard players operation #ed_pr_tail editor = @s editor_n_time
scoreboard players operation #ed_pr_tail editor += @s editor_n_dur
execute if score @s editor_n_type matches 3 if score #ed_pr_tail editor < #playhead editor run function rhythm_axe:editor/visual/tick_kill
