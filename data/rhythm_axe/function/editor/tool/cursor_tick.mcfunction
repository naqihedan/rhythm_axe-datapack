# 工具光标玻璃分发（@s = 编辑玩家；由 tick.mcfunction 每刻 as @a[tag=editor_active] 调用）
# ★ 协作要点：玻璃必须「每人一块」——身份 = 玩家 UUID[0]（tag glow_<gid> / glow_sel_<gid>）。
#   旧的「全局一块 + 没手持就 kill 全部」在多人下会互相 tp / 互相删 ⇒ 闪烁 + 自己看不见。
#   本文件只做「取身份 + 按手持工具分发」；细节在 glow_note（黄）/ select_glow_tick（黄绿）。
execute store result score #glow_uid editor run data get entity @s UUID[0]
execute store result storage rhythm_axe:prop gid int 1 run scoreboard players get #glow_uid editor
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note run function rhythm_axe:editor/tool/glow_note with storage rhythm_axe:prop
# 选择工具的黄绿玻璃只给「占用者」看（非占用者用不了它，别给误导性预览；没认领就会被 tick 的存活标记清掉）
execute if entity @s[tag=editor_select_owner] if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_select run function rhythm_axe:editor/tool/select/select_glow_tick with storage rhythm_axe:prop
data remove storage rhythm_axe:prop gid
