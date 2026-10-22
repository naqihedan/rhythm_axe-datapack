# 枚举条件解析（普通函数，由 dialog_submit_find_note_go 调用）：
#   读 prop.fn_val_str → 匹配数字 → 写中转 #fn_enum_v（-1=不限/all）。
#   ★★ 双匹配（2026-10-22）：宏替换会**丢引号**——$data modify set value "$(x)" 展开成
#   set value 3（数字而非字符串 "3"）⇒ 同时匹配字符串和数字两种形态。
scoreboard players set #fn_enum_v editor -1
execute if data storage rhythm_axe:prop {fn_val_str:"0"} run scoreboard players set #fn_enum_v editor 0
execute if data storage rhythm_axe:prop {fn_val_str:"1"} run scoreboard players set #fn_enum_v editor 1
execute if data storage rhythm_axe:prop {fn_val_str:"2"} run scoreboard players set #fn_enum_v editor 2
execute if data storage rhythm_axe:prop {fn_val_str:"3"} run scoreboard players set #fn_enum_v editor 3
execute if data storage rhythm_axe:prop {fn_val_str:"4"} run scoreboard players set #fn_enum_v editor 4
execute if data storage rhythm_axe:prop {fn_val_str:"5"} run scoreboard players set #fn_enum_v editor 5
execute if data storage rhythm_axe:prop {fn_val_str:"6"} run scoreboard players set #fn_enum_v editor 6
execute if data storage rhythm_axe:prop {fn_val_str:"9"} run scoreboard players set #fn_enum_v editor 9
execute if data storage rhythm_axe:prop {fn_val_str:"16"} run scoreboard players set #fn_enum_v editor 16
execute if data storage rhythm_axe:prop {fn_val_str:0} run scoreboard players set #fn_enum_v editor 0
execute if data storage rhythm_axe:prop {fn_val_str:1} run scoreboard players set #fn_enum_v editor 1
execute if data storage rhythm_axe:prop {fn_val_str:2} run scoreboard players set #fn_enum_v editor 2
execute if data storage rhythm_axe:prop {fn_val_str:3} run scoreboard players set #fn_enum_v editor 3
execute if data storage rhythm_axe:prop {fn_val_str:4} run scoreboard players set #fn_enum_v editor 4
execute if data storage rhythm_axe:prop {fn_val_str:5} run scoreboard players set #fn_enum_v editor 5
execute if data storage rhythm_axe:prop {fn_val_str:6} run scoreboard players set #fn_enum_v editor 6
execute if data storage rhythm_axe:prop {fn_val_str:9} run scoreboard players set #fn_enum_v editor 9
execute if data storage rhythm_axe:prop {fn_val_str:16} run scoreboard players set #fn_enum_v editor 16
data remove storage rhythm_axe:prop fn_val_str
