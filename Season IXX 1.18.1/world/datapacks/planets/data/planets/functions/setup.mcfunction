setblock ~ ~ ~ command_block[facing=down]{Command:"function planets:init_fine"}
setblock ~2 ~ ~ repeating_command_block[facing=down]{Command:"execute as @e[tag=sphere] at @s run tp @s ~ ~ ~ ~0.5 ~"}
setblock ~2 ~-1 ~ chain_command_block[facing=down]{Command:"function planets:planets/earth_large"}
setblock ~ ~ ~-1 minecraft:polished_blackstone_button
setblock ~2 ~ ~-1 minecraft:lever