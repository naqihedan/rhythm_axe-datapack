# 播放头回到开头（= min(0, 最早出生)-1，与游玩一致）；播放中则暂停；刷新主菜单让 ▶/⏸ 同步
function rhythm_axe:editor/visual/seek_start
function rhythm_axe:editor/playback/pause
function rhythm_axe:editor/refresh
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][编辑器]","color":"gray"},{"text":" 已回到开头","color":"green"}]
# 任意面板可用：返回当前面板（resume）而非强制主菜单
function rhythm_axe:editor/menu/resume
