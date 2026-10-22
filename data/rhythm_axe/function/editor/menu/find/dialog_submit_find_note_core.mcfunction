#arg:type,color,tfrom,tto,insel,idfrom,idto,szfrom,szto,dfrom,dto,dnfrom,dnto,lifrom,lito,hvfrom,hvto,easing,power,hs,pt,igsp,fwp,px,py,pz,sx,sy,sz
# 查找音符提交·宏层（2026-10-22 全属性版，两层结构的第 1 层）：
#   ★★ 唯一职责：$ 行把外层传入的全部参数写进 prop 固定字段（fc_ 前缀），然后调纯普通函数
#   dialog_submit_find_note_go（第 2 层：解析 + 校验 + 进分刻扫描）。
#   ★★★ 为什么必须两层（2026-10-22 实测，见仓库记忆 macro_with_storage_rules.md）：
#   宏函数实例内，$ 行写入的 storage 对**后续所有行**（含普通命令）不可见 ⇒
#   「$ 写入 → 普通命令读」的混合结构全废；宏层只写不读、普通层只读不写宏参，各自干净。
#   ★★★ 数值字段用**列表写入** set value [$(xxx)]（2026-10-22 实测）：
#     "24" → [24]（数字元素，data get scale 可读）；"" → []（空 = 不限）；
#     "abc" → [abc]（合法 SNBT 字符串元素 → go 层 bad=1 报错）；
#     "12a" → [12a] 非法 SNBT → 本函数实例化失败 → 外层 #dlg_ok=9 哨兵提示「输入无效」。
#     ⚠ 若用字符串写入 set value "$(xxx)"，非空数字串也是字符串类型，data get 读不出数字（实测坑）。
#   枚举/布尔字段保持字符串写入（"all"/"0".."16"，match 函数字符串匹配正常）。
scoreboard players set #dlg_ok editor 0
scoreboard players set #fn_bad editor 0
$data modify storage rhythm_axe:prop fc_type set value "$(type)"
$data modify storage rhythm_axe:prop fc_color set value "$(color)"
$data modify storage rhythm_axe:prop fc_tfrom set value [$(tfrom)]
$data modify storage rhythm_axe:prop fc_tto set value [$(tto)]
$data modify storage rhythm_axe:prop fc_insel set value "$(insel)"
$data modify storage rhythm_axe:prop fc_idfrom set value [$(idfrom)]
$data modify storage rhythm_axe:prop fc_idto set value [$(idto)]
$data modify storage rhythm_axe:prop fc_szfrom set value [$(szfrom)]
$data modify storage rhythm_axe:prop fc_szto set value [$(szto)]
$data modify storage rhythm_axe:prop fc_dfrom set value [$(dfrom)]
$data modify storage rhythm_axe:prop fc_dto set value [$(dto)]
$data modify storage rhythm_axe:prop fc_dnfrom set value [$(dnfrom)]
$data modify storage rhythm_axe:prop fc_dnto set value [$(dnto)]
$data modify storage rhythm_axe:prop fc_lifrom set value [$(lifrom)]
$data modify storage rhythm_axe:prop fc_lito set value [$(lito)]
$data modify storage rhythm_axe:prop fc_hvfrom set value [$(hvfrom)]
$data modify storage rhythm_axe:prop fc_hvto set value [$(hvto)]
$data modify storage rhythm_axe:prop fc_easing set value "$(easing)"
$data modify storage rhythm_axe:prop fc_power set value "$(power)"
$data modify storage rhythm_axe:prop fc_hs set value "$(hs)"
$data modify storage rhythm_axe:prop fc_pt set value "$(pt)"
$data modify storage rhythm_axe:prop fc_igsp set value "$(igsp)"
$data modify storage rhythm_axe:prop fc_fwp set value "$(fwp)"
$data modify storage rhythm_axe:prop fc_px set value [$(px)]
$data modify storage rhythm_axe:prop fc_py set value [$(py)]
$data modify storage rhythm_axe:prop fc_pz set value [$(pz)]
$data modify storage rhythm_axe:prop fc_sx set value [$(sx)]
$data modify storage rhythm_axe:prop fc_sy set value [$(sy)]
$data modify storage rhythm_axe:prop fc_sz set value [$(sz)]
function rhythm_axe:editor/menu/find/dialog_submit_find_note_go
