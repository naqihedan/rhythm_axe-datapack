# 四舍五入 #atan_deg100（度×100）到整度（round to nearest 100）
# ★ 2026-08-31 新增：仅用于音符实体视觉朝向（Rotation）写入前——atan2 整数有理近似误差 ~0.3%，
#   近轴方向（如本应 180°）得到 179.76，长混凝土条远端偏移肉眼可见 → 四舍五入到整度消除。
# ⚠ 不要对引导线逐帧角度 / 混凝土判定 marker 探测方向使用（它们需要逐度精度）。
# 就地修改 #atan_deg100。
scoreboard players operation #round_t display_calc = #atan_deg100 display_calc
execute if score #round_t display_calc matches ..-1 run scoreboard players operation #round_t display_calc *= -1 const
scoreboard players add #round_t display_calc 50
scoreboard players operation #round_t display_calc /= 100 const
scoreboard players operation #round_t display_calc *= 100 const
execute if score #atan_deg100 display_calc matches ..-1 run scoreboard players operation #round_t display_calc *= -1 const
scoreboard players operation #atan_deg100 display_calc = #round_t display_calc
