# 设置歌曲进度条当前值（宏；bp 为字面量，调用方 store 到 runtime.bp；每 tick 调用）
#arg: bp
$bossbar set rhythm_axe:song_progress value $(bp)
