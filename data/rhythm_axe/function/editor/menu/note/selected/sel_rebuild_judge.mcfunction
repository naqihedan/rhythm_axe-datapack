#arg:cursor,i
# 音符带 selected → 追加其 id 到 selection（遍历 notes 是时间序 → selection 天然按 notes 顺序）
# ★ 用 .selected 路径存在性判断（storage 不支持 {selected:1b} 复合匹配，会命令参数错误）
# ★ append from storage prop nid（运行时读取 prop.nid；宏 $(nid) 在实例化时替换，拿不到运行时值）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].selected run execute store result storage rhythm_axe:prop nid int 1 run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].id
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].selected run data modify storage rhythm_axe:maps.editor selection append from storage rhythm_axe:prop nid
