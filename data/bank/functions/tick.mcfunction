scoreboard players enable @a bankGUI
execute as @a[scores={bankGUI=1..}] at @s run function bank:open
scoreboard players set @a[scores={bankGUI=1..}] bankGUI 0

# 处理所有 GUI
execute as @e[type=chest_minecart,tag=BankGUI] at @s run function bank:gui/control

# 清理 GUI 掉落
kill @e[type=item,nbt={Item:{tag:{bank:{gui:1b}}}}]

# 防止特殊矿车掉落物保留
execute as @e[type=item,nbt={Item:{id:"minecraft:chest_minecart"}}] at @s if entity @e[type=armor_stand,tag=BankAnchor,distance=..3] run kill @s
