# 谱面总表渲染（面板 19）
# 布局：清屏 → 标题 → 本页最多 10 行（{标题} - {作者}【游玩】【编辑】{mapid}）→ 页脚（翻页）
# 前置：rhythm_axe:maps.index 已就绪（map_list/open 里先跑 index_sync）；@s = 查看者。
# 分页：每页 10 行，页号 0 基存**玩家自己的 `menu_page` 计分项**（2026-09-26 改：原来存全局
#       rhythm_axe:map_list.page ⇒ 多人同时在大厅时，别人翻页会改掉我的页）；行按钮值为**页内相对**
#       （规范 v2，(1000+页内序)×100+列码），所以页码不进值、翻页只改自己的计分项 —— 同一套行值跨页复用。
data modify storage rhythm_axe:map_list panel set value 19
# 视图标记（共享大厅）：告诉同步逻辑“这个人正在看总表”（见 map_list/sync_list）
#   切到总表就不再算“在看排行榜”，两个标记互斥
tag @s add maplist_view
tag @s remove lb_view
function rhythm_axe:editor/menu/clear_lines

# —— 数量与页数 ——
# 注：索引只有几十个短 id，整表 `data get` 的开销可忽略（与 notes 那种上千长元素列表不同）
scoreboard players set #ml_total menu 0
execute store result score #ml_total menu run data get storage rhythm_axe:maps index
scoreboard players operation #ml_pages menu = #ml_total menu
scoreboard players add #ml_pages menu 9
scoreboard players operation #ml_pages menu /= 10 const
execute if score #ml_pages menu matches 0 run scoreboard players set #ml_pages menu 1

# —— 页号钳制到 [0, 页数-1]（页号 = 本玩家自己的 menu_page；索引缩水后可能越界） ——
scoreboard players add @s menu_page 0
scoreboard players set #ml_page menu 0
execute store result score #ml_page menu run scoreboard players get @s menu_page
execute if score #ml_page menu matches ..-1 run scoreboard players set #ml_page menu 0
execute if score #ml_page menu >= #ml_pages menu run scoreboard players operation #ml_page menu = #ml_pages menu
execute if score #ml_page menu >= #ml_pages menu run scoreboard players remove #ml_page menu 1
scoreboard players operation @s menu_page = #ml_page menu
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
execute if score #ml_total menu matches 0 run tellraw @s [{"text":"（还没有任何谱面：点下方【＋新建谱面】开始）","color":"gray","italic":true}]

# —— 操作行（对「选中的谱面」生效）——
# 选中 = 行首 ▶️（选中行会缩进）；未选中时三个按钮变红、不可点（鼠标提示告诉你先选歌）
# 值：11901 游玩 / 11902 编辑 / 11903 排行榜（行 119，列码 01/02/03）
#    11904【＋新建谱面】—— 不依赖选中，总是绿色可点（2026-10-01 新增）
execute unless data storage rhythm_axe:map_list sel run tellraw @s [{"text":"【🎮 游玩】","color":"red"},{"text":"【✏ 编辑】","color":"red"},{"text":"【🏆 排行榜】","color":"red"},{"text":"【＋新建谱面】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set 11904"},"hover_event":{"action":"show_text","value":"输入一个 id，新建谱面并进入编辑器"}},{"text":"    "},{"text":"（先点行首 ▶ 选中一张谱面）","color":"gray","italic":true}]
execute if data storage rhythm_axe:map_list sel run tellraw @s [{"text":"【🎮 游玩】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set 11901"},"hover_event":{"action":"show_text","value":"开始游玩选中的谱面"}},{"text":"【✏ 编辑】","color":"aqua","click_event":{"action":"run_command","command":"/trigger menu_click set 11902"},"hover_event":{"action":"show_text","value":"进入编辑器编辑选中的谱面"}},{"text":"【🏆 排行榜】","color":"yellow","click_event":{"action":"run_command","command":"/trigger menu_click set 11903"},"hover_event":{"action":"show_text","value":"查看选中谱面的玩家排行榜（前 10 名）"}},{"text":"【＋新建谱面】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set 11904"},"hover_event":{"action":"show_text","value":"输入一个 id，新建谱面并进入编辑器"}}]

