# 面板 11：音符设置（单音符 / 批量编辑）。note_panel / batch_panel 设 current_panel=11。
# 入口：面板10/18 的 600+、1400+ 编辑行、1562 批量，或 801/804/856 进入全局/击打子面板后返回。
# 含：note_panel_adjust 各字段加减、相对/绝对开关与重置、批量确认、单音符确认删除、【x】各字段重置、
#     判定/起始位置单轴加减、时间轴翻转(909 仅 return，动作在面板10/18)、进全局音效/视效/击打子面板。
# 入口白名单守卫
execute unless score #click_value editor matches 760..805 unless score #click_value editor matches 856 unless score #click_value editor matches 860..887 unless score #click_value editor matches 890 unless score #click_value editor matches 891..893 unless score #click_value editor matches 894..895 unless score #click_value editor matches 896..899 unless score #click_value editor matches 904..908 unless score #click_value editor matches 909 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 760..805 unless score #click_value editor matches 856 unless score #click_value editor matches 860..887 unless score #click_value editor matches 890 unless score #click_value editor matches 891..893 unless score #click_value editor matches 894..895 unless score #click_value editor matches 896..899 unless score #click_value editor matches 904..908 unless score #click_value editor matches 909 run return fail

# —— 各字段 ± 调整（note_panel_adjust 依 field 判别）——
execute if score #click_value editor matches 760..762 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 768..781 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 783..784 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 785..786 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 799..800 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
execute if score #click_value editor matches 802..803 run function rhythm_axe:editor/menu/note/panel/note_panel_adjust
# 相对/绝对开关（787 时间 / 788 大小 / 789 位置 / 790 起始位置）
execute if score #click_value editor matches 787 run scoreboard players set #rel_field editor 1
execute if score #click_value editor matches 788 run scoreboard players set #rel_field editor 2
execute if score #click_value editor matches 789 run scoreboard players set #rel_field editor 3
execute if score #click_value editor matches 790 run scoreboard players set #rel_field editor 4
execute if score #click_value editor matches 787..790 run function rhythm_axe:editor/menu/note/panel/note_panel_rel_toggle
# 相对字段【x】重置：增量归 0（仅相对模式行显示）；单/批量都刷新面板并拦截
execute store result score #rel_on editor run data get storage rhythm_axe:maps.editor editing.rel.on.time
execute store result score #rel_pos editor run data get storage rhythm_axe:maps.editor editing.rel.on.position
execute store result score #rel_sp editor run data get storage rhythm_axe:maps.editor editing.rel.on.start_pos
execute if score #click_value editor matches 792 run data modify storage rhythm_axe:maps.editor editing.rel.delta.time set value 0
execute if score #click_value editor matches 793 run data modify storage rhythm_axe:maps.editor editing.rel.delta.size set value 0
execute if score #click_value editor matches 796 run data modify storage rhythm_axe:maps.editor editing.rel.delta.position set value [0,0,0]
execute if score #click_value editor matches 797 run data modify storage rhythm_axe:maps.editor editing.rel.delta.start_pos set value [0,0,0]
# 单音符绝对模式【x】重置：还原为打开时的值（editing.temp from editing.orig）
execute if score #click_value editor matches 792 if score #rel_on editor matches 0 unless data storage rhythm_axe:maps.editor editing.batch if data storage rhythm_axe:maps.editor editing.orig.time run data modify storage rhythm_axe:maps.editor editing.temp.time set from storage rhythm_axe:maps.editor editing.orig.time
execute if score #click_value editor matches 793 if score #rel_on editor matches 0 unless data storage rhythm_axe:maps.editor editing.batch if data storage rhythm_axe:maps.editor editing.orig.size run data modify storage rhythm_axe:maps.editor editing.temp.size set from storage rhythm_axe:maps.editor editing.orig.size
execute if score #click_value editor matches 796 if score #rel_pos editor matches 0 unless data storage rhythm_axe:maps.editor editing.batch if data storage rhythm_axe:maps.editor editing.orig.position run data modify storage rhythm_axe:maps.editor editing.temp.position set from storage rhythm_axe:maps.editor editing.orig.position
execute if score #click_value editor matches 797 if score #rel_sp editor matches 0 unless data storage rhythm_axe:maps.editor editing.batch if data storage rhythm_axe:maps.editor editing.orig.start_pos run data modify storage rhythm_axe:maps.editor editing.temp.start_pos set from storage rhythm_axe:maps.editor editing.orig.start_pos
execute if score #click_value editor matches 792..793 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #click_value editor matches 792..793 run return 0
execute if score #click_value editor matches 796..797 run function rhythm_axe:editor/menu/note/panel/note_panel
execute if score #click_value editor matches 796..797 run return 0

