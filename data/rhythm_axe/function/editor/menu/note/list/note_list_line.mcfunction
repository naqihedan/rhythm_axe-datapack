#arg:cursor,index,edit_val,copy_val,paste_val,delete_val
# 音符列表单行：时间/类型名/基础寿命/id + 【编辑】【复制】【粘贴】【删除】（按类型 5 版）
$execute store result score #note_type editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type
$execute if score #note_type editor matches 0 if data storage rhythm_axe:maps.editor note_clip run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 音符盒","color":"yellow"},\
{"text":" 基础寿命：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].note_base_life","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" id：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].id","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 【编辑】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个音符"}},\
{"text":"【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制音符"}},\
{"text":"【粘贴】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"粘贴到该时间"}},\
{"text":"【删除】","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个音符"}}\
]
$execute if score #note_type editor matches 0 unless data storage rhythm_axe:maps.editor note_clip run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 音符盒","color":"yellow"},\
{"text":" 基础寿命：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].note_base_life","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" id：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].id","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 【编辑】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个音符"}},\
{"text":"【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制音符"}},\
{"text":"【粘贴】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"剪贴板为空，先复制一个音符"}},\
{"text":"【删除】","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个音符"}}\
]
$execute if score #note_type editor matches 1 if data storage rhythm_axe:maps.editor note_clip run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 木板","color":"yellow"},\
{"text":" 基础寿命：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].note_base_life","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" id：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].id","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 【编辑】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个音符"}},\
{"text":"【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制音符"}},\
{"text":"【粘贴】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"粘贴到该时间"}},\
{"text":"【删除】","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个音符"}}\
]
$execute if score #note_type editor matches 1 unless data storage rhythm_axe:maps.editor note_clip run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 木板","color":"yellow"},\
{"text":" 基础寿命：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].note_base_life","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" id：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].id","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 【编辑】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个音符"}},\
{"text":"【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制音符"}},\
{"text":"【粘贴】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"剪贴板为空，先复制一个音符"}},\
{"text":"【删除】","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个音符"}}\
]
$execute if score #note_type editor matches 2 if data storage rhythm_axe:maps.editor note_clip run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 唱片机","color":"yellow"},\
{"text":" 基础寿命：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].note_base_life","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" id：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].id","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 【编辑】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个音符"}},\
{"text":"【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制音符"}},\
{"text":"【粘贴】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"粘贴到该时间"}},\
{"text":"【删除】","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个音符"}}\
]
$execute if score #note_type editor matches 2 unless data storage rhythm_axe:maps.editor note_clip run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 唱片机","color":"yellow"},\
{"text":" 基础寿命：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].note_base_life","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" id：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].id","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 【编辑】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个音符"}},\
{"text":"【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制音符"}},\
{"text":"【粘贴】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"剪贴板为空，先复制一个音符"}},\
{"text":"【删除】","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个音符"}}\
]
$execute if score #note_type editor matches 3 if data storage rhythm_axe:maps.editor note_clip run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 混凝土","color":"yellow"},\
{"text":" 基础寿命：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].note_base_life","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" id：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].id","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 【编辑】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个音符"}},\
{"text":"【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制音符"}},\
{"text":"【粘贴】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"粘贴到该时间"}},\
{"text":"【删除】","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个音符"}}\
]
$execute if score #note_type editor matches 3 unless data storage rhythm_axe:maps.editor note_clip run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 混凝土","color":"yellow"},\
{"text":" 基础寿命：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].note_base_life","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" id：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].id","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 【编辑】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个音符"}},\
{"text":"【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制音符"}},\
{"text":"【粘贴】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"剪贴板为空，先复制一个音符"}},\
{"text":"【删除】","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个音符"}}\
]
$execute if score #note_type editor matches 4 if data storage rhythm_axe:maps.editor note_clip run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 染色玻璃","color":"yellow"},\
{"text":" 基础寿命：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].note_base_life","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" id：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].id","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 【编辑】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个音符"}},\
{"text":"【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制音符"}},\
{"text":"【粘贴】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"粘贴到该时间"}},\
{"text":"【删除】","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个音符"}}\
]
$execute if score #note_type editor matches 4 unless data storage rhythm_axe:maps.editor note_clip run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 染色玻璃","color":"yellow"},\
{"text":" 基础寿命：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].note_base_life","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" id：","color":"gray"},\
{"nbt":"history[$(cursor)].notes[$(index)].id","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 【编辑】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个音符"}},\
{"text":"【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制音符"}},\
{"text":"【粘贴】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"剪贴板为空，先复制一个音符"}},\
{"text":"【删除】","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个音符"}}\
]
