#arg:mapid,cur
# 另存为：工作副本写入 maps.<mapid>_副本，切换编辑到新谱面（新谱面不带最高分）
$data modify storage rhythm_axe:maps.$(mapid)_副本 set from storage rhythm_axe:maps.editor history[$(cur)]
$data modify storage rhythm_axe:maps.editor mapid set value '$(mapid)_副本'
data modify storage rhythm_axe:maps.editor saved_cursor set from storage rhythm_axe:maps.editor history_cursor
$tellraw @s [{"text":"[编辑器] 已另存为 ","color":"green"},{"text":"$(mapid)_副本","color":"aqua"},{"text":"，正在编辑新谱面","color":"green"}]
