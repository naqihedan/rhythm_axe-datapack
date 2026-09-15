#arg:mapid
# 保存时移除 maps.$(mapid).notes 各音符的 selected（正式谱面不带选中状态；工作副本不受影响）
# ★ selected 是编辑器选中标记（编辑器状态），不写入正式谱面；mod 时间轴高亮靠 selection 列表，与本字段无关
$data modify storage rhythm_axe:prop mapid set value "$(mapid)"
# ★ 2026-09-15 修：storage ID 与路径之间**必须有空格**！`rhythm_axe:maps.$(mapid).notes` 会把 `.notes`
#   吞进「资源位置」里（点号在 ID 里合法）⇒ 变成查一个不存在的存储 maps.<mapid>.notes，命令失败、
#   #notes_len 保留旧值（旧写法还连带 save_strip_leaf 无法实例化 → selected 根本不会被剔除）
$execute store result score #notes_len editor run data get storage rhythm_axe:maps.$(mapid) notes
scoreboard players set #i editor 0
function rhythm_axe:editor/file/save_strip_drive
data remove storage rhythm_axe:prop mapid
data remove storage rhythm_axe:prop i
