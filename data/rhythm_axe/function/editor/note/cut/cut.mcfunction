# 剪切入口：复制入口的薄封装（clip_action="cut" → 复制后删除原音符）
data modify storage rhythm_axe:maps.editor op_label set value "剪切音符"
data modify storage rhythm_axe:prop clip_action set value "cut"
function rhythm_axe:editor/note/copy/copy
