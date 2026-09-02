# 生成编辑器实时预览的引导线（当前开启 note A 与紧邻下一 note B 连接）
# 依赖：build_ 已预先把 following_point 及 guide_prev 写到 rhythm_axe:prop
# 约束：仅在 type 0/1/2 且 following_point=true 时执行；否则不生成
# 生成实体：tag = editor_guide_<nid>，并写入 note_guide_a/b 便于同类 tick 逻辑复用
# 说明：这里仿照 play/note/guide/spawn 的节奏，在编辑器重建中统一生成，不依赖运行时 active_note
#arg: nid,guide_prev,guide_tp,guide_n,guide_ax,guide_ay,guide_az,guide_sx,guide_sy,guide_sz

# 前一个音符判定位置（build_ 已从 guide_prev 读出并 /10 → ×100）
$summon item_display 0.0 0.0 0.0 {item:{id:"minecraft:cyan_stained_glass",count:1},Tags:["editor_guide","editor_guide_$(nid)"],brightness:{block:15,sky:15},view_range:10000f,interpolation_duration:1,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.15f,0.15f,0.01f]}}
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
# 生成后立即写一个非 0 初始位置（A=前判定点 ×100, B=当前音符判定位置 ×100；后续 guide_tick 用实时 B 覆盖）
# ★ 兜底：即使 guide_tick 因某端数据缺失未写，线也不会停在原点，便于确认是哪端读不到
# ★ 修复：宏 guide_ax/ay/az 必须先写入 scoreboard #guide_ax/ay/az，否则兜底中点 #gmx=(#guide_ax+#gbx)/2 会因 #guide_ax=0 而错成 A 位置的一半
$scoreboard players set #guide_ax editor $(guide_ax)
$scoreboard players set #guide_ay editor $(guide_ay)
$scoreboard players set #guide_az editor $(guide_az)
execute store result score #gbx editor run data get storage rhythm_axe:prop pos_x 100
execute store result score #gby editor run data get storage rhythm_axe:prop pos_y 100
execute store result score #gbz editor run data get storage rhythm_axe:prop pos_z 100
scoreboard players operation #gmx editor = #guide_ax editor
scoreboard players operation #gmx editor += #gbx editor
scoreboard players operation #gmx editor /= 2 const
scoreboard players operation #gmy editor = #guide_ay editor
scoreboard players operation #gmy editor += #gby editor
scoreboard players operation #gmy editor /= 2 const
scoreboard players operation #gmz editor = #guide_az editor
scoreboard players operation #gmz editor += #gbz editor
scoreboard players operation #gmz editor /= 2 const
scoreboard players operation #gdx editor = #gbx editor
scoreboard players operation #gdx editor -= #guide_ax editor
scoreboard players operation #gdy editor = #gby editor
scoreboard players operation #gdy editor -= #guide_ay editor
scoreboard players operation #gdz editor = #gbz editor
scoreboard players operation #gdz editor -= #guide_az editor
scoreboard players operation #gh2 display_calc = #gdx editor
scoreboard players operation #gh2 display_calc *= #gdx editor
scoreboard players operation #ghz display_calc = #gdz editor
scoreboard players operation #ghz display_calc *= #gdz editor
scoreboard players operation #gh2 display_calc += #ghz display_calc
scoreboard players operation #gd2 display_calc = #gh2 display_calc
scoreboard players operation #gt2 display_calc = #gdy editor
scoreboard players operation #gt2 display_calc *= #gdy editor
scoreboard players operation #gd2 display_calc += #gt2 display_calc
scoreboard players operation #sqrt_sq display_calc = #gd2 display_calc
function rhythm_axe:utilization/math/sqrt
scoreboard players operation #ggd display_calc = #sqrt_out display_calc
$data modify entity @e[tag=editor_guide_$(nid),type=item_display,limit=1] transformation set value {translation:[0.0d,0.0d,0.0d],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.15f,0.15f,0.01f]}
$execute store result entity @e[tag=editor_guide_$(nid),type=item_display,limit=1] transformation.translation[0] double 0.01 run scoreboard players get #gmx editor
$execute store result entity @e[tag=editor_guide_$(nid),type=item_display,limit=1] transformation.translation[1] double 0.01 run scoreboard players get #gmy editor
$execute store result entity @e[tag=editor_guide_$(nid),type=item_display,limit=1] transformation.translation[2] double 0.01 run scoreboard players get #gmz editor
$execute store result entity @e[tag=editor_guide_$(nid),type=item_display,limit=1] transformation.scale[2] float 0.01 run scoreboard players get #ggd display_calc

# 说明：引导线归属由 guide_build_for_ 决定（note_guide_a=A、note_guide_b=B），此处不再用 #guide_last_id
# 这里在 build_ 中继续递归时，#guide_last_id 会被写回到 editor 计分板，确保后续依次连接
