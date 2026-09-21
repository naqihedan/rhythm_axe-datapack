# 引导线「锚点」写入（@s = 引导线展示实体 item_display）
# 把实体自身 Pos（×100 定点）存进 note_guide_px/py/pz —— 这就是该引导线的锚点。
# ★ 为什么需要锚点（2026-09-21）：
#   display 的 transformation.translation 是【相对实体 Pos】的偏移，而实体 Pos 又必须落在
#   引导线自己附近（玩家附近）—— 因为展示实体只有被客户端【追踪】才会收到更新，
#   停在世界原点的实体即使区块【强加载】也不会更新（表现为引导线不跟随/看不见）。
#   ⇒ 生成时把 Pos 锚在 A 端判定位置，绘制时 translation 写「世界中点 − 锚点」。
# 调用点（两处生成点，summon 后各调一次）：
#   play/note/guide/spawn（游玩）、editor/visual/guide_spawn_（编辑器）
# 本文件【不得】出现宏行（$ 开头）：两处都用普通 function 调用，零宏展开开销。
execute store result score @s note_guide_px run data get entity @s Pos[0] 100
execute store result score @s note_guide_py run data get entity @s Pos[1] 100
execute store result score @s note_guide_pz run data get entity @s Pos[2] 100
