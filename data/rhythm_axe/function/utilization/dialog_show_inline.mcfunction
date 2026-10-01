#arg:dialog
# 显示「内联对话框」：dialog = 完整对话框 NBT，由调用方先用 data modify 建好再 with storage 传进来
# ★ 为什么用内联，而不是 data/rhythm_axe/dialog/*.json：
#   ① 改文案/结构只需 /reload，**不必重启世界**（注册表型对话框改内容也必须重启世界）
#   ② 正文能做「动态内容」：把值当 NBT 拼进去即可 —— 对话框正文**不解析** nbt/score/selector 组件
#      （MC-297871，26.2 截图实测），所以那些节点会渲染成空白；拼字面量则正常
#   ③ 少一个 JSON 文件，对话框 NBT 还能用 data modify 增量拼（长宏行也能拆开）
# ⚠️ dialog 全程必须是 NBT：宏替换会自动做 SNBT 转义（换行/引号都安全）；
#    直接把裸字符串（含真换行）塞进宏参数会把命令截断（参见 AI常见问题）
# 用法：见 ops/confirm_delete、map/ops/map_title_reset_ask、map_list/lb/del_read
$dialog show @s $(dialog)
