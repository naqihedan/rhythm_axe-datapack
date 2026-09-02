# 谱面设置：初始位置一行三轴渲染（一位小数；score 已算好 #vxi/#vxf/#vyi/#vyf/#vzi/#vzf/#nx/#ny/#nz）
# 文档格式：初始位置 [-] 0.0 [+] [-] 0.0 [+] [-] 0.0 [+]
execute if score #nx editor matches 0 if score #ny editor matches 0 if score #nz editor matches 0 run tellraw @s [\
{"text":"初始位置：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 107"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 108"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 109"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 110"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 111"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 112"},"hover_event":{"action":"show_text","value":"Z +0.1"}}\
]
execute if score #nx editor matches 1 if score #ny editor matches 0 if score #nz editor matches 0 run tellraw @s [\
{"text":"初始位置：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 107"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"text":"-","color":"white"},{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 108"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 109"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 110"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 111"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 112"},"hover_event":{"action":"show_text","value":"Z +0.1"}}\
]
execute if score #nx editor matches 0 if score #ny editor matches 1 if score #nz editor matches 0 run tellraw @s [\
{"text":"初始位置：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 107"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 108"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 109"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"text":"-","color":"white"},{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 110"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 111"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 112"},"hover_event":{"action":"show_text","value":"Z +0.1"}}\
]
execute if score #nx editor matches 0 if score #ny editor matches 0 if score #nz editor matches 1 run tellraw @s [\
{"text":"初始位置：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 107"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 108"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 109"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 110"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 111"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"text":"-","color":"white"},{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 112"},"hover_event":{"action":"show_text","value":"Z +0.1"}}\
]
execute if score #nx editor matches 1 if score #ny editor matches 1 if score #nz editor matches 0 run tellraw @s [\
{"text":"初始位置：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 107"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"text":"-","color":"white"},{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 108"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 109"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"text":"-","color":"white"},{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 110"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 111"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 112"},"hover_event":{"action":"show_text","value":"Z +0.1"}}\
]
execute if score #nx editor matches 1 if score #ny editor matches 0 if score #nz editor matches 1 run tellraw @s [\
{"text":"初始位置：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 107"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"text":"-","color":"white"},{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 108"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 109"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 110"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 111"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"text":"-","color":"white"},{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 112"},"hover_event":{"action":"show_text","value":"Z +0.1"}}\
]
execute if score #nx editor matches 0 if score #ny editor matches 1 if score #nz editor matches 1 run tellraw @s [\
{"text":"初始位置：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 107"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 108"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 109"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"text":"-","color":"white"},{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 110"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 111"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"text":"-","color":"white"},{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 112"},"hover_event":{"action":"show_text","value":"Z +0.1"}}\
]
execute if score #nx editor matches 1 if score #ny editor matches 1 if score #nz editor matches 1 run tellraw @s [\
{"text":"初始位置：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 107"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"text":"-","color":"white"},{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 108"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 109"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"text":"-","color":"white"},{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 110"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"  [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 111"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"text":"-","color":"white"},{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 112"},"hover_event":{"action":"show_text","value":"Z +0.1"}}\
]
