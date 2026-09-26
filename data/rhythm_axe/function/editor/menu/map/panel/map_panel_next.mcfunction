# 谱面设置面板「下一刻渲染」包装（跨刻安全调用 map_panel）
# ★ 为什么需要它：`schedule` 拉起时执行者是**服务端**（没有 @s），而 map_panel 里全是 tellraw @s；
#   任何被 schedule 的渲染函数都必须先用本包装切回「正在用编辑器的玩家」（同 editor/menu/main_next）。
# ★ 2026-09-14 修复（用户实测：从别的面板触发后谱面设置面板里的标题等字段全空）：
#   panel_temp 已初始化（有 title）→ 只重渲染，保留未保存的暂存编辑；
#   未初始化 → 走 map_panel_open 重建 panel_temp（否则渲染出来全是空字段）。
# 协作：只作用于「本次操作者」（原理同其它 _next 包装；其余成员由 clear_lines 广播重绘）
execute as @a[tag=editor_lock_holder,limit=1] if data storage rhythm_axe:maps.editor panel_temp.title run function rhythm_axe:editor/menu/map/panel/map_panel_refresh
execute as @a[tag=editor_lock_holder,limit=1] unless data storage rhythm_axe:maps.editor panel_temp.title run function rhythm_axe:editor/menu/map/panel/map_panel_open
execute unless entity @a[tag=editor_lock_holder] as @a[tag=editor_active,limit=1] if data storage rhythm_axe:maps.editor panel_temp.title run function rhythm_axe:editor/menu/map/panel/map_panel_refresh
execute unless entity @a[tag=editor_lock_holder] as @a[tag=editor_active,limit=1] unless data storage rhythm_axe:maps.editor panel_temp.title run function rhythm_axe:editor/menu/map/panel/map_panel_open
