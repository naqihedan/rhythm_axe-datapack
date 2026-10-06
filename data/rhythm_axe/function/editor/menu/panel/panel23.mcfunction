# 面板 23：工具选项栏（编辑器面板）。入口：把编辑工具放进副手 → editor/tool/offhand/* 换手后打开本面板。
# 显示内容由 maps.editor.tool_panel_gid 决定（1 音符工具 / 2 时间轴工具 / 3 回到开头·跳到结尾 /
#   4 播放速度 / 5 选择 / 6 事件点·时间点 / 7 协作）；渲染见 editor/menu/tool/panel/*。
#
# 号段：22001..22999（行 220+，避开面板 20 的 20001..21104）；1 = 返回"上一个打开的非工具面板"。
# 音符工具（分组 1）设置：固定音符位置（锁定 X/Y/Z 轴）
#   行 221 X 轴（红） / 行 222 Y 轴（绿） / 行 223 Z 轴（淡蓝）
#   列码：1 = 开关  2 = −1  3 = −0.1  4 = +0.1  5 = +1  6 = 使用注视位置  7 = 对齐方块中心
#
# 入口白名单守卫（两行：先提示再 return fail）
execute unless score #click_value editor matches 1 unless score #click_value editor matches 22001..22999 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1 unless score #click_value editor matches 22001..22999 run return fail

# 1 = 返回（回到"上一个打开的非工具面板"，不是主菜单）
execute if score #click_value editor matches 1 run return run function rhythm_axe:editor/tool/offhand/back
# 音符工具设置（22101..22307）
execute if score #click_value editor matches 22101..22307 run return run function rhythm_axe:editor/menu/tool/panel/note_adjust
# 其余值（22001..22100 / 22308..22999）暂未使用
function rhythm_axe:editor/menu/wrong_panel
