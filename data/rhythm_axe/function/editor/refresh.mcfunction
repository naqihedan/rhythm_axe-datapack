# 操作后刷新入口：刷新世界中的编辑器音符（实时显示谱面内容）
# 各修改类入口在 commit 后调用本函数；当前实现 = 整体重建（后续改为按稳定 id 增量更新）
function rhythm_axe:editor/visual/refresh
