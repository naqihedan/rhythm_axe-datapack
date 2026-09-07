#arg:mapid
# 保存时移除 maps.$(mapid).notes 各音符的 selected（正式谱面不带选中状态；工作副本不受影响）
# ★ selected 是编辑器选中标记（编辑器状态），不写入正式谱面；mod 时间轴高亮靠 selection 列表，与本字段无关
$data modify storage rhythm_axe:prop mapid set value "$(mapid)"
$execute store result score #notes_len editor run data get storage rhythm_axe:maps.$(mapid).notes
scoreboard players set #i editor 0
function rhythm_axe:editor/file/save_strip_drive
data remove storage rhythm_axe:prop mapid
data remove storage rhythm_axe:prop i
