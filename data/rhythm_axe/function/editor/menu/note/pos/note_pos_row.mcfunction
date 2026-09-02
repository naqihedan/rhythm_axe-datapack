#arg:label,bxm,bxp,bym,byp,bzm,bzp,bxm2,bxp2,bym2,byp2,bzm2,bzp2
# 音符面板：判定位置/起始位置 一行三轴渲染（一位小数；负零加前导 -）
# #vxi/#vxf/#vyi/#vyf/#vzi/#vzf（绝对值+符号，|值|≥1 时整数位自带负号）与 #nx/#ny/#nz（负零标记）已由调用方算好。
# 按钮：bxm/bxp = X 精调减/加（±0.1），bym/byp = Y 精调减/加，bzm/bzp = Z 精调减/加；bxm2/bxp2/bym2/byp2/bzm2/bzp2 = 粗调减/加（±1 格）。
$execute if score #nx editor matches 0 if score #ny editor matches 0 if score #nz editor matches 0 run tellraw @s [\
{"text":"$(label)","color":"gray"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
$execute if score #nx editor matches 1 if score #ny editor matches 0 if score #nz editor matches 0 run tellraw @s [\
{"text":"$(label)","color":"gray"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"text":"-","color":"gold"},{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
$execute if score #nx editor matches 0 if score #ny editor matches 1 if score #nz editor matches 0 run tellraw @s [\
{"text":"$(label)","color":"gray"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"text":"-","color":"gold"},{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
$execute if score #nx editor matches 0 if score #ny editor matches 0 if score #nz editor matches 1 run tellraw @s [\
{"text":"$(label)","color":"gray"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"text":"-","color":"gold"},{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
$execute if score #nx editor matches 1 if score #ny editor matches 1 if score #nz editor matches 0 run tellraw @s [\
{"text":"$(label)","color":"gray"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"text":"-","color":"gold"},{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"text":"-","color":"gold"},{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
$execute if score #nx editor matches 1 if score #ny editor matches 0 if score #nz editor matches 1 run tellraw @s [\
{"text":"$(label)","color":"gray"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"text":"-","color":"gold"},{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"text":"-","color":"gold"},{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
$execute if score #nx editor matches 0 if score #ny editor matches 1 if score #nz editor matches 1 run tellraw @s [\
{"text":"$(label)","color":"gray"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"text":"-","color":"gold"},{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"text":"-","color":"gold"},{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
$execute if score #nx editor matches 1 if score #ny editor matches 1 if score #nz editor matches 1 run tellraw @s [\
{"text":"$(label)","color":"gray"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"text":"-","color":"gold"},{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"text":"-","color":"gold"},{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"  [--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"text":"-","color":"gold"},{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]