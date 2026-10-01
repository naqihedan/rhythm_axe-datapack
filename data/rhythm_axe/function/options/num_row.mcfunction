#arg: label, key, obj, lo, hi, st, blo, bhi
# 设置面板 · 数值行生成器（宏）：读当前值 → 生成 [-] / [+] 两个组件 → 交给 num_emit 输出整行
#   风格仿编辑器主菜单：可点 = 绿（带 click/hover），到头 / 越界 = 红（不带 click_event，点不动）
#   lo / hi = 值域闭区间；st = 步进量（只用于 hover 文案）；blo / bhi = [-] / [+] 的 trigger 值
#   ⚠ 分支端仍由 options/step 做钳制兜底（聊天栏旧行残留的按钮可能被点到）
#   ⚠ 参数经 storage rhythm_axe:op_ui 传入（不用 function 的 compound 参数）——
#     这样 check_all_panel_coverage.py 的「注入型按钮值」审计（param_keys + data modify set value <数字>）能识别到值。
scoreboard players set #sop_v menu 0
$execute store result score #sop_v menu run scoreboard players get $(key) $(obj)
# label / key / obj 已由调用方（page/pN）写进 op_ui，这里不重复写（只写两个按钮组件）
data modify storage rhythm_axe:op_ui minus set value '{"text":"[-]","color":"red"}'
$execute unless score #sop_v menu matches ..$(lo) run data modify storage rhythm_axe:op_ui minus set value '{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set $(blo)"},"hover_event":{"action":"show_text","value":"$(label) -$(st)（$(lo) ~ $(hi)）"}}'
data modify storage rhythm_axe:op_ui plus set value '{"text":"[+]","color":"red"}'
$execute unless score #sop_v menu matches $(hi).. run data modify storage rhythm_axe:op_ui plus set value '{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set $(bhi)"},"hover_event":{"action":"show_text","value":"$(label) +$(st)（$(lo) ~ $(hi)）"}}'
function rhythm_axe:options/num_emit with storage rhythm_axe:op_ui
