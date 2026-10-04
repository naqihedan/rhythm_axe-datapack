#arg:cursor,rm_i
# 批量重排·移出叶子：把 notes[$(rm_i)] 复制到 prop.move_out 末尾，再从数组里删掉
#   ★ 由驱动器按下标**降序**调用 ⇒ 前面的下标始终有效，不需要重扫/重算
#   ★ 与 move_out_drive / move_in_drive 配套；用途：时间轴翻转、批量改判定时间后的重排
#     （替代 editor/util/order_repair 的相邻交换冒泡：后者代价 = 逆序数 ≈ N²/2、
#      实测每步 ≈80 条命令 ⇒ 一条链（上限 100 万）最多 ≈1.2 万步，大平移必爆链）
$data modify storage rhythm_axe:prop move_out append from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(rm_i)]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(rm_i)]
