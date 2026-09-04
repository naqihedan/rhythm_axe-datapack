# 桶排序 第4步续（宏叶子）：把 notes[$(sort_i)] 整个音符对象 append 进桶 sort_bucket[$(sort_off)]
# ★ 2026-09-05 宏叶子：只入桶，不递归（不调 fill/drain；递归交给普通驱动器 sort_bucket_fill）。
#   遍历/推进由 sort_bucket_fill 负责；本函数只处理单个音符。
#arg: sort_i, sort_off
# 整个音符对象 append 进桶
$execute if data storage rhythm_axe:runtime notes[$(sort_i)]._birth run data modify storage rhythm_axe:runtime sort_bucket[$(sort_off)] append from storage rhythm_axe:runtime notes[$(sort_i)]
