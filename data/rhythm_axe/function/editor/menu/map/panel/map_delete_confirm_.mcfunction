# 删除确认面板显示（宏 #arg: cursor, mapid）
#arg: cursor, mapid
data modify storage rhythm_axe:maps.editor current_panel set value 16
tellraw @s [{"text":"====删除谱面====","color":"red"}]
$tellraw @s ["",{"text":"确定要删除","color":"red"},{"nbt":"history[$(cursor)].title","storage":"rhythm_axe:maps.editor","interpret":true,"color":"aqua"},{"text":" - ","color":"gray"},{"nbt":"history[$(cursor)].artist","storage":"rhythm_axe:maps.editor","interpret":true,"color":"aqua"},{"text":" - ","color":"gray"},{"text":"$(mapid)","color":"aqua"},{"text":"？","color":"red"}]
tellraw @s [{"text":"你可以在回收站找到它","color":"gray","italic":true}]
# 回收站存在同 id 谱面时提示（删除会覆盖导致旧回收站内容永久丢失）
# 先清理旧复合结构（旧版本 trash.<mapid> 会让 trash_has 读取失败）
function rhythm_axe:editor/file/trash_migrate
scoreboard players set #trash_has editor 0
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/file/trash_has with storage rhythm_axe:prop
data remove storage rhythm_axe:prop index
execute if score #trash_has editor matches 1 run tellraw @s [{"text":"回收站存在同id谱面，删除会导致回收站谱面永久丢失","color":"red"}]
tellraw @s [{"text":"【确认删除】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10001"},"hover_event":{"action":"show_text","value":"把谱面移入回收站并退出编辑器"}},{"text":"  【取消】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10002"},"hover_event":{"action":"show_text","value":"返回主菜单"}}]
