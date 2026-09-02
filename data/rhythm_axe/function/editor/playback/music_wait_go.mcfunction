# 延迟音乐播放：playhead==0 时从 0 播（@s = 编辑玩家，由 advance_ as @a[tag=editor_active] 调用）
# 与游玩系统一致：音乐 time==0 播、音符 time==0 判定，同刻对齐
data modify storage rhythm_axe:prop music set from storage rhythm_axe:editor.runtime music_wait_music
data modify storage rhythm_axe:prop tick set value 0
data modify storage rhythm_axe:prop speed set from storage rhythm_axe:editor.runtime music_wait_speed
function rhythm_axe:editor/playback/playmusic_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop music
data remove storage rhythm_axe:prop tick
data remove storage rhythm_axe:prop speed
data remove storage rhythm_axe:editor.runtime music_wait
data remove storage rhythm_axe:editor.runtime music_wait_music
data remove storage rhythm_axe:editor.runtime music_wait_speed
