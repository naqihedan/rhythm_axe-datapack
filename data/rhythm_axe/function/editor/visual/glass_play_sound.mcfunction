# 玻璃专用击打音效播放（绕开 play_sound 的「玻璃零反馈」终极防线）
# 调用方：visual/glass_feedback（with storage rhythm_axe:editor.runtime）
# 执行者 = 玻璃展示实体，位置 = 采样命中点（由调用链 at 好）
#arg: cur_sound
$execute if data storage rhythm_axe:editor.runtime cur_sound run $(cur_sound)
