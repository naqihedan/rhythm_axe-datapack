#arg:s0,s1,s2,s3
# 选择工具网格尺寸行（面板 23 行 225）· 宏叶子
#   参数经 storage rhythm_axe:prop 传入：s0..s3 = 已构好的 4 个按钮 JSON（s0=0.1 / s1=0.25 / s2=0.5 / s3=1）
#   ★ 不能用 tellraw 的 {"storage":...} 组件 —— 会把 SNBT 字符串原样打印，必须用宏嵌入
$tellraw @s [{"text":""},{"text":"网格尺寸：","color":"white"},$(s0),{"text":" "},$(s1),{"text":" "},$(s2),{"text":" "},$(s3)]
tellraw @s [{"text":""}]