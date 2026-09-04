#arg:cursor,note_index
# 收集游标：note_ids 遍历完 → 结束；否则查找下一个 id
$execute unless data storage rhythm_axe:prop note_ids[$(note_index)] run function rhythm_axe:editor/note/copy/copy_done
# ★ 终止分支必须 return 0（否则 copy_done 后继续执行剩余行 → 游标+1 → 无限递归 → 200000 超限）
$execute unless data storage rhythm_axe:prop note_ids[$(note_index)] run return 0
$execute if data storage rhythm_axe:prop note_ids[$(note_index)] run function rhythm_axe:editor/note/copy/copy_one_find with storage rhythm_axe:prop
