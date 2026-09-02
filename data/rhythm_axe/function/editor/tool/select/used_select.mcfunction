# 选择工具右键主入口（@s = 玩家）：两次右键循环定两角
#   第一次 定第一角 | 第二次 定第二角（生成选区+判定+高亮+填充 selection+弹已选定音符列表）后回第一角
# 位置 = 当前注视方块中心（^^^3，与音符工具游标同款）
# （操作音效由 use.mcfunction 统一播放，此处不再重复）
# 读当前注视方块中心到 prop.sx/sy/sz
function rhythm_axe:editor/tool/select/select_read_pos
# 初始化状态
execute unless data storage rhythm_axe:maps.editor select_tool run data modify storage rhythm_axe:maps.editor select_tool set value {state:0}
execute store result score #sel_state editor run data get storage rhythm_axe:maps.editor select_tool.state
# 规范化 state：旧版本残留 state=2（取消态已废弃）→ 重置为 0
execute if score #sel_state editor matches 2.. run data modify storage rhythm_axe:maps.editor select_tool.state set value 0
execute if score #sel_state editor matches 2.. run scoreboard players set #sel_state editor 0
execute if score #sel_state editor matches 0 run function rhythm_axe:editor/tool/select/select_first
execute if score #sel_state editor matches 1 run function rhythm_axe:editor/tool/select/select_second
# 清理读取临时
data remove storage rhythm_axe:prop sx
data remove storage rhythm_axe:prop sy
data remove storage rhythm_axe:prop sz
