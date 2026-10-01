#arg:old,new
# 谱面改名时同步搬移排行榜数据（分数按 mapid 当内层键存，改名后必须跟着走，
#   否则新名字下排行榜为空、旧名字下攒着一堆孤儿成绩）
# 层次：本文件读名单 → 驱动器逐人搬 → 最后搬名单本身
$data modify storage rhythm_axe:prop old set value "$(old)"
$data modify storage rhythm_axe:prop new set value "$(new)"
scoreboard players set #hr_n play_state 0
$execute store result score #hr_n play_state run data get storage rhythm_axe:scores_index $(old)
scoreboard players set #hr_i play_state 0
execute if score #hr_n play_state matches 1.. run function rhythm_axe:play/highscore/rename_drive
$execute if data storage rhythm_axe:scores_index $(old) run data modify storage rhythm_axe:scores_index $(new) set from storage rhythm_axe:scores_index $(old)
$data remove storage rhythm_axe:scores_index $(old)
data remove storage rhythm_axe:prop old
data remove storage rhythm_axe:prop new
