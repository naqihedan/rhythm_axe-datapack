# 叉号动画：4 刻内 scale → 0（消失）。
# ⚠️ 必须在「生成后第 1 刻」执行：与生成同刻的话客户端没见过初始 scale，插值不会启动（会直接跳到 0）。
data merge entity @s {interpolation_duration:4,start_interpolation:0,transformation:{scale:[0.0f,0.0f,0.0f]}}
