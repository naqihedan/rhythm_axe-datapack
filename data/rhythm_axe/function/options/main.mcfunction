# 设置面板入口：/function rhythm_axe:options/main   （@s = 打开者，必须是玩家）
#
# 定位：菜单系统（菜单层）页面 22，与编辑器（editor_click）、游玩系统并列，三套互不干扰。
#   按钮走 trigger menu_click → tick.mcfunction → 分发层 rhythm_axe:menu/consume → 本面板。
# 状态：与谱面总表/房间页**共用同一个菜单会话** rhythm_axe:map_list（open / panel = 22）。
#   页号不存 storage —— 存**玩家自己的** options_page 计分项（每人独立 ⇒ 多人同开互不干扰，同谱面总表的 menu_page）。
# 底层设置项仍是 options 计分板（不搬 storage），见《设置.md》。
execute unless entity @s[type=player] run return fail
# trigger 需对本人启用（reload 时 load 已 enable @a，这里兜底：后进服的玩家也能点）
scoreboard players enable @s menu_click
# ★ 2026-10-01 打开设置 = 离开共享大厅视图（别人切歌时不再把总表/排行榜刷到他这里）
function rhythm_axe:map_list/view_clear
data modify storage rhythm_axe:map_list open set value 1b
data modify storage rhythm_axe:map_list panel set value 22
# 清掉上一次可能残留的【恢复默认】待确认状态（每次打开都从未确认态开始）
data remove storage rhythm_axe:map_list reset_confirm
function rhythm_axe:options/render
