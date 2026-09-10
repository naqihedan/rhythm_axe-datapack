# 面板 11：音符设置（单音符 / 批量编辑）。note_panel / batch_panel 设 current_panel=11。
# 入口：面板10/18 的编辑行、批量，或 12806/12906/13006 进入全局/击打子面板后返回。
# 含：note_panel_adjust 各字段加减、相对/绝对开关与重置、批量确认、单音符确认删除、【x】各字段重置、
#     判定/起始位置单轴加减、时间轴翻转(909 仅 return，动作在面板10/18)、进全局音效/视效/击打子面板。
# 号段（spec-v2：值 = 行号*100 + 列码）见 scripts/migrate_panel11_v2.py 头部表。
# 入口白名单守卫（12001..14019 为本面板全部号段；909 = 与面板 10/18 共享的时间轴翻转）
execute unless score #click_value editor matches 12001..14019 unless score #click_value editor matches 909 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 12001..14019 unless score #click_value editor matches 909 run return fail

# —— 各字段 ± 调整（note_panel_adjust 依 field 判别）——
execute if score #click_value editor matches 12001..12002 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 12101 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 12201..12202 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 12301..12302 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 12401..12402 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 12501..12502 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 12601..12602 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 12701..12704 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 12003..12004 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 12203..12204 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 12801..12802 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 12901..12902 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
# 相对/绝对开关（787 时间 / 788 大小 / 789 位置 / 790 起始位置）
execute if score #click_value editor matches 13301 run scoreboard players set #rel_field editor 1
execute if score #click_value editor matches 13302 run scoreboard players set #rel_field editor 2
execute if score #click_value editor matches 13303 run scoreboard players set #rel_field editor 3
execute if score #click_value editor matches 13304 run scoreboard players set #rel_field editor 4
execute if score #click_value editor matches 13301..13304 run function rhythm_axe:editor/menu/note/panel/note_panel_rel_toggle
# 相对字段【x】重置：增量归 0（仅相对模式行显示）；单/批量都刷新面板并拦截
execute store result score #rel_on editor run data get storage rhythm_axe:maps.editor editing.rel.on.time
execute store result score #rel_pos editor run data get storage rhythm_axe:maps.editor editing.rel.on.position
execute store result score #rel_sp editor run data get storage rhythm_axe:maps.editor editing.rel.on.start_pos
execute if score #click_value editor matches 14016 run data modify storage rhythm_axe:maps.editor editing.rel.delta.time set value 0
execute if score #click_value editor matches 14017 run data modify storage rhythm_axe:maps.editor editing.rel.delta.size set value 0
execute if score #click_value editor matches 14018 run data modify storage rhythm_axe:maps.editor editing.rel.delta.position set value [0,0,0]
execute if score #click_value editor matches 14019 run data modify storage rhythm_axe:maps.editor editing.rel.delta.start_pos set value [0,0,0]
# 单音符绝对模式【x】重置：还原为打开时的值（editing.temp from editing.orig）
execute if score #click_value editor matches 14016 if score #rel_on editor matches 0 unless data storage rhythm_axe:maps.editor editing.batch if data storage rhythm_axe:maps.editor editing.orig.time run data modify storage rhythm_axe:maps.editor editing.temp.time set from storage rhythm_axe:maps.editor editing.orig.time
execute if score #click_value editor matches 14017 if score #rel_on editor matches 0 unless data storage rhythm_axe:maps.editor editing.batch if data storage rhythm_axe:maps.editor editing.orig.size run data modify storage rhythm_axe:maps.editor editing.temp.size set from storage rhythm_axe:maps.editor editing.orig.size
execute if score #click_value editor matches 14018 if score #rel_pos editor matches 0 unless data storage rhythm_axe:maps.editor editing.batch if data storage rhythm_axe:maps.editor editing.orig.position run data modify storage rhythm_axe:maps.editor editing.temp.position set from storage rhythm_axe:maps.editor editing.orig.position
execute if score #click_value editor matches 14019 if score #rel_sp editor matches 0 unless data storage rhythm_axe:maps.editor editing.batch if data storage rhythm_axe:maps.editor editing.orig.start_pos run data modify storage rhythm_axe:maps.editor editing.temp.start_pos set from storage rhythm_axe:maps.editor editing.orig.start_pos
execute if score #click_value editor matches 14016..14017 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #click_value editor matches 14016..14017 run return 0
execute if score #click_value editor matches 14018..14019 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #click_value editor matches 14018..14019 run return 0

