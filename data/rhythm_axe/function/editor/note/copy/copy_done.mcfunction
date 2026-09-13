# 收集完成：按 prop.clip_action 分流
#   copy       仅复制（提示「已复制」，不产生快照）
#   cut        剪切（复制 + 删除原音符，剪贴板保留）
#   batch_cut  批量剪切（同上，收尾多一步回原面板）
#   delete     删除（只删原音符，剪贴板由 delete_finish 还原）
# ★ 这里只判断一次；后续 remove_finish 也会按同一标志分派三种收尾。
execute if data storage rhythm_axe:prop {clip_action:"copy"} run function rhythm_axe:editor/note/copy/copy_finish
execute if data storage rhythm_axe:prop {clip_action:"cut"} run function rhythm_axe:editor/note/delete/remove_start
execute if data storage rhythm_axe:prop {clip_action:"batch_cut"} run function rhythm_axe:editor/note/delete/remove_start
execute if data storage rhythm_axe:prop {clip_action:"delete"} run function rhythm_axe:editor/note/delete/remove_start
