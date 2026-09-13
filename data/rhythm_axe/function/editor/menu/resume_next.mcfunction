# 返回当前面板「下一刻渲染」包装（跨刻安全调用 rhythm_axe:editor/menu/resume）
# ★ `resume` 会按 current_panel 打开对应面板（面板 10/18 会渲染整张音符列表，O(谱面)），
#   所以「refresh + resume」绝不能挤在同一条命令链里 → 重活做完后 schedule 本包装。
# ★ `schedule` 拉起时执行者是服务端（没有 @s），必须切回「正在用编辑器的玩家」。
# 用法：`schedule function rhythm_axe:editor/menu/resume_next 1t`
execute as @a[tag=editor_active] run function rhythm_axe:editor/menu/resume
