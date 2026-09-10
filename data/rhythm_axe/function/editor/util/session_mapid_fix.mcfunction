# 会话自检（每次编辑器点击时调用）：editor.mapid 缺失时，从工作副本 history[history_cursor].id 修回
# ★ 为什么需要：editor.mapid 是会话身份，保存/删除/改名/另存等宏调用都靠它；
#   一旦缺失，`with storage prop` 的宏函数会因宏参数缺失而「静默实例化失败」→ 按钮点了没反应。
#   正常路径零输出（只在异常时提示）。
# ⚠️ 不要用 {mapid:""} 复合标签判空串：MC 解析空串谓词会报【无效的字符串内容】并中断函数。
#    这里只在“键真缺失”时修（空串只出现在刚进编辑器、未加载谱面的瞬时状态）。
execute unless data storage rhythm_axe:maps.editor mapid run execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
execute unless data storage rhythm_axe:maps.editor mapid run function rhythm_axe:editor/util/session_mapid_fix_m with storage rhythm_axe:prop
execute unless data storage rhythm_axe:maps.editor mapid run data remove storage rhythm_axe:prop cursor
