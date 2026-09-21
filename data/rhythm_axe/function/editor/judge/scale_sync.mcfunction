# 按当前播放头同步判定缩放 → #ed_scale（编辑器真实判定窗口用；缺省 1）
# 用法：refresh（重建/跳转）在生成音符前调用一次；播放中由 advance_ 每刻直接读 current_timing 的输出同步
# 说明：复用 playback/current_timing（宏递归找播放头所在时间点），本函数只负责取 judgement_scale 并清理临时键
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop playhead set from storage rhythm_axe:maps.editor playhead
function rhythm_axe:editor/playback/current_timing with storage rhythm_axe:prop
scoreboard players set #ed_scale editor 1
execute if data storage rhythm_axe:prop judgement_scale run execute store result score #ed_scale editor run data get storage rhythm_axe:prop judgement_scale
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop playhead
data remove storage rhythm_axe:prop bpm
data remove storage rhythm_axe:prop tpb
data remove storage rhythm_axe:prop bpb
data remove storage rhythm_axe:prop time
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop judgement_scale
