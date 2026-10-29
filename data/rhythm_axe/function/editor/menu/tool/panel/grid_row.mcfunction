#arg:g0,g1,g2,g3
# 网格尺寸行（面板 23 行 224）· 宏叶子
#   参数经 storage rhythm_axe:prop 传入：g0..g3 = 已构好的 4 个按钮 JSON（g0=0.1 / g1=0.25 / g2=0.5 / g3=1）
#   ★ 不能写成 tellraw 的 {"storage":...} 组件 —— 那会把 SNBT 字符串原样打印出来，必须用宏嵌入
$tellraw @s [{"text":""},{"text":"网格尺寸：","color":"white"},$(g0),{"text":" "},$(g1),{"text":" "},$(g2),{"text":" "},$(g3)]
# 末行为空行（与其它分区保持一致的视觉间隔）
tellraw @s [{"text":""}]