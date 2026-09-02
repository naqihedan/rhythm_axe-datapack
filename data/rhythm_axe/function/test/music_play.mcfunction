# [测试] 编辑器阶段0：音乐播放（新版 /playmusic，起始tick 自动按 tick 速率换算）
# 用法：
#   function rhythm_axe:test/music_play      从头播放（1倍速）
#   function rhythm_axe:test/music_play_mid  从 400tick 处播放
#   function rhythm_axe:test/music_pause     暂停
#   function rhythm_axe:test/music_resume    继续
#   function rhythm_axe:test/music_speed     半速播放（验证保调）
#   function rhythm_axe:test/music_stop      停止
playmusic rhythm_axe:rhythm_axe.audio 0 1 @s 1
