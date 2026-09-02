# 添加一条空指令（默认 goodE-goodL 启用、spawn/bad/miss/damage 禁用，与文档一致）
data modify storage rhythm_axe:maps.editor editing.he_events append value {command:"",enabled:{spawn:0b,tick:0b,bad:0b,good_early:1b,perfect_early:1b,perfect:1b,perfect_late:1b,good_late:1b,miss:0b,damage:0b}}
function rhythm_axe:editor/menu/note/hit_events/note_hit_events_panel
