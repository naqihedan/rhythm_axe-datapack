# 播放判定音效（宏参数 cur_sound）
# 执行者 = 音符交互实体，位置 = 交互实体位置（~ ~ ~ 以此为准）
#arg: cur_sound
$execute if data storage rhythm_axe:runtime cur_sound run playsound $(cur_sound) master @a ~ ~ ~ 1 1
