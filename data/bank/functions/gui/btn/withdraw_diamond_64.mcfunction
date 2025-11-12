data modify entity @s Items append value {Slot:26b,id:"minecraft:diamond",Count:64b,tag:{bank:{gui:1b},display:{Name:'{"text":"取出 钻×64","color":"aqua"}'}}}

# 检查账户与准备金（取款占用准备金）
scoreboard players operation @p[distance=..4,limit=1] bank_tmp = @p[distance=..4,limit=1] diamond
scoreboard players remove @p[distance=..4,limit=1] bank_tmp 64
scoreboard players operation @s bank_tmp2 = #D bank_reserve
scoreboard players remove @s bank_tmp2 64

# 成交：扣账户、给物品、准备金-、账本-
execute if score @p[distance=..4,limit=1] bank_tmp matches 0.. if score @s bank_tmp2 matches 0.. run scoreboard players remove @p[distance=..4,limit=1] diamond 64
execute if score @p[distance=..4,limit=1] bank_tmp matches 0.. if score @s bank_tmp2 matches 0.. run give @p[distance=..4,limit=1] minecraft:diamond 64
execute if score @p[distance=..4,limit=1] bank_tmp matches 0.. if score @s bank_tmp2 matches 0.. run scoreboard players remove #D bank_reserve 64
execute if score @p[distance=..4,limit=1] bank_tmp matches 0.. if score @s bank_tmp2 matches 0.. run scoreboard players remove #TD bank_total 64

# 提示（含余额）
execute if score @p[distance=..4,limit=1] bank_tmp matches 0.. if score @s bank_tmp2 matches 0.. run tellraw @p[distance=..4,limit=1] [{"text":"[银行] 取出 钻×64 ｜余额：铜 ","color":"aqua"},{"score":{"name":"@p","objective":"copper"}},{"text":"，钻 ","color":"gray"},{"score":{"name":"@p","objective":"diamond"}}]
execute unless score @p[distance=..4,limit=1] bank_tmp matches 0.. run tellraw @p[distance=..4,limit=1] [{"text":"[银行] 你的账户余额不足。","color":"red"}]
execute if score @p[distance=..4,limit=1] bank_tmp matches 0.. unless score @s bank_tmp2 matches 0.. run tellraw @p[distance=..4,limit=1] [{"text":"[银行] 银行准备金不足。","color":"red"}]

scoreboard players reset @p[distance=..4,limit=1] bank_tmp
scoreboard players reset @s bank_tmp2
