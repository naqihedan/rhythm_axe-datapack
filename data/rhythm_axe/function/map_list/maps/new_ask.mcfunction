# 谱面总表操作行【＋新建谱面】（值 11904）：弹输入框，让玩家填新谱面的 id。
# ★ 2026-10-01 新增。菜单系统（页面 19）固定值，同步 4 处：本函数（发射点由 list_open 渲染）
#   · rhythm_axe:menu/consume          号段 11901..11904
#   · map_list/panel/panel19           守卫白名单 11901..11904
#   · map_list/panel/panel19           分支 11904 → 本文件
#   · map_list/maps/list_open          操作行 tellraw 里的按钮
# ⚠️ 新增 dialog 文件后**必须重启世界**才会加载（/reload 不重扫 dialog 注册表）。
dialog show @s rhythm_axe:map_new