# —— 批量确认/取消（editing.batch 时拦截 763/764；用 #batch_do 标志，因 batch_confirm 会移除 editing.batch）——
scoreboard players set #batch_do editor 0
execute if score #click_value editor matches 763 if data storage rhythm_axe:maps.editor editing.batch run scoreboard players set #batch_do editor 1
execute if score #click_value editor matches 764 if data storage rhythm_axe:maps.editor editing.batch run scoreboard players set #batch_do editor 1
execute if score #batch_do editor matches 1 if score #click_value editor matches 763 run function rhythm_axe:editor/menu/note/batch/batch_confirm
execute if score #batch_do editor matches 1 if score #click_value editor matches 764 run function rhythm_axe:editor/menu/note/batch/batch_cancel
execute if score #batch_do editor matches 1 run return fail
# —— 单音符确认/取消/删除 ——
execute if score #click_value editor matches 763 run function rhythm_axe:editor/menu/note/panel/note_panel_confirm
execute if score #click_value editor matches 764 run function rhythm_axe:editor/menu/note/panel/note_panel_cancel
execute if score #click_value editor matches 765 run function rhythm_axe:editor/menu/note/panel/note_panel_delete_arm
execute if score #click_value editor matches 766 run function rhythm_axe:editor/menu/note/panel/note_panel_delete
execute if score #click_value editor matches 767 run function rhythm_axe:editor/menu/note/panel/note_panel_delete_disarm

# 时间轴翻转（909）：本面板仅 return（动作在面板10/18）
execute if score #click_value editor matches 909 run return 0
# 引导线/无视流速开关（794/795）
execute if score #click_value editor matches 794 run function rhythm_axe:editor/menu/note/panel/note_toggle_following_point
execute if score #click_value editor matches 795 run function rhythm_axe:editor/menu/note/panel/note_toggle_ignore_speed

