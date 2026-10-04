#arg: sp,e1,p1m,p1p,tam,tap,tbm,tbp,e2,p2m,p2p,axm,axp,aym,ayp,azm,azp,av0,av1,av2,bxm,bxp,bym,byp,bzm,bzp,bv0,bv1,bv2,md
# 面板 20「分布 / 插值填充」**前半**渲染（宏模板）：标题 ~ 行 11（模式）
#   ★ 行 12 / 13（个数 / 间隔）不在这里 —— df_render 按当前模式二选一渲染
#     （用不到的那一行**整个不输出**，后面的行会上移；不做成"空行"，空行也占一行）
# ★ 每行第 1 个元素必须是中性组件 {"text":""}（否则后面的显示项会继承根组件的 click_event）
# ★ 可点元素自带完整样式；纯显示项（数值/分隔）不许带 click_event / hover_event

# ── 标题 ──
tellraw @s [{"text":""},{"text":"===== 音符分布 / 插值填充 =====","color":"gold"}]
# ── 行 2 ──
tellraw @s [{"text":""},{"text":"── 分布：时间 ─────────────────────────","color":"gold"}]
# ── 行 3：时间 插值（单按钮循环）+ 幂次 ──
$tellraw @s [{"text":""},{"text":"插值："},$(e1),{"text":"      幂次："},$(p1m),{"text":" "},{"nbt":"editing.df.t_pow","storage":"rhythm_axe:maps.editor","color":"white"},{"text":" "},$(p1p)]
# ── 行 4：时间端点 起 / 止 ──
$tellraw @s [{"text":""},{"text":"起点："},$(tam),{"text":" "},{"nbt":"editing.df.t_a","storage":"rhythm_axe:maps.editor","color":"white"},{"text":" "},$(tap),{"text":"   终点："},$(tbm),{"text":" "},{"nbt":"editing.df.t_b","storage":"rhythm_axe:maps.editor","color":"white"},{"text":" "},$(tbp)]
# ── 行 5：端点取点按钮 ──
tellraw @s [{"text":""},{"text":"【使用首尾音符时间】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 20201"},"hover_event":{"action":"show_text","value":"起点 ← 选区最早音符的时间；终点 ← 选区最晚音符的时间"}},{"text":"  "},{"text":"【入点】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 20202"},"hover_event":{"action":"show_text","value":"起点 ← 当前播放头"}},{"text":"  "},{"text":"【出点】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 20203"},"hover_event":{"action":"show_text","value":"终点 ← 当前播放头"}}]
# ── 行 6：拆分同一刻内的音符（分布：时间 的开关；值 20200 = 行 202 列 0）──
$tellraw @s [{"text":""},{"text":"拆分同一刻内的音符："},$(sp)]
# ── 行 7 ──
tellraw @s [{"text":""},{"text":"── 分布：空间───────────────","color":"gold"}]
# ── 行 8：空间 插值（单按钮循环）+ 幂次 ──
$tellraw @s [{"text":""},{"text":"插值："},$(e2),{"text":"      幂次："},$(p2m),{"text":" "},{"nbt":"editing.df.s_pow","storage":"rhythm_axe:maps.editor","color":"white"},{"text":" "},$(p2p)]
# ── 行 9：从（X 红 / Y 绿 / Z 淡蓝，步长 0.5）──
$tellraw @s [{"text":""},{"text":"从："},$(axm),{"text":" "},$(av0),{"text":" "},$(axp),{"text":"   "},$(aym),{"text":" "},$(av1),{"text":" "},$(ayp),{"text":"   "},$(azm),{"text":" "},$(av2),{"text":" "},$(azp),{"text":"  "},{"text":"【输入数值】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 20407"},"hover_event":{"action":"show_text","value":"输入「从」的 X Y Z（空格分隔，如 1.5 -2 0）"}},{"text":"【使用首音符位置】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 20408"},"hover_event":{"action":"show_text","value":"从 ← 选区最早音符的判定位置"}}]
# ── 行 10：到 ──
$tellraw @s [{"text":""},{"text":"到："},$(bxm),{"text":" "},$(bv0),{"text":" "},$(bxp),{"text":"   "},$(bym),{"text":" "},$(bv1),{"text":" "},$(byp),{"text":"   "},$(bzm),{"text":" "},$(bv2),{"text":" "},$(bzp),{"text":"  "},{"text":"【输入数值】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 20507"},"hover_event":{"action":"show_text","value":"输入「到」的 X Y Z（空格分隔，如 1.5 -2 0）"}},{"text":"【使用尾音符位置】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 20508"},"hover_event":{"action":"show_text","value":"到 ← 选区最晚音符的判定位置"}}]
# ── 行 11 ──
tellraw @s [{"text":""},{"text":"── 填充 ─────────────────────────────","color":"gold"}]
# ── 行 12：填充模式 ──
$tellraw @s [{"text":""},{"text":"模式："},$(md)]
