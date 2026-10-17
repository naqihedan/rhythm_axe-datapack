# 编辑器判定音效播放（宏参数 cur_sound）
# storage = rhythm_axe:editor.runtime（编辑器专属，与游玩系统 rhythm_axe:runtime 互不干扰）
# 执行者 = 展示实体，位置 = 音符判定位置（~ ~ ~ 以此为准）
# ★ 玻璃（type=4）零特效：即使误入播放函数也直接 return（终极防线）
# ★ 2026-10-17：全局「击打音效」开关（options.hitsound_on）显式 0 时不播（粒子/事件不受影响）
#arg: cur_sound
execute if score @s editor_n_type matches 4 run return fail
$execute unless score hitsound_on options matches 0 if data storage rhythm_axe:editor.runtime cur_sound run $(cur_sound)
