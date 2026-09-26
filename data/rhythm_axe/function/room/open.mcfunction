#arg: mapid
# 房间页（菜单系统页面 21）入口：大厅总表行【游玩】在「在线玩家 >= 2」时转到这里（@s = 点击者）。
# 房间 = 开局前的名单确认页：列出在线玩家的加入状态，点【加入游玩】把自己算进本局名单。
#   名单本体就是 vanilla 队伍 `player`（游玩侧一切只对 @a[team=player] 生效），本页只是它的 UI。
#   人数上限 player_count **只做显示**（不足黄 / 正好绿 / 超过红），不拦开局（2026-09-26 用户定）。
# 校验口径与 start_of_game 一致：谱面存在 + 没有正在运行的谱面
$execute unless data storage rhythm_axe:maps.$(mapid) id run tellraw @s [{"text":"[房间] ","color":"gold"},{"text":"找不到谱面 ","color":"gray"},{"text":"$(mapid)","color":"gold"},{"text":"，无法开始游戏","color":"gray"}]
$execute unless data storage rhythm_axe:maps.$(mapid) id run return fail
execute if score is_running play_state matches 1 run tellraw @s [{"text":"[房间] ","color":"gold"},{"text":"已有谱面正在运行，无法开始。请先执行 /function rhythm_axe:play/end_of_game/stop","color":"gray"}]
execute if score is_running play_state matches 1 run return fail
# 房间状态（与谱面总表共用 rhythm_axe:map_list 这一个菜单层存储）
data modify storage rhythm_axe:map_list open set value 1b
data modify storage rhythm_axe:map_list panel set value 21
$data modify storage rhythm_axe:map_list room_mapid set value "$(mapid)"
# trigger 需对本人启用（后进服玩家兜底）
scoreboard players enable @s menu_click
# 开房的人**自动加入名单**（2026-09-26 用户定：点【游玩】的人就是要玩的）；已在名单里就不重复
execute unless entity @s[team=player] run tellraw @s [{"text":"[房间] ","color":"gold"},{"text":"已自动把你加入本局名单（不想玩点【退出游玩】）","color":"gray"}]
execute unless entity @s[team=player] run team join player @s
# 广播重绘：**向所有人**（含编辑器里的人）渲染房间页
function rhythm_axe:room/render_all
