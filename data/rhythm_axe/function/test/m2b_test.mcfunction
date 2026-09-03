execute if score #nx editor matches 0 if score #ny editor matches 0 if score #nz editor matches 0 run tellraw @s [\
{"text":"        X ","color":"white"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 5"},"hover_event":{"action":"show_text","value":"X -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 5"},"hover_event":{"action":"show_text","value":"X -0.1"}},\
{"score":{"name":"#vxi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vxf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 5"},"hover_event":{"action":"show_text","value":"X +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 5"},"hover_event":{"action":"show_text","value":"X +1 格"}},\
{"text":"        Y ","color":"white"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 5"},"hover_event":{"action":"show_text","value":"Y -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 5"},"hover_event":{"action":"show_text","value":"Y -0.1"}},\
{"score":{"name":"#vyi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vyf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 5"},"hover_event":{"action":"show_text","value":"Y +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 5"},"hover_event":{"action":"show_text","value":"Y +1 格"}},\
{"text":"        Z ","color":"white"},\
{"text":"[--]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 5"},"hover_event":{"action":"show_text","value":"Z -1 格"}},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 5"},"hover_event":{"action":"show_text","value":"Z -0.1"}},\
{"score":{"name":"#vzi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vzf","objective":"editor"},"color":"gold"},\
{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 5"},"hover_event":{"action":"show_text","value":"Z +0.1"}},\
{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 5"},"hover_event":{"action":"show_text","value":"Z +1 格"}}\
]