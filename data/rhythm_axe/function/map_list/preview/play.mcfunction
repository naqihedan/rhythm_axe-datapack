#arg:music,pv_start
# 预览出声（宏叶子）：mod 的 /playmusic <音效> <起始刻> <速度> <目标> <音量>
#   · 起始刻 = 谱面记的 preview_start（歌曲时间轴，单位刻）
#   · 目标只给「正在看总表」的人（tag maplist_view = 看得见面板才听得见预览）
#     ⚠️ 因此凡移除该 tag 的地方都要先给自己 stopmusic（view_clear / maps/leaderboard），否则点不到他、音乐响到播完
#   · 速度恒 1（保调）、音量 1
#   · ⚠️ 谱面没 music 时本函数不会被调用（宏参数缺失会让整行实例化失败，见《AI常见问题》）
$playmusic $(music) $(pv_start) 1 @a[tag=maplist_view] 1
