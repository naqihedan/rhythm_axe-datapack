#arg:i
# 读 selection[$(i)].idx 到 #cur_idx（供 sel_add_drive 比较）
$execute if data storage rhythm_axe:maps.editor selection[$(i)].idx run execute store result score #cur_idx editor run data get storage rhythm_axe:maps.editor selection[$(i)].idx
