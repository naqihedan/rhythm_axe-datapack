#arg: delta
# 编辑器主菜单行110 · 全局音乐偏移步进：options.music_offset += delta，钳到 [-500, 500]（单位 ms）
#   ⚠ `scoreboard players add` 的 count 不接受负数 ⇒ 先把 delta 落到 #off_d，再用 operation +=
#   ⚠ music_offset 缺失时先 add 0 建条目（load.mcfunction 已兜底，这里双保险）
scoreboard players add music_offset options 0
scoreboard players set #off_d editor 0
$scoreboard players set #off_d editor $(delta)
scoreboard players operation music_offset options += #off_d editor
execute if score music_offset options matches ..-501 run scoreboard players set music_offset options -500
execute if score music_offset options matches 501.. run scoreboard players set music_offset options 500
