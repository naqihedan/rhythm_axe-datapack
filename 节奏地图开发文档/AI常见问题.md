# AI常见问题

# 命令方面

- 宏命开头令不写$或者非宏命令开头却写$
- 把代码注释写在同一行
- data命令语法错误
- execute if/unless data 命令语法错误
- 用计分板不在load函数里注册
- 用const计分板新数字常量不在load里注册
- 使用截图功能识别游戏内容图像（AI的识图模型烂的要死不如不用）

# 编辑器按钮（trigger）方面

> 完整规范（触发链 / 编号规则 spec v2 / 号段分配总表 / 新增按钮 checklist）见 `编辑器.md` 的《trigger值》一节。以下是高频踩坑：

- **新增按钮值不查重** → 与其它面板撞号，同一个值双触发（曾因 `842~855` 撞面板 13 的 `830~851`）。加值前必须 grep 发射点（`editor_click set`）与处理点（`matches`，注意范围会被"吞"）。
- **加了按钮却忘了同步白名单守卫** → `panelN.mcfunction` 顶部两行 `unless ... matches <号段>`，漏加就提示"该按钮不属于当前面板"、点了没反应。
- **动态列表行用了绝对行号** → 必须用页内相对值，页码存 `notes_page`/`sel_page`，处理器还原 `页号×每页数 + 页内序`。
- **旧范围迁移后仍写一条大范围** → 跨多个新行的范围（如 `768..781`）必须按连续段拆成多条 `execute`。
- **只查 `editor_click set` 就断言“改全了”** → 按钮值还有两种隐藏写法：①宏参数注入（`data modify storage rhythm_axe:prop <key> set value N` + 宏内 `editor_click set $(<key>)`，如位置三轴的 `bxm..bzp2`）；②宏拼接（`set 1128$(index)`）。漏改的后果是守卫生效、按钮发旧号 ⇒ 点了提示“该按钮不属于当前面板”。全局审计：`python scripts/audit_injected_trigger_values.py`。
- **忘更新文档**：改完 trigger 值要同步 `编辑器.md` 对应面板的表，否则下次照旧表加号必撞。
