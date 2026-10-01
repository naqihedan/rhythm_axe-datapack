# 共享大厅·同步总表：选曲/预览是**全局状态**，所以任何人的选择都要在所有人的总表上看得见
#   · 点击者（@s）**无条件**重绘（他刚点过这一行的按钮，哪怕他是在编辑器里开着列表看）
#   · 其它「正在看总表」的人一起重绘：每人保留自己的页码（menu_page 是按玩家的）
#   · 正在编辑器里（tag editor_active）或正在游玩（team=player）的人**不刷** —— 会洗掉他们的面板/聊天
#   · 用临时 tag ml_self 把点击者从"其它人"里摘出去，避免他收到两份渲染
# ⚠️ 用 tag 而不是 @a[...] 硬广播：分辨不出"谁正在看这一页"就乱刷，会把别人的界面洗掉
tag @s add ml_self
function rhythm_axe:map_list/maps/list_open
execute as @a[tag=maplist_view,tag=!ml_self,tag=!editor_active,team=!player] run function rhythm_axe:map_list/maps/list_open
tag @s remove ml_self
