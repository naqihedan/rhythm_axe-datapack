# 计算单个音符的出生时刻并更新 #earliest_birth
# 出生时刻完全自动计算（不再支持指定 birth_time）：
#   ignore_note_speed=true：出生 = time - note_base_life（忽略流速）
#   否则：出生 = time - note_base_life×16/note_speed
#arg: scan_idx
$execute store result score #tmp_birth play_state run data get storage rhythm_axe:runtime notes[$(scan_idx)].time
$execute store result score #tmp_life play_state run data get storage rhythm_axe:runtime notes[$(scan_idx)].note_base_life
# ignore_note_speed=true：出生 = time - 基础寿命（不乘流速）；否则 = time - 基础寿命×16/流速
# ★ 2026-09-04 修复：按值判断 ignore_note_speed（存在但为 0b 也算不忽略，随流速缩放）
scoreboard players set #ig_on play_state 0
$execute store result score #ig_on play_state run data get storage rhythm_axe:runtime notes[$(scan_idx)].ignore_note_speed
execute if score #ig_on play_state matches 1 run scoreboard players operation #tmp_birth play_state -= #tmp_life play_state
execute if score #ig_on play_state matches 0 run scoreboard players operation #tmp_life play_state *= 16 const
execute if score #ig_on play_state matches 0 run scoreboard players operation #tmp_life play_state /= note_speed options
execute if score #ig_on play_state matches 0 run scoreboard players operation #tmp_birth play_state -= #tmp_life play_state
# ★ 2026-08-29 线性音符出生提前 DELAY(4) 刻：把客户端插值延迟挪到出生前（不可见前置），
#   可见移动占满 note_base_life → 速度 = dist/note_base_life（不再因延迟变快）；寿命随后在 summon +4 保持节拍
$execute store result score #tmp_type play_state run data get storage rhythm_axe:runtime notes[$(scan_idx)].type
$execute store result score #tmp_pow play_state run data get storage rhythm_axe:runtime notes[$(scan_idx)].anim_power
$execute unless data storage rhythm_axe:runtime notes[$(scan_idx)].anim_power run scoreboard players set #tmp_pow play_state 1
# 普通 0/1/2 线性（power=1）
execute if score #tmp_type play_state matches 0..2 if score #tmp_pow play_state matches 1 run scoreboard players remove #tmp_birth play_state 4
# 玻璃 4 线性（power=1 且 duration>=1；缺省 duration=3）
$execute if score #tmp_type play_state matches 4 if score #tmp_pow play_state matches 1 unless data storage rhythm_axe:runtime notes[$(scan_idx)].duration run scoreboard players set #tmp_dur play_state 3
$execute if score #tmp_type play_state matches 4 if score #tmp_pow play_state matches 1 if data storage rhythm_axe:runtime notes[$(scan_idx)].duration run execute store result score #tmp_dur play_state run data get storage rhythm_axe:runtime notes[$(scan_idx)].duration
execute if score #tmp_type play_state matches 4 if score #tmp_pow play_state matches 1 if score #tmp_dur play_state matches 1.. run scoreboard players remove #tmp_birth play_state 4
# ★ 2026-10-20 线性混凝土出生提前 2 刻：段① merge 延迟链（出生→计数 2→merge）恰好落在编辑器出生刻，
#   段①插值时长不再需要 -2 补偿（旧补偿在持续时长 1/2 时撞 min 1 下限 → 短混凝土全程晚 2 刻，goodworld 实测错位根因）；
#   寿命由 summon +2 保持判定节拍（life=0 仍在判定时刻）。非线性混凝土不提前（每刻直写无延迟链）
execute if score #tmp_type play_state matches 3 if score #tmp_pow play_state matches 1 run scoreboard players remove #tmp_birth play_state 2
execute if score #tmp_birth play_state < #earliest_birth play_state run scoreboard players operation #earliest_birth play_state = #tmp_birth play_state
# 把该音符的出生时刻存入 _birth（供排序与生成直接读取，运行期字段）
$execute store result storage rhythm_axe:runtime notes[$(scan_idx)]._birth int 1 run scoreboard players get #tmp_birth play_state
