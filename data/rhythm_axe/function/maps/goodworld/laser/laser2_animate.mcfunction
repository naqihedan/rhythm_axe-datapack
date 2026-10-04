# 激光2 动画：在 6 刻内把光束沿 -z 平移 10 格（18.5 → 8.5）。
# ⚠️ 必须在「召唤后第 1 刻」执行：与召唤同刻的话客户端没见过初始状态，插值不会启动（会直接跳到终点）。
data merge entity @s {\
    interpolation_duration:6,start_interpolation:0,\
    transformation:{\
        left_rotation: [0.5f, 0.5f, -0.5f, 0.5f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], \
        scale:[9.0f, 0.1f, 3.0f], translation:[0.0f,0.0f,-70.0f]\
        }\
    }
