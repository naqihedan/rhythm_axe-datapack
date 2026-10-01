# 清除标题展示实体（谱面设置面板的「Axiom 改标题」通道）
# 调用点：点【复制展示实体文字信息】后 / 关闭谱面设置面板（保存、取消）/ reload 残留清理
# 实体存在才 kill（空选择器的 kill 是命令失败，避免多余报错）
execute if entity @e[tag=rhythm_axe_title_display] run kill @e[tag=rhythm_axe_title_display]
schedule clear rhythm_axe:editor/menu/map/ops/map_title_display_timeout
