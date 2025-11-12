summon armor_stand ~ ~ ~ {Invisible:1b,Marker:1b,NoGravity:1b,Invulnerable:1b,Tags:["BankAnchor"]}
summon chest_minecart ~ ~1 ~ {CustomName:'{"text":"§bBANK"}',CustomNameVisible:1b,Invulnerable:1b,NoGravity:1b,Silent:1b,Tags:["BankGUI","BankGUIInit"]}
execute as @e[type=chest_minecart,sort=nearest,limit=1,tag=BankGUI,tag=BankGUIInit] at @s run function bank:gui/default
tag @e[type=chest_minecart,sort=nearest,limit=1,tag=BankGUI,tag=BankGUIInit] remove BankGUIInit

tellraw @s [{"text":"[银行] ","color":"aqua"},{"text":"提示：顶排 2 槽存入铜/钻；买入 9–14，卖出 18–23。","color":"gray"}]
