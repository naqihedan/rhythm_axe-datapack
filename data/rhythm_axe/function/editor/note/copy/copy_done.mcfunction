# 收集完成：按 clip_action 分流（copy=直接提示；cut=删除原音符）
execute if data storage rhythm_axe:prop {clip_action:"cut"} run function rhythm_axe:editor/note/cut/cut_remove_start
execute if data storage rhythm_axe:prop {clip_action:"copy"} run function rhythm_axe:editor/note/copy/copy_finish
