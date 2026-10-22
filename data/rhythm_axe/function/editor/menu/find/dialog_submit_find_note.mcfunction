#arg: type,color,tfrom,tto,insel,idfrom,idto,szfrom,szto,dfrom,dto,dnfrom,dnto,lifrom,lito,hvfrom,hvto,easing,power,hs,pt,igsp,fwp,px,py,pz,sx,sy,sz
# ★ 外层「安全转发」（2026-10-17 拆层）：json 提交的软输入可能是 `12a` 这种**非法 SNBT** ——
#   若内层直接在宏行里写 `set value [$(xxx)]`，内层会**实例化失败**（整个内层不执行，点确认毫无反应）。
#   ⚠ 实测事实：**被调函数实例化失败不会中断调用者** ⇒ 本层用哨兵 #dlg_ok=9 判断「内层压根没跑」：
#     内层开头会把它置 0；外层调用后仍是 9 ⇒ 内层没跑 ⇒ 补一句提示。故【查找并选中】总会有反馈。
#   本层唯一的宏行把全部参数嵌进 **JSON 字符串** —— 任何内容都合法（除非含未转义引号）⇒ 本层永不失败。
#   下拉（type/color/easing/power/hs/pt/igsp/fwp）来自 single_option（all/数字）；
#   复选框 insel 是 boolean（on_true="1"/on_false="0"）；其余是文本框（可能空）。
scoreboard players set #dlg_ok editor 9
$function rhythm_axe:editor/menu/find/dialog_submit_find_note_core {"type":"$(type)","color":"$(color)","tfrom":"$(tfrom)","tto":"$(tto)","insel":"$(insel)","idfrom":"$(idfrom)","idto":"$(idto)","szfrom":"$(szfrom)","szto":"$(szto)","dfrom":"$(dfrom)","dto":"$(dto)","dnfrom":"$(dnfrom)","dnto":"$(dnto)","lifrom":"$(lifrom)","lito":"$(lito)","hvfrom":"$(hvfrom)","hvto":"$(hvto)","easing":"$(easing)","power":"$(power)","hs":"$(hs)","pt":"$(pt)","igsp":"$(igsp)","fwp":"$(fwp)","px":"$(px)","py":"$(py)","pz":"$(pz)","sx":"$(sx)","sy":"$(sy)","sz":"$(sz)"}
execute if score #dlg_ok editor matches 9 run tellraw @s [{"text":"[查找] ","color":"gray"},{"text":"输入无效，请检查数值条件是否为数字（留空 = 不限）","color":"red"}]
