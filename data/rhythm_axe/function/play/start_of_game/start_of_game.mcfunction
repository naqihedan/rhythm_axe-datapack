# 谱面游玩入口（宏参数 mapid）
# 所有检查通过后开始游戏
#arg: mapid
scoreboard players set #dbg play_state 1

# 编辑器占用守卫（2026-08-18 注释）：当前只能检测单人（@s），多人开局需要遍历所有参与玩家；
# 单人方案待验证，多人检测见 todo
# execute if entity @s[tag=editor_active] run tellraw @a [{"text":"[提示] ","color":"yellow"},{"text":"该玩家正处于谱面编辑状态，无法开始游戏","color":"gray"}]
# execute if entity @s[tag=editor_active] run return fail

# 已有谱面在运行 → 阻止开始（不自动重开）
# is_running 保持 1 → 下方 `if score is_running matches 0` 不满足 → 不调 start。
# 玩家需先手动结束：/function rhythm_axe:play/end_of_game/stop
execute if score is_running play_state matches 1 run tellraw @a [{"text":"[提示] ","color":"yellow"},{"text":"已有谱面正在运行，无法开始。请先执行 /function rhythm_axe:play/end_of_game/stop 结束当前谱面。","color":"gray"}]
# mod 未安装
execute if score is_running play_state matches 0 if function rhythm_axe:play/start_of_game/mod_test run \
    tellraw @a [{"text":"【错误】","color":"red","bold":true},\
        {"text":"游戏无法启动：","color":"dark_red"},\
        {"text":"检测到未安装必要mod！请","color":"white"},\
        {"text":"【点击这里(密码:nqhd)】","color":"dark_green","bold":true,\
            "click_event":\
                {"action":"open_url",\
                    "url":"https://wwbmp.lanzoul.com/b01883d56b"\
                }\
            },\
        {"text":"前往链接下载并安装必要mod！","color":"white"}\
        ]
# 没有正在运行的谱面 且 mod 已安装 → 开始
scoreboard players set #dbg play_state 2
$execute if score is_running play_state matches 0 unless function rhythm_axe:play/start_of_game/mod_test run function rhythm_axe:play/start_of_game/start {mapid:"$(mapid)"}