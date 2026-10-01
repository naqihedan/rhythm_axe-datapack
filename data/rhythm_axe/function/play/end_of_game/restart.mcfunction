# 结算界面【重新开始】：用上一局的谱面再来一局
#   mapid 从 runtime 读（结算不会清 runtime.mapid），走 start_of_game → 自带全部开局守卫
#   （已有局在跑 / 谱面不存在 / mod 未装 都会在他那里提示并拦住）
# ⚠️ 结算时 end_of_game 会逐人 `team leave`（一局打完清空名单，要重新【加入游玩】），
#   所以重开前必须把「点了这个按钮的人」自己加回队伍 —— 否则新局里没有参与者。
#   多人时其余人要自己重新【加入游玩】（本按钮只负责点击者）。
execute unless data storage rhythm_axe:runtime mapid run tellraw @s [{"text":"[结算] ","color":"gold"},{"text":"找不到上一局的谱面 id，无法重新开始","color":"gray"}]
execute unless data storage rhythm_axe:runtime mapid run return fail
team join player @s
function rhythm_axe:play/start_of_game/start_of_game with storage rhythm_axe:runtime
