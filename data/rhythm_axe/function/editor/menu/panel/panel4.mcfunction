# 面板 4：时间点设置。规范v2：值 = 行号×100 + 行内按钮号（行号 100 起）。
# 行100 时间:10001 减/10002 加/10003 使用当前; 行101 BPM:10101 编辑数值(dialog)
# 行102 拍号 bpb:10201 减/10202 加; 行103 每拍刻数 tpb:10301/10302; 行104 判定缩放:10401/10402
# 行105 导航:10501 上一个/10502 下一个; 行106 底部:10601确认 10602确认删除 10603确认新增 10604删除 10605返回(解除) 10606复制 10607粘贴 10608取消
# timing_panel_open / timing_panel_new_open 设 current_panel=4。
# 入口白名单守卫（值域 10000..10699 覆盖本面板全部按钮）
execute unless score #click_value editor matches 10000..10699 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 10000..10699 run return fail

# —— 时间（行1：101 减 / 102 加 / 103 使用当前）——
execute if score #click_value editor matches 10001 run data modify storage rhythm_axe:prop field_name set value "time"
execute if score #click_value editor matches 10002 run data modify storage rhythm_axe:prop field_name set value "time"
execute if score #click_value editor matches 10001 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 10002 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 10001..10002 run data modify storage rhythm_axe:prop min set value 0
execute if score #click_value editor matches 10001..10002 run function rhythm_axe:editor/menu/timing/panel/timing_panel_adjust with storage rhythm_axe:prop
execute if score #click_value editor matches 10003 run function rhythm_axe:editor/menu/timing/panel/timing_panel_use_now
# —— BPM（行2：201 打开对话框）——
execute if score #click_value editor matches 10101 run function rhythm_axe:editor/menu/dialog/dialog_open_bpm
# —— 拍号 bpb（行3：301 减 / 302 加）——
execute if score #click_value editor matches 10201 run data modify storage rhythm_axe:prop field_name set value "bpb"
execute if score #click_value editor matches 10202 run data modify storage rhythm_axe:prop field_name set value "bpb"
execute if score #click_value editor matches 10201 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 10202 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 10201..10202 run data modify storage rhythm_axe:prop min set value 1
execute if score #click_value editor matches 10201..10202 run function rhythm_axe:editor/menu/timing/panel/timing_panel_adjust with storage rhythm_axe:prop
# —— 每拍刻数 tpb（行4：401 减 / 402 加）——
execute if score #click_value editor matches 10301 run data modify storage rhythm_axe:prop field_name set value "tpb"
execute if score #click_value editor matches 10302 run data modify storage rhythm_axe:prop field_name set value "tpb"
execute if score #click_value editor matches 10301 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 10302 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 10301..10302 run data modify storage rhythm_axe:prop min set value 1
execute if score #click_value editor matches 10301..10302 run function rhythm_axe:editor/menu/timing/panel/timing_panel_adjust with storage rhythm_axe:prop
# —— 判定缩放（行5：501 减 / 502 加）——
execute if score #click_value editor matches 10401 run data modify storage rhythm_axe:prop field_name set value "judgement_scale"
execute if score #click_value editor matches 10402 run data modify storage rhythm_axe:prop field_name set value "judgement_scale"
execute if score #click_value editor matches 10401 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 10402 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 10401..10402 run data modify storage rhythm_axe:prop min set value 1
execute if score #click_value editor matches 10401..10402 run function rhythm_axe:editor/menu/timing/panel/timing_panel_adjust with storage rhythm_axe:prop
# —— 导航（行6：601 上一个 / 602 下一个）——
execute if score #click_value editor matches 10501 run function rhythm_axe:editor/menu/timing/panel/timing_panel_prev
execute if score #click_value editor matches 10502 run function rhythm_axe:editor/menu/timing/panel/timing_panel_next
# —— 底部动作（行7）——
execute if score #click_value editor matches 10601 run function rhythm_axe:editor/menu/timing/panel/timing_panel_confirm
execute if score #click_value editor matches 10602 run function rhythm_axe:editor/menu/timing/panel/timing_panel_delete
execute if score #click_value editor matches 10603 run function rhythm_axe:editor/menu/timing/panel/timing_panel_new_confirm
execute if score #click_value editor matches 10604 run function rhythm_axe:editor/menu/timing/panel/timing_panel_delete_arm
execute if score #click_value editor matches 10605 run function rhythm_axe:editor/menu/timing/panel/timing_panel_delete_disarm
execute if score #click_value editor matches 10606 run function rhythm_axe:editor/menu/timing/panel/timing_panel_copy
execute if score #click_value editor matches 10607 run function rhythm_axe:editor/menu/timing/panel/timing_panel_paste
execute if score #click_value editor matches 10608 run function rhythm_axe:editor/menu/timing/panel/timing_panel_cancel
