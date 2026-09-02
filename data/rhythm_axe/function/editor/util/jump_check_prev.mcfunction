# 上一个：元素 time >= 播放头 → 跳到候选（最后一个比播放头早的 time）；否则记录候选并继续
execute if score #timing_time editor >= #temp_playhead editor run function rhythm_axe:editor/util/jump_prev_apply
execute unless score #timing_time editor >= #temp_playhead editor run function rhythm_axe:editor/util/jump_advance