# —— 批量确认/取消（editing.batch 时拦截 763/764；用 #batch_do 标志，因 batch_confirm 会移除 editing.batch）——
scoreboard players set #batch_do editor 0
execute if score #click_value editor matches 13701 if data storage rhythm_axe:maps.editor editing.batch run scoreboard players set #batch_do editor 1
execute if score #click_value editor matches 13702 if data storage rhythm_axe:maps.editor editing.batch run scoreboard players set #batch_do editor 1
execute if score #batch_do editor matches 1 if score #click_value editor matches 13701 run function rhythm_axe:editor/menu/note/batch/batch_confirm
execute if score #batch_do editor matches 1 if score #click_value editor matches 13702 run function rhythm_axe:editor/menu/note/batch/batch_cancel
execute if score #batch_do editor matches 1 run return fail
# —— 单音符确认/取消/删除 ——
execute if score #click_value editor matches 13701 run function rhythm_axe:editor/menu/note/panel/note_panel_confirm
execute if score #click_value editor matches 13702 run function rhythm_axe:editor/menu/note/panel/note_panel_cancel
execute if score #click_value editor matches 13703 run function rhythm_axe:editor/menu/note/panel/note_panel_delete_arm
execute if score #click_value editor matches 13704 run function rhythm_axe:editor/menu/note/panel/note_panel_delete
execute if score #click_value editor matches 13705 run function rhythm_axe:editor/menu/note/panel/note_panel_delete_disarm

# 时间轴翻转（909）：本面板仅 return（动作在面板10/18）
execute if score #click_value editor matches 909 run return 0
# 引导线/无视流速开关（794/795）
execute if score #click_value editor matches 13201 run function rhythm_axe:editor/menu/note/panel/note_toggle_following_point
execute if score #click_value editor matches 13202 run function rhythm_axe:editor/menu/note/panel/note_toggle_ignore_speed

