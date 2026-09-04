# 桶排序 第5步：合并单个桶 sort_bucket[$(sort_bucket_idx)] 到 sort_sorted
# ★ 宏叶子：只处理单个下标，不递归（规避 26.x 宏递归重跑）。下标由驱动器 sort_bucket_drain_tick 写入 storage sort_bucket_idx。
# ★ 2026-09-05 append from 数组必须带 [] 后缀才会展开桶内元素（26.x 数组的数组上，[] 展开为单个音符；
#   不带 [] 则把整个桶作为单个元素追加 → sort_sorted 嵌套 → 游戏读不到）。
# 注意：空桶（扩容时建了 range 个），[] 后缀展开空数组无效果，安全
#arg: sort_bucket_idx
$execute if data storage rhythm_axe:runtime sort_bucket[$(sort_bucket_idx)] run data modify storage rhythm_axe:runtime sort_sorted append from storage rhythm_axe:runtime sort_bucket[$(sort_bucket_idx)][]
