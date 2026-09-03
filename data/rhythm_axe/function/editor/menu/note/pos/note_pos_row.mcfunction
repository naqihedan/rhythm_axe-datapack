#arg:label,xcomp,tcomp,paux,bxm,bxp,bym,byp,bzm,bzp,bxm2,bxp2,bym2,byp2,bzm2,bzp2
# 判定位置/起始位置：首行【x】【~】+标签+辅助按钮；第二行三轴

$tellraw @s [$(xcomp),$(tcomp),{"text":"$(label)","color":"white"},$(paux)]
$execute if score #nx editor matches 0 if score #ny editor matches 0 if score #nz editor matches 0 run tellraw @s [\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
$execute if score #nx editor matches 0 if score #ny editor matches 0 if score #nz editor matches 1 run tellraw @s [\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"text":"-","color":"gold"},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
$execute if score #nx editor matches 0 if score #ny editor matches 1 if score #nz editor matches 0 run tellraw @s [\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"text":"-","color":"gold"},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
$execute if score #nx editor matches 0 if score #ny editor matches 1 if score #nz editor matches 1 run tellraw @s [\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"text":"-","color":"gold"},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"text":"-","color":"gold"},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
$execute if score #nx editor matches 1 if score #ny editor matches 0 if score #nz editor matches 0 run tellraw @s [\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"text":"-","color":"gold"},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
$execute if score #nx editor matches 1 if score #ny editor matches 0 if score #nz editor matches 1 run tellraw @s [\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"text":"-","color":"gold"},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"text":"-","color":"gold"},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
$execute if score #nx editor matches 1 if score #ny editor matches 1 if score #nz editor matches 0 run tellraw @s [\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"text":"-","color":"gold"},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"text":"-","color":"gold"},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
$execute if score #nx editor matches 1 if score #ny editor matches 1 if score #nz editor matches 1 run tellraw @s [\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm2)"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxm)"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"text":"-","color":"gold"},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp)"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bxp2)"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym2)"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bym)"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"text":"-","color":"gold"},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp)"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(byp2)"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm2)"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzm)"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"text":"-","color":"gold"},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp)"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(bzp2)"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]
