#arg:nid
# 命中音符：给它的交互实体打「已选中」标记（与框选 select_inter 收尾一致，供右键取消单个选中判定）
# 实体不存在（音符未出生/已消失）时选择器空匹配，无副作用
$tag @e[type=interaction,tag=editor_n_$(nid)] add editor_note_selected
