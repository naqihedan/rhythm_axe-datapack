# 反向扫描驱动器（只处理「头在区间左外侧、混凝土尾巴伸进区间」的情况）：
#   从 #ts_j（= #ts_start - 1）向前递减；#ts_stop=1 时停（更早的音符 time 更小，上界已够不到 min）
# 前置：#ts_j、#ts_maxdur=0、prop.cursor
execute if score #ts_j editor matches ..-1 run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #ts_j editor
function rhythm_axe:editor/tool/select/time_select_back_judge with storage rhythm_axe:prop
scoreboard players remove #ts_j editor 1
execute if score #ts_stop editor matches 1 run return 0
function rhythm_axe:editor/tool/select/time_select_back_drive
