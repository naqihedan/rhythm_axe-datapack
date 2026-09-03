# 批量粘贴到播放头（面板 18）：剪贴板中 time 最小（最早）的音符对齐播放头，其余保持相对间距写回为新音符
# 先设 prop.time=播放头，再走 editor/note/paste/paste，最后重开已选定列表
execute store result storage rhythm_axe:prop time int 1 run scoreboard players get #playhead editor
function rhythm_axe:editor/note/paste/paste
data remove storage rhythm_axe:prop time
function rhythm_axe:editor/menu/note/selected/sel_note_list_open
