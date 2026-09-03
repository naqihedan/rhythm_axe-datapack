#arg:cursor,index
# 复制音符到暂存 editing.temp，设置引用后显示面板
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)] run tellraw @s [{"text":"[编辑器] 该音符不存在","color":"red"}]
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)] run return fail
$data modify storage rhythm_axe:maps.editor editing.temp set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)]
# 保存原值快照（供【x】重置为"打开时的值"；editing.orig 与原音符等值）
$data modify storage rhythm_axe:maps.editor editing.orig set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)]
# 打开单个音符面板：清除残留的批量编辑状态，确保渲染为单音符模式（而非批量）
data remove storage rhythm_axe:maps.editor editing.batch
data remove storage rhythm_axe:maps.editor editing.batch_ids
data remove storage rhythm_axe:maps.editor editing.batch_set
# 记录来源面板（打开前 current_panel=10 活跃列表 / 18 已选定列表）→ 返回时从哪来回哪去
data modify storage rhythm_axe:maps.editor editing.panel_from set from storage rhythm_axe:maps.editor current_panel
# 补全默认字段（面板可编辑字段缺省填默认，与 create 一致）
execute unless data storage rhythm_axe:maps.editor editing.temp.size run data modify storage rhythm_axe:maps.editor editing.temp.size set value 1.0f
execute unless data storage rhythm_axe:maps.editor editing.temp.note_base_life run data modify storage rhythm_axe:maps.editor editing.temp.note_base_life set value 24
execute unless data storage rhythm_axe:maps.editor editing.temp.anim_easing run data modify storage rhythm_axe:maps.editor editing.temp.anim_easing set value 1
execute unless data storage rhythm_axe:maps.editor editing.temp.anim_power run data modify storage rhythm_axe:maps.editor editing.temp.anim_power set value 1
execute unless data storage rhythm_axe:maps.editor editing.temp.hitsound run execute store result storage rhythm_axe:maps.editor editing.temp.hitsound int 1 run data get storage rhythm_axe:maps.editor editing.temp.type
execute unless data storage rhythm_axe:maps.editor editing.temp.hit_particles run execute store result storage rhythm_axe:maps.editor editing.temp.hit_particles int 1 run data get storage rhythm_axe:maps.editor editing.temp.type
execute unless data storage rhythm_axe:maps.editor editing.temp.following_point run data modify storage rhythm_axe:maps.editor editing.temp.following_point set value 0b
execute unless data storage rhythm_axe:maps.editor editing.temp.ignore_note_speed run data modify storage rhythm_axe:maps.editor editing.temp.ignore_note_speed set value 0b
# 【x】重置为"打开时的值" 依赖 editing.orig；缺字段的音符 orig 也要补默认，否则单个音符重置 set from 失败、值不还原
execute unless data storage rhythm_axe:maps.editor editing.orig.following_point run data modify storage rhythm_axe:maps.editor editing.orig.following_point set value 0b
execute unless data storage rhythm_axe:maps.editor editing.orig.ignore_note_speed run data modify storage rhythm_axe:maps.editor editing.orig.ignore_note_speed set value 0b
execute unless data storage rhythm_axe:maps.editor editing.orig.duration run data modify storage rhythm_axe:maps.editor editing.orig.duration set value 8
execute unless data storage rhythm_axe:maps.editor editing.orig.density run data modify storage rhythm_axe:maps.editor editing.orig.density set value 8
execute unless data storage rhythm_axe:maps.editor editing.orig.size run data modify storage rhythm_axe:maps.editor editing.orig.size set value 1.0f
execute unless data storage rhythm_axe:maps.editor editing.orig.note_base_life run data modify storage rhythm_axe:maps.editor editing.orig.note_base_life set value 24
execute unless data storage rhythm_axe:maps.editor editing.orig.anim_easing run data modify storage rhythm_axe:maps.editor editing.orig.anim_easing set value 1
execute unless data storage rhythm_axe:maps.editor editing.orig.anim_power run data modify storage rhythm_axe:maps.editor editing.orig.anim_power set value 1
execute unless data storage rhythm_axe:maps.editor editing.orig.hitsound run data modify storage rhythm_axe:maps.editor editing.orig.hitsound set value 0
execute unless data storage rhythm_axe:maps.editor editing.orig.hit_particles run data modify storage rhythm_axe:maps.editor editing.orig.hit_particles set value 0
execute unless data storage rhythm_axe:maps.editor editing.orig.custom_tag run data modify storage rhythm_axe:maps.editor editing.orig.custom_tag set value ""
execute unless data storage rhythm_axe:maps.editor editing.orig.hit_events run data modify storage rhythm_axe:maps.editor editing.orig.hit_events set value []
execute unless data storage rhythm_axe:maps.editor editing.orig.position run data modify storage rhythm_axe:maps.editor editing.orig.position set value [0.0d,0.0d,0.0d]
execute unless data storage rhythm_axe:maps.editor editing.orig.start_pos run data modify storage rhythm_axe:maps.editor editing.orig.start_pos set value [0.0d,0.0d,24.0d]
execute unless data storage rhythm_axe:maps.editor editing.temp.custom_tag run data modify storage rhythm_axe:maps.editor editing.temp.custom_tag set value ""
execute unless data storage rhythm_axe:maps.editor editing.temp.hit_events run data modify storage rhythm_axe:maps.editor editing.temp.hit_events set value []
execute unless data storage rhythm_axe:maps.editor editing.temp.position run data modify storage rhythm_axe:maps.editor editing.temp.position set value [0.0d,0.0d,0.0d]
execute unless data storage rhythm_axe:maps.editor editing.temp.start_pos run data modify storage rhythm_axe:maps.editor editing.temp.start_pos set value [0.0d,0.0d,24.0d]
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.type
execute if score #temp editor matches 3 unless data storage rhythm_axe:maps.editor editing.temp.duration run data modify storage rhythm_axe:maps.editor editing.temp.duration set value 8
execute if score #temp editor matches 4 unless data storage rhythm_axe:maps.editor editing.temp.duration run data modify storage rhythm_axe:maps.editor editing.temp.duration set value 8
execute if score #temp editor matches 3 unless data storage rhythm_axe:maps.editor editing.temp.color run data modify storage rhythm_axe:maps.editor editing.temp.color set value 9b
execute if score #temp editor matches 4 unless data storage rhythm_axe:maps.editor editing.temp.color run data modify storage rhythm_axe:maps.editor editing.temp.color set value 6b
execute unless data storage rhythm_axe:maps.editor editing.orig.type run data modify storage rhythm_axe:maps.editor editing.orig.type set value 0
execute if score #temp editor matches 3 unless data storage rhythm_axe:maps.editor editing.orig.color run data modify storage rhythm_axe:maps.editor editing.orig.color set value 9b
execute if score #temp editor matches 4 unless data storage rhythm_axe:maps.editor editing.orig.color run data modify storage rhythm_axe:maps.editor editing.orig.color set value 6b
execute if score #temp editor matches 3 unless data storage rhythm_axe:maps.editor editing.temp.density run data modify storage rhythm_axe:maps.editor editing.temp.density set value 8
data modify storage rhythm_axe:maps.editor editing.orig_index set from storage rhythm_axe:prop index
execute store result storage rhythm_axe:maps.editor editing.orig_index int 1 run data get storage rhythm_axe:prop index
# 相对/绝对状态初始化（单音符默认绝对；相对增量置 0）。位置/起始位置相对增量为数组 [x,y,z]（×100 整数）。
data modify storage rhythm_axe:maps.editor editing.rel set value {on:{time:0b,size:0b,position:0b,start_pos:0b},delta:{time:0,size:0,position:[0,0,0],start_pos:[0,0,0]}}
function rhythm_axe:editor/menu/note/panel/note_panel
