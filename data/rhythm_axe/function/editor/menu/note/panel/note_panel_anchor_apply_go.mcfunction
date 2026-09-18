# 应用锚点变换 —— 真正干活的实现
# 由 note_panel_anchor_apply 分发进来：处理音符数 ≤ 50 → 本刻直调；> 50 → 由 note_panel_anchor_apply_next 跨刻调用。
execute store result score #from editor run data get storage rhythm_axe:maps.editor current_panel
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "应用锚点变换"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
# ① 变换参数：中心 C → #rc0/1/2、锚点位置 A → #an_x/y/z、矩阵 → #r11..#r33（旋转 + 「锚点 scale 三轴×4」已按列折进矩阵）
#    （anchor_center 需要 prop.cursor，已在上面设好；无锚点实体时 anchor_read 给 #an_has=0，此时 A 会退化成 C、R 退化成单位阵 ⇒ 等效空操作）
function rhythm_axe:editor/menu/note/anchor/anchor_center
function rhythm_axe:editor/menu/note/anchor/anchor_read
execute if score #an_has editor matches 0 run scoreboard players operation #an_x editor = #rc0 editor
execute if score #an_has editor matches 0 run scoreboard players operation #an_y editor = #rc1 editor
execute if score #an_has editor matches 0 run scoreboard players operation #an_z editor = #rc2 editor
function rhythm_axe:editor/menu/note/anchor/anchor_matrix
# ② S 开关（是否同时把 start_pos 绕各音符自己的判定位置旋转）
execute store result score #mirror_s editor run data get storage rhythm_axe:maps.editor mirror.s
# ③ 逐个选中音符套用变换
scoreboard players set #flip_i editor 0
execute store result score #flip_total editor run data get storage rhythm_axe:maps.editor selection
data modify storage rhythm_axe:prop flip_cursor set value 0
function rhythm_axe:editor/menu/note/panel/note_panel_anchor_apply_drive
data remove storage rhythm_axe:prop flip_cursor
# ④ 收尾：落快照 → 锚点完全重置（按新几何回到中心、旋转归零、变回红）→ 重建视觉
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/menu/note/anchor/anchor_rebuild_at_center
function rhythm_axe:editor/refresh
scoreboard players add #content_ver editor 1
execute store result storage rhythm_axe:maps.editor content_ver int 1 run scoreboard players get #content_ver editor
data modify storage rhythm_axe:maps.editor feedback set value "已应用锚点变换"
data remove storage rhythm_axe:maps.editor editing
data remove storage rhythm_axe:prop cursor
# ★ 回面板改为「下一刻渲染」：本文件前面已有 refresh（整表重建视觉）+ 逐音符遍历，同刻渲染列表会超命令链被截断
schedule function rhythm_axe:editor/menu/note/panel/note_panel_return_next 1t
