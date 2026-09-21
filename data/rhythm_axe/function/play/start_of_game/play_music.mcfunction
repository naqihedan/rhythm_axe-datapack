# 播放谱面背景音乐（宏参数 music；time == 0 时由 main_loop 调用）
# 用 mod 的 /playmusic：与编辑器试听同一条播放路径 ⇒ 客户端每刻把音频对齐到歌曲时间轴
#   （play_state.time，只动音频、不动游戏时间与判定），见《游玩谱面.md》音乐播放
# 起始 0 刻（= 音乐起点）、速率 1（保调）、音量 1；@a = 所有玩家各自本地播放（不看距离衰减）
#arg: music
$playmusic $(music) 0 1 @a 1
