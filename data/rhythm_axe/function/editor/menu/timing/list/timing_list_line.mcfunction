#arg:cursor,index,edit_val,copy_val,paste_val,delete_val
# 时间点列表单行：█（红/绿）+ 时间/bpm(三位小数)/拍数/刻数/判定缩放 + [编辑][复制][粘贴][删除]
$execute store result score #v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].bpm 1000
scoreboard players operation #vi editor = #v editor
scoreboard players operation #vi editor /= 1000 const
scoreboard players operation #vf editor = #v editor
scoreboard players operation #vf editor %= 1000 const
$execute if data storage rhythm_axe:prop is_red if score #vf editor matches 0..9 run tellraw @s [\
{"text":"█","color":"red"},\
{"text":"时间:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" bpm:","color":"gray"},\
{"score":{"name":"#vi","objective":"editor"}},\
{"text":".00"},\
{"score":{"name":"#vf","objective":"editor"}},\
{"text":" 拍数:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].bpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 刻数:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].tpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 判定缩放:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].judgement_scale","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个时间点"}},\
{"text":"[复制]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制时间点信息"}},\
{"text":"[粘贴]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"粘贴时间点信息"}},\
{"text":"[删除]","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个时间点"}}\
]
$execute if data storage rhythm_axe:prop is_red if score #vf editor matches 10..99 run tellraw @s [\
{"text":"█","color":"red"},\
{"text":"时间:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" bpm:","color":"gray"},\
{"score":{"name":"#vi","objective":"editor"}},\
{"text":".0"},\
{"score":{"name":"#vf","objective":"editor"}},\
{"text":" 拍数:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].bpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 刻数:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].tpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 判定缩放:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].judgement_scale","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个时间点"}},\
{"text":"[复制]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制时间点信息"}},\
{"text":"[粘贴]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"粘贴时间点信息"}},\
{"text":"[删除]","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个时间点"}}\
]
$execute if data storage rhythm_axe:prop is_red if score #vf editor matches 100..999 run tellraw @s [\
{"text":"█","color":"red"},\
{"text":"时间:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" bpm:","color":"gray"},\
{"score":{"name":"#vi","objective":"editor"}},\
{"text":"."},\
{"score":{"name":"#vf","objective":"editor"}},\
{"text":" 拍数:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].bpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 刻数:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].tpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 判定缩放:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].judgement_scale","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个时间点"}},\
{"text":"[复制]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制时间点信息"}},\
{"text":"[粘贴]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"粘贴时间点信息"}},\
{"text":"[删除]","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个时间点"}}\
]
$execute unless data storage rhythm_axe:prop is_red if score #vf editor matches 0..9 run tellraw @s [\
{"text":"█","color":"green"},\
{"text":"时间:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" bpm:","color":"gray"},\
{"score":{"name":"#vi","objective":"editor"}},\
{"text":".00"},\
{"score":{"name":"#vf","objective":"editor"}},\
{"text":" 拍数:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].bpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 刻数:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].tpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 判定缩放:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].judgement_scale","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个时间点"}},\
{"text":"[复制]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制时间点信息"}},\
{"text":"[粘贴]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"粘贴时间点信息"}},\
{"text":"[删除]","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个时间点"}}\
]
$execute unless data storage rhythm_axe:prop is_red if score #vf editor matches 10..99 run tellraw @s [\
{"text":"█","color":"green"},\
{"text":"时间:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" bpm:","color":"gray"},\
{"score":{"name":"#vi","objective":"editor"}},\
{"text":".0"},\
{"score":{"name":"#vf","objective":"editor"}},\
{"text":" 拍数:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].bpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 刻数:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].tpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 判定缩放:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].judgement_scale","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个时间点"}},\
{"text":"[复制]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制时间点信息"}},\
{"text":"[粘贴]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"粘贴时间点信息"}},\
{"text":"[删除]","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个时间点"}}\
]
$execute unless data storage rhythm_axe:prop is_red if score #vf editor matches 100..999 run tellraw @s [\
{"text":"█","color":"green"},\
{"text":"时间:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" bpm:","color":"gray"},\
{"score":{"name":"#vi","objective":"editor"}},\
{"text":"."},\
{"score":{"name":"#vf","objective":"editor"}},\
{"text":" 拍数:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].bpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 刻数:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].tpb","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 判定缩放:","color":"gray"},\
{"nbt":"history[$(cursor)].timing_points[$(index)].judgement_scale","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个时间点"}},\
{"text":"[复制]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制时间点信息"}},\
{"text":"[粘贴]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"粘贴时间点信息"}},\
{"text":"[删除]","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个时间点"}}\
]
