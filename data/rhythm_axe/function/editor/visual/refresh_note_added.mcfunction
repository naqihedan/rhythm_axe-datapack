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
# ①b 清掉 spawn_one_ 复制音符元素用的临时键（卫生）
data remove storage rhythm_axe:prop note
# ② 新音符下标 → #vis_k，并精确设定 #vis_next（见上面推论：k+1）
execute store result score #vis_k editor run data get storage rhythm_axe:prop new_index
scoreboard players operation #vis_next editor = #vis_k editor
scoreboard players add #vis_next editor 1
# ③（2026-09-14 已删除）原先要「复原预扫描状态 + 从 k 继续预扫描」，给 guide_prev 补占位。
#   现在引导线由 guide_build_for_ → guide_find_next_* **现场查找**下一个普通音符，无需 guide_prev，也无需预扫描。
# ④ 只生成新音符自己的展示实体（新音符是最后一个 → spawn 链下一步就因越界终止，O(1)）
execute store result storage rhythm_axe:prop note_idx int 1 run scoreboard players get #vis_k editor
function rhythm_axe:editor/visual/spawn_one_ with storage rhythm_axe:prop
# 清理本次用到的 prop 键（spawn_one_/build_ 自己也会清掉它用的）
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop note_idx
