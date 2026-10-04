#arg:cursor,index
# 判定时间【使用当前时间】相对模式：读最早音符的判定时间 → #uh_ref（宏叶子）
$execute store result score #uh_ref editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time
