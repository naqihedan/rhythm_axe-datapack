# 【粘贴并选中】：粘贴剪贴板到播放头 + 清空原选区 + 把粘贴出来的音符设为选中（核心，两个面板共用）
#   ★ 与「批量粘贴」的唯一区别：粘贴时带 prop.paste_select → paste_apply_* 给新音符打 selected:1b
#   ★ 清空选中放在 paste 之前 → 落在 paste 的 begin/commit 快照里（撤销可一并还原原选区与粘贴）
#   ★ selection/黄光不用自己刷：paste 末尾的 refresh 内部会 sel_rebuild + sel_glow 补光
function rhythm_axe:editor/menu/note/selected/sel_clear_all_visual
data modify storage rhythm_axe:prop paste_select set value 1b
execute store result storage rhythm_axe:prop time int 1 run scoreboard players get #playhead editor
function rhythm_axe:editor/note/paste/paste
data remove storage rhythm_axe:prop time
data remove storage rhythm_axe:prop paste_select
# refresh 已重建 selection；这里补 #sel_count（面板底部按钮的启用条件靠它）
execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
