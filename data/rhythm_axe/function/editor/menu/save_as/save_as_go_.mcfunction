#arg:mapid,cur
# 另存为新谱面：把当前工作副本复制成一张 <原mapid>_copy 的新谱面工作副本（内部 id 同步为新 mapid）
# 不落盘（不创建 maps.<原mapid>_copy）；副本标记为未保存（saved_cursor=-1，无保存基线），
# 需再点【保存谱面】才真正写入 maps.<原mapid>_copy——与新建未保存谱面一致，随后改动才算未保存
# ① 备份当前工作副本（history[$(cur)]）到独立缓冲
$data modify storage rhythm_axe:undo save_as_snap set from storage rhythm_axe:maps.editor history[$(cur)]
# ② 重置为单快照新档（丢弃原谱面的撤销/重做分支，副本是一份干净的开档内容）
data modify storage rhythm_axe:maps.editor history set value []
data modify storage rhythm_axe:maps.editor history append from storage rhythm_axe:undo save_as_snap
data remove storage rhythm_axe:undo save_as_snap
data modify storage rhythm_axe:maps.editor history_cursor set value 0
data modify storage rhythm_axe:maps.editor history_labels set value []
data modify storage rhythm_axe:maps.editor saved_cursor set value -1
scoreboard players set #history_cursor editor 0
# ③ mapid 与快照内部 id 同步为新 mapid（★ 修复：此前直接复制导致新谱面内部 id 仍是原 mapid）
$data modify storage rhythm_axe:maps.editor mapid set value "$(mapid)_copy"
$data modify storage rhythm_axe:maps.editor history[0].id set value "$(mapid)_copy"
# ④ 反馈：写入 feedback，由主菜单在十行换行后显示【编辑器】已切换编辑为 <原mapid>_copy
#    （no_undo：本操作不进撤销历史，纯文本反馈不带撤销/重做按钮）
$data modify storage rhythm_axe:maps.editor feedback set value "已切换编辑为 $(mapid)_copy"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
# 按新 mapid 重建世界音符视觉（不清播放头）
function rhythm_axe:editor/refresh
