#arg:cmd_i
# 用指令剪贴板覆盖 editing.temp.commands[cmd_i]（保留该行的位置，只改内容）。
$execute if data storage rhythm_axe:maps.editor cmd_clip run data modify storage rhythm_axe:maps.editor editing.temp.commands[$(cmd_i)] set from storage rhythm_axe:maps.editor cmd_clip
