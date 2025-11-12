# === 初始化 ===
scoreboard objectives add copper dummy
scoreboard objectives add diamond dummy
scoreboard objectives add bank_tmp dummy
scoreboard objectives add bank_tmp2 dummy

scoreboard objectives add bank_rate dummy
scoreboard objectives add bank_reserve dummy
scoreboard objectives add bank_total dummy
scoreboard objectives add bank_fee dummy
scoreboard objectives add bank_const dummy
scoreboard objectives add bank_cfg dummy
scoreboard objectives add bankGUI trigger

# 常量
scoreboard players set #ONE bank_const 1
scoreboard players set #HUNDRED bank_const 100
scoreboard players set #PERMIL bank_const 1000

# 手续费（%）默认 2
execute unless score #FEE bank_fee matches 0.. run scoreboard players set #FEE bank_fee 2

# 准备金（默认初值，可运维修改）
execute unless score #C bank_reserve matches 1.. run scoreboard players set #C bank_reserve 1000000
execute unless score #D bank_reserve matches 1.. run scoreboard players set #D bank_reserve 1000

# 账面总资金（按交易增量维护）
execute unless score #TC bank_total matches 0.. run scoreboard players set #TC bank_total 0
execute unless score #TD bank_total matches 0.. run scoreboard players set #TD bank_total 0

# 交易数量常量
scoreboard players set #k1 bank_rate 1
scoreboard players set #k10 bank_rate 10
scoreboard players set #k64 bank_rate 64
scoreboard players set #k100 bank_rate 100
scoreboard players set #k1000 bank_rate 1000
scoreboard players set #k10000 bank_rate 10000

# ===== 可配置项（bank_cfg） =====
# 差额权重（‰）：EC = C + floor( (C-TC) * ALPHA_C / 1000 ), ED = D + floor( (D-TD) * ALPHA_D / 1000 )
execute unless score #ALPHA_C bank_cfg matches 0.. run scoreboard players set #ALPHA_C bank_cfg 1000
execute unless score #ALPHA_D bank_cfg matches 0.. run scoreboard players set #ALPHA_D bank_cfg 1000

# 最小/最大汇率（铜/钻）
execute unless score #RMIN bank_cfg matches 0.. run scoreboard players set #RMIN bank_cfg 1
execute unless score #RMAX bank_cfg matches 0.. run scoreboard players set #RMAX bank_cfg 999999

tellraw @a [{"text":"[银行] ","color":"aqua"},{"text":"输入 ","color":"gray"},{"text":"/trigger bankGUI","color":"yellow"},{"text":" 打开界面 ｜ 手续费 ","color":"gray"},{"score":{"name":"#FEE","objective":"bank_fee"}},{"text":"% ｜ αC=","color":"gray"},{"score":{"name":"#ALPHA_C","objective":"bank_cfg"}},{"text":"‰ αD=","color":"gray"},{"score":{"name":"#ALPHA_D","objective":"bank_cfg"}},{"text":"‰ ｜ 范围[","color":"gray"},{"score":{"name":"#RMIN","objective":"bank_cfg"}},{"text":",","color":"gray"},{"score":{"name":"#RMAX","objective":"bank_cfg"}},{"text":"]","color":"gray"}]