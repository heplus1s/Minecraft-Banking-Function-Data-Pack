# ===== 差额驱动汇率 =====
# EC = C + floor( (C - TC) * ALPHA_C / 1000 )
scoreboard players operation #EC bank_rate = #C bank_reserve
scoreboard players operation @s bank_tmp = #C bank_reserve
scoreboard players operation @s bank_tmp -= #TC bank_total
scoreboard players operation @s bank_tmp *= #ALPHA_C bank_cfg
scoreboard players operation @s bank_tmp /= #PERMIL bank_const
scoreboard players operation #EC bank_rate += @s bank_tmp

# ED = D + floor( (D - TD) * ALPHA_D / 1000 )
scoreboard players operation #ED bank_rate = #D bank_reserve
scoreboard players operation @s bank_tmp = #D bank_reserve
scoreboard players operation @s bank_tmp -= #TD bank_total
scoreboard players operation @s bank_tmp *= #ALPHA_D bank_cfg
scoreboard players operation @s bank_tmp /= #PERMIL bank_const
scoreboard players operation #ED bank_rate += @s bank_tmp

# rate = EC / max(1, ED)
scoreboard players operation @s bank_tmp = #ED bank_rate
execute if score @s bank_tmp matches ..0 run scoreboard players operation @s bank_tmp = #ONE bank_const
scoreboard players operation #rate bank_rate = #EC bank_rate
scoreboard players operation #rate bank_rate /= @s bank_tmp

# 限幅
execute if score #rate bank_rate < #RMIN bank_cfg run scoreboard players operation #rate bank_rate = #RMIN bank_cfg
execute if score #rate bank_rate > #RMAX bank_cfg run scoreboard players operation #rate bank_rate = #RMAX bank_cfg

# 行动栏
title @p[distance=..4,limit=1] actionbar [{"text":"汇率：","color":"yellow"},{"score":{"name":"#rate","objective":"bank_rate"}},{"text":" 铜/钻 ｜ 手续费：","color":"yellow"},{"score":{"name":"#FEE","objective":"bank_fee"}},{"text":"%","color":"yellow"}]

# ===== 存入（槽 2）：账户 + 准备金 + 账面合计，并提示余额 =====
execute store result score @p[distance=..4,limit=1] bank_tmp run data get entity @s Items[{Slot:2b}].Count 1
# 存铜
# 账户/准备金/账本
execute if data entity @s Items[{Slot:2b,id:"minecraft:copper_ingot"}] unless data entity @s Items[{Slot:2b,tag:{bank:{gui:1b}}}] run scoreboard players operation @p[distance=..4,limit=1] copper += @p[distance=..4,limit=1] bank_tmp
execute if data entity @s Items[{Slot:2b,id:"minecraft:copper_ingot"}] unless data entity @s Items[{Slot:2b,tag:{bank:{gui:1b}}}] run scoreboard players operation #C bank_reserve += @p[distance=..4,limit=1] bank_tmp
execute if data entity @s Items[{Slot:2b,id:"minecraft:copper_ingot"}] unless data entity @s Items[{Slot:2b,tag:{bank:{gui:1b}}}] run scoreboard players operation #TC bank_total += @p[distance=..4,limit=1] bank_tmp
# 先提示（用玩家上下文，分数用 @s 取）
execute if data entity @s Items[{Slot:2b,id:"minecraft:copper_ingot"}] unless data entity @s Items[{Slot:2b,tag:{bank:{gui:1b}}}] run execute as @p[distance=..4,sort=nearest,limit=1] run tellraw @s [{"text":"[银行] 存入 铜锭 成功 ｜余额：铜 ","color":"gold"},{"score":{"name":"@s","objective":"copper"}},{"text":"，钻 ","color":"gray"},{"score":{"name":"@s","objective":"diamond"}}]
# 再移除存入物
execute if data entity @s Items[{Slot:2b,id:"minecraft:copper_ingot"}] unless data entity @s Items[{Slot:2b,tag:{bank:{gui:1b}}}] run data remove entity @s Items[{Slot:2b}]
scoreboard players reset @p[distance=..4,limit=1] bank_tmp

