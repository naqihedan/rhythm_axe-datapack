# 范围条件·下限解析（普通函数，由 core 调用）：
#   读 prop.dlg_in → 三态哨兵写中转 #fn_has_v（2=有数字/1=空/0=非数字）。
#   ★ 无 $ 行 ⇒ 能看到 core 刚写入的 dlg_in（宏坑绕开）。
#   ★★ 三态写法（2026-10-22 修正）：store success 只返回 0/1，直接存会把「有数字」写成 1、
#   与「空」的 1 撞车 ⇒ 数字有效性存独立中转 #fn_ok_v，最后归并：有元素且 ok → 2；有元素且 !ok → 0。
scoreboard players set #fn_has_v editor 1
execute if data storage rhythm_axe:prop dlg_in[0] run scoreboard players set #fn_has_v editor 0
execute if data storage rhythm_axe:prop dlg_in[0] run scoreboard players set #fn_ok_v editor 0
execute if data storage rhythm_axe:prop dlg_in[0] run execute store success score #fn_ok_v editor run data get storage rhythm_axe:prop dlg_in[0] 1
execute if data storage rhythm_axe:prop dlg_in[0] if score #fn_ok_v editor matches 1 run scoreboard players set #fn_has_v editor 2
execute if score #fn_has_v editor matches 0 run scoreboard players set #fn_bad editor 1
