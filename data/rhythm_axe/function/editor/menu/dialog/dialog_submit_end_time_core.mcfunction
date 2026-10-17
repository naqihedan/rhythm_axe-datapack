#arg:value
# 对话框提交：结束时间（刻，输入正整数；输入 -1 表示未定义）；写入暂存 panel_temp
# ★ 校验（2026-10-17 重写）：旧写法 `$scoreboard players set #temp editor $(value)` 在**空输入 / 非数字**时
#   会展开成非法命令 ⇒ **整个函数实例化失败 → 点【确认】毫无反应**（连提示都没有）。
#   现改为：裸 token 装进**列表**（`[$(value)]` 永远合法）→ `data get … [0] 1`（**必须带 scale**）验数字。
#   ⚠ 不带 scale 的 data get 会把 SNBT 字符串当成功并返回字符串长度（"abc"→3），不能用来判定。
scoreboard players set #dlg_ok editor 0
data remove storage rhythm_axe:prop dlg_in
$data modify storage rhythm_axe:prop dlg_in set value [$(value)]
scoreboard players set #dlg_ok editor 0
scoreboard players set #dlg_v editor 0
execute store result score #dlg_v editor store success score #dlg_ok editor run data get storage rhythm_axe:prop dlg_in[0] 1
data remove storage rhythm_axe:prop dlg_in
execute if score #dlg_ok editor matches 0 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"输入无效，请填数字（刻；-1 = 未定义）","color":"red"}]
execute if score #dlg_ok editor matches 1 if score #dlg_v editor matches -1 run data remove storage rhythm_axe:maps.editor panel_temp.end_time
execute if score #dlg_ok editor matches 1 unless score #dlg_v editor matches -1 run execute store result storage rhythm_axe:maps.editor panel_temp.end_time int 1 run scoreboard players get #dlg_v editor
execute if score #dlg_ok editor matches 1 unless score #dlg_v editor matches -1 run data modify storage rhythm_axe:maps.editor feedback set value "已设置结束时间（保存设置后生效）"
execute if score #dlg_ok editor matches 1 unless score #dlg_v editor matches -1 run data modify storage rhythm_axe:maps.editor no_undo set value 1b
execute if score #dlg_ok editor matches 1 run function rhythm_axe:editor/menu/map/panel/map_panel_refresh
