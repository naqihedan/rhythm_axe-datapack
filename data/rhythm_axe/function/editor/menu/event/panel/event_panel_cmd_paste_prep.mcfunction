# 粘贴指令：点击值 = (1000+指令序号)×100 + 6 → 序号 = click/100 − 1000
# 把 cmd_clip 覆盖到这一行。剪贴板为空 → 只提示。
# 只动暂存，不产生历史快照 → feedback 打 no_undo。
# ⚠️ #temp 会被 event_panel 内部改写（时间行），所以下标先算进 prop 再渲染。
scoreboard players operation #temp editor = #click_value editor
scoreboard players operation #temp editor /= 100 const
scoreboard players remove #temp editor 1000
execute if data storage rhythm_axe:maps.editor cmd_clip run execute store result storage rhythm_axe:prop cmd_i int 1 run scoreboard players get #temp editor
execute if data storage rhythm_axe:maps.editor cmd_clip run function rhythm_axe:editor/menu/event/panel/event_panel_cmd_paste_ with storage rhythm_axe:prop
execute if data storage rhythm_axe:maps.editor cmd_clip run data remove storage rhythm_axe:prop cmd_i
execute if data storage rhythm_axe:maps.editor cmd_clip run data modify storage rhythm_axe:maps.editor feedback set value "已粘贴指令"
execute unless data storage rhythm_axe:maps.editor cmd_clip run data modify storage rhythm_axe:maps.editor feedback set value "剪贴板为空，先复制一条指令"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/event/panel/event_panel
