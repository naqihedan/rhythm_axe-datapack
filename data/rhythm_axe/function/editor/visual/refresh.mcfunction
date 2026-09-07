# 刷新世界中的编辑器音符（实时显示谱面内容）
# 数据源 = maps.editor 工作副本（history[$(cursor)].notes[]）+ 播放头（playhead）
# 当前为整体重建（kill 全部 editor_note 实体再遍历生成）；后续改为按稳定 id 增量更新
kill @e[tag=editor_note]
kill @e[tag=editor_guide]
# 同步 #playhead 镜像（advance_/seek 都会写，此处保险再读一次）
execute store result score #playhead editor run data get storage rhythm_axe:maps.editor playhead
# 播放游标起点：哨兵 999999，遍历时 spawn_skip_ 记录第一个未出生 idx
scoreboard players set #vis_next editor 999999
# 事件点游标（播放经过 events 触发用；跳转后重置，确保跳转不触发）
scoreboard players set #vis_event editor 0
# 引导线重建：前一个有效 0/1/2 音符 id（default: -1，后续遍历时更新）
scoreboard players set #guide_last_id editor -1
scoreboard players set #guide_last_px editor 0
scoreboard players set #guide_last_py editor 0
scoreboard players set #guide_last_pz editor 0
scoreboard players set #guide_last_tp editor 0
# 从 0 开始遍历（工作副本 = history[cursor]，cursor 由 history_cursor 传入 prop 供宏链使用）
scoreboard players set #vis_idx editor 0
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop note_idx int 1 run scoreboard players get #vis_idx editor
# 预扫描：为每个开启音符记录其"下一个普通音符"（id/出生点/判定时刻），供引导线生成用
# 只要求 A（上一个普通音符）开启；B（下一个普通）是否开启不影响生成；混凝土/玻璃被跳过
# 先清空列表，避免重复 rebuild 时 append 的占位越积越多
data modify storage rhythm_axe:guide_prev notes set value []
scoreboard players set #scan_idx editor 0
scoreboard players set #gn_last editor -1
scoreboard players set #gn_fp editor 0
execute store result storage rhythm_axe:prop scan_idx int 1 run scoreboard players get #scan_idx editor
execute store result storage rhythm_axe:prop gn_last int 1 run scoreboard players get #gn_last editor
function rhythm_axe:editor/visual/guide_prescan_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop scan_idx
data remove storage rhythm_axe:prop gn_last
function rhythm_axe:editor/visual/spawn_note_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop note_idx
data remove storage rhythm_axe:prop cursor
# ★ seek/快进快退（非播放）：播放头停在判定时刻的存活音符触发判定（类似 auto；橙光提示判定时机）
#   普通音符：playhead==time；混凝土：密度段边界（seg 由 summon_ 按当前 playhead 初始化）；玻璃零反馈（trigger 防线）
#   正常播放不走这里（由 tick_one 每刻判定）
# ★ playing 键恒存在（0b/1b），unless data storage 恒失败；按值判断：非播放 = playing==0
execute store result score #temp editor run data get storage rhythm_axe:maps.editor playing
execute as @e[tag=editor_note,type=item_display] at @s if score #temp editor matches 0 if score @s editor_n_type matches 3 if score @s editor_n_density matches 1.. run function rhythm_axe:editor/visual/concrete_seg_check
execute as @e[tag=editor_note,type=item_display] at @s if score #temp editor matches 0 if score @s editor_n_type matches 0..2 if score #playhead editor = @s editor_n_time unless entity @s[tag=editor_n_triggered] run function rhythm_axe:editor/visual/trigger
execute as @e[tag=editor_guide,type=item_display] run function rhythm_axe:editor/visual/guide_tick
# 无未出生（全部已消失/存活）→ 游标落到末尾（#vis_idx 结束时 = notes 长度）
execute if score #vis_next editor matches 999999 run scoreboard players operation #vis_next editor = #vis_idx editor
# ★ 刷新后补光：整体重建会清掉 Glowing，重新给被选中音符补黄色高亮
# ★ 先重建 selection（基于音符元素 selected 标记，按 notes 顺序），供 sel_glow 补光
function rhythm_axe:editor/menu/note/selected/sel_rebuild
data modify storage rhythm_axe:prop glow_idx set value 0
function rhythm_axe:editor/menu/note/selected/sel_glow_drive
data remove storage rhythm_axe:prop glow_idx
