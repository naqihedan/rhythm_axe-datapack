#arg:cursor,list_name,i
# 二分探测宏叶子（只读一个元素；不递归 / 不 return）
# 元素存在 → #ins_ex=1 且 #ins_t = 该元素 time；不存在（越界）→ #ins_ex=0
# ★ 用 store success 一次同时得到「存在与否」+ 值（1 条宏命令 / 次；旧实现每元素要 3~4 条）
$execute store success score #ins_ex editor run execute store result score #ins_t editor run data get storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(i)].time
