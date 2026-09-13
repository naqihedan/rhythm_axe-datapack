# 主菜单「下一刻渲染」包装（跨刻安全调用 rhythm_axe:editor/menu/main）
# ★ 为什么需要它：`schedule` 拉起时执行者是**服务端**（没有 @s），而菜单里全是 tellraw @s；
#   任何被 schedule 的渲染函数都必须先用本包装切回「正在用编辑器的玩家」。
# 用法：把调用点里的 `function rhythm_axe:editor/menu/main` 换成
#       `schedule function rhythm_axe:editor/menu/main_next 1t`
execute as @a[tag=editor_active] run function rhythm_axe:editor/menu/main
