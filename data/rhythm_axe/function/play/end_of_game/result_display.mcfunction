#=============================大标题=============================

execute if score score play_state >= SS options run \
    title @a title {"text":"SS","color":"gold","bold":true}

execute if score score play_state >= S options if score score play_state < SS options run \
    title @a title {"text":"S","color":"yellow","bold":true}

execute if score score play_state >= A options if score score play_state < S options run \
    title @a title {"text":"A","color":"green","bold":true}

execute if score score play_state >= B options if score score play_state < A options run \
    title @a title {"text":"B","color":"blue","bold":true}

execute if score score play_state >= C options if score score play_state < B options run \
    title @a title {"text":"C","color":"gray","bold":true}

execute if score score play_state < C options run \
    title @a title {"text":"Failed","color":"gray","bold":true}


#=============================聊天栏=============================
execute if score percentage_health score_calculate matches 100 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gold"},{"text":"","color":"gray"}]
execute if score percentage_health score_calculate matches 90..99 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"yellow"},{"text":"▃▃▃","color":"gray"}]
execute if score percentage_health score_calculate matches 80..89 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"yellow"},{"text":"▃▃▃▃▃▃","color":"gray"}]
execute if score percentage_health score_calculate matches 70..79 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"green"},{"text":"▃▃▃▃▃▃▃▃▃","color":"gray"}]
execute if score percentage_health score_calculate matches 60..69 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"green"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"}]
execute if score percentage_health score_calculate matches 50..59 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"green"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"}]
execute if score percentage_health score_calculate matches 40..49 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"blue"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"}]
execute if score percentage_health score_calculate matches 30..39 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃","color":"blue"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"}]
execute if score percentage_health score_calculate matches 20..29 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃","color":"blue"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"}]
execute if score percentage_health score_calculate matches 10..19 run tellraw @a \
    [{"text":"▃▃▃▃▃▃","color":"blue"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"}]
execute if score percentage_health score_calculate matches 1..9 run tellraw @a \
    [{"text":"▃▃▃","color":"blue"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"}]
execute if score percentage_health score_calculate matches 0 run tellraw @a \
    [{"text":"","color":"gray"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"}]

function rhythm_axe:play/end_of_game/result_title with storage rhythm_axe:runtime

tellraw @a [\
            {"text":"     你的成绩:","color":"yellow"},\
            {"score":{"name":"score","objective":"play_state"},bold: true,"color":"white"},\
            {"text":"      "},\
            {"text":"最高记录:","color":"yellow"},\
            {"score":{"name":"highest_score","objective":"play_state"},bold: true,"color":"white"},\
           ]
           
tellraw @a ""

tellraw @a [\
            {"text":"      Perfect:","color":"gold"},\
            {"score":{"name":"perfect","objective":"score_calculate"},bold: true,"color":"yellow"},\
            \
            {"text":"        Good:","color":"dark_green"},\
            {"score":{"name":"good","objective":"score_calculate"},"color":"green"},\
            \
            {"text":"        Miss:","color":"dark_gray"},\
            {"score":{"name":"miss","objective":"score_calculate"},"color":"gray"},\
           ]

execute if score detailed_judgements options matches 1 run \
        tellraw @a [\
            {"text":"(early ","color":"yellow"},\
            {"score":{"name":"perfect_early","objective":"play_state"},"color":"yellow"},\
            {"text":",late ","color":"yellow"},\
            {"score":{"name":"perfect_late","objective":"play_state"},"color":"yellow"},\
            {"text":") ","color":"yellow"},\
            \
            {"text":"(early ","color":"green"},\
            {"score":{"name":"good_early","objective":"play_state"},"color":"green"},\
            {"text":",late ","color":"green"},\
            {"score":{"name":"good_late","objective":"play_state"},"color":"green"},\
            {"text":") ","color":"green"},\
            \
            {"text":"(bad ","color":"aqua"},\
            {"score":{"name":"bad","objective":"play_state"},"color":"dark_aqua"},\
            {"text":",miss ","color":"gray"},\
            {"score":{"name":"miss","objective":"play_state"},"color":"dark_gray"},\
            {"text":") ","color":"gray"},\
            \ 
           ]

tellraw @a ""

tellraw @a [\
            {"text":"        最大连击:","color":"yellow"},\
            {"score":{"name":"max_combo","objective":"play_state"},bold: true,"color":"white"},\
           ]

# ★ 自动模式（2026-08-09）：auto 局显示 AUTO PLAY（加粗 aqua），不显示 FC/AP
execute if score auto play_state matches 1 run tellraw @a [{"text":"                            AUTO PLAY","color":"aqua","bold":true}]
execute if score auto play_state matches 0 if score fc_ap play_state matches 2 run tellraw @a [{"text":"                            ALL PERFECT!","color":"gold","bold":true}]
execute if score auto play_state matches 0 if score fc_ap play_state matches 1 run tellraw @a [{"text":"                            FULL COMBO!","color":"light_purple","bold":true}]

execute if score percentage_health score_calculate matches 100 run tellraw @a \
    [{"text":"","color":"gray"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gold"}]
execute if score percentage_health score_calculate matches 90..99 run tellraw @a \
    [{"text":"▃▃▃","color":"gray"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"yellow"}]
execute if score percentage_health score_calculate matches 80..89 run tellraw @a \
    [{"text":"▃▃▃▃▃▃","color":"gray"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"yellow"}]
execute if score percentage_health score_calculate matches 70..79 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃","color":"gray"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"green"}]
execute if score percentage_health score_calculate matches 60..69 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"green"}]
execute if score percentage_health score_calculate matches 50..59 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"green"}]
execute if score percentage_health score_calculate matches 40..49 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"blue"}]
execute if score percentage_health score_calculate matches 30..39 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"},{"text":"▃▃▃▃▃▃▃▃▃▃▃▃","color":"blue"}]
execute if score percentage_health score_calculate matches 20..29 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"},{"text":"▃▃▃▃▃▃▃▃▃","color":"blue"}]
execute if score percentage_health score_calculate matches 10..19 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"},{"text":"▃▃▃▃▃▃","color":"blue"}]
execute if score percentage_health score_calculate matches 1..9 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"},{"text":"▃▃▃","color":"blue"}]
execute if score percentage_health score_calculate matches 0 run tellraw @a \
    [{"text":"▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃","color":"gray"},{"text":"","color":"gray"}]
