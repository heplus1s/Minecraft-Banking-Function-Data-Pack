data modify entity @s Items append value {Slot:20b,id:"minecraft:redstone",Count:64b,tag:{bank:{gui:1b},display:{Name:'{"text":"卖出 钻×64","color":"dark_red"}'}}}

# base = rate * 64
scoreboard players operation @p[distance=..4,limit=1] bank_tmp = #rate bank_rate
scoreboard players operation @p[distance=..4,limit=1] bank_tmp *= #k64 bank_rate

# fee = floor(base * FEE / 100)
scoreboard players operation @p[distance=..4,limit=1] bank_tmp2 = @p[distance=..4,limit=1] bank_tmp
scoreboard players operation @p[distance=..4,limit=1] bank_tmp2 *= #FEE bank_fee
scoreboard players operation @p[distance=..4,limit=1] bank_tmp2 /= #HUNDRED bank_const

# net = base - fee
scoreboard players operation @p[distance=..4,limit=1] bank_tmp -= @p[distance=..4,limit=1] bank_tmp2

# 检查 玩家钻
scoreboard players operation @p[distance=..4,limit=1] bank_tmp2 = @p[distance=..4,limit=1] diamond
scoreboard players remove @p[distance=..4,limit=1] bank_tmp2 64

# 成交（准备金不变）：账户 & 账本
execute if score @p[distance=..4,limit=1] bank_tmp2 matches 0.. run scoreboard players remove @p[distance=..4,limit=1] diamond 64
execute if score @p[distance=..4,limit=1] bank_tmp2 matches 0.. run scoreboard players operation @p[distance=..4,limit=1] copper += @p[distance=..4,limit=1] bank_tmp
execute if score @p[distance=..4,limit=1] bank_tmp2 matches 0.. run scoreboard players remove #TD bank_total 64
execute if score @p[distance=..4,limit=1] bank_tmp2 matches 0.. run scoreboard players operation #TC bank_total += @p[distance=..4,limit=1] bank_tmp

# 提示
execute if score @p[distance=..4,limit=1] bank_tmp2 matches 0.. run tellraw @p[distance=..4,limit=1] [{"text":"[银行] 卖出 钻×64 成功 ｜余额：铜 ","color":"dark_red"},{"score":{"name":"@p","objective":"copper"}},{"text":"，钻 ","color":"gray"},{"score":{"name":"@p","objective":"diamond"}}]
execute unless score @p[distance=..4,limit=1] bank_tmp2 matches 0.. run tellraw @p[distance=..4,limit=1] [{"text":"[银行] 你的钻石不足。","color":"red"}]

scoreboard players reset @p[distance=..4,limit=1] bank_tmp
scoreboard players reset @p[distance=..4,limit=1] bank_tmp2
