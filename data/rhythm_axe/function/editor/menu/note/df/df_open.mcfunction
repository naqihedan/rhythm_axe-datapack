# 打开面板 20「分布 / 插值填充」
# 入口：面板 10 / 18 底部共用组 11512【分布】 / 11513【插值填充】
# 每次打开都：① 参数重置为默认 ② 按「选区最早/最晚的选中音符」自动填端点 ③ 重绘
# 参数存 memory 位置：rhythm_axe:maps.editor editing.df（不随 /reload 清）

data modify storage rhythm_axe:maps.editor editing.df set value {t_ease:1,t_pow:1,t_a:0,t_b:0,s_ease:1,s_pow:1,s_a_fp:[0,0,0],s_b_fp:[0,0,0],dup:0b,dfsel:1b,spl:1b,mode:0b,cnt:3,stp:4}
# 来源面板（10 活跃列表 / 18 已选定列表）→【返回】用
execute store result storage rhythm_axe:maps.editor editing.df.from int 1 run data get storage rhythm_axe:maps.editor current_panel
data modify storage rhythm_axe:maps.editor current_panel set value 20
data modify storage rhythm_axe:maps.editor feedback set value "分布与填充：参数已按选区重置"
# 自动填端点开关：
#   起 ← 选区最早音符（时间 + 判定位置）
#   止 ← 选区最晚音符：**只在选区内有 ≥2 个音符时填**。
#        只选中 1 个时只把它当「起点」（起点上已有音符 ⇒ 填充时不会重复生成），
#        终点留给【出点】（← 播放头）或 ± 自己定。
scoreboard players set #df_on editor 0
execute store result score #df_on editor run data get storage rhythm_axe:maps.editor selection
data modify storage rhythm_axe:prop w_ta set value 1b
data modify storage rhythm_axe:prop w_sa set value 1b
execute if score #df_on editor matches 2.. run data modify storage rhythm_axe:prop w_tb set value 1b
execute if score #df_on editor matches 2.. run data modify storage rhythm_axe:prop w_sb set value 1b
function rhythm_axe:editor/menu/note/df/df_scan
function rhythm_axe:editor/menu/note/df/df_render
