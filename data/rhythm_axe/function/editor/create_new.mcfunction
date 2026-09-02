#arg:mapid
# 新建谱面：默认模板写入【编辑工作副本】（maps.editor.history），不创建 maps.<mapid>；
# 只有保存操作（阶段6）才会把工作副本写入 rhythm_axe:maps.<mapid>
# 初始位置取玩家当前位置（spawn_x/y/z 标量 + 角度缺省 0，追加后写入 history[0]）
$data modify storage rhythm_axe:maps.editor history append value {\
    id:"$(mapid)",\
    title:{text:"$(mapid)"},\
    artist:"unknown",\
    music:"rhythm_axe:rhythm_axe.audio",\
    preview:"rhythm_axe:rhythm_axe.audio",\
    health:10,\
    player_count:1,\
    teleport:1b,\
    spawn_yaw:0.0d,\
    spawn_pitch:0.0d,\
    notes:[],\
    events:[],\
    timing_points:[\
        {\
            time:0,\
            bpm:150.0f,\
            bpb:4,\
            tpb:8,\
            judgement_scale:1\
        }\
    ]\
}
execute store result storage rhythm_axe:maps.editor history[0].spawn_x double 1 run data get entity @s Pos[0]
execute store result storage rhythm_axe:maps.editor history[0].spawn_y double 1 run data get entity @s Pos[1]
execute store result storage rhythm_axe:maps.editor history[0].spawn_z double 1 run data get entity @s Pos[2]
$data modify storage rhythm_axe:maps.editor mapid set value "$(mapid)"
$tellraw @s [{"text":"[编辑器] 已创建谱面，mapid：","color":"green"},{"text":"$(mapid)","color":"aqua"},{"text":"（尚未保存，退出前记得保存）","color":"yellow"}]

# 播放头回到开头（= min(0, 最早出生)-1）再刷新视觉
function rhythm_axe:editor/visual/seek_start
# 显示聊天栏主菜单
function rhythm_axe:editor/refresh
function rhythm_axe:editor/menu/main