# —— 【x】字段重置：批量=清 batch_set + temp 恢复默认；单音符=temp 恢复 orig；均清 changed 并刷新 ——
# 890 基础寿命
execute if score #click_value editor matches 14001 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.base_life
execute if score #click_value editor matches 14001 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.note_base_life set value 24
execute if score #click_value editor matches 14001 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.note_base_life set from storage rhythm_axe:maps.editor editing.orig.note_base_life
execute if score #click_value editor matches 14001 run data remove storage rhythm_axe:maps.editor editing.changed.base_life
execute if score #click_value editor matches 14001 run function rhythm_axe:editor/menu/note/panel/note_panel
# 891 持续
execute if score #click_value editor matches 14002 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.duration
execute if score #click_value editor matches 14002 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.duration set value 8
execute if score #click_value editor matches 14002 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.duration set from storage rhythm_axe:maps.editor editing.orig.duration
execute if score #click_value editor matches 14002 run data remove storage rhythm_axe:maps.editor editing.changed.duration
execute if score #click_value editor matches 14002 run function rhythm_axe:editor/menu/note/panel/note_panel
# 892 密度
execute if score #click_value editor matches 14003 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.density
execute if score #click_value editor matches 14003 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.density set value 8
execute if score #click_value editor matches 14003 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.density set from storage rhythm_axe:maps.editor editing.orig.density
execute if score #click_value editor matches 14003 run data remove storage rhythm_axe:maps.editor editing.changed.density
execute if score #click_value editor matches 14003 run function rhythm_axe:editor/menu/note/panel/note_panel
# 893 类型
execute if score #click_value editor matches 14004 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.type
execute if score #click_value editor matches 14004 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.type set value 0
execute if score #click_value editor matches 14004 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.type set from storage rhythm_axe:maps.editor editing.orig.type
execute if score #click_value editor matches 14004 run data remove storage rhythm_axe:maps.editor editing.changed.type
execute if score #click_value editor matches 14004 run function rhythm_axe:editor/menu/note/panel/note_panel
# 899 动画（缓动+强度一次重置）
execute if score #click_value editor matches 14010 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.anim_easing
execute if score #click_value editor matches 14010 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.anim_power
execute if score #click_value editor matches 14010 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.anim_easing set value 1
execute if score #click_value editor matches 14010 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.anim_power set value 1
execute if score #click_value editor matches 14010 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.anim_easing set from storage rhythm_axe:maps.editor editing.orig.anim_easing
execute if score #click_value editor matches 14010 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.anim_power set from storage rhythm_axe:maps.editor editing.orig.anim_power
execute if score #click_value editor matches 14010 run data remove storage rhythm_axe:maps.editor editing.changed.anim_easing
execute if score #click_value editor matches 14010 run data remove storage rhythm_axe:maps.editor editing.changed.anim_power
execute if score #click_value editor matches 14010 run function rhythm_axe:editor/menu/note/panel/note_panel
# 904 击打音效
execute if score #click_value editor matches 14011 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.hitsound
execute if score #click_value editor matches 14011 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hitsound set value 0
execute if score #click_value editor matches 14011 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hitsound set from storage rhythm_axe:maps.editor editing.orig.hitsound
execute if score #click_value editor matches 14011 run data remove storage rhythm_axe:maps.editor editing.changed.hitsound
execute if score #click_value editor matches 14011 run function rhythm_axe:editor/menu/note/panel/note_panel
# 905 击打视效
execute if score #click_value editor matches 14012 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.hit_particles
execute if score #click_value editor matches 14012 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hit_particles set value 0
execute if score #click_value editor matches 14012 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hit_particles set from storage rhythm_axe:maps.editor editing.orig.hit_particles
execute if score #click_value editor matches 14012 run data remove storage rhythm_axe:maps.editor editing.changed.hit_particles
execute if score #click_value editor matches 14012 run function rhythm_axe:editor/menu/note/panel/note_panel
# 906 击打事件
execute if score #click_value editor matches 14013 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.hit_events
execute if score #click_value editor matches 14013 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hit_events set value []
execute if score #click_value editor matches 14013 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hit_events set from storage rhythm_axe:maps.editor editing.orig.hit_events
execute if score #click_value editor matches 14013 run data remove storage rhythm_axe:maps.editor editing.changed.hit_events
execute if score #click_value editor matches 14013 run function rhythm_axe:editor/menu/note/panel/note_panel
# 907 标签
execute if score #click_value editor matches 14014 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.custom_tag
execute if score #click_value editor matches 14014 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.custom_tag set value ""
execute if score #click_value editor matches 14014 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.custom_tag set from storage rhythm_axe:maps.editor editing.orig.custom_tag
execute if score #click_value editor matches 14014 run data remove storage rhythm_axe:maps.editor editing.changed.custom_tag
execute if score #click_value editor matches 14014 run function rhythm_axe:editor/menu/note/panel/note_panel
# 908 颜色
execute if score #click_value editor matches 14015 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.color
execute if score #click_value editor matches 14015 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.color set value 1b
execute if score #click_value editor matches 14015 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.color set from storage rhythm_axe:maps.editor editing.orig.color
execute if score #click_value editor matches 14015 run data remove storage rhythm_axe:maps.editor editing.changed.color
execute if score #click_value editor matches 14015 run function rhythm_axe:editor/menu/note/panel/note_panel
# 894 引导线
execute if score #click_value editor matches 14005 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.following_point
execute if score #click_value editor matches 14005 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.following_point set value 0b
execute if score #click_value editor matches 14005 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.following_point set from storage rhythm_axe:maps.editor editing.orig.following_point
execute if score #click_value editor matches 14005 run data remove storage rhythm_axe:maps.editor editing.changed.following_point
execute if score #click_value editor matches 14005 run function rhythm_axe:editor/menu/note/panel/note_panel
# 895 无视流速
execute if score #click_value editor matches 14006 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.ignore_note_speed
execute if score #click_value editor matches 14006 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.ignore_note_speed set value 0b
execute if score #click_value editor matches 14006 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.ignore_note_speed set from storage rhythm_axe:maps.editor editing.orig.ignore_note_speed
execute if score #click_value editor matches 14006 run data remove storage rhythm_axe:maps.editor editing.changed.ignore_note_speed
execute if score #click_value editor matches 14006 run function rhythm_axe:editor/menu/note/panel/note_panel

