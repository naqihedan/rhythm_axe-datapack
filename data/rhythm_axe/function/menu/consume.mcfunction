# 菜单系统（聊天栏菜单 UI，独立于编辑器与游玩系统）：点击分发。
#   @s = 点击者；由 tick.mcfunction 检测 @a[scores={menu_click=1..}] 调用。
#   与 editor/menu/consume 完全分开：菜单按钮发 menu_click，编辑器按钮发 editor_click，两套互不干扰。
# 分发按**值所属号段**（19 = 谱面总表 / 21 = 房间页；20 留给难度选择）；map_list.panel 仍会写，但不参与分发。
execute store result score #menu_value menu run scoreboard players get @s menu_click
scoreboard players reset @s menu_click
scoreboard players enable @s menu_click
# 统一操作反馈音（与编辑器点击同款）
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1
# 没有菜单开着 → 静默忽略（旧聊天行里残留的按钮点不动）
execute unless data storage rhythm_axe:map_list {open:1b} run return fail
# 分发：按**值所属号段**（每个页面有独立号段，值即归属）
# ★ 2026-09-26 改：原来按全局 map_list.panel 分发 ⇒ A 打开房间页（panel=21）后，B（正在看谱面总表）
#   点自己的按钮也会被路由到 21 → 提示「该按钮不属于当前面板」。改成按值段分发后：
#   房间页能**广播给所有人**，各人点各自的按钮都按值对号入座，互不影响。
execute if score #menu_value menu matches 100000..100909 run return run function rhythm_axe:map_list/panel/panel19
execute if score #menu_value menu matches 11701..11702 run return run function rhythm_axe:map_list/panel/panel19
execute if score #menu_value menu matches 12101..12104 run return run function rhythm_axe:room/panel/panel21
function rhythm_axe:map_list/wrong_panel
