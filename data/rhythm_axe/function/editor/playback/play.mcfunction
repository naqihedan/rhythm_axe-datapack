# 播放：tick rate 跟随播放头所在时间点，playmusic 从播放头处播放
function rhythm_axe:editor/playback/current_timing
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
# ★ 播放头已到/超过谱面结束时间 → 先回到开头再播放（避免播到最后又推进一刻）
function rhythm_axe:editor/playback/play_check_end with storage rhythm_axe:prop
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/playback/play_ with storage rhythm_axe:prop