# —— 【x】字段重置：批量=清 batch_set + temp 恢复默认；单音符=temp 恢复 orig；均清 changed 并刷新 ——
# 890 基础寿命
execute if score #click_value editor matches 890 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.base_life
execute if score #click_value editor matches 890 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.note_base_life set value 24
execute if score #click_value editor matches 890 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.note_base_life set from storage rhythm_axe:maps.editor editing.orig.note_base_life
execute if score #click_value editor matches 890 run data remove storage rhythm_axe:maps.editor editing.changed.base_life
execute if score #click_value editor matches 890 run function rhythm_axe:editor/menu/note/panel/note_panel
# 891 持续
execute if score #click_value editor matches 891 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.duration
execute if score #click_value editor matches 891 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.duration set value 8
execute if score #click_value editor matches 891 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.duration set from storage rhythm_axe:maps.editor editing.orig.duration
execute if score #click_value editor matches 891 run data remove storage rhythm_axe:maps.editor editing.changed.duration
execute if score #click_value editor matches 891 run function rhythm_axe:editor/menu/note/panel/note_panel
# 892 密度
execute if score #click_value editor matches 892 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.density
execute if score #click_value editor matches 892 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.density set value 8
execute if score #click_value editor matches 892 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.density set from storage rhythm_axe:maps.editor editing.orig.density
execute if score #click_value editor matches 892 run data remove storage rhythm_axe:maps.editor editing.changed.density
execute if score #click_value editor matches 892 run function rhythm_axe:editor/menu/note/panel/note_panel
# 893 类型
execute if score #click_value editor matches 893 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.type
execute if score #click_value editor matches 893 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.type set value 0
execute if score #click_value editor matches 893 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.type set from storage rhythm_axe:maps.editor editing.orig.type
execute if score #click_value editor matches 893 run data remove storage rhythm_axe:maps.editor editing.changed.type
execute if score #click_value editor matches 893 run function rhythm_axe:editor/menu/note/panel/note_panel
# 899 动画（缓动+强度一次重置）
execute if score #click_value editor matches 899 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.anim_easing
execute if score #click_value editor matches 899 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.anim_power
execute if score #click_value editor matches 899 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.anim_easing set value 1
execute if score #click_value editor matches 899 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.anim_power set value 1
execute if score #click_value editor matches 899 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.anim_easing set from storage rhythm_axe:maps.editor editing.orig.anim_easing
execute if score #click_value editor matches 899 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.anim_power set from storage rhythm_axe:maps.editor editing.orig.anim_power
execute if score #click_value editor matches 899 run data remove storage rhythm_axe:maps.editor editing.changed.anim_easing
execute if score #click_value editor matches 899 run data remove storage rhythm_axe:maps.editor editing.changed.anim_power
execute if score #click_value editor matches 899 run function rhythm_axe:editor/menu/note/panel/note_panel
# 904 击打音效
execute if score #click_value editor matches 904 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.hitsound
execute if score #click_value editor matches 904 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hitsound set value 0
execute if score #click_value editor matches 904 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hitsound set from storage rhythm_axe:maps.editor editing.orig.hitsound
execute if score #click_value editor matches 904 run data remove storage rhythm_axe:maps.editor editing.changed.hitsound
execute if score #click_value editor matches 904 run function rhythm_axe:editor/menu/note/panel/note_panel
# 905 击打视效
execute if score #click_value editor matches 905 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.hit_particles
execute if score #click_value editor matches 905 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hit_particles set value 0
execute if score #click_value editor matches 905 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hit_particles set from storage rhythm_axe:maps.editor editing.orig.hit_particles
execute if score #click_value editor matches 905 run data remove storage rhythm_axe:maps.editor editing.changed.hit_particles
execute if score #click_value editor matches 905 run function rhythm_axe:editor/menu/note/panel/note_panel
# 906 击打事件
execute if score #click_value editor matches 906 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.hit_events
execute if score #click_value editor matches 906 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hit_events set value []
execute if score #click_value editor matches 906 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.hit_events set from storage rhythm_axe:maps.editor editing.orig.hit_events
execute if score #click_value editor matches 906 run data remove storage rhythm_axe:maps.editor editing.changed.hit_events
execute if score #click_value editor matches 906 run function rhythm_axe:editor/menu/note/panel/note_panel
# 907 标签
execute if score #click_value editor matches 907 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.custom_tag
execute if score #click_value editor matches 907 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.custom_tag set value ""
execute if score #click_value editor matches 907 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.custom_tag set from storage rhythm_axe:maps.editor editing.orig.custom_tag
execute if score #click_value editor matches 907 run data remove storage rhythm_axe:maps.editor editing.changed.custom_tag
execute if score #click_value editor matches 907 run function rhythm_axe:editor/menu/note/panel/note_panel
# 908 颜色
execute if score #click_value editor matches 908 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.color
execute if score #click_value editor matches 908 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.color set value 1b
execute if score #click_value editor matches 908 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.color set from storage rhythm_axe:maps.editor editing.orig.color
execute if score #click_value editor matches 908 run data remove storage rhythm_axe:maps.editor editing.changed.color
execute if score #click_value editor matches 908 run function rhythm_axe:editor/menu/note/panel/note_panel
# 894 引导线
execute if score #click_value editor matches 894 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.following_point
execute if score #click_value editor matches 894 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.following_point set value 0b
execute if score #click_value editor matches 894 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.following_point set from storage rhythm_axe:maps.editor editing.orig.following_point
execute if score #click_value editor matches 894 run data remove storage rhythm_axe:maps.editor editing.changed.following_point
execute if score #click_value editor matches 894 run function rhythm_axe:editor/menu/note/panel/note_panel
# 895 无视流速
execute if score #click_value editor matches 895 if data storage rhythm_axe:maps.editor editing.batch run data remove storage rhythm_axe:maps.editor editing.batch_set.ignore_note_speed
execute if score #click_value editor matches 895 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.ignore_note_speed set value 0b
execute if score #click_value editor matches 895 unless data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.temp.ignore_note_speed set from storage rhythm_axe:maps.editor editing.orig.ignore_note_speed
execute if score #click_value editor matches 895 run data remove storage rhythm_axe:maps.editor editing.changed.ignore_note_speed
execute if score #click_value editor matches 895 run function rhythm_axe:editor/menu/note/panel/note_panel

