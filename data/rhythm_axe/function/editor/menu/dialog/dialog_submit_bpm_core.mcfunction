#arg:value
# 对话框提交：BPM（小数）写入暂存 editing.temp（确认后才进历史）
# ★ 校验（2026-10-17）：空 / 非数字会让 `set value $(value)` 整条失败 ⇒ 整个函数不执行（点确认毫无反应）
#   改为：裸 token 装进**列表**（`[$(value)]` 永远合法，空输入 → `[]`）→ `data get … [0] 1`（带 scale）验数字；
#   验过之后用 `set from … dlg_in[0]` 拷贝，**保留数值类型（double）**，再转 float 存回。
scoreboard players set #dlg_ok editor 0
data remove storage rhythm_axe:prop dlg_in
$data modify storage rhythm_axe:prop dlg_in set value [$(value)]
scoreboard players set #dlg_ok editor 0
execute store success score #dlg_ok editor run data get storage rhythm_axe:prop dlg_in[0] 1
execute if score #dlg_ok editor matches 0 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"输入无效，请填数字（如 175.000）","color":"red"}]
execute if score #dlg_ok editor matches 1 run data modify storage rhythm_axe:maps.editor editing.temp.bpm set from storage rhythm_axe:prop dlg_in[0]
execute if score #dlg_ok editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.temp.bpm float 1 run data get storage rhythm_axe:maps.editor editing.temp.bpm
data remove storage rhythm_axe:prop dlg_in
execute if score #dlg_ok editor matches 1 run data modify storage rhythm_axe:maps.editor feedback set value "BPM 已修改（确认后生效）"
execute if score #dlg_ok editor matches 1 run data modify storage rhythm_axe:maps.editor no_undo set value 1b
execute if score #dlg_ok editor matches 1 run function rhythm_axe:editor/menu/timing/panel/timing_panel
