# 名单行 · 已加入（@s = 成员；接收者 = @a[tag=room_viewer]）
#   ★ tellraw JSON 里的 {"selector":"@s"} 用的是**命令上下文**的 @s：这里正好 execute as <成员>
#     ⇒ 直接输出该成员的显示名（玩家没有可读的 name NBT，这是唯一不靠宏的做法）。
tellraw @a[tag=room_viewer] [{"text":"  ✔ ","color":"green"},{"selector":"@s"}]
