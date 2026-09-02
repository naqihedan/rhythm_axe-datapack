# 诊断：实时显示谱面功能状态（跑 function rhythm_axe:editor/visual/diag）
# 打印：音符数 / playhead / note_speed / 第一个音符数据 / 展示实体是否存在+Pos / 游标
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/visual/diag_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor

