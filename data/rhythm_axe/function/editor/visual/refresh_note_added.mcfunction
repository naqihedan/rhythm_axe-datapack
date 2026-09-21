# 放置单个音符的「增量刷新」（A，2026-09-14）——仅在 create 判定为 append（追加到末尾）时调用
# 前置：prop.cursor（工作副本下标）、prop.new_index（新音符下标 = 追加前数组长度 k）
#
# ★ 与全量 refresh 的区别：不 kill 展示实体、不重建引导线全表、不重建选区（放置不改选中）
#   → 只补做三件必要的事，全程 O(1)（新音符就在末尾）。
# ★ 为什么可以这么省（前置推论，务必保留）：
#   · append ⟺ insert_find 没找到「time 更大的元素」⟺ 播放头(新音符 time) ≥ 所有旧音符 time。
#   · 出生刻 = time − note_base_life×16/note_speed ≤ time → 旧音符**全部已出生** ⇒ 全量刷新算出的
#     #vis_next（第一个未出生下标）必然 = 旧数组长度 = k；新音符自身也必然已出生（time=播放头）。
#     所以 #vis_next 直接 = k+1，不用 walk。
#   · notes 按 time 升序由 order_repair 维护；追加不会改变任何已有音符的下标，
#     展示实体/选区（存 id、time 等，不存下标）全部保持有效。
#   · guide_prev.notes 与 notes 下标一一对应，条目里存的是 id/坐标/时刻（不是下标）→
#     只需「从 k 继续预扫描」补上新音符的占位与相关 next_*，前面条目不用动。
# ⚠️ 中段插入（insert 模式）不走这里，仍走全量 refresh（create 里分流）。
# ① 同步播放头（spawn 分支只看 #playhead）
execute store result score #playhead editor run data get storage rhythm_axe:maps.editor playhead
# ①a ★ 最大前导：读回已存量（普通函数 spawn_one_ 会与本音符取 max；新音符可能继承到更长的 base_life）
scoreboard players set #vis_lead_max editor 0
execute store result score #vis_lead_max editor run data get storage rhythm_axe:editor.runtime vis_lead_max
# ①b 清掉 spawn_one_ 复制音符元素用的临时键（卫生）
data remove storage rhythm_axe:prop note
# ①c ⚠️ 必须**显式**设置 prop.cursor：spawn_one_ / build_ 的宏参数 $(cursor) 靠它展开。
#   上游（tool → place → create）不保证留着这个键（create 收尾会清掉、别的入口可能没设），
#   一旦缺失 → 宏展开失败 → spawn_one_ **整个静默不执行** → 新音符不生成实体（2026-09-15 用户报告：
#   「世界里没有其他音符时，放置的音符不刷新出来」）。
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
# ② 新音符下标 → #vis_k，并精确设定 #vis_next（见上面推论：k+1）
execute store result score #vis_k editor run data get storage rhythm_axe:prop new_index
scoreboard players operation #vis_next editor = #vis_k editor
scoreboard players add #vis_next editor 1
# ③（2026-09-14 已删除）原先要「复原预扫描状态 + 从 k 继续预扫描」，给 guide_prev 补占位。
#   现在引导线由 guide_build_for_ → guide_find_next_* **现场查找**下一个普通音符，无需 guide_prev，也无需预扫描。
# ④ 只生成新音符自己的展示实体（新音符是最后一个 → spawn 链下一步就因越界终止，O(1)）
execute store result storage rhythm_axe:prop note_idx int 1 run scoreboard players get #vis_k editor
function rhythm_axe:editor/visual/spawn_one_ with storage rhythm_axe:prop
# ④b ★ 2026-09-15 补上「播放头停在判定时刻 → 触发一次判定」——与全量 refresh 末尾那 4 行完全同款。
#   新音符的判定时刻 = 播放头（append 的推论），所以放下去就该响一次击打音效/粒子并亮橙光；
#   漏掉它的症状就是「新音符直接出现，没音效也没橙光」（用户 2026-09-15 反馈）。
#   增量刷新不重建全表，这里只按「现存实体」遍历（= 同时存活的几个到几十个，成本可忽略）。
execute store result score #temp editor run data get storage rhythm_axe:maps.editor playing
execute as @e[tag=editor_note,type=item_display] at @s if score #temp editor matches 0 if score @s editor_n_type matches 3 if score @s editor_n_density matches 1.. run function rhythm_axe:editor/visual/concrete_seg_check
execute as @e[tag=editor_note,type=item_display] at @s if score #temp editor matches 0 if score @s editor_n_type matches 0..2 if score #playhead editor = @s editor_n_time unless entity @s[tag=editor_n_triggered] run function rhythm_axe:editor/visual/trigger
execute as @e[tag=editor_guide,type=item_display] run function rhythm_axe:editor/visual/guide_tick
# ⑤ 最大前导写回（补扫窗口上界；无脑写回，省一次比较）
execute store result storage rhythm_axe:editor.runtime vis_lead_max int 1 run scoreboard players get #vis_lead_max editor
# 清理本次用到的 prop 键（spawn_one_/build_ 自己也会清掉它用的）
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop note_idx
