# 面板 19：谱面总表（大厅）+ 排行榜页。规范 v2：
#   动态行值 = (1000+页内序)×100 + 列码（页内序 0..9；列码 0 = 行首 ▶️/⏸️ 选中+预览）⇒ 100000..100900
#   固定：11701 = 上一页 / 11702 = 下一页 / 11703 = 打开设置面板 / 11704 = 从排行榜回总表
#         11705 = 排行榜的【编辑成绩】开关
#         11801..11810 = 排行榜名次行的 [x] 删除（值 = 11800 + 名次）
#         11901/11902/11903 = 【🎮 游玩】【✏️ 编辑】【🏆 排行榜】（对「选中的谱面」生效）
#         11904 = 【＋新建谱面】（弹输入框；**不**依赖选中）
# 入口：map_list/maps/list_open 设 map_list.panel = 19（打开 / 翻页 / 重绘都会重设）。
# 入口白名单守卫（两行：先提示再 return fail）
execute unless score #menu_value menu matches 11701 unless score #menu_value menu matches 11702 unless score #menu_value menu matches 11703 unless score #menu_value menu matches 11704 unless score #menu_value menu matches 11705 unless score #menu_value menu matches 11801..11810 unless score #menu_value menu matches 11901..11904 unless score #menu_value menu matches 100000..100909 run function rhythm_axe:map_list/wrong_panel
execute unless score #menu_value menu matches 11701 unless score #menu_value menu matches 11702 unless score #menu_value menu matches 11703 unless score #menu_value menu matches 11704 unless score #menu_value menu matches 11705 unless score #menu_value menu matches 11801..11810 unless score #menu_value menu matches 11901..11904 unless score #menu_value menu matches 100000..100909 run return fail

# —— 排行榜的【编辑成绩】/【完成编辑】（切换全局 map_list.lb_edit，然后重绘排行榜）——
execute if score #menu_value menu matches 11705 run function rhythm_axe:map_list/lb/toggle_edit
execute if score #menu_value menu matches 11705 run return 0

# —— 操作行：对「选中的谱面」操作（11901 游玩 / 11902 编辑 / 11903 排行榜）——
execute if score #menu_value menu matches 11901 run scoreboard players set #sel_act menu 1
execute if score #menu_value menu matches 11902 run scoreboard players set #sel_act menu 2
execute if score #menu_value menu matches 11903 run scoreboard players set #sel_act menu 3
execute if score #menu_value menu matches 11901..11903 run function rhythm_axe:map_list/sel/act
execute if score #menu_value menu matches 11901..11903 run return 0

# —— 11904【＋新建谱面】：弹输入框（不需要先选中谱面）——
execute if score #menu_value menu matches 11904 run return run function rhythm_axe:map_list/maps/new_ask

# —— 排行榜名次行 [x]：删除该名次的成绩（值 = 11800 + 名次 ⇒ 下标 = 值 - 11801）——
# 实际是谁由渲染快照 rhythm_axe:lb.rows 决定（不重算排名）
execute if score #menu_value menu matches 11801..11810 run scoreboard players operation #lb_slot menu = #menu_value menu
execute if score #menu_value menu matches 11801..11810 run scoreboard players remove #lb_slot menu 11801
execute if score #menu_value menu matches 11801..11810 run execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #lb_slot menu
execute if score #menu_value menu matches 11801..11810 run function rhythm_axe:map_list/lb/del_ask with storage rhythm_axe:prop
execute if score #menu_value menu matches 11801..11810 run data remove storage rhythm_axe:prop i

execute if score #menu_value menu matches 11801..11810 run return 0

# 固定控件
execute if score #menu_value menu matches 11701 run function rhythm_axe:map_list/maps/page_prev
execute if score #menu_value menu matches 11702 run function rhythm_axe:map_list/maps/page_next
# 11703：【设置】—— 直接打开设置面板（options/main 自己会设 map_list.panel = 22，总表随之被替换掉）
execute if score #menu_value menu matches 11703 run return run function rhythm_axe:options/main
# 11704：【返回总表】—— 从排行榜页面回到总表（列码 5 的排行榜是聊天栏就地输出，不占页面号）
execute if score #menu_value menu matches 11704 run function rhythm_axe:map_list/maps/list_open

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
# 列码 0 = 行首 ▶️/⏸️：选中这张谱面 + 切换预览（全局状态；点击者面板立刻重绘）
#   注意：sel/select 内部会再跑一次 list_open（重绘），本函数收尾的 prop 清理不影响它
execute if score #menu_value menu matches 100000..100909 if score #ml_tcol menu matches 0 run function rhythm_axe:map_list/sel/select with storage rhythm_axe:prop
# 其它列码 / 该行已不存在 → 兜底
execute if score #menu_value menu matches 100000..100909 unless score #ml_tcol menu matches 0 run function rhythm_axe:map_list/wrong_panel
# 清理临时键
execute if score #menu_value menu matches 100000..100909 run data remove storage rhythm_axe:prop i
execute if score #menu_value menu matches 100000..100909 run data remove storage rhythm_axe:prop mapid
