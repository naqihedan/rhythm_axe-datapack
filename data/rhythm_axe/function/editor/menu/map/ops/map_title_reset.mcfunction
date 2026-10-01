# 行114 列码03【重置谱面标题】的**执行端**（2026-10-01）
# 调用链：11403 → map_title_reset_ask（弹原生确认框）→ 点【重置】→ **本函数**；点【取消】→ map_title_reset_cancel
# 用途：标题存了无法正常解析的内容时（表现 = 主菜单 / bossbar / 谱面设置面板里找不到标题行，
#       因为那一行的 tellraw JSON 被注入的坏组件整条破坏），重置成必然能正常显示的占位。
# 只改暂存副本 panel_temp：需点【保存设置】才写回谱面。
data modify storage rhythm_axe:maps.editor panel_temp.title set value "(无标题)"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
data modify storage rhythm_axe:maps.editor feedback set value "已重置谱面标题（保存设置后生效）"
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
