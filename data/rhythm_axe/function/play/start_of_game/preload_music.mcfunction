# 预热谱面音乐（宏参数 music）：mod 在后台线程整首解码进客户端缓存，music 起点（time==0）起播零延迟
# 时机：play/start_of_game/start 开头（谱面 merge 之后立刻发）；越早越好——解码与后续初始化并行
# 与 start_of_game/play_music 是同一条播放路径（见《游玩谱面.md》音乐播放）
#arg: music
$preloadmusic $(music)
