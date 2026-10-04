# 设置面板渲染（@s = 查看者）。布局：清屏 → 标题 → 本页设置行 → 页脚
#   页号 = @s 自己的 options_page（0=游玩 / 1=模组 / 2=编辑器 / 3=高级），钳到 [0,3]。
#   页脚有两态：正常（翻页 / 收起 / 恢复默认）/ 【恢复默认】待确认（警告 + 确认恢复 / 取消）。
#   渲染全是 tellraw @s（只发给本次的 @s）⇒ 不做广播；每人点开各自一份。
data modify storage rhythm_axe:map_list panel set value 22
scoreboard players enable @s menu_click
function rhythm_axe:editor/menu/clear_lines

# —— 页号兜底 + 钳制（0=游玩 / 1=模组 / 2=编辑器 / 3=高级）——
scoreboard players add @s options_page 0
execute if score @s options_page matches ..-1 run scoreboard players set @s options_page 0
execute if score @s options_page matches 4.. run scoreboard players set @s options_page 3
scoreboard players set #op_page menu 0
execute store result score #op_page menu run scoreboard players get @s options_page
scoreboard players operation #op_page_show menu = #op_page menu
scoreboard players add #op_page_show menu 1

# —— 标题（一行金色粗体，沿用最初版本的写法）——
tellraw @s [{"text":"====  节奏地图设置 Rhythm axe Options  ====","color":"gold","bold":true}]

# —— 本页设置行（p0~p3；每行由 options/num_row、options/bool_row 生成）——
execute if score #op_page menu matches 0 run function rhythm_axe:options/page/p0
execute if score #op_page menu matches 1 run function rhythm_axe:options/page/p1
execute if score #op_page menu matches 2 run function rhythm_axe:options/page/p2
execute if score #op_page menu matches 3 run function rhythm_axe:options/page/p3

# —— 页脚：翻页 + 收起 + 恢复默认（行 160）——
#   ★ 2026-09-30：【恢复默认】加了二次确认（照编辑器「删除谱面」的做法）——
#   点【恢复默认】(16004) 只进入待确认状态（map_list.reset_confirm）并重绘，
#   确认态下页脚换成醒目警告 + 【确认恢复】(16005) / 【取消】(16006)。
execute if data storage rhythm_axe:map_list reset_confirm run tellraw @s [{"text":"【警告】","color":"dark_red","bold":true},{"text":"恢复默认会把所有设置重置为初始值，且不可撤销！","color":"red","bold":true}]
execute if data storage rhythm_axe:map_list reset_confirm run tellraw @s [{"text":""},{"text":"【确认恢复】","color":"red","bold":true,"click_event":{"action":"run_command","command":"/trigger menu_click set 16005"},"hover_event":{"action":"show_text","value":"确认：把所有设置重置为初始值"}},{"text":"  ","color":"red","bold":true},{"text":"【取消】","color":"green","bold":true,"click_event":{"action":"run_command","command":"/trigger menu_click set 16006"},"hover_event":{"action":"show_text","value":"取消，不修改任何设置"}}]
#   ★ 2026-09-30：页脚最后那个按钮**按页不同** —— 模组页（页 1）= 【关闭所有模组】(16007)、
#   其它页 = 【恢复默认】(16004)。所以页脚拆成「公共部分 foot_head（用 extra 包成一个组件）」
#   +「最后按钮 foot_tail」，交给宏叶子 footer_emit 输出（两个参数经 storage op_ui 传）。
execute unless data storage rhythm_axe:map_list reset_confirm run data modify storage rhythm_axe:op_ui foot_head set value '{"text":"","extra":[{"text":"【上一页】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set 16001"},"hover_event":{"action":"show_text","value":"上一页（页号循环 0/1/2/3）"}},{"text":"  "},{"score":{"name":"#op_page_show","objective":"menu"},"color":"white"},{"text":"/","color":"gray"},{"text":"4","color":"white"},{"text":"  【下一页】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set 16002"},"hover_event":{"action":"show_text","value":"下一页（页号循环 0/1/2/3）"}},{"text":"    "},{"text":"【收起】","color":"gray","click_event":{"action":"run_command","command":"/trigger menu_click set 16003"},"hover_event":{"action":"show_text","value":"收起设置面板（旧按钮失效）"}},{"text":"  "}]}'
execute unless data storage rhythm_axe:map_list reset_confirm run data modify storage rhythm_axe:op_ui foot_tail set value '{"text":"【恢复默认】","color":"red","click_event":{"action":"run_command","command":"/trigger menu_click set 16004"},"hover_event":{"action":"show_text","value":"把所有设置重置为初始值（需再次确认）"}}'
execute unless data storage rhythm_axe:map_list reset_confirm if score #op_page menu matches 1 run data modify storage rhythm_axe:op_ui foot_tail set value '{"text":"【关闭所有模组】","color":"red","click_event":{"action":"run_command","command":"/trigger menu_click set 16007"},"hover_event":{"action":"show_text","value":"把 mods 计分板上所有模组开关置 0（当前只有自动模式）"}}'
execute unless data storage rhythm_axe:map_list reset_confirm run function rhythm_axe:options/footer_emit with storage rhythm_axe:op_ui
