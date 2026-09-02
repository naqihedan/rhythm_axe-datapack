#arg:cursor,inherit_idx
# 继承复制宏叶子（只复制一次属性；绝不递归 / 不 return）
# 复制同类最近音符属性：除 time/id/hit_events/position/custom_tag 外全部
# （position 由工具放置位置覆盖；custom_tag 不继承——放置始终用默认空）
# 起始位置存于 start_pos 列表（create 期待标量 start_x/y/z）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].start_pos run data modify storage rhythm_axe:prop start_x set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].start_pos[0]
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].start_pos run data modify storage rhythm_axe:prop start_y set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].start_pos[1]
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].start_pos run data modify storage rhythm_axe:prop start_z set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].start_pos[2]
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].size run data modify storage rhythm_axe:prop size set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].size
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].duration run data modify storage rhythm_axe:prop duration set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].duration
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].color run data modify storage rhythm_axe:prop color set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].color
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].density run data modify storage rhythm_axe:prop density set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].density
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].note_base_life run data modify storage rhythm_axe:prop note_base_life set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].note_base_life
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].anim_easing run data modify storage rhythm_axe:prop anim_easing set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].anim_easing
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].anim_power run data modify storage rhythm_axe:prop anim_power set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].anim_power
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].hitsound run data modify storage rhythm_axe:prop hitsound set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].hitsound
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].hit_particles run data modify storage rhythm_axe:prop hit_particles set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].hit_particles
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].following_point run data modify storage rhythm_axe:prop following_point set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(inherit_idx)].following_point
