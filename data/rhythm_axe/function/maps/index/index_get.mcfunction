#arg: i
# 谱面索引取项（共享助手 / 宏叶子）：把 index[$(i)] 读进 prop.mapid。
# ★ 未命中时 index[$(i)] 不存在 ⇒ data modify set from 失败并**保留旧值** —— 所以必须先 data remove。
#   下游一律用「prop.mapid 是否存在」判断越界（存在性探测约定，见 AI常见问题）。
data remove storage rhythm_axe:prop mapid
$data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps index[$(i)]
