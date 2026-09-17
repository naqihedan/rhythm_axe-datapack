# 播放头回到开头（= min(0, 最早出生)-1，与游玩一致）；播放中则暂停；刷新主菜单让 ▶/⏸ 同步
function rhythm_axe:editor/visual/seek_start
function rhythm_axe:editor/playback/pause
# ★ 只移动播放头，不改音符 → 跳过 refresh 里的 selection 重建（省一整趟遍历）
data modify storage rhythm_axe:prop refresh_skip_sel set value 1b
function rhythm_axe:editor/refresh
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][编辑器]","color":"gray"},{"text":" 已回到开头","color":"green"}]
# 任意面板可用：返回当前面板（只有面板 1/10 需要随播放头重绘）
# ★ 2026-09-12：面板/列表渲染推迟到下一 tick（refresh 已经重建了整表视觉，同刻渲染会挤爆命令链）
function rhythm_axe:editor/menu/resume_playback_next
