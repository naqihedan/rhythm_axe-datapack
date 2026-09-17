# 操作后刷新入口：刷新世界中的编辑器音符（实时显示谱面内容）
# 各修改类入口在 commit 后调用本函数；当前实现 = 整体重建（后续改为按稳定 id 增量更新）
# ★ 锚点（镜像/旋转中心）的同步不需要在这里再插一次：visual/refresh 末尾的 sel_rebuild 已经调了 anchor_sync
function rhythm_axe:editor/visual/refresh
