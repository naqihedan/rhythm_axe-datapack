# 面板 18：已选定音符列表（规范v2：11401 返回 / 11402 清空返回 / 11403 批量编辑 / 11404 批量复制 / 11408 批量剪切 / 11405 批量粘贴 / 11406 粘贴并选中 / 11407 批量删除；
#            100000..103999 动态行；11601/11602 翻页；11501/11502/11503-11506 翻转组 / 11507-11509 旋转组 / 11510 锚点重置 / 11511 应用锚点变换）。
#   动态行：值 = 100000 + 页内序×100 + 列码（复选框 0 / 编辑 3 / 复制 5 / 粘贴 6 / 删除 7；页内序 0..39）
# sel_note_list_open 设 current_panel=18。返回用 1560/1561，本面板不含值 1。
# 入口白名单守卫
execute unless score #click_value editor matches 11401..11408 unless score #click_value editor matches 100000..103999 unless score #click_value editor matches 11601..11602 unless score #click_value editor matches 11501 unless score #click_value editor matches 11502 unless score #click_value editor matches 11503..11506 unless score #click_value editor matches 11507..11511 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 11401..11408 unless score #click_value editor matches 100000..103999 unless score #click_value editor matches 11601..11602 unless score #click_value editor matches 11501 unless score #click_value editor matches 11502 unless score #click_value editor matches 11503..11506 unless score #click_value editor matches 11507..11511 run return fail

# 【返回】1560：仅返回主菜单（不清空 selection）
execute if score #click_value editor matches 11401 run function rhythm_axe:editor/menu/main
# 【清空选中并返回】11402（清空 selection + 每个音符的 selected 标记 + 黄光 + 交互 tag + #sel_count + **锚点实体**）
# ★ 2026-09-18：不再内联重写一遍，改调面板 10【取消选中】同款 `sel_clear_all_visual` ——
#   原来内联版漏了「清锚点」（用户实测：点这个按钮锚点不消失）；以后清选区的公共步骤只改那一个文件
#   注意：必须在 `menu/main` 之前（main 会重绘主菜单）
execute if score #click_value editor matches 11402 run function rhythm_axe:editor/menu/note/selected/sel_clear_all_visual
execute if score #click_value editor matches 11402 run function rhythm_axe:editor/menu/main
# 【批量编辑】11403 / 【批量复制】11404 / 【批量粘贴】11405 / 【粘贴并选中】11406 / 【批量删除】11407
execute if score #click_value editor matches 11403 run function rhythm_axe:editor/menu/note/batch/batch_open
execute if score #click_value editor matches 11404 run function rhythm_axe:editor/menu/note/selected/sel_batch_copy
execute if score #click_value editor matches 11405 run function rhythm_axe:editor/menu/note/selected/sel_batch_paste
# 粘贴并选中（粘贴到播放头 + 清空原选中 + 选中粘贴出来的音符）
execute if score #click_value editor matches 11406 run function rhythm_axe:editor/menu/note/selected/sel_paste_select
# 批量删除（直接删除全部选中音符，不弹二次确认；一次快照可撤销；删完回活跃列表）
execute if score #click_value editor matches 11407 run function rhythm_axe:editor/note/delete/batch_delete
# 批量剪切（11408）：剪切 = 复制到剪贴板 + 删除原音符（剪贴板保留 → 可接着【批量粘贴】）
execute if score #click_value editor matches 11408 run function rhythm_axe:editor/note/cut/batch_cut

# —— 动态行（值 = 100000 + 页内序×100 + 列码）：抠出列码(#temp_cursor) 与 页内序(#temp) ——
execute if score #click_value editor matches 100000..103999 run scoreboard players operation #temp_cursor editor = #click_value editor
execute if score #click_value editor matches 100000..103999 run scoreboard players remove #temp_cursor editor 100000
execute if score #click_value editor matches 100000..103999 run scoreboard players set #temp editor 100
execute if score #click_value editor matches 100000..103999 run scoreboard players operation #temp_cursor editor %= #temp editor
execute if score #click_value editor matches 100000..103999 run scoreboard players operation #temp editor = #click_value editor
execute if score #click_value editor matches 100000..103999 run scoreboard players remove #temp editor 100000
execute if score #click_value editor matches 100000..103999 run scoreboard players operation #temp editor /= 100 const
# sel_idx = sel_page×40 + 页内序（所有列共用）
execute if score #click_value editor matches 100000..103999 run execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor sel_page
execute if score #click_value editor matches 100000..103999 run scoreboard players set #temp_ig editor 40
execute if score #click_value editor matches 100000..103999 run scoreboard players operation #temp_playhead editor *= #temp_ig editor
execute if score #click_value editor matches 100000..103999 run scoreboard players operation #temp editor += #temp_playhead editor
# 复选框 0：取消选中该音符并重开已选定列表
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 0 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 0 run function rhythm_axe:editor/menu/note/selected/sel_note_toggle with storage rhythm_axe:prop
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 0 run data remove storage rhythm_axe:prop sel_idx
# 编辑 3（进面板 11）
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 3 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 3 run function rhythm_axe:editor/menu/note/selected/sel_note_panel_open_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 3 run data remove storage rhythm_axe:prop sel_idx
# 复制 5
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 5 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 5 run function rhythm_axe:editor/menu/note/selected/sel_note_copy_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 5 run data remove storage rhythm_axe:prop sel_idx
# 粘贴 6
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 6 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 6 run function rhythm_axe:editor/menu/note/selected/sel_note_paste_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 6 run data remove storage rhythm_axe:prop sel_idx
# 删除 7
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 7 run execute store result storage rhythm_axe:prop sel_idx int 1 run scoreboard players get #temp editor
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 7 run function rhythm_axe:editor/menu/note/selected/sel_note_delete_prep with storage rhythm_axe:prop
execute if score #click_value editor matches 100000..103999 if score #temp_cursor editor matches 7 run data remove storage rhythm_axe:prop sel_idx
# 清理临时
execute if score #click_value editor matches 100000..103999 run scoreboard players reset #temp editor
execute if score #click_value editor matches 100000..103999 run scoreboard players reset #temp_cursor editor
# 翻页（本面板 → sel_note_prev/next_page）
execute if score #click_value editor matches 11601 run function rhythm_axe:editor/menu/note/selected/sel_note_prev_page
execute if score #click_value editor matches 11602 run function rhythm_axe:editor/menu/note/selected/sel_note_next_page

