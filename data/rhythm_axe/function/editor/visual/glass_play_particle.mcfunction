# 玻璃专用击打粒子播放（绕开 play_particle 的「玻璃零反馈」终极防线）
# 粒子表存完整指令 ⇒ 直接宏执行；执行者 = 玻璃展示实体，位置 = 采样命中点
#arg: cur_particle
$execute if data storage rhythm_axe:editor.runtime cur_particle run $(cur_particle)
