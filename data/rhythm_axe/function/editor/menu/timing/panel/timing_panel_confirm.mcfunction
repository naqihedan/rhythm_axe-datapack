# 确认时间点修改：把暂存 editing.temp 写回工作副本（一次历史快照，可撤销）
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "修改时间点"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set from storage rhythm_axe:maps.editor editing.ref
# ★ 必须在写回之前捕获旧 bpm/tpb：写回会先 remove 原元素再按新 time 重插，之后再问「旧值」就没了。
function rhythm_axe:editor/timing/rescale/ctx_old with storage rhythm_axe:prop
function rhythm_axe:editor/menu/timing/panel/timing_panel_confirm_ with storage rhythm_axe:prop
# ★ 时间点改 tpb 的同步缩放（2026-10-29），锚点与边界都按**写回后**的数组重新定位：
#   · 锚 a = 暂存里的新 time（用户可能同时拖了时间，用旧起点会错位）
#   · 边界 b = 写回后第一个 time > a 的时间点（insert_find 的等值靠后语义正好给出）
#   tpb 未变 / 开关全关时 rescale/run 自己静默返回。
function rhythm_axe:editor/timing/rescale/ctx_new
function rhythm_axe:editor/timing/rescale/run
# ★ #rs_own = 1 ⇒ 缩放链路已接管：遍历跨 tick，commit 必须等遍历跑完（rescale/finish_next 里做），
#   此处不能 commit，否则快照只记到「时间点改了但音符还没缩」的中间态。
execute unless score #rs_own editor matches 1 run function rhythm_axe:editor/file/commit
# ★ 时间点改动本身不重建音符（2026-10-02），但 rescale 改过 notes[] 时必须重建世界视觉
execute unless score #rs_own editor matches 1 run function rhythm_axe:editor/timing/rescale/refresh_guard
function rhythm_axe:editor/judge/scale_sync
data modify storage rhythm_axe:maps.editor feedback set value "已修改时间点"
data remove storage rhythm_axe:maps.editor editing
# ★ #rs_own=1 ⇒ 缩放分刻还在跑，prop.cursor 是它的运行期参数（notes_leaf 的宏参数）
#   必须在 rescale/finish_next 里清，此处**不能**删 —— 否则宏实例化失败 ⇒ 遍历不收敛、死循环。
execute unless score #rs_own editor matches 1 run data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop tmp_elem
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
# ★ 2026-09-12：列表渲染推迟到下一 tick（列表渲染是 O(谱长) 两遍遍历，与主操作分开跑）
schedule function rhythm_axe:editor/menu/timing/list/timing_list_open_next 1t
