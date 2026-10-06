#arg:slot
# @s = 玩家；$(slot) = 目标槽位。
# 站立 = 【播放/暂停】+「蹲下播放以添加记录点」
# 蹲下 = 【添加/删除记录点】+「下次暂停会回到记录点，在记录点处蹲下右键删除记录点」
# 蹲下状态由 tool_regular_apply 统一写入 #tool_sneak；此处只在该槽 state 与目标不符时重写，避免每刻重写。
# 前置：由 tool_regular_slot 确认该槽是编辑工具。
# 名字前的空格 = 提示栏像素宽 ÷ 4（空格 4px、中文 9px）⇒ 物品切换弹窗里主名称居中。
$execute if score #tool_sneak editor matches 0 unless items entity @s $(slot) *[custom_data~{editor_tool_state:0}] run function rhythm_axe:editor/tool/tool_pp_write {slot:"$(slot)",name:"                         【播放/暂停】",hint:"蹲下播放以添加记录点",state:0}
$execute if score #tool_sneak editor matches 1 unless items entity @s $(slot) *[custom_data~{editor_tool_state:1}] run function rhythm_axe:editor/tool/tool_pp_write {slot:"$(slot)",name:"                                                          【添加/删除记录点】",hint:"下次暂停会回到记录点，在记录点处蹲下右键删除记录点",state:1}
