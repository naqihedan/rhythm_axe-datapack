# 找播放头所在时间点（宏递归）。输出到 rhythm_axe:prop：bpm/tpb/bpb/offset = 播放头所在段；time = 该段起点（新小节起点）
# 前置：prop.cursor（history 游标）、prop.playhead（播放头刻数）——缺失时自动从编辑器状态补
execute unless data storage rhythm_axe:prop cursor run data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute unless data storage rhythm_axe:prop playhead run data modify storage rhythm_axe:prop playhead set from storage rhythm_axe:maps.editor playhead
data modify storage rhythm_axe:prop index set value 0
data modify storage rhythm_axe:prop time set value 0
data modify storage rhythm_axe:prop bpm set value 0.0f
data modify storage rhythm_axe:prop tpb set value 8
data modify storage rhythm_axe:prop bpb set value 4
function rhythm_axe:editor/playback/current_timing_ with storage rhythm_axe:prop