# —— 判定位置/起始位置单轴加减（field_name + delta；[--]/[++]粗调 ±100=1 格）——
execute if score #click_value editor matches 860 run data modify storage rhythm_axe:prop field_name set value "position[0]"
execute if score #click_value editor matches 861 run data modify storage rhythm_axe:prop field_name set value "position[0]"
execute if score #click_value editor matches 862 run data modify storage rhythm_axe:prop field_name set value "position[1]"
execute if score #click_value editor matches 863 run data modify storage rhythm_axe:prop field_name set value "position[1]"
execute if score #click_value editor matches 864 run data modify storage rhythm_axe:prop field_name set value "position[2]"
execute if score #click_value editor matches 865 run data modify storage rhythm_axe:prop field_name set value "position[2]"
execute if score #click_value editor matches 868 run data modify storage rhythm_axe:prop field_name set value "start_pos[0]"
execute if score #click_value editor matches 869 run data modify storage rhythm_axe:prop field_name set value "start_pos[0]"
execute if score #click_value editor matches 870 run data modify storage rhythm_axe:prop field_name set value "start_pos[1]"
execute if score #click_value editor matches 871 run data modify storage rhythm_axe:prop field_name set value "start_pos[1]"
execute if score #click_value editor matches 872 run data modify storage rhythm_axe:prop field_name set value "start_pos[2]"
execute if score #click_value editor matches 873 run data modify storage rhythm_axe:prop field_name set value "start_pos[2]"
# 粗调（[--]/[++]：±1 格 = ±100）
execute if score #click_value editor matches 876 run data modify storage rhythm_axe:prop field_name set value "position[0]"
execute if score #click_value editor matches 877 run data modify storage rhythm_axe:prop field_name set value "position[0]"
execute if score #click_value editor matches 878 run data modify storage rhythm_axe:prop field_name set value "position[1]"
execute if score #click_value editor matches 879 run data modify storage rhythm_axe:prop field_name set value "position[1]"
execute if score #click_value editor matches 880 run data modify storage rhythm_axe:prop field_name set value "position[2]"
execute if score #click_value editor matches 881 run data modify storage rhythm_axe:prop field_name set value "position[2]"
execute if score #click_value editor matches 882 run data modify storage rhythm_axe:prop field_name set value "start_pos[0]"
execute if score #click_value editor matches 883 run data modify storage rhythm_axe:prop field_name set value "start_pos[0]"
execute if score #click_value editor matches 884 run data modify storage rhythm_axe:prop field_name set value "start_pos[1]"
execute if score #click_value editor matches 885 run data modify storage rhythm_axe:prop field_name set value "start_pos[1]"
execute if score #click_value editor matches 886 run data modify storage rhythm_axe:prop field_name set value "start_pos[2]"
execute if score #click_value editor matches 887 run data modify storage rhythm_axe:prop field_name set value "start_pos[2]"
execute if score #click_value editor matches 860..873 run scoreboard players set #pos_delta const 10
execute if score #click_value editor matches 860 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 862 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 864 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 868 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 870 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 872 run scoreboard players set #pos_delta const -10
execute if score #click_value editor matches 876..887 run scoreboard players set #pos_delta const 100
execute if score #click_value editor matches 876 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 878 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 880 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 882 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 884 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 886 run scoreboard players set #pos_delta const -100
execute if score #click_value editor matches 860..887 run execute store result storage rhythm_axe:prop delta int 1 run scoreboard players get #pos_delta const
# 相对增量目标组/轴
execute if score #click_value editor matches 860..865 run data modify storage rhythm_axe:prop rel_group set value "position"
execute if score #click_value editor matches 876..881 run data modify storage rhythm_axe:prop rel_group set value "position"
execute if score #click_value editor matches 868..873 run data modify storage rhythm_axe:prop rel_group set value "start_pos"
execute if score #click_value editor matches 882..887 run data modify storage rhythm_axe:prop rel_group set value "start_pos"
execute if score #click_value editor matches 860..861 run data modify storage rhythm_axe:prop rel_axis set value 0
execute if score #click_value editor matches 876..877 run data modify storage rhythm_axe:prop rel_axis set value 0
execute if score #click_value editor matches 868..869 run data modify storage rhythm_axe:prop rel_axis set value 0
execute if score #click_value editor matches 882..883 run data modify storage rhythm_axe:prop rel_axis set value 0
execute if score #click_value editor matches 862..863 run data modify storage rhythm_axe:prop rel_axis set value 1
execute if score #click_value editor matches 878..879 run data modify storage rhythm_axe:prop rel_axis set value 1
execute if score #click_value editor matches 870..871 run data modify storage rhythm_axe:prop rel_axis set value 1
execute if score #click_value editor matches 884..885 run data modify storage rhythm_axe:prop rel_axis set value 1
execute if score #click_value editor matches 864..865 run data modify storage rhythm_axe:prop rel_axis set value 2
execute if score #click_value editor matches 880..881 run data modify storage rhythm_axe:prop rel_axis set value 2
execute if score #click_value editor matches 872..873 run data modify storage rhythm_axe:prop rel_axis set value 2
execute if score #click_value editor matches 886..887 run data modify storage rhythm_axe:prop rel_axis set value 2
execute if score #click_value editor matches 860..887 run function rhythm_axe:editor/menu/note/pos/note_pos_adjust with storage rhythm_axe:prop
# 使用当前/吸附中心
execute if score #click_value editor matches 866 run function rhythm_axe:editor/menu/note/pos/note_pos_use_player
execute if score #click_value editor matches 867 run function rhythm_axe:editor/menu/note/pos/note_pos_snap_center
# 标签字段对话框
execute if score #click_value editor matches 805 run function rhythm_axe:editor/menu/note/dialog/dialog_open_note_tag

# —— 进入全局音效(12)/全局视效(13)/击打事件(14)子面板（进入时备份）——
execute if score #click_value editor matches 801 run data modify storage rhythm_axe:prop sound_backup set from storage rhythm_axe:feedback sounds
execute if score #click_value editor matches 801 run function rhythm_axe:editor/menu/note/global/global_sound_panel
execute if score #click_value editor matches 804 run data modify storage rhythm_axe:prop particle_backup set from storage rhythm_axe:feedback particles
execute if score #click_value editor matches 804 run function rhythm_axe:editor/menu/note/global/global_particle_panel
execute if score #click_value editor matches 856 run function rhythm_axe:editor/menu/note/hit_events/note_hit_events_open
