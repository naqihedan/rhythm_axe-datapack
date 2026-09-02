# 上一个/下一个时间点按钮（存在绿色，不存在红色）
# 上一个：ref-1
execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor editing.ref
scoreboard players remove #temp_playhead editor 1
execute if score #temp_playhead editor matches ..-1 run tellraw @s [{"text":"【上一个时间点】","color":"red"},{"text":"  ","color":"white"}]
execute if score #temp_playhead editor matches 0.. run function rhythm_axe:editor/menu/timing/panel/timing_panel_nav_prev
# 下一个：ref+1
execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor editing.ref
scoreboard players add #temp_playhead editor 1
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp_playhead editor
function rhythm_axe:editor/menu/timing/panel/timing_panel_nav_next_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
