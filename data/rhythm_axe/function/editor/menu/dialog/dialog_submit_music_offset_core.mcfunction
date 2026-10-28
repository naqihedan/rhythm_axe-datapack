#arg:value
# 对话框提交：谱面音乐偏移（毫秒，≥0，正 = 音乐延后）；写入暂存 panel_temp.music_offset
# ★ 校验同 dialog_submit_end_time_core：裸 token 装进**列表**（[$(value)] 永远合法）→ data get … [0] 1 验数字
#   ⚠ 不带 scale 的 data get 会把 SNBT 字符串当成功并返回字符串长度（"abc"→3），不能用它判定。
scoreboard players set #dlg_ok editor 0
data remove storage rhythm_axe:prop dlg_in
$data modify storage rhythm_axe:prop dlg_in set value [$(value)]
scoreboard players set #dlg_ok editor 0
scoreboard players set #dlg_v editor 0
execute store result score #dlg_v editor store success score #dlg_ok editor run data get storage rhythm_axe:prop dlg_in[0] 1
data remove storage rhythm_axe:prop dlg_in
# 负数无意义（只有延后没有提前）→ 钳到 0 并提示
execute if score #dlg_ok editor matches 1 if score #dlg_v editor matches ..-1 run scoreboard players set #dlg_v editor 0
execute if score #dlg_ok editor matches 1 if score #dlg_v editor matches ..-1 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"谱面音乐偏移只有延后没有提前，已改为 0 ms","color":"yellow"}]
execute if score #dlg_ok editor matches 0 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"输入无效，请填非负整数（毫秒）","color":"red"}]
execute if score #dlg_ok editor matches 1 run execute store result storage rhythm_axe:maps.editor panel_temp.music_offset int 1 run scoreboard players get #dlg_v editor
execute if score #dlg_ok editor matches 1 run data modify storage rhythm_axe:maps.editor feedback set value "已设置谱面音乐偏移（保存设置后写回谱面）"
execute if score #dlg_ok editor matches 1 run data modify storage rhythm_axe:maps.editor no_undo set value 1b
execute if score #dlg_ok editor matches 1 run function rhythm_axe:editor/menu/map/panel/map_panel_refresh