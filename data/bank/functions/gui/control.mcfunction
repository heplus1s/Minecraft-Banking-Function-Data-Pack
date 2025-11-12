execute as @s at @s run tp @s @e[type=armor_stand,tag=BankAnchor,sort=nearest,limit=1,distance=..8]
function bank:gui/internal
execute unless entity @p[distance=..6] run function bank:gui/cleanup
