# 预热音乐解码（宏参数 music）：后台解码整首 OGG，之后的 playmusic 缓存命中零延迟
# 主时机：编辑器打开谱面（finish_open）时预热；兑底：播放启动（play_）再预热一次（覆盖打开后修改音乐的场景）
#arg: music
$preloadmusic $(music)
