# 面板 4：时间点设置（301..323）。timing_panel_open / timing_panel_new_open 设 current_panel=4。
# 入口白名单守卫
execute unless score #click_value editor matches 301..323 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 301..323 run return fail

# 时间 ±1（301/302）
execute if score #click_value editor matches 301 run data modify storage rhythm_axe:prop field_name set value "time"
execute if score #click_value editor matches 302 run data modify storage rhythm_axe:prop field_name set value "time"
execute if score #click_value editor matches 301 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 302 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 301..302 run data modify storage rhythm_axe:prop min set value 0
execute if score #click_value editor matches 301..302 run function rhythm_axe:editor/menu/timing/panel/timing_panel_adjust with storage rhythm_axe:prop
execute if score #click_value editor matches 303 run function rhythm_axe:editor/menu/timing/panel/timing_panel_use_now
execute if score #click_value editor matches 304 run function rhythm_axe:editor/menu/dialog/dialog_open_bpm
# bpb/tpb/judgement_scale 加减
execute if score #click_value editor matches 305 run data modify storage rhythm_axe:prop field_name set value "bpb"
execute if score #click_value editor matches 306 run data modify storage rhythm_axe:prop field_name set value "bpb"
execute if score #click_value editor matches 307 run data modify storage rhythm_axe:prop field_name set value "tpb"
execute if score #click_value editor matches 308 run data modify storage rhythm_axe:prop field_name set value "tpb"
execute if score #click_value editor matches 311 run data modify storage rhythm_axe:prop field_name set value "judgement_scale"
execute if score #click_value editor matches 312 run data modify storage rhythm_axe:prop field_name set value "judgement_scale"
execute if score #click_value editor matches 305 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 306 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 307 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 308 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 311 run data modify storage rhythm_axe:prop delta set value -1
execute if score #click_value editor matches 312 run data modify storage rhythm_axe:prop delta set value 1
execute if score #click_value editor matches 305..306 run data modify storage rhythm_axe:prop min set value 1
execute if score #click_value editor matches 307..308 run data modify storage rhythm_axe:prop min set value 1
execute if score #click_value editor matches 311..312 run data modify storage rhythm_axe:prop min set value 1
execute if score #click_value editor matches 305..308 run function rhythm_axe:editor/menu/timing/panel/timing_panel_adjust with storage rhythm_axe:prop
execute if score #click_value editor matches 311..312 run function rhythm_axe:editor/menu/timing/panel/timing_panel_adjust with storage rhythm_axe:prop
# 上一个/下一个
execute if score #click_value editor matches 313 run function rhythm_axe:editor/menu/timing/panel/timing_panel_prev
execute if score #click_value editor matches 314 run function rhythm_axe:editor/menu/timing/panel/timing_panel_next
# 确认/删除/取消/复制/粘贴
execute if score #click_value editor matches 316 run function rhythm_axe:editor/menu/timing/panel/timing_panel_confirm
execute if score #click_value editor matches 317 run function rhythm_axe:editor/menu/timing/panel/timing_panel_delete_arm
execute if score #click_value editor matches 318 run function rhythm_axe:editor/menu/timing/panel/timing_panel_delete
execute if score #click_value editor matches 319 run function rhythm_axe:editor/menu/timing/panel/timing_panel_new_confirm
execute if score #click_value editor matches 320 run function rhythm_axe:editor/menu/timing/panel/timing_panel_cancel
execute if score #click_value editor matches 321 run function rhythm_axe:editor/menu/timing/panel/timing_panel_delete_disarm
execute if score #click_value editor matches 322 run function rhythm_axe:editor/menu/timing/panel/timing_panel_copy
execute if score #click_value editor matches 323 run function rhythm_axe:editor/menu/timing/panel/timing_panel_paste
