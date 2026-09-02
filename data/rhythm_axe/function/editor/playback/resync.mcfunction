# 播放中跳转后重新同步（tick rate + playmusic 从新播放头处继续）
function rhythm_axe:editor/playback/current_timing
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/playback/play_ with storage rhythm_axe:prop
