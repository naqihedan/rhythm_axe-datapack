# 音符面板字段调整（spec-v2 号段）：12001 时间-1 / 12002 时间+1 / 12003 时间-tpb / 12004 时间+tpb / 12101 类型循环 0-4
# 判定时间：[--]/[++] = ±当前播放头所在时间点 tpb；[-]/[+] = ±1 刻
# 绝对模式改 temp.time（下界 0）；相对模式改 editing.rel.delta.time（可负，确认时统一钳制）
scoreboard players set #rel_on editor 0
execute store result score #rel_on editor run data get storage rhythm_axe:maps.editor editing.rel.on.time
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.time
execute if score #rel_on editor matches 1 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.rel.delta.time
scoreboard players set #time_step editor 1
execute if score #click_value editor matches 12003..12004 run function rhythm_axe:editor/menu/note/panel/note_time_tpb
execute if score #click_value editor matches 12001 run scoreboard players operation #temp editor -= #time_step editor
execute if score #click_value editor matches 12002 run scoreboard players operation #temp editor += #time_step editor
execute if score #click_value editor matches 12003 run scoreboard players operation #temp editor -= #time_step editor
execute if score #click_value editor matches 12004 run scoreboard players operation #temp editor += #time_step editor
execute if score #rel_on editor matches 0 if score #click_value editor matches 12001..12002 if score #temp editor matches ..-1 run scoreboard players set #temp editor 0
execute if score #rel_on editor matches 0 if score #click_value editor matches 12003..12004 if score #temp editor matches ..-1 run scoreboard players set #temp editor 0
execute if score #rel_on editor matches 0 if score #click_value editor matches 12001..12002 run execute store result storage rhythm_axe:maps.editor editing.temp.time int 1 run scoreboard players get #temp editor
execute if score #rel_on editor matches 0 if score #click_value editor matches 12003..12004 run execute store result storage rhythm_axe:maps.editor editing.temp.time int 1 run scoreboard players get #temp editor
execute if score #rel_on editor matches 1 if score #click_value editor matches 12001..12002 run execute store result storage rhythm_axe:maps.editor editing.rel.delta.time int 1 run scoreboard players get #temp editor
execute if score #rel_on editor matches 1 if score #click_value editor matches 12003..12004 run execute store result storage rhythm_axe:maps.editor editing.rel.delta.time int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 12101 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.type
execute if score #click_value editor matches 12101 run scoreboard players add #temp editor 1
execute if score #click_value editor matches 12101 if score #temp editor matches 5.. run scoreboard players set #temp editor 0
execute if score #click_value editor matches 12101 run execute store result storage rhythm_axe:maps.editor editing.temp.type int 1 run scoreboard players get #temp editor
# 持续 duration（12201/12202 单步 ±1 刻；12203/12204 双步 ±tpb）
# 绝对模式改 temp.duration（下界 0）；相对模式改 editing.rel.delta.duration（可负，确认时统一钳制）
scoreboard players set #rel_dur editor 0
execute store result score #rel_dur editor run data get storage rhythm_axe:maps.editor editing.rel.on.duration
execute if score #click_value editor matches 12201..12204 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.duration
execute if score #rel_dur editor matches 1 if score #click_value editor matches 12201..12204 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.rel.delta.duration
execute if score #click_value editor matches 12203..12204 run function rhythm_axe:editor/menu/note/panel/note_time_tpb
execute if score #click_value editor matches 12201 run scoreboard players operation #temp editor -= #time_step editor
execute if score #click_value editor matches 12202 run scoreboard players operation #temp editor += #time_step editor
execute if score #click_value editor matches 12203 run scoreboard players operation #temp editor -= #time_step editor
execute if score #click_value editor matches 12204 run scoreboard players operation #temp editor += #time_step editor
execute if score #rel_dur editor matches 0 if score #click_value editor matches 12201..12204 if score #temp editor matches ..-1 run scoreboard players set #temp editor 0
execute if score #rel_dur editor matches 0 if score #click_value editor matches 12201..12204 run execute store result storage rhythm_axe:maps.editor editing.temp.duration int 1 run scoreboard players get #temp editor
execute if score #rel_dur editor matches 1 if score #click_value editor matches 12201..12204 run execute store result storage rhythm_axe:maps.editor editing.rel.delta.duration int 1 run scoreboard players get #temp editor
# 批量：判定时间被改时打 batch_set.time 标记（供【x】状态判断）
execute if score #click_value editor matches 12001..12002 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.time set value 1b
execute if score #click_value editor matches 12501..12502 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.size set value 1b
execute if score #click_value editor matches 12501..12502 run data modify storage rhythm_axe:maps.editor editing.changed.size set value 1b
execute if score #click_value editor matches 12003..12004 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.time set value 1b
# 颜色 color（770/771，循环 0-16；0=无 1-16=16 色）
execute if score #click_value editor matches 12301..12302 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.color
execute if score #click_value editor matches 12301 run scoreboard players remove #temp editor 1
execute if score #click_value editor matches 12302 run scoreboard players add #temp editor 1
execute if score #click_value editor matches 12301..12302 if score #temp editor matches ..0 run scoreboard players set #temp editor 16
execute if score #click_value editor matches 12301..12302 if score #temp editor matches 17.. run scoreboard players set #temp editor 1
execute if score #click_value editor matches 12301..12302 run execute store result storage rhythm_axe:maps.editor editing.temp.color byte 1 run scoreboard players get #temp editor
# 密度 density（772/773，下界 1；混凝土用）
execute if score #click_value editor matches 12401..12402 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.density
execute if score #click_value editor matches 12401 run scoreboard players remove #temp editor 1
execute if score #click_value editor matches 12402 run scoreboard players add #temp editor 1
execute if score #click_value editor matches 12401..12402 if score #temp editor matches ..1 run scoreboard players set #temp editor 1
execute if score #click_value editor matches 12401..12402 run execute store result storage rhythm_axe:maps.editor editing.temp.density int 1 run scoreboard players get #temp editor
# 大小 size（774/775，0.1 步；绝对下界 0.1、相对改增量；float 用 scoreboard ×100）
scoreboard players set #rel_on editor 0
execute store result score #rel_on editor run data get storage rhythm_axe:maps.editor editing.rel.on.size
execute if score #click_value editor matches 12501..12502 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.size 1000
execute if score #click_value editor matches 12501..12502 run scoreboard players operation #temp editor += 5 const
execute if score #click_value editor matches 12501..12502 run scoreboard players operation #temp editor /= 10 const
execute if score #rel_on editor matches 1 if score #click_value editor matches 12501..12502 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.rel.delta.size
execute if score #click_value editor matches 12501 run scoreboard players remove #temp editor 10
execute if score #click_value editor matches 12502 run scoreboard players add #temp editor 10
execute if score #rel_on editor matches 0 if score #click_value editor matches 12501..12502 if score #temp editor matches ..10 run scoreboard players set #temp editor 10
execute if score #rel_on editor matches 0 if score #click_value editor matches 12501..12502 run execute store result storage rhythm_axe:maps.editor editing.temp.size float 0.01 run scoreboard players get #temp editor
execute if score #rel_on editor matches 1 if score #click_value editor matches 12501..12502 run execute store result storage rhythm_axe:maps.editor editing.rel.delta.size int 1 run scoreboard players get #temp editor
# 基础寿命 note_base_life（776/777，下界 1）
execute if score #click_value editor matches 12601..12602 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.note_base_life
execute if score #click_value editor matches 12601 run scoreboard players remove #temp editor 1
execute if score #click_value editor matches 12602 run scoreboard players add #temp editor 1
execute if score #click_value editor matches 12601..12602 if score #temp editor matches ..1 run scoreboard players set #temp editor 1
execute if score #click_value editor matches 12601..12602 run execute store result storage rhythm_axe:maps.editor editing.temp.note_base_life int 1 run scoreboard players get #temp editor
# 缓动类型 anim_easing（778/779，循环 1-3）
execute if score #click_value editor matches 12701..12702 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.anim_easing
execute if score #click_value editor matches 12701 run scoreboard players remove #temp editor 1
execute if score #click_value editor matches 12702 run scoreboard players add #temp editor 1
execute if score #click_value editor matches 12701..12702 if score #temp editor matches ..0 run scoreboard players set #temp editor 3
execute if score #click_value editor matches 12701..12702 if score #temp editor matches 4.. run scoreboard players set #temp editor 1
execute if score #click_value editor matches 12701..12702 run execute store result storage rhythm_axe:maps.editor editing.temp.anim_easing int 1 run scoreboard players get #temp editor
# 缓动强度 anim_power（780/781，循环 1-5）
execute if score #click_value editor matches 12703..12704 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.anim_power
execute if score #click_value editor matches 12703 run scoreboard players remove #temp editor 1
execute if score #click_value editor matches 12704 run scoreboard players add #temp editor 1
execute if score #click_value editor matches 12703..12704 if score #temp editor matches ..0 run scoreboard players set #temp editor 5
execute if score #click_value editor matches 12703..12704 if score #temp editor matches 6.. run scoreboard players set #temp editor 1
execute if score #click_value editor matches 12703..12704 run execute store result storage rhythm_axe:maps.editor editing.temp.anim_power int 1 run scoreboard players get #temp editor
# 击打音效 hitsound（799/800，组号 0-6 循环）
execute if score #click_value editor matches 12801..12802 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.hitsound
execute if score #click_value editor matches 12801 run scoreboard players remove #temp editor 1
execute if score #click_value editor matches 12802 run scoreboard players add #temp editor 1
execute if score #click_value editor matches 12801..12802 if score #temp editor matches ..-1 run scoreboard players set #temp editor 6
execute if score #click_value editor matches 12801..12802 if score #temp editor matches 7.. run scoreboard players set #temp editor 0
execute if score #click_value editor matches 12801..12802 run execute store result storage rhythm_axe:maps.editor editing.temp.hitsound int 1 run scoreboard players get #temp editor
# 击打视效 hit_particles（802/803，组号 0-6 循环）
execute if score #click_value editor matches 12901..12902 run execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.hit_particles
execute if score #click_value editor matches 12901 run scoreboard players remove #temp editor 1
execute if score #click_value editor matches 12902 run scoreboard players add #temp editor 1
execute if score #click_value editor matches 12901..12902 if score #temp editor matches ..-1 run scoreboard players set #temp editor 6
execute if score #click_value editor matches 12901..12902 if score #temp editor matches 7.. run scoreboard players set #temp editor 0
execute if score #click_value editor matches 12901..12902 run execute store result storage rhythm_axe:maps.editor editing.temp.hit_particles int 1 run scoreboard players get #temp editor
# 批量：标记被改动的同值字段（确认时对全部选中应用同值；@x 撤销=清除标记）
execute if score #click_value editor matches 12101 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.type set value 1b
execute if score #click_value editor matches 12101 run data modify storage rhythm_axe:maps.editor editing.changed.type set value 1b
execute if score #click_value editor matches 12201..12202 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.duration set value 1b
execute if score #click_value editor matches 12203..12204 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.duration set value 1b
execute if score #click_value editor matches 12201..12202 run data modify storage rhythm_axe:maps.editor editing.changed.duration set value 1b
execute if score #click_value editor matches 12203..12204 run data modify storage rhythm_axe:maps.editor editing.changed.duration set value 1b
execute if score #click_value editor matches 12301..12302 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.color set value 1b
execute if score #click_value editor matches 12401..12402 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.density set value 1b
execute if score #click_value editor matches 12401..12402 run data modify storage rhythm_axe:maps.editor editing.changed.density set value 1b
execute if score #click_value editor matches 12601..12602 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.base_life set value 1b
execute if score #click_value editor matches 12601..12602 run data modify storage rhythm_axe:maps.editor editing.changed.base_life set value 1b
execute if score #click_value editor matches 12701..12702 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.anim_easing set value 1b
execute if score #click_value editor matches 12703..12704 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.anim_power set value 1b
execute if score #click_value editor matches 12701..12702 run data modify storage rhythm_axe:maps.editor editing.changed.anim_easing set value 1b
execute if score #click_value editor matches 12703..12704 run data modify storage rhythm_axe:maps.editor editing.changed.anim_power set value 1b
execute if score #click_value editor matches 12801..12802 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.hitsound set value 1b
execute if score #click_value editor matches 12901..12902 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.hit_particles set value 1b
execute if score #click_value editor matches 12801..12802 run data modify storage rhythm_axe:maps.editor editing.changed.hitsound set value 1b
execute if score #click_value editor matches 12901..12902 run data modify storage rhythm_axe:maps.editor editing.changed.hit_particles set value 1b
function rhythm_axe:editor/menu/note/panel/note_panel
