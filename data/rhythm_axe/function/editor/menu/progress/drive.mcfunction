# 进度条逐格驱动：#i = 当前格号（1..51）；决定颜色/前导零/逗号后调 cell 宏拼接
execute if score #i editor < #prog_mark editor run data modify storage rhythm_axe:prop col set value "green"
execute if score #i editor = #prog_mark editor run data modify storage rhythm_axe:prop col set value "yellow"
execute if score #i editor > #prog_mark editor run data modify storage rhythm_axe:prop col set value "gray"
data modify storage rhythm_axe:prop pad set value ""
execute if score #i editor matches 1..9 run data modify storage rhythm_axe:prop pad set value "0"
data modify storage rhythm_axe:prop comma set value ","
execute if score #i editor matches 1 run data modify storage rhythm_axe:prop comma set value ""
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #i editor
function rhythm_axe:editor/menu/progress/cell with storage rhythm_axe:prop