execute store result score @p[distance=..4,limit=1] bank_tmp run data get entity @s Items[{Slot:2b}].Count 1
# 存钻
# 账户/准备金/账本
execute if data entity @s Items[{Slot:2b,id:"minecraft:diamond"}] unless data entity @s Items[{Slot:2b,tag:{bank:{gui:1b}}}] run scoreboard players operation @p[distance=..4,limit=1] diamond += @p[distance=..4,limit=1] bank_tmp
execute if data entity @s Items[{Slot:2b,id:"minecraft:diamond"}] unless data entity @s Items[{Slot:2b,tag:{bank:{gui:1b}}}] run scoreboard players operation #D bank_reserve += @p[distance=..4,limit=1] bank_tmp
execute if data entity @s Items[{Slot:2b,id:"minecraft:diamond"}] unless data entity @s Items[{Slot:2b,tag:{bank:{gui:1b}}}] run scoreboard players operation #TD bank_total += @p[distance=..4,limit=1] bank_tmp
# 先提示（玩家上下文）
execute if data entity @s Items[{Slot:2b,id:"minecraft:diamond"}] unless data entity @s Items[{Slot:2b,tag:{bank:{gui:1b}}}] run execute as @p[distance=..4,sort=nearest,limit=1] run tellraw @s [{"text":"[银行] 存入 钻石 成功 ｜余额：铜 ","color":"aqua"},{"score":{"name":"@s","objective":"copper"}},{"text":"，钻 ","color":"gray"},{"score":{"name":"@s","objective":"diamond"}}]
# 再移除存入物
execute if data entity @s Items[{Slot:2b,id:"minecraft:diamond"}] unless data entity @s Items[{Slot:2b,tag:{bank:{gui:1b}}}] run data remove entity @s Items[{Slot:2b}]
scoreboard players reset @p[distance=..4,limit=1] bank_tmp

# ===== 按钮检测 =====
execute unless data entity @s Items[{Slot:8b}] run function bank:gui/btn/close

execute unless data entity @s Items[{Slot:9b}] run function bank:gui/btn/buy_diamond_1
execute unless data entity @s Items[{Slot:10b}] run function bank:gui/btn/buy_diamond_10
execute unless data entity @s Items[{Slot:11b}] run function bank:gui/btn/buy_diamond_64
execute unless data entity @s Items[{Slot:12b}] run function bank:gui/btn/buy_diamond_100
execute unless data entity @s Items[{Slot:13b}] run function bank:gui/btn/buy_diamond_1000
execute unless data entity @s Items[{Slot:14b}] run function bank:gui/btn/buy_diamond_10000

execute unless data entity @s Items[{Slot:18b}] run function bank:gui/btn/sell_diamond_1
execute unless data entity @s Items[{Slot:19b}] run function bank:gui/btn/sell_diamond_10
execute unless data entity @s Items[{Slot:20b}] run function bank:gui/btn/sell_diamond_64
execute unless data entity @s Items[{Slot:21b}] run function bank:gui/btn/sell_diamond_100
execute unless data entity @s Items[{Slot:22b}] run function bank:gui/btn/sell_diamond_1000
execute unless data entity @s Items[{Slot:23b}] run function bank:gui/btn/sell_diamond_10000

execute unless data entity @s Items[{Slot:15b}] run function bank:gui/btn/withdraw_copper_1
execute unless data entity @s Items[{Slot:16b}] run function bank:gui/btn/withdraw_copper_10
execute unless data entity @s Items[{Slot:17b}] run function bank:gui/btn/withdraw_copper_64

execute unless data entity @s Items[{Slot:24b}] run function bank:gui/btn/withdraw_diamond_1
execute unless data entity @s Items[{Slot:25b}] run function bank:gui/btn/withdraw_diamond_10
execute unless data entity @s Items[{Slot:26b}] run function bank:gui/btn/withdraw_diamond_64

# 清理误拿
clear @p[distance=..4,limit=1] minecraft:barrier{bank:{gui:1b}} 64
clear @p[distance=..4,limit=1] minecraft:emerald{bank:{gui:1b}} 64
clear @p[distance=..4,limit=1] minecraft:redstone{bank:{gui:1b}} 64
clear @p[distance=..4,limit=1] minecraft:copper_ingot{bank:{gui:1b}} 64
clear @p[distance=..4,limit=1] minecraft:diamond{bank:{gui:1b}} 64
clear @p[distance=..4,limit=1] minecraft:spectral_arrow{bank:{gui:1b}} 64
clear @p[distance=..4,limit=1] minecraft:black_stained_glass_pane{bank:{gui:1b}} 64
