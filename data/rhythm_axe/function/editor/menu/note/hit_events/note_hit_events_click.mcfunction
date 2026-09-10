# 处理击打事件指令按钮点击（规范v2 点击值 = (1000+idx)×100 + 列码）
# 列码：3=编辑 / 5=复制 / 6=粘贴 / 7=删除
# ★ 2026-08-25 值段 860 起迁移到 10000：原 860..9999 覆盖退出确认(901-903)/切换确认(911-913) → 退出/切换点击误触击打面板
scoreboard players operation #he_rel editor = #click_value editor
scoreboard players operation #he_idx editor = #he_rel editor
scoreboard players operation #he_idx editor /= 100 const
scoreboard players remove #he_idx editor 1000
scoreboard players operation #he_off editor = #he_rel editor
scoreboard players operation #he_off editor %= 100 const
execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #he_idx editor
# 编辑（3）：设 editing.he_cur 供对话框提交（第一步从 editing 复制到 prop）读取索引，打开编辑对话框
execute if score #he_off editor matches 3 run execute store result storage rhythm_axe:maps.editor editing.he_cur int 1 run scoreboard players get #he_idx editor
execute if score #he_off editor matches 3 run function rhythm_axe:editor/menu/note/dialog/dialog_open_note_he_cmd
# 复制（5）
execute if score #he_off editor matches 5 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_copy with storage rhythm_axe:prop
# 粘贴（6）：覆盖该行（paste 是宏函数，需 with storage 传 idx）
execute if score #he_off editor matches 6 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_paste with storage rhythm_axe:prop
# 删除（7）
execute if score #he_off editor matches 7 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_delete with storage rhythm_axe:prop
data remove storage rhythm_axe:prop idx