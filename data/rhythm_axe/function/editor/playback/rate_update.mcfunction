# 时间点（红线）变化 → 更新 tick rate（前置：prop.bpm/tpb 已由 current_timing 输出）
# 更新 #rate_bpm/#rate_tpb 记录，speed 从 play_speed 取，tickrate_ 用后即删
execute store result score #rate_bpm editor run data get storage rhythm_axe:prop bpm 1000
execute store result score #rate_tpb editor run data get storage rhythm_axe:prop tpb
data modify storage rhythm_axe:prop speed set from storage rhythm_axe:maps.editor play_speed
function rhythm_axe:editor/playback/tickrate_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop speed
