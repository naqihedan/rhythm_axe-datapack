#arg:mapid
# ========== 编辑器入口 ==========
# 用法：function rhythm_axe:editor/editor {mapid:"xx"}
# 由玩家执行（@s 必须是玩家）
execute unless entity @s[type=player] run return fail
# ① 单人锁：若已有其他玩家在编辑 → 拒绝
execute if entity @a[tag=editor_active] unless entity @s[tag=editor_active] run tellraw @s [{"text":"[编辑器] 编辑器已被占用，请稍后再试","color":"red"}]
execute if entity @a[tag=editor_active] unless entity @s[tag=editor_active] run return fail
# ② @s 已在编辑 → 比较 mapid：相同→提示已在编辑；不同→弹切换谱面确认
$execute if entity @s[tag=editor_active] run function rhythm_axe:editor/menu/switch/switch_check {mapid:"$(mapid)"}
execute if entity @s[tag=editor_active] run return fail
# ③ 未在编辑：初始化编辑器状态（单人锁标记 + maps.editor 状态）并打开谱面
function rhythm_axe:editor/init_state
# ④ 打开谱面（不存在则以默认模板建立工作副本）
$function rhythm_axe:editor/open {mapid:"$(mapid)"}
