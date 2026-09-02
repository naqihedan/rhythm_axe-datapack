# 下一个：元素 time > 播放头 → 跳到该 time；否则继续找
execute if score #timing_time editor > #temp_playhead editor run function rhythm_axe:editor/util/jump_next_apply
execute unless score #timing_time editor > #temp_playhead editor run function rhythm_axe:editor/util/jump_advance
