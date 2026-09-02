# 播放谱面背景音乐（宏参数 music；time == 0 时由 main_loop 调用）
# as @a at @s：每个玩家在自己位置播放（main_loop 执行位置 = 世界原点，直接 ~ ~ ~ 会因距离衰减听不到）
# minVolume 1（playsound 第 7 参数）：无论距离多远都以全音量播放（无视差）
# record 通道 + 立体声音频（audio.ogg）→ 不随距离衰减
#arg: music
$execute as @a at @s run playsound $(music) record @s ~ ~ ~ 1 1 1
