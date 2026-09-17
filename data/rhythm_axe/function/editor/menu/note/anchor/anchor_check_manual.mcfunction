# 判定锚点是否「被手动改过」→ #an_manual（1=改过，之后不再自动跟随选区）
# 前置：#an_has / #an_x,y,z（锚点实体 Pos ×100）、#rc0,1,2（当前包围盒中心 ×100）
# ★ 2026-09-17 修正（用户实测：选完第一个音符、没动过锚点，选第二个就被判成「动过」）：
#   判定的基准必须是**实体上记录的「上次自动摆放位置」**（`data.anchor_cx/cy/cz`），
#   **不能拿「当前包围盒中心」当基准** —— 选区一变中心就变，锚点却还停在旧中心，差 >0.05 格 ⇒ 误判。
# 规则：
#   ① 实体不存在 → 0（交给 anchor_put 生成）
#   ② 实体已带 tag editor_anchor_manual → 1（判定结果持久化在实体上 ⇒「改过一次就永远算改过」）
#   ③ 有 `data.anchor_c*` 记录 → 实体当前 Pos 与记录任一轴差 > 5（=0.05 格，吸收定点取整误差）→ 1
#      （只有用户/其他方式**挪动过实体**才会出现这种差；选区变化不会）
#   ④ 无记录（旧版本遗留实体 / 外部生成的实体）→ 退回旧口径：与当前中心比较，不等则视为手动（保守，保住用户摆的位置）
scoreboard players set #an_manual editor 0
execute if score #an_has editor matches 0 run return 0
execute if entity @e[tag=editor_anchor_manual] run scoreboard players set #an_manual editor 1
execute if score #an_manual editor matches 1 run return 0
# 读实体上的记录（先置哨兵 2147483647 = 无记录；store 失败会留旧值，所以必须预置）
scoreboard players set #an_px editor 2147483647
scoreboard players set #an_py editor 2147483647
scoreboard players set #an_pz editor 2147483647
execute store result score #an_px editor run data get entity @e[tag=editor_anchor,type=item_display,limit=1] data.anchor_cx
execute store result score #an_py editor run data get entity @e[tag=editor_anchor,type=item_display,limit=1] data.anchor_cy
execute store result score #an_pz editor run data get entity @e[tag=editor_anchor,type=item_display,limit=1] data.anchor_cz
# 无记录 → 基准退回「当前中心」
execute if score #an_px editor matches 2147483647 run scoreboard players operation #an_px editor = #rc0 editor
execute if score #an_py editor matches 2147483647 run scoreboard players operation #an_py editor = #rc1 editor
execute if score #an_pz editor matches 2147483647 run scoreboard players operation #an_pz editor = #rc2 editor
# 逐轴比较：实体位置 vs 基准
scoreboard players operation #ad editor = #an_x editor
scoreboard players operation #ad editor -= #an_px editor
execute if score #ad editor matches ..-1 run scoreboard players operation #ad editor *= -1 const
execute if score #ad editor matches 6.. run scoreboard players set #an_manual editor 1
scoreboard players operation #ad editor = #an_y editor
scoreboard players operation #ad editor -= #an_py editor
execute if score #ad editor matches ..-1 run scoreboard players operation #ad editor *= -1 const
execute if score #ad editor matches 6.. run scoreboard players set #an_manual editor 1
scoreboard players operation #ad editor = #an_z editor
scoreboard players operation #ad editor -= #an_pz editor
execute if score #ad editor matches ..-1 run scoreboard players operation #ad editor *= -1 const
execute if score #ad editor matches 6.. run scoreboard players set #an_manual editor 1
