# 单个事件点判断（宏参数 ev_idx）：
# playhead == time → 执行 commands + 推进；playhead > time → 跳过推进（跳转后防御）；playhead < time → 停
#arg: cursor, ev_idx
$execute store result score #ev_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].time
# 相等比较（=）用 双 unless > < 等价写法（规避 Spyglass 对 = 的解析误报）
execute unless score #playhead editor > #ev_time editor unless score #playhead editor < #ev_time editor run function rhythm_axe:editor/visual/event_go_ with storage rhythm_axe:prop
execute if score #playhead editor > #ev_time editor run function rhythm_axe:editor/visual/event_next_ with storage rhythm_axe:prop
