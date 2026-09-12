---
description: "rhythm_axe 编辑器按钮（trigger editor_click 值）编号规范与新增/修改流程。Use when: 新增编辑器按钮、修改/迁移 trigger 值、动 panelN 守卫或分支、改编辑器的 trigger 表。"
applyTo: "**/data/rhythm_axe/**"
---

# rhythm_axe 编辑器按钮（trigger 值）规范

> 权威文档：`节奏地图开发文档/编辑器.md` 的《trigger值》一节（完整号段总表 / 列码约定 / 新增按钮 checklist / 常见坑 / 迁移记录）。**动手前先读它**，本文件只是硬约束摘要。

## 核心规则

值 = `行号×100 + 列码`（行号 ≥ 100，列码从 1 起）：

| 场景 | 公式 | 例 |
| --- | --- | --- |
| 固定控件 | `行号×100 + 列码` | `12001` = 行 120 列 01 |
| 动态行（每页 ≤9 行） | `(1000+页内行序)×100 + 列码` | `10757` |
| 动态行（每页 40 行） | `100000 + 页内序×100 + 列码` | `100003` |

列表类列码固定：`0` 复选框/开关、`1` 减、`2` 加、`3` 编辑、`5` 复制、`6` 粘贴、`7` 删除。字段类面板可自定，但必须在面板表头注明。

**页码不进值**：翻页值固定（`11601`/`11602`），页码存 `notes_page`/`sel_page`，处理器用 `页号×每页数 + 页内序` 还原真实下标。

**共用组**（仅跨多面板共用才用）：`11501`~`11509` = 翻转/镜像/旋转组（面板 10/18）；另有 `1` 返回主菜单、`8`/`9` 撤销重做、`20`~`29` 时间控件、`903` 恢复编辑（全局）。**单面板按钮一律用该面板自己的号段。**

## 改一个按钮值 = 必须同步 4 处

1. **发射点**：渲染该面板的 mcfunction 里按钮的 `click_event` → `/trigger editor_click set <值>`
2. **守卫**：`editor/menu/panel/panelN.mcfunction` 顶部**两行**白名单 `unless ... matches <号段>`（漏加 ⇒ 点了提示「该按钮不属于当前面板」）
3. **分支**：同文件里 `execute if score #click_value editor matches <值> run ...`
4. **文档**：`编辑器.md` 里该面板的 trigger 表

## 查重（必做，否则会撞号双触发）

```
grep -rn "editor_click set <值>" data/      # 谁发的
grep -rn "matches <值>" data/               # 谁处理的（注意范围写法会把段内的值「吞掉」）
python scripts/audit_injected_trigger_values.py    # 全局孤儿值审计
```

⚠️ **按钮值有三种写法，只 grep `editor_click set <数字>` 会漏掉两种**：
- **宏参数注入**：`data modify storage rhythm_axe:prop <key> set value N` + 宏内 `editor_click set $(<key>)`（例：位置三轴的 `bxm..bzp2` → `note_pos_row`）
- **宏拼接**：`editor_click set 1128$(index)`（实际值 11280~11289）

## 收尾必做

- `/reload`（新函数/新按钮值必须重载；加载失败只进游戏日志 `Failed to load function`）
- `scripts\check_all_macros.ps1` → 必须 0 错误
- `python scripts/check_all_panel_coverage.py` → 应满足 `emit ⊆ 守卫 ⊆ 分支`
- 桥接实测点一次：`bridge.ps1 runchat "trigger editor_click set <值>" -As <玩家>`

⚠️ 上述两项**静态检查只覆盖「值级」**，查不出**条件组合漏分支**这类语义问题（例：批量+绝对模式下 `prop.xcomp` 少写一个分支会让行首 `[x]` 整条消失）——值级通过后仍需按「相对/绝对 × 单音符/批量」等模式组合逐项核对 + 实测。
