#arg:mapid,i
# 若音符带 selected 标记则移除（正式谱面不带选中状态）
# ★ 2026-09-15 修：storage ID 与路径之间必须有空格！`rhythm_axe:maps.$(mapid).notes[$(i)].selected`
#   会被解析成「ID 吃掉 .notes + 紧跟 [ 没有空格」⇒ 命令解析失败 ⇒ 整个宏实例无法创建
#   （报错：无法实例化函数 rhythm_axe:editor/file/save_strip_leaf）⇒ selected 从来没被剔除过
$execute if data storage rhythm_axe:maps.$(mapid) notes[$(i)].selected run data remove storage rhythm_axe:maps.$(mapid) notes[$(i)].selected
