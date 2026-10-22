# 查找音符提交·普通层（两层结构的第 2 层，由 dialog_submit_find_note_core 调用）：
#   读 prop.fc_*（宏层写好的原始值）→ 解析全部条件成 #fn_* 分数 → 校验 → find_note_start。
#   ★ 纯普通函数（无 $ 行）⇒ 读写 storage 一切正常（宏坑只在宏函数实例内）。
#   解析套路（每条件三步）：
#   枚举/布尔：data modify prop fn_val_str set from prop.fc_xxx → find_cond_enum_match/_bool_match
#     （纯普通函数，NBT 匹配 + 写中转 #fn_enum_v/#fn_bool_v）→ operation 搬到 #fn_xxx。
#   范围/位置：data modify prop dlg_in set from prop.fc_xxx（fc_* 已是**列表形态**：
#     core 用 set value [$(xxx)] 写入，"24"→[24] 数字、""→[] 不限、"abc"→[abc] 字符串元素）→
#     find_cond_range_lo/_hi/_pos_match（写中转 #fn_has_v）→ operation 搬哨兵 →
#     if 哨兵=2 → store result 读值（普通命令，此刻 dlg_in 还在）。
# ★ 选区无上限（2026-10-22 纠正）：命中多少选多少；「查找选区内」= 在当前选区内筛选。
# 哨兵约定：#fn_has_<x>_lo/_hi（2=有值/1=空/0=坏）；枚举/布尔 -1=不限；#fn_bad=1 有非数字输入。
# ── 枚举：type / color / easing / power / hitsound / particles ──
data modify storage rhythm_axe:prop fn_val_str set from storage rhythm_axe:prop fc_type
function rhythm_axe:editor/menu/find/find_cond_enum_match
scoreboard players operation #fn_type editor = #fn_enum_v editor
data modify storage rhythm_axe:prop fn_val_str set from storage rhythm_axe:prop fc_color
function rhythm_axe:editor/menu/find/find_cond_enum_match
scoreboard players operation #fn_color editor = #fn_enum_v editor
data modify storage rhythm_axe:prop fn_val_str set from storage rhythm_axe:prop fc_easing
function rhythm_axe:editor/menu/find/find_cond_enum_match
scoreboard players operation #fn_easing editor = #fn_enum_v editor
data modify storage rhythm_axe:prop fn_val_str set from storage rhythm_axe:prop fc_power
function rhythm_axe:editor/menu/find/find_cond_enum_match
scoreboard players operation #fn_power editor = #fn_enum_v editor
data modify storage rhythm_axe:prop fn_val_str set from storage rhythm_axe:prop fc_hs
function rhythm_axe:editor/menu/find/find_cond_enum_match
scoreboard players operation #fn_hs editor = #fn_enum_v editor
data modify storage rhythm_axe:prop fn_val_str set from storage rhythm_axe:prop fc_pt
function rhythm_axe:editor/menu/find/find_cond_enum_match
scoreboard players operation #fn_pt editor = #fn_enum_v editor
# ── 布尔：无视流速 / 引导线 / 查找选区内 ──
data modify storage rhythm_axe:prop fn_val_str set from storage rhythm_axe:prop fc_igsp
function rhythm_axe:editor/menu/find/find_cond_bool_match
scoreboard players operation #fn_igsp editor = #fn_bool_v editor
data modify storage rhythm_axe:prop fn_val_str set from storage rhythm_axe:prop fc_fwp
function rhythm_axe:editor/menu/find/find_cond_bool_match
scoreboard players operation #fn_fwp editor = #fn_bool_v editor
data modify storage rhythm_axe:prop fn_val_str set from storage rhythm_axe:prop fc_insel
function rhythm_axe:editor/menu/find/find_cond_bool_match
scoreboard players operation #fn_insel editor = #fn_bool_v editor
# ── 范围：时间 ──
# ★ fc_* 数值字段已是**列表形态**（core 用 set value [$(xxx)] 写入："24"→[24] 数字、""→[] 不限、
#   "abc"→[abc] 字符串元素 → bad=1 报错）⇒ 直接 set from 拷列表，不再需要空串守卫 + append 两步。
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_tfrom
function rhythm_axe:editor/menu/find/find_cond_range_lo
scoreboard players operation #fn_has_t_lo editor = #fn_has_v editor
execute if score #fn_has_t_lo editor matches 2 run execute store result score #fn_t_lo editor run data get storage rhythm_axe:prop dlg_in[0] 1
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_tto
function rhythm_axe:editor/menu/find/find_cond_range_hi
scoreboard players operation #fn_has_t_hi editor = #fn_has_v editor
execute if score #fn_has_t_hi editor matches 2 run execute store result score #fn_t_hi editor run data get storage rhythm_axe:prop dlg_in[0] 1
# ── 范围：音符 id ──
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_idfrom
function rhythm_axe:editor/menu/find/find_cond_range_lo
scoreboard players operation #fn_has_id_lo editor = #fn_has_v editor
execute if score #fn_has_id_lo editor matches 2 run execute store result score #fn_id_lo editor run data get storage rhythm_axe:prop dlg_in[0] 1
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_idto
function rhythm_axe:editor/menu/find/find_cond_range_hi
scoreboard players operation #fn_has_id_hi editor = #fn_has_v editor
execute if score #fn_has_id_hi editor matches 2 run execute store result score #fn_id_hi editor run data get storage rhythm_axe:prop dlg_in[0] 1
# ── 范围：大小（×10 定点）──
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_szfrom
function rhythm_axe:editor/menu/find/find_cond_range_lo
scoreboard players operation #fn_has_sz_lo editor = #fn_has_v editor
execute if score #fn_has_sz_lo editor matches 2 run execute store result score #fn_sz_lo editor run data get storage rhythm_axe:prop dlg_in[0] 10
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_szto
function rhythm_axe:editor/menu/find/find_cond_range_hi
scoreboard players operation #fn_has_sz_hi editor = #fn_has_v editor
execute if score #fn_has_sz_hi editor matches 2 run execute store result score #fn_sz_hi editor run data get storage rhythm_axe:prop dlg_in[0] 10
# ── 范围：持续时长 ──
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_dfrom
function rhythm_axe:editor/menu/find/find_cond_range_lo
scoreboard players operation #fn_has_d_lo editor = #fn_has_v editor
execute if score #fn_has_d_lo editor matches 2 run execute store result score #fn_d_lo editor run data get storage rhythm_axe:prop dlg_in[0] 1
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_dto
function rhythm_axe:editor/menu/find/find_cond_range_hi
scoreboard players operation #fn_has_d_hi editor = #fn_has_v editor
execute if score #fn_has_d_hi editor matches 2 run execute store result score #fn_d_hi editor run data get storage rhythm_axe:prop dlg_in[0] 1
# ── 范围：判定密度 ──
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_dnfrom
function rhythm_axe:editor/menu/find/find_cond_range_lo
scoreboard players operation #fn_has_dn_lo editor = #fn_has_v editor
execute if score #fn_has_dn_lo editor matches 2 run execute store result score #fn_dn_lo editor run data get storage rhythm_axe:prop dlg_in[0] 1
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_dnto
function rhythm_axe:editor/menu/find/find_cond_range_hi
scoreboard players operation #fn_has_dn_hi editor = #fn_has_v editor
execute if score #fn_has_dn_hi editor matches 2 run execute store result score #fn_dn_hi editor run data get storage rhythm_axe:prop dlg_in[0] 1
# ── 范围：基础寿命 ──
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_lifrom
function rhythm_axe:editor/menu/find/find_cond_range_lo
scoreboard players operation #fn_has_li_lo editor = #fn_has_v editor
execute if score #fn_has_li_lo editor matches 2 run execute store result score #fn_li_lo editor run data get storage rhythm_axe:prop dlg_in[0] 1
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_lito
function rhythm_axe:editor/menu/find/find_cond_range_hi
scoreboard players operation #fn_has_li_hi editor = #fn_has_v editor
execute if score #fn_has_li_hi editor matches 2 run execute store result score #fn_li_hi editor run data get storage rhythm_axe:prop dlg_in[0] 1
# ── 范围：击打事件数 ──
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_hvfrom
function rhythm_axe:editor/menu/find/find_cond_range_lo
scoreboard players operation #fn_has_hv_lo editor = #fn_has_v editor
execute if score #fn_has_hv_lo editor matches 2 run execute store result score #fn_hv_lo editor run data get storage rhythm_axe:prop dlg_in[0] 1
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_hvto
function rhythm_axe:editor/menu/find/find_cond_range_hi
scoreboard players operation #fn_has_hv_hi editor = #fn_has_v editor
execute if score #fn_has_hv_hi editor matches 2 run execute store result score #fn_hv_hi editor run data get storage rhythm_axe:prop dlg_in[0] 1
# ── 位置（×10 定点，各轴独立）：判定位置 X/Y/Z + 起始位置 X/Y/Z ──
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_px
function rhythm_axe:editor/menu/find/find_cond_pos_match
scoreboard players operation #fn_has_px editor = #fn_has_v editor
execute if score #fn_has_px editor matches 2 run execute store result score #fn_px editor run data get storage rhythm_axe:prop dlg_in[0] 10
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_py
function rhythm_axe:editor/menu/find/find_cond_pos_match
scoreboard players operation #fn_has_py editor = #fn_has_v editor
execute if score #fn_has_py editor matches 2 run execute store result score #fn_py editor run data get storage rhythm_axe:prop dlg_in[0] 10
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_pz
function rhythm_axe:editor/menu/find/find_cond_pos_match
scoreboard players operation #fn_has_pz editor = #fn_has_v editor
execute if score #fn_has_pz editor matches 2 run execute store result score #fn_pz editor run data get storage rhythm_axe:prop dlg_in[0] 10
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_sx
function rhythm_axe:editor/menu/find/find_cond_pos_match
scoreboard players operation #fn_has_sx editor = #fn_has_v editor
execute if score #fn_has_sx editor matches 2 run execute store result score #fn_sx editor run data get storage rhythm_axe:prop dlg_in[0] 10
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_sy
function rhythm_axe:editor/menu/find/find_cond_pos_match
scoreboard players operation #fn_has_sy editor = #fn_has_v editor
execute if score #fn_has_sy editor matches 2 run execute store result score #fn_sy editor run data get storage rhythm_axe:prop dlg_in[0] 10
data modify storage rhythm_axe:prop dlg_in set from storage rhythm_axe:prop fc_sz
function rhythm_axe:editor/menu/find/find_cond_pos_match
scoreboard players operation #fn_has_sz2 editor = #fn_has_v editor
execute if score #fn_has_sz2 editor matches 2 run execute store result score #fn_sz2 editor run data get storage rhythm_axe:prop dlg_in[0] 10
# ── 清理 fc_* / dlg_in ──
data remove storage rhythm_axe:prop dlg_in
data remove storage rhythm_axe:prop fc_type
data remove storage rhythm_axe:prop fc_color
data remove storage rhythm_axe:prop fc_tfrom
data remove storage rhythm_axe:prop fc_tto
data remove storage rhythm_axe:prop fc_insel
data remove storage rhythm_axe:prop fc_idfrom
data remove storage rhythm_axe:prop fc_idto
data remove storage rhythm_axe:prop fc_szfrom
data remove storage rhythm_axe:prop fc_szto
data remove storage rhythm_axe:prop fc_dfrom
data remove storage rhythm_axe:prop fc_dto
data remove storage rhythm_axe:prop fc_dnfrom
data remove storage rhythm_axe:prop fc_dnto
data remove storage rhythm_axe:prop fc_lifrom
data remove storage rhythm_axe:prop fc_lito
data remove storage rhythm_axe:prop fc_hvfrom
data remove storage rhythm_axe:prop fc_hvto
data remove storage rhythm_axe:prop fc_easing
data remove storage rhythm_axe:prop fc_power
data remove storage rhythm_axe:prop fc_hs
data remove storage rhythm_axe:prop fc_pt
data remove storage rhythm_axe:prop fc_igsp
data remove storage rhythm_axe:prop fc_fwp
data remove storage rhythm_axe:prop fc_px
data remove storage rhythm_axe:prop fc_py
data remove storage rhythm_axe:prop fc_pz
data remove storage rhythm_axe:prop fc_sx
data remove storage rhythm_axe:prop fc_sy
data remove storage rhythm_axe:prop fc_sz
# ── 校验失败（任一数值条件非数字）→ 提示并终止 ──
execute if score #fn_bad editor matches 1 run tellraw @s [{"text":"[查找] ","color":"gray"},{"text":"有数值条件不是数字（留空 = 不限；大小/坐标支持小数）","color":"red"}]
execute if score #fn_bad editor matches 1 run return fail
# ── 校验通过 → 进分刻扫描链 ──
scoreboard players set #dlg_ok editor 1
function rhythm_axe:editor/menu/find/find_note_start