# —— 页脚（4 版：上一页 可用/禁用 × 下一页 可用/禁用）——
# ★ 2026-09-19 配色对齐事件列表翻页行：可用 = green（带 click/hover）、禁用 = red（不带 click）、
#   中间页码「1/2 共6张谱面」= 数字 white / 分隔（/、共、单位）gray。
execute if score #ml_has_prev menu matches 1 if score #ml_has_next menu matches 1 run tellraw @s [{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set 11701"},"hover_event":{"action":"show_text","value":"上一页"}},{"text":" ","color":"white"},{"score":{"name":"#ml_page_show","objective":"menu"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#ml_pages","objective":"menu"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#ml_total","objective":"menu"},"color":"white"},{"text":"张谱面","color":"gray"},{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set 11702"},"hover_event":{"action":"show_text","value":"下一页"}}]
execute if score #ml_has_prev menu matches 1 if score #ml_has_next menu matches 0 run tellraw @s [{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set 11701"},"hover_event":{"action":"show_text","value":"上一页"}},{"text":" ","color":"white"},{"score":{"name":"#ml_page_show","objective":"menu"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#ml_pages","objective":"menu"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#ml_total","objective":"menu"},"color":"white"},{"text":"张谱面","color":"gray"},{"text":" 【下一页】","color":"red"}]
execute if score #ml_has_prev menu matches 0 if score #ml_has_next menu matches 1 run tellraw @s [{"text":"【上一页】","color":"red"},{"text":" ","color":"white"},{"score":{"name":"#ml_page_show","objective":"menu"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#ml_pages","objective":"menu"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#ml_total","objective":"menu"},"color":"white"},{"text":"张谱面","color":"gray"},{"text":" 【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set 11702"},"hover_event":{"action":"show_text","value":"下一页"}}]
execute if score #ml_has_prev menu matches 0 if score #ml_has_next menu matches 0 run tellraw @s [{"text":"【上一页】","color":"red"},{"text":" ","color":"white"},{"score":{"name":"#ml_page_show","objective":"menu"},"color":"white"},{"text":"/","color":"gray"},{"score":{"name":"#ml_pages","objective":"menu"},"color":"white"},{"text":" 共","color":"gray"},{"score":{"name":"#ml_total","objective":"menu"},"color":"white"},{"text":"张谱面","color":"gray"},{"text":" 【下一页】","color":"red"}]

# —— 设置入口（全局设置面板；值 11703 = 页脚行 117 + 列码 3）——
tellraw @s [{"text":"【设置】","color":"aqua","click_event":{"action":"run_command","command":"/trigger menu_click set 11703"},"hover_event":{"action":"show_text","value":"打开节奏地图设置（游玩 / 模组 / 编辑器 / 高级）"}}]

# —— 清理临时 prop 键 ——
data remove storage rhythm_axe:prop i
data remove storage rhythm_axe:prop row
data remove storage rhythm_axe:prop mapid
data remove storage rhythm_axe:prop title
data remove storage rhythm_axe:prop artist
data remove storage rhythm_axe:prop charter
data remove storage rhythm_axe:prop src
data remove storage rhythm_axe:prop title_comp
data remove storage rhythm_axe:prop ind
data remove storage rhythm_axe:prop pv_val
data remove storage rhythm_axe:prop pv_icon
data remove storage rhythm_axe:prop pv_color
data remove storage rhythm_axe:prop src
data remove storage rhythm_axe:prop artist
data remove storage rhythm_axe:prop title_comp
data remove storage rhythm_axe:prop play_val
data remove storage rhythm_axe:prop edit_val
