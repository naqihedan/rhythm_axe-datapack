import math
import os

# 写入到脚本自身所在目录
script_dir = os.path.dirname(os.path.abspath(__file__))
output_path = os.path.join(script_dir, "init_trig_table.mcfunction")

with open(output_path, "w", encoding="utf-8") as f:
    # 先清空旧表
    f.write('data modify storage display_animation:trig_table trig set value []\n')
    total = 0
    # 角度从 0 到 36000，步长 10（即 0.1°）
    for angle in range(0, 36001, 10):
        rad = math.radians(angle / 100)
        sin_val = int(round(math.sin(rad) * 10000))
        cos_val = int(round(math.cos(rad) * 10000))
        f.write(
            f'data modify storage display_animation:trig_table trig append value {{sin:{sin_val}, cos:{cos_val}}}\n'
        )
        total += 1
    # 调试提示
    f.write(
        'execute if score debug_output options matches 1.. run tellraw @a '
        f'[{{"text":"[调试.lv1]","color":"gray"}},{{"text":" 三角函数表已生成（{total}项）","color":"green"}}]\n'
    )

print(f"Done! Trig table with {total} entries (0-360°) written to {output_path}")