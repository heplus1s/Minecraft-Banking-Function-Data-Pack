data modify entity @s Items set value []

# 顶排：1箭头、2存入、3玻璃锁定，8关闭
data modify entity @s Items append value {Slot:1b,id:"minecraft:spectral_arrow",Count:1b,tag:{bank:{gui:1b},display:{Name:'{"text":"→ 在右侧存入铜锭/钻石","color":"gold"}'}}}
data modify entity @s Items append value {Slot:3b,id:"minecraft:black_stained_glass_pane",Count:1b,tag:{bank:{gui:1b}}}
data modify entity @s Items append value {Slot:8b,id:"minecraft:barrier",Count:1b,tag:{bank:{gui:1b},display:{Name:'{"text":"关闭","color":"red"}'}}}

# 第二排 买入（9–14） emerald（带显示名）
data modify entity @s Items append value {Slot:9b,id:"minecraft:emerald",Count:1b,tag:{bank:{gui:1b},display:{Name:'{"text":"买入 钻×1","color":"green"}'}}}
data modify entity @s Items append value {Slot:10b,id:"minecraft:emerald",Count:10b,tag:{bank:{gui:1b},display:{Name:'{"text":"买入 钻×10","color":"green"}'}}}
data modify entity @s Items append value {Slot:11b,id:"minecraft:emerald",Count:64b,tag:{bank:{gui:1b},display:{Name:'{"text":"买入 钻×64","color":"green"}'}}}
data modify entity @s Items append value {Slot:12b,id:"minecraft:emerald",Count:64b,tag:{bank:{gui:1b},display:{Name:'{"text":"买入 钻×100","color":"green"}'}}}
data modify entity @s Items append value {Slot:13b,id:"minecraft:emerald",Count:64b,tag:{bank:{gui:1b},display:{Name:'{"text":"买入 钻×1000","color":"green"}'}}}
data modify entity @s Items append value {Slot:14b,id:"minecraft:emerald",Count:64b,tag:{bank:{gui:1b},display:{Name:'{"text":"买入 钻×10000","color":"green"}'}}}

# 第三排 卖出（18–23） redstone（带显示名）
data modify entity @s Items append value {Slot:18b,id:"minecraft:redstone",Count:1b,tag:{bank:{gui:1b},display:{Name:'{"text":"卖出 钻×1","color":"dark_red"}'}}}
data modify entity @s Items append value {Slot:19b,id:"minecraft:redstone",Count:10b,tag:{bank:{gui:1b},display:{Name:'{"text":"卖出 钻×10","color":"dark_red"}'}}}
data modify entity @s Items append value {Slot:20b,id:"minecraft:redstone",Count:64b,tag:{bank:{gui:1b},display:{Name:'{"text":"卖出 钻×64","color":"dark_red"}'}}}
data modify entity @s Items append value {Slot:21b,id:"minecraft:redstone",Count:64b,tag:{bank:{gui:1b},display:{Name:'{"text":"卖出 钻×100","color":"dark_red"}'}}}
data modify entity @s Items append value {Slot:22b,id:"minecraft:redstone",Count:64b,tag:{bank:{gui:1b},display:{Name:'{"text":"卖出 钻×1000","color":"dark_red"}'}}}
data modify entity @s Items append value {Slot:23b,id:"minecraft:redstone",Count:64b,tag:{bank:{gui:1b},display:{Name:'{"text":"卖出 钻×10000","color":"dark_red"}'}}}

# 取款：铜 15/16/17；钻 24/25/26
data modify entity @s Items append value {Slot:15b,id:"minecraft:copper_ingot",Count:1b,tag:{bank:{gui:1b},display:{Name:'{"text":"取出 铜×1","color":"gold"}'}}}
data modify entity @s Items append value {Slot:16b,id:"minecraft:copper_ingot",Count:10b,tag:{bank:{gui:1b},display:{Name:'{"text":"取出 铜×10","color":"gold"}'}}}
data modify entity @s Items append value {Slot:17b,id:"minecraft:copper_ingot",Count:64b,tag:{bank:{gui:1b},display:{Name:'{"text":"取出 铜×64","color":"gold"}'}}}
data modify entity @s Items append value {Slot:24b,id:"minecraft:diamond",Count:1b,tag:{bank:{gui:1b},display:{Name:'{"text":"取出 钻×1","color":"aqua"}'}}}
data modify entity @s Items append value {Slot:25b,id:"minecraft:diamond",Count:10b,tag:{bank:{gui:1b},display:{Name:'{"text":"取出 钻×10","color":"aqua"}'}}}
data modify entity @s Items append value {Slot:26b,id:"minecraft:diamond",Count:64b,tag:{bank:{gui:1b},display:{Name:'{"text":"取出 钻×64","color":"aqua"}'}}}

# 其余全部用深色玻璃占位
data modify entity @s Items append value {Slot:0b,id:"minecraft:black_stained_glass_pane",Count:1b,tag:{bank:{gui:1b}}}
data modify entity @s Items append value {Slot:4b,id:"minecraft:black_stained_glass_pane",Count:1b,tag:{bank:{gui:1b}}}
data modify entity @s Items append value {Slot:5b,id:"minecraft:black_stained_glass_pane",Count:1b,tag:{bank:{gui:1b}}}
data modify entity @s Items append value {Slot:6b,id:"minecraft:black_stained_glass_pane",Count:1b,tag:{bank:{gui:1b}}}
data modify entity @s Items append value {Slot:7b,id:"minecraft:black_stained_glass_pane",Count:1b,tag:{bank:{gui:1b}}}
