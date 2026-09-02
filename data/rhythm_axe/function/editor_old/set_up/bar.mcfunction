scoreboard players add color_group set_up_timeline 1
scoreboard players operation color_group set_up_timeline %= 2 const

scoreboard players set beat_per_bar set_up_timeline 1
function rhythm_axe:editor/set_up/beat

scoreboard players add bar set_up_timeline 1

execute if score bar set_up_timeline <= bar editor run \
    function rhythm_axe:editor/set_up/bar