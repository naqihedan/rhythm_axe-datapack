# 删除完成收尾（唯一尾部）：按 prop.clip_action 分派到各操作的收尾（各收尾自己负责 commit + refresh）
# ★ 不要写成「先执行某收尾、再判断 clip_action 决定要不要 return」——收尾函数会清掉 clip_action，
#   那种守卫会在执行后失效并掉进下一个分支（曾导致【批量删除】误报「已剪切 N 个音符」）。
execute if data storage rhythm_axe:prop {clip_action:"delete"} run function rhythm_axe:editor/note/delete/delete_finish
execute if data storage rhythm_axe:prop {clip_action:"cut"} run function rhythm_axe:editor/note/cut/cut_finish
execute if data storage rhythm_axe:prop {clip_action:"batch_cut"} run function rhythm_axe:editor/note/cut/batch_cut_finish
