# 工具选项栏 · 检测入口（@s = 玩家；每刻由 tick.mcfunction 对 editor_active 玩家调用）
#
# 功能：把编辑工具"放进副手" = 打开该工具的选项栏（对副手工具本来就没法右键使用，等于换了个手势）。
#   ① 检测副手有编辑工具（editor_tool:true）
#   ② 把工具换回主手、主手原物品换回副手（= 撤销这一次换手）
#   ③ 打开该工具所属分组的选项栏（面板 23）
#
# ★ 门控 editor_active：退出编辑器后编辑工具会残留在背包里，不该再触发。
# ★ 防死循环：主手也持工具（双手都是工具）时**不处理** —— 否则换手后副手又出现工具，会逐刻反复触发。
#   （正常情况：副手是空/非工具，换手后副手自然变回非工具，不会重复触发。）
execute unless entity @s[tag=editor_active] run return fail
execute unless items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run return fail
execute if items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] run return fail

# 先判定分组（此刻工具还在副手），再换手，最后开面板
function rhythm_axe:editor/tool/offhand/group
function rhythm_axe:editor/tool/offhand/swap
function rhythm_axe:editor/tool/offhand/open
