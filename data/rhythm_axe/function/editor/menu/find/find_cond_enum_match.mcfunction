# 枚举条件解析（普通函数，由 dialog_submit_find_note_go 调用）：
#   读 prop.fn_val_str → 匹配数字 → 写中转 #fn_enum_v（-1=不限/all）。
#   ★★ 双匹配（2026-10-22）：宏替换会**丢引号**——$data modify set value "$(x)" 展开成
#   set value 3（数字而非字符串 "3"）⇒ 同时匹配字符串和数字两种形态。
#   ★ 2026-11-14 修复：原表只列了 0..6/9/16 ⇒ 颜色 7、8、10..15（橙/黄/绿/青/淡蓝/蓝/紫/品红）
#     解析不出 → 落回 -1（不限）⇒ 选「绿」时黄色混凝土也被命中。现补全 0..16 全枚举值。
scoreboard players set #fn_enum_v editor -1
execute if data storage rhythm_axe:prop {fn_val_str:"0"} run scoreboard players set #fn_enum_v editor 0
execute if data storage rhythm_axe:prop {fn_val_str:"1"} run scoreboard players set #fn_enum_v editor 1
execute if data storage rhythm_axe:prop {fn_val_str:"2"} run scoreboard players set #fn_enum_v editor 2
execute if data storage rhythm_axe:prop {fn_val_str:"3"} run scoreboard players set #fn_enum_v editor 3
execute if data storage rhythm_axe:prop {fn_val_str:"4"} run scoreboard players set #fn_enum_v editor 4
execute if data storage rhythm_axe:prop {fn_val_str:"5"} run scoreboard players set #fn_enum_v editor 5
execute if data storage rhythm_axe:prop {fn_val_str:"6"} run scoreboard players set #fn_enum_v editor 6
execute if data storage rhythm_axe:prop {fn_val_str:"7"} run scoreboard players set #fn_enum_v editor 7
execute if data storage rhythm_axe:prop {fn_val_str:"8"} run scoreboard players set #fn_enum_v editor 8
execute if data storage rhythm_axe:prop {fn_val_str:"9"} run scoreboard players set #fn_enum_v editor 9
execute if data storage rhythm_axe:prop {fn_val_str:"10"} run scoreboard players set #fn_enum_v editor 10
execute if data storage rhythm_axe:prop {fn_val_str:"11"} run scoreboard players set #fn_enum_v editor 11
execute if data storage rhythm_axe:prop {fn_val_str:"12"} run scoreboard players set #fn_enum_v editor 12
execute if data storage rhythm_axe:prop {fn_val_str:"13"} run scoreboard players set #fn_enum_v editor 13
execute if data storage rhythm_axe:prop {fn_val_str:"14"} run scoreboard players set #fn_enum_v editor 14
execute if data storage rhythm_axe:prop {fn_val_str:"15"} run scoreboard players set #fn_enum_v editor 15
execute if data storage rhythm_axe:prop {fn_val_str:"16"} run scoreboard players set #fn_enum_v editor 16
execute if data storage rhythm_axe:prop {fn_val_str:0} run scoreboard players set #fn_enum_v editor 0
execute if data storage rhythm_axe:prop {fn_val_str:1} run scoreboard players set #fn_enum_v editor 1
execute if data storage rhythm_axe:prop {fn_val_str:2} run scoreboard players set #fn_enum_v editor 2
execute if data storage rhythm_axe:prop {fn_val_str:3} run scoreboard players set #fn_enum_v editor 3
execute if data storage rhythm_axe:prop {fn_val_str:4} run scoreboard players set #fn_enum_v editor 4
execute if data storage rhythm_axe:prop {fn_val_str:5} run scoreboard players set #fn_enum_v editor 5
execute if data storage rhythm_axe:prop {fn_val_str:6} run scoreboard players set #fn_enum_v editor 6
execute if data storage rhythm_axe:prop {fn_val_str:7} run scoreboard players set #fn_enum_v editor 7
execute if data storage rhythm_axe:prop {fn_val_str:8} run scoreboard players set #fn_enum_v editor 8
execute if data storage rhythm_axe:prop {fn_val_str:9} run scoreboard players set #fn_enum_v editor 9
execute if data storage rhythm_axe:prop {fn_val_str:10} run scoreboard players set #fn_enum_v editor 10
execute if data storage rhythm_axe:prop {fn_val_str:11} run scoreboard players set #fn_enum_v editor 11
execute if data storage rhythm_axe:prop {fn_val_str:12} run scoreboard players set #fn_enum_v editor 12
execute if data storage rhythm_axe:prop {fn_val_str:13} run scoreboard players set #fn_enum_v editor 13
execute if data storage rhythm_axe:prop {fn_val_str:14} run scoreboard players set #fn_enum_v editor 14
execute if data storage rhythm_axe:prop {fn_val_str:15} run scoreboard players set #fn_enum_v editor 15
execute if data storage rhythm_axe:prop {fn_val_str:16} run scoreboard players set #fn_enum_v editor 16
data remove storage rhythm_axe:prop fn_val_str
