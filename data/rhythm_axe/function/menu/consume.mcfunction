# 菜单系统（聊天栏菜单 UI，独立于编辑器与游玩系统）：点击分发。
#   @s = 点击者；由 tick.mcfunction 检测 @a[scores={menu_click=1..}] 调用。
#   与 editor/menu/consume 完全分开：菜单按钮发 menu_click，编辑器按钮发 editor_click，两套互不干扰。
# 页面号存 rhythm_axe:map_list.panel（19 = 谱面总表；规划中 20 = 难度选择）。
execute store result score #menu_value menu run scoreboard players get @s menu_click
scoreboard players reset @s menu_click
scoreboard players enable @s menu_click
# 统一操作反馈音（与编辑器点击同款）
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1
# 没有菜单开着 → 静默忽略（旧聊天行里残留的按钮点不动）
execute unless data storage rhythm_axe:map_list {open:1b} run return fail
scoreboard players set #menu_panel menu 0
execute store result score #menu_panel menu run data get storage rhythm_axe:map_list panel
execute if score #menu_panel menu matches 19 run return run function rhythm_axe:map_list/panel/panel19
function rhythm_axe:map_list/wrong_panel
