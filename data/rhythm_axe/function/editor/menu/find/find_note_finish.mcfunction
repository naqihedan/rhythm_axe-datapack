# 查找音符·收尾（由 find_note_scan_drive 在扫完后调用）：
#   sel_rebuild 重建 selection（按 notes 顺序）→ 反馈 → 弹已选定列表（下一刻渲染，防同刻超链）→ 清全部状态。
# ★ 选区内模式的反馈口径：命中 = 保留数；移除数 = 原选中 - 命中（#fn_kept 记原选中数）。
# ★ 列表渲染 schedule 到下一刻（sel_note_list_open 含整页渲染，与扫描尾巴同刻有截断风险）。
function rhythm_axe:editor/menu/note/selected/sel_rebuild
execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
# 反馈（普通模式：命中 N 已选中 N；选区内模式：保留 N / 移除 M）
execute if score #fn_insel editor matches 0 run tellraw @s [{"text":"[查找] ","color":"gray"},{"text":"命中 ","color":"yellow"},{"score":{"name":"#fn_hit","objective":"editor"},"color":"aqua"},{"text":" 个音符，已全部选中","color":"yellow"}]
execute if score #fn_insel editor matches 1 run scoreboard players operation #fn_rm editor = #fn_kept editor
execute if score #fn_insel editor matches 1 run scoreboard players operation #fn_rm editor -= #fn_hit editor
execute if score #fn_insel editor matches 1 run tellraw @s [{"text":"[查找] ","color":"gray"},{"text":"选区内筛选：保留 ","color":"yellow"},{"score":{"name":"#fn_hit","objective":"editor"},"color":"aqua"},{"text":" 个，移除 ","color":"yellow"},{"score":{"name":"#fn_rm","objective":"editor"},"color":"aqua"},{"text":" 个","color":"yellow"}]
execute if score #sel_count editor matches 0 run tellraw @s [{"text":"[查找] ","color":"gray"},{"text":"没有匹配的音符","color":"red"}]
# 弹已选定列表（下一刻渲染；空选中不弹）
execute if score #sel_count editor matches 1.. run schedule function rhythm_axe:editor/menu/note/selected/sel_note_list_open_next 1t
# ── 清状态（find_scan.active + 全部 #fn_* 分数 + prop 临时）──
data remove storage rhythm_axe:maps.editor find_scan
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop i
data remove storage rhythm_axe:prop idx
data remove storage rhythm_axe:prop nid
data remove storage rhythm_axe:prop selnote
scoreboard players reset #fn_i editor
scoreboard players reset #fn_len editor
scoreboard players reset #fn_lo editor
scoreboard players reset #fn_hi editor
scoreboard players reset #fn_hit editor
scoreboard players reset #fn_chunk editor
scoreboard players reset #fn_kept editor
scoreboard players reset #fn_rm editor
scoreboard players reset #fn_type editor
scoreboard players reset #fn_color editor
scoreboard players reset #fn_easing editor
scoreboard players reset #fn_power editor
scoreboard players reset #fn_hs editor
scoreboard players reset #fn_pt editor
scoreboard players reset #fn_igsp editor
scoreboard players reset #fn_fwp editor
scoreboard players reset #fn_insel editor
scoreboard players reset #fn_v editor
scoreboard players reset #fn_skip editor
scoreboard players reset #fn_ok editor
scoreboard players reset #fn_bad editor
scoreboard players reset #fn_has_t_lo editor
scoreboard players reset #fn_has_t_hi editor
scoreboard players reset #fn_t_lo editor
scoreboard players reset #fn_t_hi editor
scoreboard players reset #fn_has_id_lo editor
scoreboard players reset #fn_has_id_hi editor
scoreboard players reset #fn_id_lo editor
scoreboard players reset #fn_id_hi editor
scoreboard players reset #fn_has_sz_lo editor
scoreboard players reset #fn_has_sz_hi editor
scoreboard players reset #fn_sz_lo editor
scoreboard players reset #fn_sz_hi editor
scoreboard players reset #fn_has_d_lo editor
scoreboard players reset #fn_has_d_hi editor
scoreboard players reset #fn_d_lo editor
scoreboard players reset #fn_d_hi editor
scoreboard players reset #fn_has_dn_lo editor
scoreboard players reset #fn_has_dn_hi editor
scoreboard players reset #fn_dn_lo editor
scoreboard players reset #fn_dn_hi editor
scoreboard players reset #fn_has_li_lo editor
scoreboard players reset #fn_has_li_hi editor
scoreboard players reset #fn_li_lo editor
scoreboard players reset #fn_li_hi editor
scoreboard players reset #fn_has_hv_lo editor
scoreboard players reset #fn_has_hv_hi editor
scoreboard players reset #fn_hv_lo editor
scoreboard players reset #fn_hv_hi editor
scoreboard players reset #fn_has_px editor
scoreboard players reset #fn_px editor
scoreboard players reset #fn_has_py editor
scoreboard players reset #fn_py editor
scoreboard players reset #fn_has_pz editor
scoreboard players reset #fn_pz editor
scoreboard players reset #fn_has_sx editor
scoreboard players reset #fn_sx editor
scoreboard players reset #fn_has_sy editor
scoreboard players reset #fn_sy editor
scoreboard players reset #fn_has_sz2 editor
scoreboard players reset #fn_sz2 editor
