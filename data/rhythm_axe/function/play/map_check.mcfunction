# 谱面格式校验（雏形版；口径 = 只警告、不阻止开局 —— 方案 B）
# 调用：play/start_of_game/start（谱面已 merge 到 rhythm_axe:runtime、写入 mapid 之后，
#   且必须早于 spawn_x/y/z 的兜底 —— 否则第 ④ 条"teleport 为真但缺 spawn_x"判不出来）
# 范围：只做 O(1) 的根级检查。逐音符检查（必填字段 / 升序 / time 越界）需要遍历，
#   而本库"宏叶子逐下标"≈1ms/个 → 700+ 音符会让开局明显卡顿，故留给后续"完整校验"
#   （分刻处理或离线脚本）。规则来源：节奏地图开发文档/谱面格式校验.md（error 级）
# 输出：每条问题一行（黄标题 + 红描述）；末尾汇总计数；0 问题且 debug_output>=1 时输出"通过"

scoreboard players set #mc_problem play_state 0

# ① 结束点 end_time：缺失 → 主循环不会自动结束（只能手动 stop）
execute unless data storage rhythm_axe:runtime end_time run tellraw @a [{"text":"[谱面校验] ","color":"yellow"},{"text":"未定义 end_time（结束点）：谱面不会自动结束，需手动 /function rhythm_axe:play/end_of_game/stop","color":"red"}]
execute unless data storage rhythm_axe:runtime end_time run scoreboard players add #mc_problem play_state 1

# ② 时间点 timing_points：缺失/空 → tick rate 与判定缩放无法确定
execute unless data storage rhythm_axe:runtime timing_points[0].time run tellraw @a [{"text":"[谱面校验] ","color":"yellow"},{"text":"缺少 timing_points（时间点）：tick rate 与判定缩放无法确定","color":"red"}]
execute unless data storage rhythm_axe:runtime timing_points[0].time run scoreboard players add #mc_problem play_state 1

# ③ 音符 notes：缺失/空 → 空谱面（无判定、无结算内容）
execute unless data storage rhythm_axe:runtime notes[0].id run tellraw @a [{"text":"[谱面校验] ","color":"yellow"},{"text":"谱面没有任何音符","color":"red"}]
execute unless data storage rhythm_axe:runtime notes[0].id run scoreboard players add #mc_problem play_state 1

# ④ 出生点：teleport 为真但缺 spawn_x/y/z → 兜底 0.0 会把玩家传到原点附近
#    （#mc_tp / #mc_spawn 都先清零再统计，防上一局残留）
scoreboard players set #mc_tp play_state 0
execute if data storage rhythm_axe:runtime teleport run execute store result score #mc_tp play_state run data get storage rhythm_axe:runtime teleport
scoreboard players set #mc_spawn play_state 0
execute unless data storage rhythm_axe:runtime spawn_x run scoreboard players add #mc_spawn play_state 1
execute unless data storage rhythm_axe:runtime spawn_y run scoreboard players add #mc_spawn play_state 1
execute unless data storage rhythm_axe:runtime spawn_z run scoreboard players add #mc_spawn play_state 1
execute if score #mc_tp play_state matches 1 if score #mc_spawn play_state matches 1.. run tellraw @a [{"text":"[谱面校验] ","color":"yellow"},{"text":"teleport 为真，但 spawn_x/y/z 缺 ","color":"red"},{"score":{"objective":"play_state","name":"#mc_spawn"},"color":"red"},{"text":" 项：玩家会被传送到原点附近","color":"red"}]
execute if score #mc_tp play_state matches 1 if score #mc_spawn play_state matches 1.. run scoreboard players add #mc_problem play_state 1

# 汇总：有问题 → 计数 + 说明本轮仍继续（方案 B）；无问题 → 仅 debug_output>=1 输出
execute if score #mc_problem play_state matches 1.. run tellraw @a [{"text":"[谱面校验] ","color":"yellow"},{"text":"发现 ","color":"gold"},{"score":{"objective":"play_state","name":"#mc_problem"},"color":"gold"},{"text":" 个问题；本轮仍会照常开局（请对照 谱面格式校验.md 修正）","color":"gray"}]
execute if score #mc_problem play_state matches 0 if score debug_output options matches 1.. run tellraw @a [{"text":"[调试.lv1][谱面校验] ","color":"gray"},{"text":"谱面基础检查通过","color":"green"}]

# 扩展位（后续"完整校验"，需遍历 → 建议分刻或离线脚本）：
#   音符必填字段 id/type/time、time 升序、time<0 或 > end_time、type 越界 0..4、
#   size/note_base_life/duration/density 越界、混凝土/玻璃 color 越界 1..16、
#   时间点/事件点 time 重复或越界
