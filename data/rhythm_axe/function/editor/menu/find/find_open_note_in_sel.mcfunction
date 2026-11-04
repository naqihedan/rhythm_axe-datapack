# 从「已选定音符列表」（面板 18）打开查找对话框：
#   与面板 7 的【音符】查找不同 —— 这里打开的对话框 `in_selection` **默认勾选**，
#   语义就是「在当前选区里再筛一遍」（保留命中、移出不命中）。
#   ★ 2026-11-04 新增（面板 18 底部【查找】11409）。
# 前置：当前有选中音符（selection 非空）。空选区的入口按钮在 UI 上是灰的（不带 click_event），
#   这里再兜一道：没选中就直接提示，不弹对话框。
# ★ 不写 `editing`（find_open_note 会清 `editing`，那是给对话框暂存用的）。
execute unless data storage rhythm_axe:maps.editor selection[0] run tellraw @s [{"text":"[查找] ","color":"gray"},{"text":"先选中音符再查找","color":"red"}]
execute unless data storage rhythm_axe:maps.editor selection[0] run return fail
dialog show @s rhythm_axe:editor_find_note_in_sel