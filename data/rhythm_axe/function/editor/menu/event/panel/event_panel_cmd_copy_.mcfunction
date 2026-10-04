#arg:cmd_i
# 把 editing.temp.commands[cmd_i] 复制进指令剪贴板（cmd_clip）。
$execute if data storage rhythm_axe:maps.editor editing.temp.commands[$(cmd_i)] run data modify storage rhythm_axe:maps.editor cmd_clip set from storage rhythm_axe:maps.editor editing.temp.commands[$(cmd_i)]
