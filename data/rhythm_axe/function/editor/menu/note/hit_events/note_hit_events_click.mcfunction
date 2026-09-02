# 处理击打特效指令按钮点击（点击值 = 10000 + idx*10 + 偏移）
# 偏移：0=编辑 / 1=复制 / 2=粘贴 / 3=删除
# ★ 2026-08-25 值段 860 起迁移到 10000：原 860..9999 覆盖退出确认(901-903)/切换确认(911-913) → 退出/切换点击误触击打面板
scoreboard players operation #he_rel editor = #click_value editor
scoreboard players operation #he_rel editor -= 10000 const
scoreboard players operation #he_idx editor = #he_rel editor
scoreboard players operation #he_idx editor /= 10 const
scoreboard players operation #he_off editor = #he_rel editor
scoreboard players operation #he_off editor %= 10 const
execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #he_idx editor
# 编辑（0）：设 editing.he_cur 供对话框提交（第一步从 editing 复制到 prop）读取索引，打开编辑对话框
execute if score #he_off editor matches 0 run execute store result storage rhythm_axe:maps.editor editing.he_cur int 1 run scoreboard players get #he_idx editor
execute if score #he_off editor matches 0 run function rhythm_axe:editor/menu/note/dialog/dialog_open_note_he_cmd
# 复制（1）
execute if score #he_off editor matches 1 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_copy with storage rhythm_axe:prop
# 粘贴（2）：覆盖该行（paste 是宏函数，需 with storage 传 idx）
execute if score #he_off editor matches 2 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_paste with storage rhythm_axe:prop
# 删除（3）
execute if score #he_off editor matches 3 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_delete with storage rhythm_axe:prop
data remove storage rhythm_axe:prop idx