# —— 时间轴翻转（11501）与镜像翻转组（11502/11503/11504/11505 开关 + 11506 执行），本面板刷新 sel_note_list_open ——
execute if score #click_value editor matches 11501 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_time
execute if score #click_value editor matches 11501 run return 0
# X 开关（11502）
execute if score #click_value editor matches 11502 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.x
execute if score #click_value editor matches 11502 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.x set value 1b
execute if score #click_value editor matches 11502 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.x set value 0b
execute if score #click_value editor matches 11502 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 11502 run return 0
# Y 开关（11503）
execute if score #click_value editor matches 11503 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.y
execute if score #click_value editor matches 11503 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.y set value 1b
execute if score #click_value editor matches 11503 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.y set value 0b
execute if score #click_value editor matches 11503 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 11503 run return 0
# Z 开关（11504）
execute if score #click_value editor matches 11504 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.z
execute if score #click_value editor matches 11504 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.z set value 1b
execute if score #click_value editor matches 11504 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.z set value 0b
execute if score #click_value editor matches 11504 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 11504 run return 0
# S 开关（11505）
execute if score #click_value editor matches 11505 run execute store result score #tmp editor run data get storage rhythm_axe:maps.editor mirror.s
execute if score #click_value editor matches 11505 if score #tmp editor matches 0 run data modify storage rhythm_axe:maps.editor mirror.s set value 1b
execute if score #click_value editor matches 11505 if score #tmp editor matches 1 run data modify storage rhythm_axe:maps.editor mirror.s set value 0b
execute if score #click_value editor matches 11505 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 11505 run return 0
# 执行翻转（11506）
execute if score #click_value editor matches 11506 run function rhythm_axe:editor/menu/note/panel/note_panel_flip_mirror
execute if score #click_value editor matches 11506 run return 0
# 旋转（11507=15° / 11508=45° / 11509=90°）：写角度 cos/sin（×10000）后按 [X][Y][Z] 开关绕包围盒中心轴旋转
execute if score #click_value editor matches 11507 run data modify storage rhythm_axe:prop rotate_cos set value 9659
execute if score #click_value editor matches 11507 run data modify storage rhythm_axe:prop rotate_sin set value 2588
execute if score #click_value editor matches 11508 run data modify storage rhythm_axe:prop rotate_cos set value 7071
execute if score #click_value editor matches 11508 run data modify storage rhythm_axe:prop rotate_sin set value 7071
execute if score #click_value editor matches 11509 run data modify storage rhythm_axe:prop rotate_cos set value 0
execute if score #click_value editor matches 11509 run data modify storage rhythm_axe:prop rotate_sin set value 10000
execute if score #click_value editor matches 11507..11509 run function rhythm_axe:editor/menu/note/panel/note_panel_rotate
execute if score #click_value editor matches 11507..11509 run return 0
# 锚点重置（11510）【⌖】：清掉锚点（含「被改过」标记）→ 按选中包围盒中心重建（回到自动跟随）→ 重绘本面板
execute if score #click_value editor matches 11510 run function rhythm_axe:editor/menu/note/anchor/anchor_reset
execute if score #click_value editor matches 11510 run return 0
# 应用锚点变换（11511）：把锚点的旋转+相对包围盒中心的位移当刚体变换套到选中音符判定位置（S 开则 start_pos 同旋转）
#   应用后锚点完全重置（位置回新中心 + 旋转归零 + 清 manual）⇒ 面板上【⌖】变回红
execute if score #click_value editor matches 11511 run function rhythm_axe:editor/menu/note/panel/note_panel_anchor_apply
execute if score #click_value editor matches 11511 run return 0
