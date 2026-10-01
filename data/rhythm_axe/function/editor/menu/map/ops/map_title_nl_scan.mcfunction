#arg:title_nl_i,title_nl_j
# 换行扫描（专用叶子，勿复用；由 editor/menu/map/ops/map_title_display_copy 调用）
# 输入：rhythm_axe:prop.title_nl_cand = 待检查的字符串；title_nl_i/title_nl_j = 当前 1 字符子串下标 [i, j)
# 输出：命中换行 → #title_nl 置 0（循环随即停止；调用方用 #title_nl = 0 判「含换行」）
# ★ 为什么这么绕（2026-10-01 实测）：26.2 的 `execute if data` 字符串模式**不支持 * 通配**，
#   只有精确匹配生效（`{s:"A*"}` `{s:"*B*"}` 全部不命中）⇒「找某个字符」只能靠
#   `set string` 取 1 字符子串 + 精确匹配（同 utilization/title_comp 取首字符的手法）。
$data modify storage rhythm_axe:prop title_nl_ch set string storage rhythm_axe:prop title_nl_cand $(title_nl_i) $(title_nl_j)
execute if data storage rhythm_axe:prop {title_nl_ch:"\n"} run scoreboard players set #title_nl editor 0
execute if score #title_nl editor matches 1 run function rhythm_axe:editor/menu/map/ops/map_title_nl_step
