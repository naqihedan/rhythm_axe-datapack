# 复制完成：走反馈系统（纯文本 + 数量，无撤销按钮），由重开列表时 show_feedback 渲染
execute store result score #copy_count editor run data get storage rhythm_axe:maps.editor clipboard.notes
data modify storage rhythm_axe:maps.editor feedback set value "已复制"
scoreboard players operation #fb_count editor = #copy_count editor
data modify storage rhythm_axe:prop fb_count set value 1b
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/note/copy/clip_cleanup
