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
# ★ 最大前导（= time − birth）统计起点：spawn_one_ 逐个音符取 max，遍历后写入 editor.runtime
#   供播放中的补扫（visual/scan_due）当扫描窗口上界用
scoreboard players set #vis_lead_max editor 0
# 遍历终止标志（由 spawn_note_ 在越界时置 1，见 spawn_drive）
scoreboard players set #vis_stop editor 0
# 事件点游标（播放经过 events 触发用；跳转后重置，确保跳转不触发）
scoreboard players set #vis_event editor 0
# 从 0 开始遍历（工作副本 = history[cursor]，cursor 由 history_cursor 传入 prop 供宏链使用）
scoreboard players set #vis_idx editor 0
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop note_idx int 1 run scoreboard players get #vis_idx editor
# ★ 2026-09-14 性能：原先这里要做一次**全表预扫描**（guide_prescan_：为 976 个音符各读 7 个字段、生成
#   guide_prev 数组），但引导线只在「存活的 + 开启 following_point 的」音符上生成（几个到几十个）→ 99% 白做。
#   已改为：build_ → guide_build_for_ 在生成引导线时**现场向后查找**下一个普通音符（guide_find_next_*）。
function rhythm_axe:editor/visual/spawn_drive
data remove storage rhythm_axe:prop note_idx
data remove storage rhythm_axe:prop cursor
# 最大前导落盘（补扫扫描窗口上界；空谱面为 0 → 补扫立即收工）
execute store result storage rhythm_axe:editor.runtime vis_lead_max int 1 run scoreboard players get #vis_lead_max editor
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
# ★ selection 重建只在「音符数组可能变化」时才需要。快进快退/跳转/进度条只是移动播放头，
#   selected 标记与已有 selection 都还有效 → 那些调用点会先设 prop.refresh_skip_sel，跳过这趟遍历。
execute unless data storage rhythm_axe:prop refresh_skip_sel run function rhythm_axe:editor/menu/note/selected/sel_rebuild
data modify storage rhythm_axe:prop glow_idx set value 0
function rhythm_axe:editor/menu/note/selected/sel_glow_drive
data remove storage rhythm_axe:prop glow_idx
data remove storage rhythm_axe:prop refresh_skip_sel
