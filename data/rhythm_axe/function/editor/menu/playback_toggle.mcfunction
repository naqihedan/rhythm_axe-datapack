# 播放/暂停切换（按 playing 状态）
# ★★ 2026-10-07 修复：分支判断**不能**用共享的 #temp！
#   暂停分支里的 return_mark → refresh 会在中途 `store result score #temp …
#   data get …playing`（暂停后 = 0），把 #temp 重新写成 0 ⇒ 下面第 9 行
#   `unless #temp matches 1 → play` 被误触发，表现为「按暂停后立刻又自己播放、关不掉」。
#   ⇒ 本文件改用**专用**分数 #temp_playing（只有本文件读写，任何被调函数都不会碰）。
execute store result score #temp_playing editor run data get storage rhythm_axe:maps.editor playing
# 播放中 → 暂停；★ 2026-10-07：只要存在「记录点」（蹲下右键记录）→ 暂停后跳回记录点
#   记录点是**持久**的（可反复使用，不随暂停/播放清除），只在「在记录点处蹲下右键」时删除
#   （见 playback/record_toggle；工具蹲下分派见 tool/timeline/used_timeline_playpause）
execute if score #temp_playing editor matches 1 run function rhythm_axe:editor/playback/pause
execute if score #temp_playing editor matches 1 if data storage rhythm_axe:maps.editor record_head run function rhythm_axe:editor/playback/return_mark
# 未播放 → 播放（记录点不受影响）
execute unless score #temp_playing editor matches 1 run function rhythm_axe:editor/playback/play
# ★ 2026-10-06：暂停→**播放**（恢复播放）不重绘面板 10 活跃音符列表 ——
#   播放头未变 ⇒ 列表内容不变；而重绘要「清屏 + 重画整表」，与同刻 refresh（如播放头停在末尾时
#   play_check_end → jump_start → refresh）叠加时二者一起吃掉几十~一百多 ms，明显掉刻。
#   暂停方向仍重绘（播放期间进出窗口的音符需要刷新）。
execute unless score #temp_playing editor matches 1 run data modify storage rhythm_axe:prop skip_note_list set value 1b
# ★ 2026-09-17：只有面板 1/10 需要随播放状态重绘（守卫 + 理由见 menu/resume_playback）
function rhythm_axe:editor/menu/resume_playback
