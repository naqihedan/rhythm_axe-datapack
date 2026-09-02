#arg:rm_idx
# 处理 selection[$(rm_idx)]：若 id==#rm_id 则跳过，否则 append 到 prop.rm_out
$execute store result score #rm_cur editor run data get storage rhythm_axe:maps.editor selection[$(rm_idx)]
$execute unless score #rm_cur editor = #rm_id editor run data modify storage rhythm_axe:prop rm_out append from storage rhythm_axe:maps.editor selection[$(rm_idx)]
