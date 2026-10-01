#arg:key,mapid
# 输出第二层：按 key 取名字/分数/血量（名字分数交 out_c，评级与颜色交 decorate）
# ★ 同时把「这一行是谁」按名次顺序追加进渲染快照 rhythm_axe:lb.rows ——
#   [x] 删除按钮带的就是名次，靠快照回查 key（不重算排名，避免榜单变了删错人）。
$data modify storage rhythm_axe:lb rows append value {key:"$(key)", mapid:"$(mapid)"}
$data modify storage rhythm_axe:prop name set from storage rhythm_axe:scores $(key).$(mapid).name
$execute store result storage rhythm_axe:prop score int 1 run data get storage rhythm_axe:scores $(key).$(mapid).score
# 血量（旧数据没有该字段 ⇒ 先删掉防残留，再读；读失败保持缺失 → decorate 走白字）
data remove storage rhythm_axe:prop health
$execute store result storage rhythm_axe:prop health int 1 run data get storage rhythm_axe:scores $(key).$(mapid).health
