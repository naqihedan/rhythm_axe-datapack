#arg: cursor, idx
# 找「选区里第一个（= 最早）的音符」下标 → prop.src（找不到就不写，调用方报错「没有可复制的音符」）
# 它是填充新音符的**属性模板**（类型/寿命/缩放/动画/颜色/音效/视效都用它那份）
$scoreboard players set #fs_len editor $(idx)
execute if score #fs_len editor matches 0 run scoreboard players set #fs_tot editor 0
$execute if score #fs_len editor matches 0 run execute store result score #fs_tot editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected unless data storage rhythm_axe:prop src run execute store result storage rhythm_axe:prop src int 1 run scoreboard players get #fs_len editor
scoreboard players add #fs_len editor 1
execute if score #fs_len editor < #fs_tot editor unless data storage rhythm_axe:prop src run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #fs_len editor
execute if score #fs_len editor < #fs_tot editor unless data storage rhythm_axe:prop src run function rhythm_axe:editor/menu/note/df/df_fill_src with storage rhythm_axe:prop
