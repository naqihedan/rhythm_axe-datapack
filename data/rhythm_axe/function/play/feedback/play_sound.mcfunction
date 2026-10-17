# 播放判定音效（宏参数 cur_sound）
# 执行者 = 音符交互实体，位置 = 交互实体位置（~ ~ ~ 以此为准）
# ★ 2026-10-17：全局「击打音效」开关（options.hitsound_on）显式设为 0 时不播放（粒子/事件不受影响）；
#   缺失或 1 照常播（用 unless … matches 0 而非 if matches 1，与「缺失=开」惯例一致）
#arg: cur_sound
$execute unless score hitsound_on options matches 0 if data storage rhythm_axe:runtime cur_sound run $(cur_sound)
