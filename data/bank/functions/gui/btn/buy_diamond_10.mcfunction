data modify entity @s Items append value {Slot:10b,id:"minecraft:emerald",Count:10b,tag:{bank:{gui:1b},display:{Name:'{"text":"买入 钻×10","color":"green"}'}}}

# base = rate * 10
scoreboard players operation @p[distance=..4,limit=1] bank_tmp = #rate bank_rate
scoreboard players operation @p[distance=..4,limit=1] bank_tmp *= #k10 bank_rate

# fee = floor(base * FEE / 100)
scoreboard players operation @p[distance=..4,limit=1] bank_tmp2 = @p[distance=..4,limit=1] bank_tmp
scoreboard players operation @p[distance=..4,limit=1] bank_tmp2 *= #FEE bank_fee
scoreboard players operation @p[distance=..4,limit=1] bank_tmp2 /= #HUNDRED bank_const

# total = base + fee
scoreboard players operation @p[distance=..4,limit=1] bank_tmp += @p[distance=..4,limit=1] bank_tmp2

# 检查 玩家铜
scoreboard players operation @p[distance=..4,limit=1] bank_tmp2 = @p[distance=..4,limit=1] copper
scoreboard players operation @p[distance=..4,limit=1] bank_tmp2 -= @p[distance=..4,limit=1] bank_tmp

# 成交（准备金不变）：账户 & 账本
execute if score @p[distance=..4,limit=1] bank_tmp2 matches 0.. run scoreboard players operation @p[distance=..4,limit=1] copper -= @p[distance=..4,limit=1] bank_tmp
execute if score @p[distance=..4,limit=1] bank_tmp2 matches 0.. run scoreboard players add @p[distance=..4,limit=1] diamond 10
execute if score @p[distance=..4,limit=1] bank_tmp2 matches 0.. run scoreboard players operation #TC bank_total -= @p[distance=..4,limit=1] bank_tmp
execute if score @p[distance=..4,limit=1] bank_tmp2 matches 0.. run scoreboard players add #TD bank_total 10

# 提示
execute if score @p[distance=..4,limit=1] bank_tmp2 matches 0.. run tellraw @p[distance=..4,limit=1] [{"text":"[银行] 买入 钻×10 成功 ｜余额：铜 ","color":"green"},{"score":{"name":"@p","objective":"copper"}},{"text":"，钻 ","color":"gray"},{"score":{"name":"@p","objective":"diamond"}}]
execute unless score @p[distance=..4,limit=1] bank_tmp2 matches 0.. run tellraw @p[distance=..4,limit=1] [{"text":"[银行] 铜锭不足。","color":"red"}]

scoreboard players reset @p[distance=..4,limit=1] bank_tmp
scoreboard players reset @p[distance=..4,limit=1] bank_tmp2
