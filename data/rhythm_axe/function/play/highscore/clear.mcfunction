#arg:mapid
# 清空某张谱面的排行榜（遍历 scores_index 里该谱面的玩家名单逐人删分，最后删名单本身）
# 调用方：编辑器主菜单【重置谱面最高分】(10406)、回收站【彻底删除】
# 用 `editor` 计分板放临时量（调用方都在编辑器会话内）
# ⚠️ 存储 id 会把点分名字整个吃掉 ⇒ 键必须放在**路径**里（空格分隔），下同
scoreboard players set #rh_n editor 0
$execute store result score #rh_n editor run data get storage rhythm_axe:scores_index $(mapid)
scoreboard players set #rh_i editor 0
execute if score #rh_n editor matches 1.. run function rhythm_axe:play/highscore/clear_drive
$data remove storage rhythm_axe:scores_index $(mapid)
