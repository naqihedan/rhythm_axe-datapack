# 布尔条件解析（普通函数，由 dialog_submit_find_note_go 调用）：
#   读 prop.fn_val_str → 写中转 #fn_bool_v（1=开 / 0=关 / -1=不限）。
#   ★★ 双匹配（字符串 + 数字形态；宏替换丢引号，见 find_cond_enum_match）。
scoreboard players set #fn_bool_v editor -1
execute if data storage rhythm_axe:prop {fn_val_str:"0"} run scoreboard players set #fn_bool_v editor 0
execute if data storage rhythm_axe:prop {fn_val_str:"1"} run scoreboard players set #fn_bool_v editor 1
execute if data storage rhythm_axe:prop {fn_val_str:0} run scoreboard players set #fn_bool_v editor 0
execute if data storage rhythm_axe:prop {fn_val_str:1} run scoreboard players set #fn_bool_v editor 1
data remove storage rhythm_axe:prop fn_val_str
