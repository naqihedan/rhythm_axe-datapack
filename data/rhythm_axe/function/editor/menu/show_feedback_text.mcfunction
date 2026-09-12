#arg:fb
# 纯文本反馈（无撤销/重做按钮）：用于不产生撤销/重做的操作（保存、改名、设置暂存等）
# 带 prop.fb_count 时在文案后追加 " N 个音符"（用于批量复制等数量反馈）
$execute unless data storage rhythm_axe:prop fb_count run tellraw @s [{"text":"[编辑器] ","color":"yellow"},{"text":"$(fb)","color":"yellow"}]
$execute if data storage rhythm_axe:prop fb_count run tellraw @s [{"text":"[编辑器] ","color":"yellow"},{"text":"$(fb) ","color":"yellow"},{"score":{"name":"#fb_count","objective":"editor"},"color":"white"},{"text":" 个音符","color":"yellow"}]
