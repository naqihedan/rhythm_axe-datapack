#arg: key, obj, blo
# 设置面板 · 布尔行生成器（宏）：开 = 绿、关 = 灰（两态都可点，与编辑器主菜单一致）
#   先写「关」再按分值覆盖 ⇒ 计分项缺失时也不会误显示为「开」
#   参数经 storage rhythm_axe:op_ui 传入（同 num_row，便于审计脚本识别注入型按钮值）
#   obj = 计分板名（普通设置 = options；模组开关 = mods），必须由调用方写入
#   label 由调用方写入 op_ui（本函数不用），由 bool_emit 读出
scoreboard players set #sop_v menu 0
$execute store result score #sop_v menu run scoreboard players get $(key) $(obj)
$data modify storage rhythm_axe:op_ui val set value '{"text":"【关】","color":"gray","click_event":{"action":"run_command","command":"/trigger menu_click set $(blo)"},"hover_event":{"action":"show_text","value":"点击开启"}}'
$execute if score #sop_v menu matches 1 run data modify storage rhythm_axe:op_ui val set value '{"text":"【开】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set $(blo)"},"hover_event":{"action":"show_text","value":"点击关闭"}}'
function rhythm_axe:options/bool_emit with storage rhythm_axe:op_ui
