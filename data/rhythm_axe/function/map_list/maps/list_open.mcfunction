# 谱面总表渲染（面板 19）
# 布局：清屏 → 标题 → 本页最多 10 行（{标题} - {作者}【游玩】【编辑】{mapid}）→ 页脚（翻页）
# 前置：rhythm_axe:maps.index 已就绪（map_list/open 里先跑 index_sync）；@s = 查看者。
# 分页：每页 10 行，页号 0 基存 rhythm_axe:map_list.page；行按钮值为**页内相对**（规范 v2，(1000+页内序)×100+列码），
#       所以页码不进值、翻页只改 storage —— 同一套行值跨页复用。
data modify storage rhythm_axe:map_list panel set value 19
function rhythm_axe:editor/menu/clear_lines

# —— 数量与页数 ——
# 注：索引只有几十个短 id，整表 `data get` 的开销可忽略（与 notes 那种上千长元素列表不同）
scoreboard players set #ml_total menu 0
execute store result score #ml_total menu run data get storage rhythm_axe:maps index
scoreboard players operation #ml_pages menu = #ml_total menu
scoreboard players add #ml_pages menu 9
scoreboard players operation #ml_pages menu /= 10 const
execute if score #ml_pages menu matches 0 run scoreboard players set #ml_pages menu 1

# —— 页号钳制到 [0, 页数-1]（索引缩水后可能越界） ——
scoreboard players set #ml_page menu 0
execute store result score #ml_page menu run data get storage rhythm_axe:map_list page
execute if score #ml_page menu matches ..-1 run scoreboard players set #ml_page menu 0
execute if score #ml_page menu >= #ml_pages menu run scoreboard players operation #ml_page menu = #ml_pages menu
execute if score #ml_page menu >= #ml_pages menu run scoreboard players remove #ml_page menu 1
execute store result storage rhythm_axe:map_list page int 1 run scoreboard players get #ml_page menu
scoreboard players operation #ml_page_show menu = #ml_page menu
scoreboard players add #ml_page_show menu 1
# 是否有上/下一页
scoreboard players set #ml_has_prev menu 0
scoreboard players set #ml_has_next menu 0
execute if score #ml_page menu matches 1.. run scoreboard players set #ml_has_prev menu 1
scoreboard players operation #ml_next_max menu = #ml_pages menu
scoreboard players remove #ml_next_max menu 1
execute if score #ml_page menu < #ml_next_max menu run scoreboard players set #ml_has_next menu 1

# —— 标题 + 本页行 ——
tellraw @s [{"text":"====  节奏地图谱面总表 Rhythm axe Maps  ====","color":"gold","bold":true}]
scoreboard players set #ml_row menu 0
scoreboard players operation #ml_i menu = #ml_page menu
scoreboard players operation #ml_i menu *= 10 const
function rhythm_axe:map_list/maps/list_drive
execute if score #ml_total menu matches 0 run tellraw @s [{"text":"（还没有任何谱面：先在编辑器里创建并保存一张，再回到这里）","color":"gray","italic":true}]

# —— 页脚（4 版：上一页 可用/禁用 × 下一页 可用/禁用）——
# ★ 2026-09-19 配色对齐事件列表翻页行：可用 = green（带 click/hover）、禁用 = red（不带 click）、
#   中间页码「1/2 共6张谱面」= 数字 white / 分隔（/、共、单位）gray。
execute if score #ml_has_prev menu matches 1 if score #ml_has_next menu matches 1 run tellraw @s [{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set 11701"},"hover_event":{"action":"show_text","value":"上一页"}},{"text":" ","color":"white"},{"score":{"name":"#ml_page_show","objective":"menu"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#ml_pages","objective":"menu"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#ml_total","objective":"menu"},"color":"white"},{"text":"张谱面","color":"gray"},{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set 11702"},"hover_event":{"action":"show_text","value":"下一页"}}]
execute if score #ml_has_prev menu matches 1 if score #ml_has_next menu matches 0 run tellraw @s [{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set 11701"},"hover_event":{"action":"show_text","value":"上一页"}},{"text":" ","color":"white"},{"score":{"name":"#ml_page_show","objective":"menu"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#ml_pages","objective":"menu"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#ml_total","objective":"menu"},"color":"white"},{"text":"张谱面","color":"gray"},{"text":" 【下一页】","color":"red"}]
execute if score #ml_has_prev menu matches 0 if score #ml_has_next menu matches 1 run tellraw @s [{"text":"【上一页】","color":"red"},{"text":" ","color":"white"},{"score":{"name":"#ml_page_show","objective":"menu"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#ml_pages","objective":"menu"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#ml_total","objective":"menu"},"color":"white"},{"text":"张谱面","color":"gray"},{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set 11702"},"hover_event":{"action":"show_text","value":"下一页"}}]
execute if score #ml_has_prev menu matches 0 if score #ml_has_next menu matches 0 run tellraw @s [{"text":"【上一页】","color":"red"},{"text":" ","color":"white"},{"score":{"name":"#ml_page_show","objective":"menu"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#ml_pages","objective":"menu"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#ml_total","objective":"menu"},"color":"white"},{"text":"张谱面","color":"gray"},{"text":" 【下一页】","color":"red"}]

# —— 清理临时 prop 键 ——
data remove storage rhythm_axe:prop i
data remove storage rhythm_axe:prop row
data remove storage rhythm_axe:prop mapid
data remove storage rhythm_axe:prop title
data remove storage rhythm_axe:prop src
data remove storage rhythm_axe:prop artist
data remove storage rhythm_axe:prop title_comp
data remove storage rhythm_axe:prop play_val
data remove storage rhythm_axe:prop edit_val
