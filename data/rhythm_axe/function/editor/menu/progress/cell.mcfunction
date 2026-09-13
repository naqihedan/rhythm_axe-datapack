#arg: pro,col,pad,comma,i
# 进度条单格：把第 $(i) 格组件追加到 $(pro)（值 = 1150$(pad)$(i)，共 115001..115051）；末格拼接完停止
$data modify storage rhythm_axe:prop pro set value '$(pro)$(comma){"text":"=","color":"$(col)","click_event":{"action":"run_command","command":"/trigger editor_click set 1150$(pad)$(i)"}}'
scoreboard players add #i editor 1
execute if score #i editor matches ..51 run function rhythm_axe:editor/menu/progress/drive
