#arg:key,name,mapid,score,health
# 单人写回：索引登记 → 取旧分 → 更高才写 → 更新结算显示用的「你的最高记录」
# 存储：rhythm_axe:scores.<key>.<mapid> = {name:"..", score:N, health:P}
#       health = 当时剩余血量百分比（排行榜按它给分数上色，同结算界面上下边框）
#       rhythm_axe:scores_index.<mapid> = ["key",...]（枚举用；首次记录时追加，见下）
# 玩家 key = UUID 四个 int 拼串（原版拿不到 UUID 字符串，见 collect_ 顶部说明）
# 1) 首次记录才登记索引（该玩家这张谱面还没有条目 ⇒ 之前没写进去过）
# ⚠️ 26.x 的 `data … storage <id> <path>`：**存储 id 会把点分名字整个吃掉**，后面必须再跟一个路径；
#    写成 `storage rhythm_axe:scores_index.<mapid> set value …` 会被当成「id=整个名字、没有路径」→
#    报「错误的命令参数」，而宏函数一旦命令不合法就**整个实例化失败**（静默不执行）。2026-10-01 踩坑。
$execute if data storage rhythm_axe:prop {write:1b} unless data storage rhythm_axe:scores_index $(mapid) run data modify storage rhythm_axe:scores_index $(mapid) set value []
$execute if data storage rhythm_axe:prop {write:1b} unless data storage rhythm_axe:scores $(key).$(mapid) run data modify storage rhythm_axe:scores_index $(mapid) append value "$(key)"
# 2) 旧分（条目不存在 → data get 失败 → 保持 0）
scoreboard players set #hs_old play_state 0
$execute store result score #hs_old play_state run data get storage rhythm_axe:scores $(key).$(mapid).score
# 3) 本局分数与血量（宏参数注入）
$scoreboard players set #hs_new play_state $(score)
$scoreboard players set #hs_health play_state $(health)
# 4) 写入判定：首次记录无条件建条目（0 分也建）；已有条目则只在更高时覆盖
scoreboard players set #hs_should play_state 0
$execute if data storage rhythm_axe:prop {write:1b} unless data storage rhythm_axe:scores $(key).$(mapid) run scoreboard players set #hs_should play_state 1
$execute if data storage rhythm_axe:prop {write:1b} if data storage rhythm_axe:scores $(key).$(mapid) if score #hs_new play_state > #hs_old play_state run scoreboard players set #hs_should play_state 1
# 5) 逐级确保父复合存在后写入（set value 要求父键已存在）
#   ⚠️ 别再写 `data modify storage rhythm_axe:scores set value {}` 想建「存储根」——那是**非法命令**
#      （storage 后必须跟路径），会让整个文件加载失败（游戏报「未知的函数」）。2026-10-01 踩坑。
#      单层路径的 `set value` 会自动创建存储本身，所以第一行就够。
$execute if score #hs_should play_state matches 1 unless data storage rhythm_axe:scores $(key) run data modify storage rhythm_axe:scores $(key) set value {}
$execute if score #hs_should play_state matches 1 run data modify storage rhythm_axe:scores $(key).$(mapid) set value {name:"$(name)", score:0, health:0}
$execute if score #hs_should play_state matches 1 run execute store result storage rhythm_axe:scores $(key).$(mapid).score int 1 run scoreboard players get #hs_new play_state
$execute if score #hs_should play_state matches 1 run execute store result storage rhythm_axe:scores $(key).$(mapid).health int 1 run scoreboard players get #hs_health play_state
# 6) 结算界面「你的最高记录」= max(旧分, 本局分〔写回时才有本局分〕)
scoreboard players operation highest_score play_state > #hs_old play_state
execute if score #hs_should play_state matches 1 run scoreboard players operation highest_score play_state > #hs_new play_state
