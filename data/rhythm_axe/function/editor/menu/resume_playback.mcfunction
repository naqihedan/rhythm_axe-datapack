# 播放相关操作（暂停/继续 23、调速 27、返回开头 28、跳到结尾 29、播放到尾自动暂停）后的「面板重绘守卫」。
# ★ 2026-09-17：这些操作只有两个面板的渲染内容真的会变 ——
#   面板 1 主菜单（▶/⏸ 按钮 + 51 格播放进度条按播放头着色）、
#   面板 10 活跃音符列表（存活窗口按 playhead 判定，重绘可把播放期间进出窗口的音符刷新掉）。
#   其余面板只读各自数据、与 playing/playhead 无关 → 不重绘。
#   ★ 2026-10-06：面板 10 的重开已改为「只遍历可能存活音符的下标窗口」（note_list_window + #note_hi），
#     不再是 O(谱长) 全表 3 趟遍历（1243 音符实测单次 ≈450ms → 窗口内几十个）；面板 18 仍是 O(选中×全谱)。
#   兜底：current_panel 缺失（异常）→ 仍走 resume（其内部会回落主菜单）。
scoreboard players reset #pb_panel editor
execute store result score #pb_panel editor run data get storage rhythm_axe:maps.editor current_panel
execute if score #pb_panel editor matches 1 run function rhythm_axe:editor/menu/resume
# ★ 2026-10-06：调用方设了 prop.skip_note_list（暂停→播放/恢复播放）→ 跳过面板 10 重绘：
#   播放头未变，列表内容不变，但重绘要清屏 + 重画整表；与同刻 refresh 叠加会明显掉刻。
execute if score #pb_panel editor matches 10 unless data storage rhythm_axe:prop skip_note_list run function rhythm_axe:editor/menu/resume
data remove storage rhythm_axe:prop skip_note_list
execute unless data storage rhythm_axe:maps.editor current_panel run function rhythm_axe:editor/menu/resume
