# 编辑器判定音效播放（宏参数 cur_sound）
# storage = rhythm_axe:editor.runtime（编辑器专属，与游玩系统 rhythm_axe:runtime 互不干扰）
# 执行者 = 展示实体，位置 = 音符判定位置（~ ~ ~ 以此为准）
# ★ 玻璃（type=4）零特效：即使误入播放函数也直接 return（终极防线）
#arg: cur_sound
execute if score @s editor_n_type matches 4 run return fail
$execute if data storage rhythm_axe:editor.runtime cur_sound run playsound $(cur_sound) master @a ~ ~ ~ 1 1
