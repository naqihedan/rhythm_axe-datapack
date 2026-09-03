# 批量粘贴到播放头（面板 10）：剪贴板中 time 最小（最早）的音符对齐播放头，其余保持相对间距写回为新音符
# 先设 prop.time=播放头，再走 editor/note/paste/paste（内部完成偏移/分配 id/插入/快照），最后重开列表
execute store result storage rhythm_axe:prop time int 1 run scoreboard players get #playhead editor
function rhythm_axe:editor/note/paste/paste
data remove storage rhythm_axe:prop time
function rhythm_axe:editor/menu/note/list/note_list_open
