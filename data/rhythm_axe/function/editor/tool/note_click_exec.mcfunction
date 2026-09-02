# 被左键点击的音符交互实体（@s = 实体）
# 清除 attack.player，防止残留匹配（修复「点第二个音符误触第一个」的 bug）
data remove entity @s attack
execute if score debug_output options matches 1.. run tellraw @a[tag=editor_active] [{"text":"[调试.lv1][左键]","color":"gray"},{"text":" 匹配到并清除 attack，进行选中/打开","color":"green"}]
# 选中 / 打开编辑面板（现有分发逻辑：已选中→打开面板；未选中→选中+打开列表）
function rhythm_axe:editor/tool/note_click_do_
