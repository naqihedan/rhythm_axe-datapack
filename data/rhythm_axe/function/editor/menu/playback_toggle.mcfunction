# 播放/暂停切换（按 playing 状态）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor playing
execute if score #temp editor matches 1 run function rhythm_axe:editor/playback/pause
execute unless score #temp editor matches 1 run function rhythm_axe:editor/playback/play
# ★ 2026-09-17：只有面板 1/10 需要随播放状态重绘（守卫 + 理由见 menu/resume_playback）
function rhythm_axe:editor/menu/resume_playback
