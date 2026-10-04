#arg: dp,ds,rd,rs,rf
# 面板 20 后半渲染（宏模板）：行 14 ~ 行 19，接在 df_row_cnt / df_row_stp 之后
#   ★ 行 12/13（个数 / 间隔）由 df_render 按模式二选一渲染，不在本模板里
# ★ 每行第 1 个元素必须是中性组件 {"text":""}
$tellraw @s [{"text":""},{"text":"允许一刻内填充多个音符："},$(dp)]
$tellraw @s [{"text":""},{"text":"填充后选中头尾+新音符："},$(ds)]
tellraw @s [{"text":""},{"text":"── 执行 ─────────────────────────────","color":"gold"}]
$tellraw @s [{"text":""},$(rd),{"text":"  "},$(rs)]
$tellraw @s [{"text":""},$(rf),{"text":"  "},{"text":"【返回】","color":"dark_aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 21103"},"hover_event":{"action":"show_text","value":"返回来源列表（不修改任何数据）"}}]
