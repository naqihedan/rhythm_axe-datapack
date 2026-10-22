# find_note_scan_drive 的「下一刻执行」包装：schedule 拉起时执行者是服务端（没有 @s），先切回正在用编辑器的玩家再继续扫。
# 协作：只作用于「本次操作者」（editor_lock_holder 优先，与 note_panel_*_next 同款）。
execute as @a[tag=editor_lock_holder,limit=1] run function rhythm_axe:editor/menu/find/find_note_scan_drive
execute unless entity @a[tag=editor_lock_holder] as @a[tag=editor_active,limit=1] run function rhythm_axe:editor/menu/find/find_note_scan_drive
