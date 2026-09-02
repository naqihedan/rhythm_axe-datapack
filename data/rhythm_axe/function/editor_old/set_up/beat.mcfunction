scoreboard players add color_group_number set_up_timeline 1
scoreboard players operation color_group_number set_up_timeline %= 2 const

scoreboard players set tick_per_beat set_up_timeline 1
function rhythm_axe:editor/set_up/tick

scoreboard players add beat_per_bar set_up_timeline 1
execute if score beat_per_bar set_up_timeline <= beat_per_bar editor run \
    function rhythm_axe:editor/set_up/beat