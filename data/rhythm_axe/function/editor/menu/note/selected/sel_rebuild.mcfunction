# 重建 selection：遍历 notes，收集带 selected:1b 的音符 id（按 notes 顺序，天然有序）
# ★ selected 标记存音符元素（storage，不随 refresh/重载丢失）；idx/time 变化不影响（选中跟音符走，顺序跟 notes 走）
# ★ 2026-09-14：不再调 sel_rebuild_len 取数组长度（`data get ... notes` 会把 976 音符整表序列化 ≈260KB）；
#   改为用 sel_rebuild_probe 逐个探测元素存在性来终止遍历。
data modify storage rhythm_axe:maps.editor selection set value []
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
scoreboard players set #sel_has editor 1
scoreboard players set #sel_i editor 0
function rhythm_axe:editor/menu/note/selected/sel_rebuild_drive
# ★ 2026-09-17 锚点：选区重建后同步「镜像/旋转中心」锚点（中心 = 选中判定位置的包围盒中心；被手动改过则不再跟随）
#   必须在删掉 prop.cursor 之前调用（锚点的兜底扫描要用它找音符下标）
function rhythm_axe:editor/menu/note/anchor/anchor_sync
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop i
data remove storage rhythm_axe:prop nid
data remove storage rhythm_axe:prop selnote
