# 刷新世界中的编辑器音符（实时显示谱面内容）
# 数据源 = maps.editor 工作副本（history[$(cursor)].notes[]）+ 播放头（playhead）
# 当前为整体重建（kill 全部 editor_note 实体再遍历生成）；后续改为按稳定 id 增量更新
# ★ 2026-09-20 修复分数板泄漏：kill【不会】清掉挂在该实体 UUID 上的 editor_n_* 计分项，
#   整体重建每次都会留下一整套残留（实测堆到 133 万项 → 每次自动保存卡顿，详见 note_scores_reset_）
#   必须 kill 前先清（此处是全部实体，一条 execute as 即可）。
execute as @e[tag=editor_note] run function rhythm_axe:editor/visual/note_scores_reset_
kill @e[tag=editor_note]
kill @e[tag=editor_guide]
# 同步 #playhead 镜像（advance_/seek 都会写，此处保险再读一次）
execute store result score #playhead editor run data get storage rhythm_axe:maps.editor playhead
# 清掉 spawn_one_ 复制音符元素用的临时键（卫生）
data remove storage rhythm_axe:prop note
# ★ 判定缩放：重建前按播放头同步 #ed_scale（真实判定模式下 spawn 用它延长普通音符存活窗口）
function rhythm_axe:editor/judge/scale_sync
# 播放游标起点：哨兵 999999，遍历时 spawn_note_ 记录第一个未出生 idx
scoreboard players set #vis_next editor 999999
# ★ 2026-10-03 窗口化（性能）：决定本次遍历范围
#   · 编辑后的刷新（未设 prop.refresh_skip_sel）→ **全表**遍历，并重算 lead/trail 上界缓存
#   · 只动播放头的刷新（seek / 拖进度条 已设 prop.refresh_skip_sel）+ 缓存存在 → 只遍历**可能存活**窗口
#     [playhead − max(trail_max, 3x+1), playhead + lead_max]，跳过前面已消失的音符（通常占绝大多数）
#     上界靠「time > playhead + lead_max 即停」实现（此时 birth > playhead，必未出生）
#     下界靠「首个 time ≥ playhead − 尾长上界」定位（复用 insert_find 的指数+二分，O(log M)）
#     ⚠️ 上界缓存只增不减（每次从缓存值起累加）⇒ 永远偏保守，不会漏音符
#   ★ 实测：1243 音符时全表 refresh ≈1.5~1.8 s（存活只有 36 个）；窗口化后只过几十~百来个音符
scoreboard players set #vis_win editor 0
scoreboard players set #vis_lead_max editor 0
scoreboard players set #vis_trail_max editor 0
execute store result score #vis_lead_max editor run data get storage rhythm_axe:editor.runtime vis_lead_max
execute store result score #vis_trail_max editor run data get storage rhythm_axe:editor.runtime vis_trail_max
execute if data storage rhythm_axe:prop refresh_skip_sel if data storage rhythm_axe:editor.runtime vis_trail_max run scoreboard players set #vis_win editor 1
# 窗口下界时刻 = playhead − max(trail_max, 3x+1)；上界时刻 = playhead + lead_max
scoreboard players operation #vis_trail_u editor = #vis_trail_max editor
execute store result score #vis_x3 editor run scoreboard players get #ed_scale editor
scoreboard players operation #vis_x3 editor *= 3 const
scoreboard players add #vis_x3 editor 1
execute if score #vis_x3 editor > #vis_trail_u editor run scoreboard players operation #vis_trail_u editor = #vis_x3 editor
scoreboard players operation #vis_lo_t editor = #playhead editor
scoreboard players operation #vis_lo_t editor -= #vis_trail_u editor
scoreboard players operation #vis_hi_t editor = #playhead editor
scoreboard players operation #vis_hi_t editor += #vis_lead_max editor
# 遍历终止标志（由 spawn_note_ 在越界 / 超出窗口上界时置 1，见 spawn_drive）
scoreboard players set #vis_stop editor 0
# 事件点游标（播放经过 events 触发用；跳转后重置，确保跳转不触发）
scoreboard players set #vis_event editor 0
# 起点：全表 = 0；窗口 = 首个 time ≥ 窗口下界的下标
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
scoreboard players set #vis_idx editor 0
execute if score #vis_win editor matches 1 run scoreboard players remove #vis_lo_t editor 1
execute if score #vis_win editor matches 1 run data modify storage rhythm_axe:prop list_name set value "notes"
execute if score #vis_win editor matches 1 run execute store result storage rhythm_axe:prop new_time int 1 run scoreboard players get #vis_lo_t editor
execute if score #vis_win editor matches 1 run data remove storage rhythm_axe:prop insert_mode
execute if score #vis_win editor matches 1 run data remove storage rhythm_axe:prop insert_index
execute if score #vis_win editor matches 1 run function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute if score #vis_win editor matches 1 run execute store result score #vis_idx editor run data get storage rhythm_axe:prop index
execute if score #vis_win editor matches 1 run data remove storage rhythm_axe:prop insert_mode
execute if score #vis_win editor matches 1 run data remove storage rhythm_axe:prop insert_index
execute if score #vis_win editor matches 1 run data remove storage rhythm_axe:prop list_name
execute store result storage rhythm_axe:prop note_idx int 1 run scoreboard players get #vis_idx editor
# ★ 2026-09-14 性能：原先这里要做一次**全表预扫描**（guide_prescan_：为 976 个音符各读 7 个字段、生成
#   guide_prev 数组），但引导线只在「存活的 + 开启 following_point 的」音符上生成（几个到几十个）→ 99% 白做。
#   已改为：build_ → guide_build_for_ 在生成引导线时**现场向后查找**下一个普通音符（guide_find_next_*）。
function rhythm_axe:editor/visual/spawn_drive
data remove storage rhythm_axe:prop note_idx
data remove storage rhythm_axe:prop cursor
# 最大前导 / 最大尾长落盘（补扫窗口上界 + refresh 窗口化的下界缓存；只增不减 ⇒ 保守）
execute store result storage rhythm_axe:editor.runtime vis_lead_max int 1 run scoreboard players get #vis_lead_max editor
execute store result storage rhythm_axe:editor.runtime vis_trail_max int 1 run scoreboard players get #vis_trail_max editor
# ★ seek/快进快退（非播放）：播放头停在判定时刻的存活音符触发判定（类似 auto；橙光提示判定时机）
#   普通音符：playhead==time；混凝土：密度段边界（seg 由 summon_ 按当前 playhead 初始化）；玻璃零反馈（trigger 防线）
#   正常播放不走这里（由 tick_one 每刻判定）
# ★ playing 键恒存在（0b/1b），unless data storage 恒失败；按值判断：非播放 = playing==0
execute store result score #temp editor run data get storage rhythm_axe:maps.editor playing
execute as @e[tag=editor_note,type=item_display] at @s if score #temp editor matches 0 if score @s editor_n_type matches 3 if score @s editor_n_density matches 1.. run function rhythm_axe:editor/visual/concrete_seg_check
execute as @e[tag=editor_note,type=item_display] at @s if score #temp editor matches 0 if score @s editor_n_type matches 0..2 if score #playhead editor = @s editor_n_time unless entity @s[tag=editor_n_triggered] run function rhythm_axe:editor/visual/trigger
# 快进快退 / 跳转 / 打开谱面 / 编辑后刷新（这些路径不经过 tick_one）同样做「音符位于方块中」检查
# 门控与播放路径（tick_one）一致：游玩测试【关】 + 音符盒/木板（type 0..1）+ 播放头正停在判定时刻
# 此处实体刚由 refresh 重建并跑过 place，交互实体已在当前刻位置
execute as @e[tag=editor_note,type=item_display] at @s if score editor_note_judge options matches 0 if score @s editor_n_type matches 0..1 if score #playhead editor = @s editor_n_time run function rhythm_axe:editor/visual/err_note_in_block
execute as @e[tag=editor_guide,type=item_display] run function rhythm_axe:editor/visual/guide_tick
# 无未出生（全部已消失/存活）→ 游标落到末尾（#vis_idx 结束时 = notes 长度）
execute if score #vis_next editor matches 999999 run scoreboard players operation #vis_next editor = #vis_idx editor
# ★ 刷新后补光：整体重建会清掉 Glowing，重新给被选中音符补黄色高亮
# ★ selection 重建只在「音符数组可能变化」时才需要。快进快退/跳转/进度条只是移动播放头，
#   selected 标记与已有 selection 都还有效 → 那些调用点会先设 prop.refresh_skip_sel，跳过这趟遍历。
execute unless data storage rhythm_axe:prop refresh_skip_sel run function rhythm_axe:editor/menu/note/selected/sel_rebuild
data modify storage rhythm_axe:prop glow_idx set value 0
function rhythm_axe:editor/menu/note/selected/sel_glow_drive
data remove storage rhythm_axe:prop glow_idx
data remove storage rhythm_axe:prop refresh_skip_sel
