# 编辑器判定：寿命 → 等级（输入 #ed_life、#ed_scale；输出 #ed_level）
# 等级：0=bad 1=good_early 2=perfect_early 3=perfect 4=perfect_late 5=good_late 6=miss
# 窗口（以寿命为坐标，x = #ed_scale）：
#   bad [2x+1, 3x] / goodE [x+1, 2x] / perfectE [1, x] / PERFECT 0 / perfectL [-x, -1] / goodL [-2x, -x-1] / miss < -2x
# ★ 与游玩 play/judgement/level_from_life 是同一套边界：改一处必须同步另一处
# ★ 全部用 editor 计分板的 #ed_* 假玩家，不碰 play_state（不与游玩系统串味）
scoreboard players set #ed_level editor 6
scoreboard players operation #ed_t3 editor = #ed_scale editor
scoreboard players operation #ed_t3 editor *= 3 const
scoreboard players operation #ed_t2 editor = #ed_scale editor
scoreboard players operation #ed_t2 editor *= 2 const
scoreboard players operation #ed_t1 editor = #ed_scale editor
scoreboard players operation #ed_tn1 editor = #ed_t1 editor
scoreboard players operation #ed_tn1 editor *= -1 const
scoreboard players operation #ed_tn2 editor = #ed_t2 editor
scoreboard players operation #ed_tn2 editor *= -1 const
# 边界：bad 下界 2x+1 / goodE 下界 x+1 / goodL 上界 -x-1
scoreboard players operation #ed_b_bad_low editor = #ed_t2 editor
scoreboard players add #ed_b_bad_low editor 1
scoreboard players operation #ed_b_goode_low editor = #ed_t1 editor
scoreboard players add #ed_b_goode_low editor 1
scoreboard players operation #ed_b_goodl_high editor = #ed_tn1 editor
scoreboard players remove #ed_b_goodl_high editor 1
# 从高到低判断（life 越大越早；bad 最高）
execute if score #ed_life editor >= #ed_b_bad_low editor if score #ed_life editor <= #ed_t3 editor run scoreboard players set #ed_level editor 0
execute if score #ed_life editor >= #ed_b_goode_low editor if score #ed_life editor <= #ed_t2 editor run scoreboard players set #ed_level editor 1
execute if score #ed_life editor >= 1 const if score #ed_life editor <= #ed_t1 editor run scoreboard players set #ed_level editor 2
execute if score #ed_life editor matches 0 run scoreboard players set #ed_level editor 3
execute if score #ed_life editor >= #ed_tn1 editor if score #ed_life editor <= -1 const run scoreboard players set #ed_level editor 4
execute if score #ed_life editor >= #ed_tn2 editor if score #ed_life editor <= #ed_b_goodl_high editor run scoreboard players set #ed_level editor 5
