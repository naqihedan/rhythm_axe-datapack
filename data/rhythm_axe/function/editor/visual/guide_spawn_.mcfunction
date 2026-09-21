# 生成编辑器实时预览的引导线（当前开启 note A 与紧邻下一 note B 连接）
# 依赖：build_ 已预先把 following_point 及 guide_prev 写到 rhythm_axe:prop
# 约束：仅在 type 0/1/2 且 following_point=true 时执行；否则不生成
# 生成实体：tag = editor_guide_<nid>，并写入 note_guide_a/b 便于同类 tick 逻辑复用
# 说明：这里仿照 play/note/guide/spawn 的节奏，在编辑器重建中统一生成，不依赖运行时 active_note
#arg: nid,guide_prev,guide_tp,guide_n,guide_ax,guide_ay,guide_az,guide_sx,guide_sy,guide_sz,pos_x,pos_y,pos_z

# ★ 2026-09-21 锚点：Pos 从世界原点迁到【A 端判定位置】（prop.pos_x/y/z = 本音符判定位置）
#   原因：展示实体只有落在玩家附近才会被客户端追踪更新，停在原点的实体即使区块【强加载】也不更新；
#   顺带解决「往未加载区块 summon 后选择器找不到它」的隐患（旧写法恒在 0,0,0 生成）。
#   精确 Pos 随即由 utilization/guide_anchor_set 读回（tick 写 translation 时减掉）；
#   初始 scale.z=0（不可见）：真正的几何由 guide_tick 每刻写入（编辑器每 tick 都调它）
$summon item_display $(pos_x) $(pos_y) $(pos_z) {item:{id:"minecraft:cyan_stained_glass",count:1},Tags:["editor_guide","editor_guide_$(nid)"],brightness:{block:15,sky:15},view_range:10000f,interpolation_duration:1,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.15f,0.15f,0f]}}
$execute as @e[tag=editor_guide_$(nid),type=item_display,limit=1] run scoreboard players set @s note_guide_a $(nid)
$execute as @e[tag=editor_guide_$(nid),type=item_display,limit=1] run scoreboard players set @s note_guide_b $(guide_prev)
$execute as @e[tag=editor_guide_$(nid),type=item_display,limit=1] run scoreboard players set @s note_guide_x $(guide_ax)
$execute as @e[tag=editor_guide_$(nid),type=item_display,limit=1] run scoreboard players set @s note_guide_y $(guide_ay)
$execute as @e[tag=editor_guide_$(nid),type=item_display,limit=1] run scoreboard players set @s note_guide_z $(guide_az)
$execute as @e[tag=editor_guide_$(nid),type=item_display,limit=1] run scoreboard players set @s note_guide_sx $(guide_sx)
$execute as @e[tag=editor_guide_$(nid),type=item_display,limit=1] run scoreboard players set @s note_guide_sy $(guide_sy)
$execute as @e[tag=editor_guide_$(nid),type=item_display,limit=1] run scoreboard players set @s note_guide_sz $(guide_sz)
$execute as @e[tag=editor_guide_$(nid),type=item_display,limit=1] run scoreboard players set @s note_guide_tp $(guide_tp)
$execute as @e[tag=editor_guide_$(nid),type=item_display,limit=1] run scoreboard players set @s note_guide_n $(guide_n)
# ★ 锚点（2026-09-21）：读回实体真实 Pos（×100）存 note_guide_px/py/pz
#   → guide_tick_body 写 transformation.translation 时要减掉它（translation 是【相对 Pos】的偏移）。
#   原先这里还有一段「兜底初始位置」，但其 B 端读的是 prop.pos_x（= 本音符 A 的判定位置，与 #guide_ax 同值）
#   → 中点恒 = A、长度恒 = 0、又配 scale.z=0 ⇒ 根本不可见，属死代码，已删。
$execute as @e[tag=editor_guide_$(nid),type=item_display,limit=1] run function rhythm_axe:utilization/guide_anchor_set

# 说明：引导线归属由 guide_build_for_ 决定（note_guide_a=A、note_guide_b=B）；A 未出生（或播放头未到）时
#   由 guide_tick 设 scale.z=0 隐藏，A 出现后自动显示。
