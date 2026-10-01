# 换行扫描：游标 +1，写回 prop 后递归扫描；扫到串尾就结束
# 见 map_title_nl_scan 的文件头说明（为什么不用 `if data` 通配）
scoreboard players add #title_nl_i editor 1
scoreboard players add #title_nl_j editor 1
execute store result storage rhythm_axe:prop title_nl_i int 1 run scoreboard players get #title_nl_i editor
execute store result storage rhythm_axe:prop title_nl_j int 1 run scoreboard players get #title_nl_j editor
execute if score #title_nl_i editor < #title_nl_len editor run function rhythm_axe:editor/menu/map/ops/map_title_nl_scan with storage rhythm_axe:prop
