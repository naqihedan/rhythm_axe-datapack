#arg:cursor,index
# 把暂存 editing.temp 重新从工作副本 history[$(cursor)].events[$(index)] 拷回（丢弃本次改动）。
# 用于「快捷操作」对话框取消时还原：已有事件点本身从未被改（只改了暂存），这里把暂存也复原，
# 保证「取消后事件点完全不变」（不会残留一条被追加的空指令）。
# ★ 不渲染面板、不挪播放头、不弹对话框 —— 由调用方决定后续动作。
$data modify storage rhythm_axe:maps.editor editing.ref set value $(index)
$data modify storage rhythm_axe:maps.editor editing.temp set from storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)]
execute unless data storage rhythm_axe:maps.editor editing.temp.time run data modify storage rhythm_axe:maps.editor editing.temp.time set value 0
execute unless data storage rhythm_axe:maps.editor editing.temp.commands run data modify storage rhythm_axe:maps.editor editing.temp.commands set value []
data remove storage rhythm_axe:maps.editor editing.cmd_target