# —— 判定位置/起始位置单轴加减（field_name + delta；[--]/[++]粗调 ±100=1 格）——
execute if score #click_value editor matches 13401 run data modify storage rhythm_axe:prop field_name set value "position[0]"
execute if score #click_value editor matches 13402 run data modify storage rhythm_axe:prop field_name set value "position[0]"
execute if score #click_value editor matches 13403 run data modify storage rhythm_axe:prop field_name set value "position[1]"
execute if score #click_value editor matches 13404 run data modify storage rhythm_axe:prop field_name set value "position[1]"
execute if score #click_value editor matches 13405 run data modify storage rhythm_axe:prop field_name set value "position[2]"
execute if score #click_value editor matches 13406 run data modify storage rhythm_axe:prop field_name set value "position[2]"
execute if score #click_value editor matches 13501 run data modify storage rhythm_axe:prop field_name set value "start_pos[0]"
execute if score #click_value editor matches 13502 run data modify storage rhythm_axe:prop field_name set value "start_pos[0]"
execute if score #click_value editor matches 13503 run data modify storage rhythm_axe:prop field_name set value "start_pos[1]"
execute if score #click_value editor matches 13504 run data modify storage rhythm_axe:prop field_name set value "start_pos[1]"
execute if score #click_value editor matches 13505 run data modify storage rhythm_axe:prop field_name set value "start_pos[2]"
execute if score #click_value editor matches 13506 run data modify storage rhythm_axe:prop field_name set value "start_pos[2]"
# 粗调（[--]/[++]：±1 格 = ±100）
execute if score #click_value editor matches 13407 run data modify storage rhythm_axe:prop field_name set value "position[0]"
execute if score #click_value editor matches 13408 run data modify storage rhythm_axe:prop field_name set value "position[0]"
execute if score #click_value editor matches 13409 run data modify storage rhythm_axe:prop field_name set value "position[1]"
execute if score #click_value editor matches 13410 run data modify storage rhythm_axe:prop field_name set value "position[1]"
execute if score #click_value editor matches 13411 run data modify storage rhythm_axe:prop field_name set value "position[2]"
execute if score #click_value editor matches 13412 run data modify storage rhythm_axe:prop field_name set value "position[2]"
execute if score #click_value editor matches 13507 run data modify storage rhythm_axe:prop field_name set value "start_pos[0]"
execute if score #click_value editor matches 13508 run data modify storage rhythm_axe:prop field_name set value "start_pos[0]"
execute if score #click_value editor matches 13509 run data modify storage rhythm_axe:prop field_name set value "start_pos[1]"
execute if score #click_value editor matches 13510 run data modify storage rhythm_axe:prop field_name set value "start_pos[1]"
execute if score #click_value editor matches 13511 run data modify storage rhythm_axe:prop field_name set value "start_pos[2]"
execute if score #click_value editor matches 13512 run data modify storage rhythm_axe:prop field_name set value "start_pos[2]"
execute if score #click_value editor matches 13401..13406 run scoreboard players set #pos_delta const 10
execute if score #click_value editor matches 13501..13506 run scoreboard players set #pos_delta const 10
execute if score #click_value editor matches 13601..13602 run scoreboard players set #pos_delta const 10
execute if score #click_value editor matches 13401 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 13403 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 13405 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 13501 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 13503 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 13505 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 13407..13412 run scoreboard players set #pos_delta const 100
execute if score #click_value editor matches 13507..13512 run scoreboard players set #pos_delta const 100
execute if score #click_value editor matches 13407 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 13409 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 13411 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 13507 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 13509 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 13511 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 13401..13412 run execute store result storage rhythm_axe:prop delta int 1 run scoreboard players get #pos_delta const
execute if score #click_value editor matches 13501..13512 run execute store result storage rhythm_axe:prop delta int 1 run scoreboard players get #pos_delta const
execute if score #click_value editor matches 13601..13602 run execute store result storage rhythm_axe:prop delta int 1 run scoreboard players get #pos_delta const
# 相对增量目标组/轴
execute if score #click_value editor matches 13401..13406 run data modify storage rhythm_axe:prop rel_group set value "position"
execute if score #click_value editor matches 13407..13412 run data modify storage rhythm_axe:prop rel_group set value "position"
execute if score #click_value editor matches 13501..13506 run data modify storage rhythm_axe:prop rel_group set value "start_pos"
execute if score #click_value editor matches 13507..13512 run data modify storage rhythm_axe:prop rel_group set value "start_pos"
execute if score #click_value editor matches 13401..13402 run data modify storage rhythm_axe:prop rel_axis set value 0
execute if score #click_value editor matches 13407..13408 run data modify storage rhythm_axe:prop rel_axis set value 0
execute if score #click_value editor matches 13501..13502 run data modify storage rhythm_axe:prop rel_axis set value 0
execute if score #click_value editor matches 13507..13508 run data modify storage rhythm_axe:prop rel_axis set value 0
execute if score #click_value editor matches 13403..13404 run data modify storage rhythm_axe:prop rel_axis set value 1
execute if score #click_value editor matches 13409..13410 run data modify storage rhythm_axe:prop rel_axis set value 1
execute if score #click_value editor matches 13503..13504 run data modify storage rhythm_axe:prop rel_axis set value 1
execute if score #click_value editor matches 13509..13510 run data modify storage rhythm_axe:prop rel_axis set value 1
execute if score #click_value editor matches 13405..13406 run data modify storage rhythm_axe:prop rel_axis set value 2
execute if score #click_value editor matches 13411..13412 run data modify storage rhythm_axe:prop rel_axis set value 2
execute if score #click_value editor matches 13505..13506 run data modify storage rhythm_axe:prop rel_axis set value 2
execute if score #click_value editor matches 13511..13512 run data modify storage rhythm_axe:prop rel_axis set value 2
execute if score #click_value editor matches 13401..13412 run function rhythm_axe:editor/menu/note/pos/note_pos_adjust with storage rhythm_axe:prop
execute if score #click_value editor matches 13501..13512 run function rhythm_axe:editor/menu/note/pos/note_pos_adjust with storage rhythm_axe:prop
execute if score #click_value editor matches 13601..13602 run function rhythm_axe:editor/menu/note/pos/note_pos_adjust with storage rhythm_axe:prop
# 使用当前/吸附中心
execute if score #click_value editor matches 13601 run function rhythm_axe:editor/menu/note/pos/note_pos_use_player
execute if score #click_value editor matches 13602 run function rhythm_axe:editor/menu/note/pos/note_pos_snap_center
# 标签字段对话框
execute if score #click_value editor matches 13106 run function rhythm_axe:editor/menu/note/dialog/dialog_open_note_tag

# —— 进入全局音效(12)/全局视效(13)/击打事件(14)子面板（进入时备份）——
execute if score #click_value editor matches 12806 run data modify storage rhythm_axe:prop sound_backup set from storage rhythm_axe:feedback sounds
execute if score #click_value editor matches 12806 run function rhythm_axe:editor/menu/note/global/global_sound_panel
execute if score #click_value editor matches 12906 run data modify storage rhythm_axe:prop particle_backup set from storage rhythm_axe:feedback particles
execute if score #click_value editor matches 12906 run function rhythm_axe:editor/menu/note/global/global_particle_panel
execute if score #click_value editor matches 13006 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_open
