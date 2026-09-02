#arg: cursor, idx
# 重排 id 的"叶子"（宏）：给当前音符分配 id = 数组下标（唯一），并统计总音符数
# 仅对含有 id 字段的有效音符设置（避免给半坏元素凭空造 id）
scoreboard players set #fix_total editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes run execute store result score #fix_total editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].id run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].id set value $(idx)
