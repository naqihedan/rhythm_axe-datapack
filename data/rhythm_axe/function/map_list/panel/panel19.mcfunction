# 面板 19：谱面总表（大厅）。规范 v2：
#   动态行值 = (1000+页内序)×100 + 列码（页内序 0..9；列码 1 = 游玩 / 3 = 编辑）⇒ 100001..100903
#   固定：11701 = 上一页 / 11702 = 下一页
# 入口：map_list/maps/list_open 设 map_list.panel = 19（打开 / 翻页 / 重绘都会重设）。
# 入口白名单守卫（两行：先提示再 return fail）
execute unless score #menu_value menu matches 11701 unless score #menu_value menu matches 11702 unless score #menu_value menu matches 100000..100909 run function rhythm_axe:map_list/wrong_panel
execute unless score #menu_value menu matches 11701 unless score #menu_value menu matches 11702 unless score #menu_value menu matches 100000..100909 run return fail

# 固定控件
execute if score #menu_value menu matches 11701 run function rhythm_axe:map_list/maps/page_prev
execute if score #menu_value menu matches 11702 run function rhythm_axe:map_list/maps/page_next

# —— 动态行（值 = 100000 + 页内序×100 + 列码，页内序 0..9）——
# 页号（0 基）= **点击者自己的** menu_page（与 list_open 写的是同一处；每人独立 ⇒ 行值解析不会串页）
scoreboard players add @s menu_page 0
scoreboard players set #ml_page menu 0
execute store result score #ml_page menu run scoreboard players get @s menu_page
# 列码 #ml_tcol = (click - 100000) % 100
execute if score #menu_value menu matches 100000..100909 run scoreboard players operation #ml_tcol menu = #menu_value menu
execute if score #menu_value menu matches 100000..100909 run scoreboard players remove #ml_tcol menu 100000
execute if score #menu_value menu matches 100000..100909 run scoreboard players operation #ml_tcol menu %= 100 const
# 页内序 #ml_row = (click - 100000) / 100
execute if score #menu_value menu matches 100000..100909 run scoreboard players operation #ml_row menu = #menu_value menu
execute if score #menu_value menu matches 100000..100909 run scoreboard players remove #ml_row menu 100000
execute if score #menu_value menu matches 100000..100909 run scoreboard players operation #ml_row menu /= 100 const
# 真实下标 #ml_i = 页号×每页行数(10) + 页内序
execute if score #menu_value menu matches 100000..100909 run scoreboard players operation #ml_i menu = #ml_page menu
execute if score #menu_value menu matches 100000..100909 run scoreboard players operation #ml_i menu *= 10 const
execute if score #menu_value menu matches 100000..100909 run scoreboard players operation #ml_i menu += #ml_row menu
# 取 index[#ml_i] → prop.mapid（越界则无键 → 下面两个分支都不会命中，落到 wrong_panel）
execute if score #menu_value menu matches 100000..100909 run execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #ml_i menu
execute if score #menu_value menu matches 100000..100909 run function rhythm_axe:maps/index/index_get with storage rhythm_axe:prop
# 列码 1 = 游玩
execute if score #menu_value menu matches 100000..100909 if score #ml_tcol menu matches 1 run function rhythm_axe:map_list/maps/play with storage rhythm_axe:prop
# 列码 3 = 编辑
execute if score #menu_value menu matches 100000..100909 if score #ml_tcol menu matches 3 run function rhythm_axe:map_list/maps/edit with storage rhythm_axe:prop
# 其它列码 / 该行已不存在 → 兜底
execute if score #menu_value menu matches 100000..100909 unless score #ml_tcol menu matches 1 unless score #ml_tcol menu matches 3 run function rhythm_axe:map_list/wrong_panel
# 清理临时键
execute if score #menu_value menu matches 100000..100909 run data remove storage rhythm_axe:prop i
execute if score #menu_value menu matches 100000..100909 run data remove storage rhythm_axe:prop mapid
