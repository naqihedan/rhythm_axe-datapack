# 锚点同步（由 sel_rebuild 末尾调用，见 编辑器.md《锚点》）：把锚点维护在选中集合的判定位置包围盒中心
# 铁律（用户定稿）：锚点**真值 = 实体 tag=editor_anchor 的 Pos**（不存 storage）→ 无论谁用什么方式挪它都算数；
#   实体不存在 → 按包围盒中心重建；实体位置 ≠ 当前中心（被改过）→ 打 tag editor_anchor_manual，之后不再自动跟随选区。
# 调用时机唯一（sel_rebuild 收口）：选择变化 / 编辑（commit→refresh→其末尾的 sel_rebuild）/ 重载后刷新都会走到；
#   「只动播放头」的刷新（快进快退/跳转/进度条，带 prop.refresh_skip_sel）会跳过 sel_rebuild —— 那种刷新几何没变，锚点不需要动。
#   成本 = 一次「选中数」规模的扫描（与点一次【镜像】同量级），故意不做指纹缓存（简单、不会漏）。
# 前置：prop.cursor 已指向工作副本（sel_rebuild 在删除它之前调用本函数）
# ---- ① 空选区：用不着锚点 → 清掉 ----
execute unless data storage rhythm_axe:maps.editor selection[0] run function rhythm_axe:editor/menu/note/anchor/anchor_clear
execute unless data storage rhythm_axe:maps.editor selection[0] run return 0
# ---- ② 算当前包围盒中心（#rc0/1/2）+ 读锚点状态（#an_has/#an_x/y/z）+ 判是否被改过（#an_manual）----
function rhythm_axe:editor/menu/note/anchor/anchor_center
function rhythm_axe:editor/menu/note/anchor/anchor_read
function rhythm_axe:editor/menu/note/anchor/anchor_check_manual
# ---- ③ 自动跟随：把锚点放到新中心（实体不存在时 anchor_put 会先 summon）----
execute if score #an_manual editor matches 0 run scoreboard players operation #an_tx editor = #rc0 editor
execute if score #an_manual editor matches 0 run scoreboard players operation #an_ty editor = #rc1 editor
execute if score #an_manual editor matches 0 run scoreboard players operation #an_tz editor = #rc2 editor
execute if score #an_manual editor matches 0 run function rhythm_axe:editor/menu/note/anchor/anchor_put
# 记录「本次自动摆放的位置」⇒ 下次判定的基准（不能用当前中心当基准，见 anchor_check_manual 头注释）
execute if score #an_manual editor matches 0 run function rhythm_axe:editor/menu/note/anchor/anchor_mark_auto
# ---- ④ 已被改过：位置保持不动，只补上 manual 标记（供面板按钮变蓝）+ 把发光改成蓝色（与按钮蓝色一致）----
execute if score #an_manual editor matches 1 as @e[tag=editor_anchor,type=item_display] run tag @s add editor_anchor_manual
execute if score #an_manual editor matches 1 as @e[tag=editor_anchor,type=item_display] run data modify entity @s glow_color_override set value 5592575
