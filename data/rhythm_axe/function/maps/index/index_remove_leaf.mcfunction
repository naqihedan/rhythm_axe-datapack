#arg: i, old_id
# 索引出队叶子（宏，单步不递归）：index[$(i)] == old_id ⇒ 删除该项并置 #idx_stop=1
# ★ 删完立即停（#idx_stop=1）：删除会让后面元素下标前移，继续扫会漏判
$data modify storage rhythm_axe:prop probe set from storage rhythm_axe:maps index[$(i)]
$execute if data storage rhythm_axe:prop {probe:"$(old_id)"} run data remove storage rhythm_axe:maps index[$(i)]
$execute if data storage rhythm_axe:prop {probe:"$(old_id)"} run scoreboard players set #idx_stop editor 1
