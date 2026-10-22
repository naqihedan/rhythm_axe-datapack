#arg:cursor,i
# 查找音符·全属性命中判定（宏叶子，不递归）：所有条件全过 → 命中（2026-10-22 全属性版）
# ★ 宏展开成本控制：本叶子只有 3 个 $ 行（① 复制元素到 prop.selnote ② 命中写回 selected ③ 选区内模式移除 selected），
#   其余条件判定全部走**普通命令**读 prop.selnote.<字段>（sel_rebuild_judge 同款手法）——
#   条件值从计分板 #fn_* 读（不进宏参数），参数空间恒为 (cursor,i) ⇒ 宏缓存有界可复用。
# ★ 缺字段语义（与音符文档默认值一致）：color 缺 = 0（未设置）；duration 缺 = 0；density 缺 = 0；
#   hitsound/hit_particles 缺 = 0；anim_easing 缺 = 1；anim_power 缺 = 1；布尔缺 = 0（关）。
#   读法：先 reset 分数再 store（store 失败保留旧值 ⇒ 必须 reset 归零）。
# ★「查找选区内」模式（#fn_insel=1）：只对**已选中**音符判定（selnote.selected 存在）；
#   命中 → 保留（无操作）；不命中 → 移除 selected（selection 由收尾 sel_rebuild 重建）。
#   普通模式：命中 → 打 selected + 实体黄光/标记 + 计数（无上限）；不命中 → 无操作。
# ── ① 复制元素（唯一的数据读取宏行）──
data remove storage rhythm_axe:prop selnote
$data modify storage rhythm_axe:prop selnote set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)]
# ── 选区内模式：未选中的音符直接跳过（不参与判定）──
scoreboard players set #fn_skip editor 0
execute if score #fn_insel editor matches 1 unless data storage rhythm_axe:prop selnote.selected run scoreboard players set #fn_skip editor 1
execute if score #fn_skip editor matches 1 run return 0
# ── 条件判定（#fn_ok 1=全过；任一不过置 0）──
scoreboard players set #fn_ok editor 1
# type（-1=不限；selnote.type 缺 = 0）
scoreboard players reset #fn_v editor
execute if score #fn_type editor matches 0..4 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.type
execute if score #fn_type editor matches 0..4 unless score #fn_v editor = #fn_type editor run scoreboard players set #fn_ok editor 0
# color（-1=不限；缺 = 0）
scoreboard players reset #fn_v editor
execute if score #fn_color editor matches 0..16 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.color
execute if score #fn_color editor matches 0..16 unless score #fn_v editor = #fn_color editor run scoreboard players set #fn_ok editor 0
# time（窗口已二分定位，兜底复核；哨兵 2 = 有值）
scoreboard players reset #fn_v editor
execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.time
execute if score #fn_has_t_lo editor matches 2 if score #fn_v editor < #fn_t_lo editor run scoreboard players set #fn_ok editor 0
execute if score #fn_has_t_hi editor matches 2 if score #fn_v editor > #fn_t_hi editor run scoreboard players set #fn_ok editor 0
# id 范围
execute if score #fn_has_id_lo editor matches 2 if score #fn_v editor < #fn_id_lo editor run scoreboard players set #fn_ok editor 0
execute if score #fn_has_id_hi editor matches 2 if score #fn_v editor > #fn_id_hi editor run scoreboard players set #fn_ok editor 0
# 大小范围（×10 定点：selnote.size 是 Double → data get ... 10）
scoreboard players reset #fn_v editor
execute if score #fn_has_sz_lo editor matches 2 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.size 10
execute if score #fn_has_sz_lo editor matches 2 if score #fn_v editor < #fn_sz_lo editor run scoreboard players set #fn_ok editor 0
execute if score #fn_has_sz_hi editor matches 2 if score #fn_v editor > #fn_sz_hi editor run scoreboard players set #fn_ok editor 0
# 持续时长范围（缺 = 0）
scoreboard players reset #fn_v editor
execute if score #fn_has_d_lo editor matches 2 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.duration
execute if score #fn_has_d_lo editor matches 2 if score #fn_v editor < #fn_d_lo editor run scoreboard players set #fn_ok editor 0
execute if score #fn_has_d_hi editor matches 2 if score #fn_v editor > #fn_d_hi editor run scoreboard players set #fn_ok editor 0
# 判定密度范围（缺 = 0）
scoreboard players reset #fn_v editor
execute if score #fn_has_dn_lo editor matches 2 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.density
execute if score #fn_has_dn_lo editor matches 2 if score #fn_v editor < #fn_dn_lo editor run scoreboard players set #fn_ok editor 0
execute if score #fn_has_dn_hi editor matches 2 if score #fn_v editor > #fn_dn_hi editor run scoreboard players set #fn_ok editor 0
# 基础寿命范围（缺 = 0）
scoreboard players reset #fn_v editor
execute if score #fn_has_li_lo editor matches 2 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.note_base_life
execute if score #fn_has_li_lo editor matches 2 if score #fn_v editor < #fn_li_lo editor run scoreboard players set #fn_ok editor 0
execute if score #fn_has_li_hi editor matches 2 if score #fn_v editor > #fn_li_hi editor run scoreboard players set #fn_ok editor 0
# 击打事件数范围（缺 = 空列表 = 0；data get 列表返回长度）
scoreboard players reset #fn_v editor
execute if score #fn_has_hv_lo editor matches 2 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.hit_events
execute if score #fn_has_hv_lo editor matches 2 if score #fn_v editor < #fn_hv_lo editor run scoreboard players set #fn_ok editor 0
execute if score #fn_has_hv_hi editor matches 2 if score #fn_v editor > #fn_hv_hi editor run scoreboard players set #fn_ok editor 0
# 缓动类型（-1=不限；缺 = 1）
scoreboard players reset #fn_v editor
execute if score #fn_easing editor matches 1..3 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.anim_easing
execute if score #fn_easing editor matches 1..3 if score #fn_v editor matches ..0 run scoreboard players set #fn_v editor 1
execute if score #fn_easing editor matches 1..3 unless score #fn_v editor = #fn_easing editor run scoreboard players set #fn_ok editor 0
# 缓动幂次（-1=不限；缺 = 1）
scoreboard players reset #fn_v editor
execute if score #fn_power editor matches 1..5 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.anim_power
execute if score #fn_power editor matches 1..5 if score #fn_v editor matches ..0 run scoreboard players set #fn_v editor 1
execute if score #fn_power editor matches 1..5 unless score #fn_v editor = #fn_power editor run scoreboard players set #fn_ok editor 0
# 击打音效组（-1=不限；缺 = 0）
scoreboard players reset #fn_v editor
execute if score #fn_hs editor matches 0..6 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.hitsound
execute if score #fn_hs editor matches 0..6 unless score #fn_v editor = #fn_hs editor run scoreboard players set #fn_ok editor 0
# 击打粒子组（-1=不限；缺 = 0）
scoreboard players reset #fn_v editor
execute if score #fn_pt editor matches 0..6 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.hit_particles
execute if score #fn_pt editor matches 0..6 unless score #fn_v editor = #fn_pt editor run scoreboard players set #fn_ok editor 0
# 无视流速（-1=不限；0=关/1=开；缺 = 0）
scoreboard players reset #fn_v editor
execute if score #fn_igsp editor matches 0..1 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.ignore_note_speed
execute if score #fn_igsp editor matches 0..1 unless score #fn_v editor = #fn_igsp editor run scoreboard players set #fn_ok editor 0
# 引导线（-1=不限；0=关/1=开；缺 = 0。⚠ 音符文档默认 true，但 storage 里未勾 = 字段缺失，按 0 处理）
scoreboard players reset #fn_v editor
execute if score #fn_fwp editor matches 0..1 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.following_point
execute if score #fn_fwp editor matches 0..1 unless score #fn_v editor = #fn_fwp editor run scoreboard players set #fn_ok editor 0
# 判定位置 X/Y/Z（×10 定点；哨兵 #fn_has_px 等 2=有值）
scoreboard players reset #fn_v editor
execute if score #fn_has_px editor matches 2 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.position[0] 10
execute if score #fn_has_px editor matches 2 unless score #fn_v editor = #fn_px editor run scoreboard players set #fn_ok editor 0
scoreboard players reset #fn_v editor
execute if score #fn_has_py editor matches 2 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.position[1] 10
execute if score #fn_has_py editor matches 2 unless score #fn_v editor = #fn_py editor run scoreboard players set #fn_ok editor 0
scoreboard players reset #fn_v editor
execute if score #fn_has_pz editor matches 2 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.position[2] 10
execute if score #fn_has_pz editor matches 2 unless score #fn_v editor = #fn_pz editor run scoreboard players set #fn_ok editor 0
# 起始位置 X/Y/Z（×10 定点）
scoreboard players reset #fn_v editor
execute if score #fn_has_sx editor matches 2 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.start_pos[0] 10
execute if score #fn_has_sx editor matches 2 unless score #fn_v editor = #fn_sx editor run scoreboard players set #fn_ok editor 0
scoreboard players reset #fn_v editor
execute if score #fn_has_sy editor matches 2 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.start_pos[1] 10
execute if score #fn_has_sy editor matches 2 unless score #fn_v editor = #fn_sy editor run scoreboard players set #fn_ok editor 0
scoreboard players reset #fn_v editor
execute if score #fn_has_sz2 editor matches 2 run execute store result score #fn_v editor run data get storage rhythm_axe:prop selnote.start_pos[2] 10
execute if score #fn_has_sz2 editor matches 2 unless score #fn_v editor = #fn_sz2 editor run scoreboard players set #fn_ok editor 0
# ── ②/③ 写回（两个模式分支）──
# 普通模式（#fn_insel=0）：命中 → 打 selected + 计数 + 实体黄光/标记（无上限）
execute if score #fn_insel editor matches 0 if score #fn_ok editor matches 1 run scoreboard players add #fn_hit editor 1
execute if score #fn_insel editor matches 0 if score #fn_ok editor matches 1 run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #fn_i editor
$execute if score #fn_insel editor matches 0 if score #fn_ok editor matches 1 run execute store result storage rhythm_axe:prop nid int 1 run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].id
execute if score #fn_insel editor matches 0 if score #fn_ok editor matches 1 run function rhythm_axe:editor/menu/note/selected/sel_select_one with storage rhythm_axe:prop
execute if score #fn_insel editor matches 0 if score #fn_ok editor matches 1 run scoreboard players add #sel_count editor 1
execute if score #fn_insel editor matches 0 if score #fn_ok editor matches 1 run function rhythm_axe:editor/tool/select/select_mark_glow with storage rhythm_axe:prop
execute if score #fn_insel editor matches 0 if score #fn_ok editor matches 1 run function rhythm_axe:editor/tool/select/time_select_tag with storage rhythm_axe:prop
# 选区内模式（#fn_insel=1）：命中 → 计数保留；不命中 → 移除 selected（selection 收尾重建）
execute if score #fn_insel editor matches 1 if score #fn_ok editor matches 1 run scoreboard players add #fn_hit editor 1
$execute if score #fn_insel editor matches 1 if score #fn_ok editor matches 0 run data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].selected
