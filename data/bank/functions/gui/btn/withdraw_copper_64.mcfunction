data modify entity @s Items append value {Slot:17b,id:"minecraft:copper_ingot",Count:64b,tag:{bank:{gui:1b},display:{Name:'{"text":"取出 铜×64","color":"gold"}'}}}

# 检查账户与准备金（取款占用准备金）
scoreboard players operation @p[distance=..4,limit=1] bank_tmp = @p[distance=..4,limit=1] copper
scoreboard players remove @p[distance=..4,limit=1] bank_tmp 64
scoreboard players operation @s bank_tmp2 = #C bank_reserve
scoreboard players remove @s bank_tmp2 64

# 成交：扣账户、给物品、准备金-、账本-
execute if score @p[distance=..4,limit=1] bank_tmp matches 0.. if score @s bank_tmp2 matches 0.. run scoreboard players remove @p[distance=..4,limit=1] copper 64
execute if score @p[distance=..4,limit=1] bank_tmp matches 0.. if score @s bank_tmp2 matches 0.. run give @p[distance=..4,limit=1] minecraft:copper_ingot 64
execute if score @p[distance=..4,limit=1] bank_tmp matches 0.. if score @s bank_tmp2 matches 0.. run scoreboard players remove #C bank_reserve 64
execute if score @p[distance=..4,limit=1] bank_tmp matches 0.. if score @s bank_tmp2 matches 0.. run scoreboard players remove #TC bank_total 64

# 提示（含余额）
execute if score @p[distance=..4,limit=1] bank_tmp matches 0.. if score @s bank_tmp2 matches 0.. run tellraw @p[distance=..4,limit=1] [{"text":"[银行] 取出 铜×64 ｜余额：铜 ","color":"gold"},{"score":{"name":"@p","objective":"copper"}},{"text":"，钻 ","color":"gray"},{"score":{"name":"@p","objective":"diamond"}}]
execute unless score @p[distance=..4,limit=1] bank_tmp matches 0.. run tellraw @p[distance=..4,limit=1] [{"text":"[银行] 你的账户余额不足。","color":"red"}]
execute if score @p[distance=..4,limit=1] bank_tmp matches 0.. unless score @s bank_tmp2 matches 0.. run tellraw @p[distance=..4,limit=1] [{"text":"[银行] 银行准备金不足。","color":"red"}]

scoreboard players reset @p[distance=..4,limit=1] bank_tmp
scoreboard players reset @s bank_tmp2
