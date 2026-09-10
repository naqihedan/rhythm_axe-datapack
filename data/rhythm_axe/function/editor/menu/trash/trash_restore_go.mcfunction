#arg: mapid, index
# 还原执行：把回收站元素整体写回该谱面自己的存储 rhythm_axe:maps.<mapid>（去掉多余 mapid 键）→ 删 trash[index] → 刷新回收站
# ⚠️ 本次"点了没反应"根因（两条致命写法，都会让宏函数实例化失败 → 整个函数静默作废）：
#    ① data modify <目标> set from ... 的目标不能是存储根（缺路径）→ 非法命令（错误的命令参数）
#    ② data remove storage <id> 不能删存储根，必须带路径
# 故照 map_rename / save 的既有做法：先确保存储存在 → 逐键清空旧存储 → {} 根合并回收站版本
#
# ★ 守卫：正在编辑「同一张」谱面时禁止还原
#   理由：编辑内容在工作副本 maps.editor.history[cursor]，还原只改正式存储 ⇒ 两边立刻不一致：
#        之后【保存谱面】会用工作副本覆盖还原结果；退出编辑器则静默丢弃改动
#   （回收站只能在编辑器会话内打开，故必须让玩家先切到别的谱面再还原）
$execute if data storage rhythm_axe:maps.editor {active:1b,mapid:"$(mapid)"} run data modify storage rhythm_axe:maps.editor feedback set value "该谱面正在编辑中，请先用【切换谱面】切到其他谱面，再回来还原"
$execute if data storage rhythm_axe:maps.editor {active:1b,mapid:"$(mapid)"} run data modify storage rhythm_axe:maps.editor no_undo set value 1b
$execute if data storage rhythm_axe:maps.editor {active:1b,mapid:"$(mapid)"} run function rhythm_axe:editor/menu/trash/trash_panel_open
$execute if data storage rhythm_axe:maps.editor {active:1b,mapid:"$(mapid)"} run return 0
$execute unless data storage rhythm_axe:maps.$(mapid) id run data modify storage rhythm_axe:maps.$(mapid) id set value "tmp"
$data remove storage rhythm_axe:maps.$(mapid) id
$data remove storage rhythm_axe:maps.$(mapid) title
$data remove storage rhythm_axe:maps.$(mapid) artist
$data remove storage rhythm_axe:maps.$(mapid) author
$data remove storage rhythm_axe:maps.$(mapid) music
$data remove storage rhythm_axe:maps.$(mapid) preview
$data remove storage rhythm_axe:maps.$(mapid) teleport
$data remove storage rhythm_axe:maps.$(mapid) spawn_pos
$data remove storage rhythm_axe:maps.$(mapid) spawn_x
$data remove storage rhythm_axe:maps.$(mapid) spawn_y
$data remove storage rhythm_axe:maps.$(mapid) spawn_z
$data remove storage rhythm_axe:maps.$(mapid) spawn_yaw
$data remove storage rhythm_axe:maps.$(mapid) spawn_pitch
$data remove storage rhythm_axe:maps.$(mapid) player_count
$data remove storage rhythm_axe:maps.$(mapid) health
$data remove storage rhythm_axe:maps.$(mapid) end_time
$data remove storage rhythm_axe:maps.$(mapid) highest_score
$data remove storage rhythm_axe:maps.$(mapid) progress_color
$data remove storage rhythm_axe:maps.$(mapid) notes
$data remove storage rhythm_axe:maps.$(mapid) timing_points
$data remove storage rhythm_axe:maps.$(mapid) events
$data remove storage rhythm_axe:maps.$(mapid) editor_playhead
$data modify storage rhythm_axe:maps.$(mapid) {} merge from storage rhythm_axe:maps trash[$(index)]
# ★ 强制键与内部 id 一致（回收站那份可能是改名前的旧 id；正式存储的键=mapid 是不变量）
$data modify storage rhythm_axe:maps.$(mapid) id set value "$(mapid)"
$data remove storage rhythm_axe:maps.$(mapid) mapid
$data remove storage rhythm_axe:maps trash[$(index)]
$tellraw @s [{"text":"已还原谱面","color":"green"},{"text":"$(mapid)","color":"aqua"}]
function rhythm_axe:editor/menu/trash/trash_panel_open
