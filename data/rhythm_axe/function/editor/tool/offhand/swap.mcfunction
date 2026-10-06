# 双手互换（@s = 玩家）：把副手的工具换回主手，同时把主手原物品换回副手 = 撤销这一次换手。
#
# ★ item replace ... from 是「复制」语义（wiki：Copies the source items to the target slot），
#   不是「移动」—— 所以只靠两只手无法完成互换（一定会丢一件），必须借一个第三槽位。
#   这里用一个**同刻生成、同刻击杀**的隐形盔甲架当临时槽（Marker+Invisible，且当刻就 kill，客户端看不到）。
# ★ 顺序刻意这么写：先把副手**显式清空**再复制旧主手 —— 这样无论"源槽为空时 from 是清空还是失败"，
#   副手结果都正确（空源 ⇒ 保持空 / 有物品 ⇒ 写入），不依赖 from 对空源的具体行为。
summon armor_stand ~ ~ ~ {Tags:["editor_tool_swap_tmp"],Invisible:1b,Marker:1b,NoGravity:1b,Silent:1b,NoBasePlate:1b}
item replace entity @e[tag=editor_tool_swap_tmp,limit=1] weapon.mainhand from entity @s weapon.mainhand
item replace entity @s weapon.mainhand from entity @s weapon.offhand
item replace entity @s weapon.offhand with air
item replace entity @s weapon.offhand from entity @e[tag=editor_tool_swap_tmp,limit=1] weapon.mainhand
kill @e[tag=editor_tool_swap_tmp]
