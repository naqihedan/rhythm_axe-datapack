#arg:mapid
# 编辑状态 + editor 命令：比较目标 mapid 与当前编辑 mapid（@s = 已编辑玩家）
# 相同 → 提示已在编辑这张谱面【返回编辑器】
# 不同 → 记录 pending_mapid 并弹出切换谱面确认面板
$execute if data storage rhythm_axe:maps.editor {mapid:"$(mapid)"} run tellraw @s [{"text":"[编辑器] 您已经在编辑这张谱面了  ","color":"yellow"},{"text":"【返回编辑器】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 903"},"hover_event":{"action":"show_text","value":"返回编辑器主菜单"}}]
$execute if data storage rhythm_axe:maps.editor {mapid:"$(mapid)"} run return fail
# 不同 mapid：存待切换目标并弹确认面板
$data modify storage rhythm_axe:maps.editor pending_mapid set value "$(mapid)"
function rhythm_axe:editor/menu/switch/switch_confirm
