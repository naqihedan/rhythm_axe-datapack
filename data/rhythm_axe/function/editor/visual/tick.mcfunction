# 播放中每刻：1) 从游标 #vis_next 起生成新出生音符 2) 已有实体更新位置 / 消失清理 / 击打触发
# 3) 事件点触发（editor_play_events=1 时；游标 #vis_event，以编辑玩家为执行者）
# 前置：advance_ 已把 playhead +1 并同步 #playhead；本函数仅播放中调用

# ★ 玻璃命中冷却（#ed_g_cd，编辑器假玩家）每刻递减一次 —— 与游玩 damage_cooldown 同款【玩家级单一冷却】。
#   放这里（每刻一次）而不是 glass_check 里（每个玻璃各调一次 ⇒ 会按玻璃数量放大递减速度）。
#   ⚠ 门控一律用 unless「matches 1..」，不要用「matches ..0」：后者对【未赋值】的计分项不成立，
#     会让没经 fill_disp 初始化的音符永不判定（2026-09-21 用户实测：明着撞也不判）。
execute if score #ed_g_cd editor matches 1.. run scoreboard players remove #ed_g_cd editor 1
# 1) 新出生检查（游标从 #vis_next 起；按 time 序推进，遇到第一个未出生即停）
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop note_idx int 1 run scoreboard players get #vis_next editor
function rhythm_axe:editor/visual/tick_birth_note_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop note_idx
data remove storage rhythm_axe:prop cursor
# 1.1) ★ 补扫出生（2026-09-21 新增）：数组按 time 升序，但出生刻 birth = time − note_base_life×16/流速
#   在 base_life 不统一时**不单调** ⇒ 只靠上面的游标（队首未出生即停）会漏生成「排在后面前导更长」的音符
#   （症状：音符只剩后半程才出现、一出现就已经走了一半）。补扫从队首之后按各自出生刻把它补上。
#   两条路都只认「birth == playhead」精确一刻 ⇒ 每个音符只生成一次（详见 scan_due）。
function rhythm_axe:editor/visual/scan_due
# 1.4) ★ 游玩测试（真实判定）播放期间：视线/交互距离对齐游玩 4.5
#   游玩侧硬编码：play/start_of_game/start.mcfunction 把 entity_interaction_range 设为 4.5
#   （looked_at 谓词的射线长度由该属性决定；编辑器不设则只剩原版 3.0 ⇒ 判定距离比游玩短）。
#   ⚠ 音符/选择工具自带主手修饰符 entity_interaction_range -1.0（防误触远处实体）
#     ⇒ 手持带 attribute_modifiers 的物品时把 base 补到 5.5，叠加后仍是 4.5。
#   每刻设（而非只在 play_ 设一次）：玩家中途换手持物品也能立即跟上。
#   暂停时由 playback/pause 恢复 3.0。
execute if score editor_note_judge options matches 1 if data storage rhythm_axe:maps.editor {playing:1b} as @a[tag=editor_active] run attribute @s entity_interaction_range base set 4.5
execute if score editor_note_judge options matches 1 if data storage rhythm_axe:maps.editor {playing:1b} as @a[tag=editor_active] if items entity @s weapon.mainhand *[minecraft:attribute_modifiers] run attribute @s entity_interaction_range base set 5.5
# 1.5) ★ 真实判定：判定保护用的射线步进（每刻重算 —— 先清上一刻标记，再按编辑者视线重新打）
#   必须在下面 tick_one（→ judge/note_check）之前，保证"保护进入"检查读到的是本刻结果
execute if score editor_note_judge options matches 1 run tag @e[type=item_display,tag=editor_note,tag=editor_n_looked_perfect] remove editor_n_looked_perfect
execute if score editor_note_judge options matches 1 run function rhythm_axe:editor/judge/raycast
# 1.6) ★ 真实判定：《同一刻判定限制》预扫 —— 先求出本刻可判候选的最小寿命 #ed_min_life，
#      再由下面 tick_one → judge/note_check 只放行 note_life == #ed_min_life 的候选取得判定
#      （必须两遍：判定不许依赖逐音符的遍历顺序；无候选时保持 999999，门控自然全不成立）
execute if score editor_note_judge options matches 1 run scoreboard players set #ed_min_life editor 999999
execute if score editor_note_judge options matches 1 as @e[type=item_display,tag=editor_note] at @s run function rhythm_axe:editor/judge/probe
# 2) 已有实体：更新位置 + 消失/未出生清理 + 击打触发（实体驱动）
# ★ at @s：把执行位置设到展示实体坐标（=判定位置），与游玩系统 as @e[...] at @s 一致
#   否则 trigger_ → play_sound/play_particle 的 ~ ~ ~ 停留在 tick 调用位置（世界原点），音效/粒子播错位置
execute as @e[type=item_display,tag=editor_note] at @s run function rhythm_axe:editor/visual/tick_one
execute as @e[tag=editor_guide,type=item_display] run function rhythm_axe:editor/visual/guide_tick
# ★ 真实判定：清掉本轮点击标记（判定已在上面 tick_one → judge/note_check 内逐音符消费；
#   点击发生在扫描之后的（advancement 晚于 tick）留给下一刻，见 judge/input_click）
execute if score editor_note_judge options matches 1 run tag @e[type=interaction,tag=editor_note,tag=editor_n_clicked] remove editor_n_clicked
# 3) 事件点触发（仅播放中经过；跳转不触发）
execute if score editor_play_events options matches 1 run execute as @a[tag=editor_active] at @s run function rhythm_axe:editor/visual/tick_event
# ★ 2026-09-20 取消「播放中每刻刷新播放进度 actionbar」：它每刻都把 actionbar 顶掉，
#   真实判定的 PERFECT/GOOD/MISS 文字刚显示就被进度覆盖。
#   进度改看播放进度 bossbar（播放中一直可见）与主菜单「当前刻/最终刻」；
#   快进/快退/回到开头/打开收尾仍保留一次性提示（visual/progress_actionbar）。
