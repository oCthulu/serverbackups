execute as @e[tag=factionph] at @s unless score @s fmembers matches 1.. run tag @s add disband
execute as @e[tag=disband] run tellraw @a ["",{"text":"Faction ","color":"yellow"},{"score":{"name":"@s","objective":"faction_id"},"color":"yellow"},{"text":" (","color":"yellow"},{"selector":"@s","color":"yellow"},{"text":") ","color":"yellow"},{"text":"was disbanded.","color":"yellow"}]
execute as @e[tag=territory] at @s if score @s territory_id = @e[tag=disband,limit=1] faction_id run kill @s
execute as @e[tag=disband] run kill @s
execute as @a unless score @s faction_id matches -999999999..999999999 run scoreboard players set @s faction_id 0
execute as @e[scores={invited_to=1..}] at @s run scoreboard players add @s f_timeout 1
execute as @e[scores={f_timeout=1200..}] at @s run scoreboard players set @s invited_to 0
execute as @e[scores={f_timeout=1200..}] at @s run scoreboard players set @s f_timeout 0

scoreboard players add colorroll f_lighting 1
execute if score colorroll f_lighting matches 10.. run scoreboard players set colorroll f_lighting 1
scoreboard players enable @a f_list
scoreboard players enable @a f_inspect
scoreboard players enable @a[scores={faction_id=1..,permlevel=2..}] f_claim
scoreboard players enable @a[scores={faction_id=1..,permlevel=4..}] f_title
scoreboard players enable @a[scores={faction_id=1..,permlevel=4..}] f_permissions
scoreboard players enable @a[scores={faction_id=1..,permlevel=2..}] f_unclaim
scoreboard players enable @a[scores={faction_id=1..,permlevel=3..}] f_kick
scoreboard players enable @a[scores={faction_id=1..,permlevel=3..}] f_sethome
scoreboard players enable @a[scores={faction_id=1..,permlevel=1..}] f_home
scoreboard players enable @a[scores={faction_id=1..,permlevel=2..}] f_invite
scoreboard players enable @a[scores={faction_id=0}] f_create
scoreboard players enable @a[scores={invited_to=1..}] f_join
scoreboard players enable @a[scores={faction_id=1..}] f_leave



execute as @e[tag=factionph] at @s if score @p[scores={f_inspect=1..}] in_territory = @s faction_id run tellraw @p[scores={f_inspect=1..}] ["",{"text":"Faction ","color":"yellow"},{"score":{"name":"@s","objective":"faction_id"},"color":"yellow"},{"text":" - ","color":"yellow"},{"selector":"@s","color":"yellow"}]
execute as @e[scores={f_inspect=1..}] if score @s in_territory matches 0 run tellraw @s {"text":"Wilderness","color":"dark_green"}
execute as @e[scores={f_inspect=1..}] at @s run scoreboard players set @s f_inspect 0


execute as @e[tag=territory] at @s unless score @s landcolor matches 1..10 run tag @s add nocolor
execute as @e[tag=territory] at @s if score @s landcolor matches 1..10 run tag @s remove nocolor

execute as @e[tag=factionph] at @s if score @s faction_id = @e[tag=territory,tag=nocolor,limit=1] territory_id run scoreboard players operation @e[tag=territory,tag=nocolor,limit=1] landcolor = @s landcolor

execute as @e[tag=factionph] at @s if score @s faction_id = @p[scores={f_create=1..}] f_create run tellraw @p[scores={f_create=1..}] {"text":"A Faction with that ID already exists!","color":"red"}
execute as @e[tag=factionph] at @s if score @s faction_id = @p[scores={f_create=1..}] f_create run scoreboard players set @p[scores={f_create=1..}] f_create 0
execute as @a[scores={f_create=1..}] run tellraw @s {"text":"Faction Successfully Created!","color":"yellow"}
execute as @a[scores={f_create=1..}] run scoreboard players operation @s faction_id = @s f_create
execute as @a[scores={f_create=1..}] run summon armor_stand 0 255 0 {NoGravity:1b,Invisible:1b,Invulnerable:1b,Tags:["notinit"],CustomName:'{"text":"Faction"}'}
execute as @a[scores={f_create=1..}] run scoreboard players operation @e[tag=notinit,limit=1] faction_id = @p[scores={f_create=1..}] f_create
execute as @a[scores={f_create=1..}] run scoreboard players operation @e[tag=notinit,limit=1] landcolor = colorroll f_lighting
execute as @a[scores={f_create=1..}] run tag @e[tag=notinit] add factionph
execute as @a[scores={f_create=1..}] run scoreboard players set @e[tag=notinit] fmembers 1
execute as @a[scores={f_create=1..}] run scoreboard players set @s permlevel 4
execute as @a[scores={f_create=1..}] run tag @e[tag=notinit] remove notinit

execute as @a[scores={f_create=1..}] run scoreboard players set @s create 0

execute as @a[scores={f_invite=1..}] at @s if score @p[distance=0.1..] faction_id matches 1.. run tellraw @s {"text":"That player is already in a faction!","color":"red"}
execute as @a[scores={f_invite=1..}] at @s if score @p[distance=0.1..] faction_id matches 1.. run scoreboard players set @s f_invite 0
execute as @a[scores={f_invite=1..}] at @s run tellraw @s ["",{"text":"You invited ","color":"yellow"},{"selector":"@p[distance=0.1..]","color":"none"},{"text":" to your faction.","color":"yellow"}]
execute as @a[scores={f_invite=1..}] at @s run tellraw @p[distance=0.1..] ["",{"text":"You were invited to Faction ","color":"yellow"},{"score":{"name":"@p[scores={f_invite=1..}]","objective":"faction_id"},"color":"yellow"}]
execute as @a[scores={f_invite=1..}] at @s run tellraw @p[distance=0.1..] ["",{"text":"Type ","color":"yellow"},{"text":"/trigger f_join ","color":"gold"},{"text":"to join!","color":"yellow"}]
execute as @a[scores={f_invite=1..}] at @s run scoreboard players operation @p[distance=0.1..] invited_to = @s faction_id
execute as @a[scores={f_invite=1..}] at @s run scoreboard players set @s f_invite 0


execute as @a[scores={f_permissions=1..}] at @s unless score @p[distance=0.1..] faction_id = @s faction_id run tellraw @s {"text":"That player is not in your faction!","color":"red"}
execute as @a[scores={f_permissions=1..}] at @s unless score @p[distance=0.1..] faction_id = @s faction_id run scoreboard players set @s f_kick 0
execute as @a[scores={f_permissions=1..}] at @s if score @p[distance=0.1..] faction_id = @s faction_id run tellraw @p[distance=0.1..] {"text":"Your faction permissions were changed!","color":"red"}
execute as @a[scores={f_permissions=1..}] at @s run tellraw @s ["",{"text":"Successfully changed ","color":"yellow"},{"selector":"@p[distance=0.1..]","color":"none"},{"text":"'s permissions!","color":"yellow"}]
execute as @a[scores={f_permissions=1..}] at @s run scoreboard players operation @p[distance=0.1..] permlevel = @s f_permissions
execute as @a[scores={f_permissions=1..}] at @s run scoreboard players set @s f_permissions 0



execute as @a[scores={f_kick=1..}] at @s unless score @p[distance=0.1..] faction_id = @s faction_id run tellraw @s {"text":"That player is not in your faction!","color":"red"}
execute as @a[scores={f_kick=1..}] at @s unless score @p[distance=0.1..] faction_id = @s faction_id run scoreboard players set @s f_kick 0
execute as @a[scores={f_kick=1..}] at @s if score @p[distance=0.1..] faction_id = @s faction_id run tellraw @p[distance=0.1..] {"text":"You were kicked from the faction!","color":"red"}
execute as @a[scores={f_kick=1..}] at @s run tellraw @s ["",{"text":"Successfully kicked ","color":"yellow"},{"selector":"@p[distance=0.1..]","color":"none"},{"text":" from the faction!","color":"yellow"}]
execute as @a[scores={f_kick=1..}] at @s run scoreboard players set @p[distance=0.1..] permlevel 0
execute as @a[scores={f_kick=1..}] at @s run tag @p[distance=0.1..] add kicked
execute as @e[tag=factionph] at @s if score @s faction_id = @p[tag=kicked] faction_id run scoreboard players remove @s fmembers 1
execute as @a[scores={f_kick=1..}] at @s run scoreboard players set @p[distance=0.1..] faction_id 0
execute as @a[scores={f_kick=1..}] at @s run tag @p[distance=0.1..] remove kicked
execute as @a[scores={f_kick=1..}] at @s run scoreboard players set @s f_kick 0

execute as @a[scores={f_join=1..}] at @s run scoreboard players operation @s faction_id = @s invited_to
execute as @a[scores={f_join=1..}] at @s run tellraw @s {"text":"Successfully joined the Faction!","color":"yellow"}
execute as @e[tag=factionph] at @s if score @s faction_id = @p[scores={f_join=1..}] invited_to run scoreboard players add @s fmembers 1
execute as @a[scores={f_join=1..}] at @s run scoreboard players set @s invited_to 0
execute as @a[scores={f_join=1..}] at @s run scoreboard players set @s permlevel 1
execute as @a[scores={f_join=1..}] at @s run scoreboard players set @s f_join 0

execute as @e[tag=factionph] at @s if score @s faction_id = @p[scores={f_title=1..}] faction_id run tag @s add namechange
execute as @e[tag=namechange] at @s run data modify entity @s CustomName set from entity @p[scores={f_title=1..}] SelectedItem.tag.display.Name
execute as @e[tag=namechange] at @s run tellraw @a[scores={f_title=1..}] {"text":"Faction Name Successfully Changed!","color":"yellow"}
execute as @e[tag=namechange] at @s run scoreboard players set @a[scores={f_title=1..}] f_title 0
execute as @e[tag=namechange] at @s run tag @s remove namechange

execute as @a[scores={f_leave=1..}] run tellraw @s {"text":"You left the Faction.","color":"yellow"}
execute as @e[tag=factionph] at @s if score @s faction_id = @p[scores={f_leave=1..}] faction_id run scoreboard players remove @s fmembers 1
execute as @a[scores={f_leave=1..}] run scoreboard players set @s faction_id 0
execute as @a[scores={f_leave=1..}] run scoreboard players set @s permlevel 0
execute as @a[scores={f_leave=1..}] run scoreboard players set @s f_leave 0
execute as @a[scores={permlevel=0..1}] run trigger f_claim set 0
execute as @a[scores={permlevel=0..1}] run trigger f_unclaim set 0
execute as @a[scores={permlevel=0..3}] run trigger f_title set 0
execute as @a[scores={faction_id=1..}] run trigger f_create set 0
execute as @a[scores={faction_id=1..}] run trigger f_join set 0
execute as @a[scores={faction_id=0}] run trigger f_leave set 0
execute as @a[scores={permlevel=0..1}] run trigger f_invite set 0
execute as @a[scores={permlevel=0..3}] run trigger f_permissions set 0
execute as @a[scores={permlevel=0..2}] run trigger f_kick set 0
execute as @a[scores={permlevel=0}] run trigger f_home set 0
execute as @a[scores={permlevel=0..2}] run trigger f_sethome set 0

execute as @e[tag=territory] at @s positioned ~ 256 ~ unless entity @e[tag=rotatorfx,distance=..1] run summon armor_stand ~ ~ ~ {Invisible:1b,Invulnerable:1b,NoGravity:1b,Tags:["rotatorfx"]} 
execute as @e[tag=territory] at @s positioned ~ 256 ~ unless entity @e[tag=rotatorfy,distance=..1] run summon armor_stand ~ ~ ~ {Invisible:1b,Invulnerable:1b,NoGravity:1b,Tags:["rotatorfy"]} 

execute as @e[tag=territory] at @s positioned ~ 256 ~ if entity @e[tag=rotatorfx,distance=..1] run scoreboard players operation @e[tag=rotatorfx,limit=1,sort=nearest] landcolor = @s landcolor
execute as @e[tag=territory] at @s positioned ~ 256 ~ if entity @e[tag=rotatorfx,distance=..1] run scoreboard players operation @e[tag=rotatorfx,limit=1,sort=nearest] faction_id = @s territory_id

execute as @e[tag=rotatorfx,scores={landcolor=1}] at @s positioned ~ 255 ~ run fill ^ ^ ^ ^ ^ ^8 red_stained_glass replace air
execute as @e[tag=rotatorfx,scores={landcolor=2}] at @s positioned ~ 255 ~ run fill ^ ^ ^ ^ ^ ^8 orange_stained_glass replace air
execute as @e[tag=rotatorfx,scores={landcolor=3}] at @s positioned ~ 255 ~ run fill ^ ^ ^ ^ ^ ^8 yellow_stained_glass replace air
execute as @e[tag=rotatorfx,scores={landcolor=4}] at @s positioned ~ 255 ~ run fill ^ ^ ^ ^ ^ ^8 green_stained_glass replace air
execute as @e[tag=rotatorfx,scores={landcolor=5}] at @s positioned ~ 255 ~ run fill ^ ^ ^ ^ ^ ^8 blue_stained_glass replace air
execute as @e[tag=rotatorfx,scores={landcolor=6}] at @s positioned ~ 255 ~ run fill ^ ^ ^ ^ ^ ^8 purple_stained_glass replace air
execute as @e[tag=rotatorfx,scores={landcolor=7}] at @s positioned ~ 255 ~ run fill ^ ^ ^ ^ ^ ^8 pink_stained_glass replace air
execute as @e[tag=rotatorfx,scores={landcolor=8}] at @s positioned ~ 255 ~ run fill ^ ^ ^ ^ ^ ^8 black_stained_glass replace air
execute as @e[tag=rotatorfx,scores={landcolor=9}] at @s positioned ~ 255 ~ run fill ^ ^ ^ ^ ^ ^8 white_stained_glass replace air

execute as @e[tag=rotatorfx,tag=uc] at @s run fill ~-8 255 ~-8 ~8 255 ~8 air
execute as @e[tag=rotatorfx,tag=uc] at @s run kill @s

execute as @e[tag=territory,nbt={Age:9999998}] at @s run data merge entity @s {Age:0s}

execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=1}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0.91 0.14 0.14 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=1}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^-8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0.91 0.14 0.14 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=1}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0.91 0.14 0.14 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=1}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^-8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0.91 0.14 0.14 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=2}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0.91 0.51 0.14 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=2}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^-8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0.91 0.51 0.14 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=2}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0.91 0.51 0.14 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=2}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^-8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0.91 0.51 0.14 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=3}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0.91 0.9 0.14 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=3}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^-8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0.91 0.9 0.14 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=3}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0.91 0.9 0.14 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=3}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^-8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0.91 0.9 0.14 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=4}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0.5 1 0 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=4}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^-8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0.5 1 0 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=4}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0.5 1 0 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=4}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^-8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0.5 1 0 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=5}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0.3 0.3 1 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=5}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^-8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0.3 0.3 1 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=5}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0.3 0.3 1 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=5}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^-8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0.3 0.3 1 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=6}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0.29 0 0.51 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=6}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^-8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0.29 0 0.51 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=6}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0.29 0 0.51 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=6}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^-8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0.29 0 0.51 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=7}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0.83 0.19 0.55 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=7}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^-8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0.83 0.19 0.55 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=7}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0.83 0.19 0.55 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=7}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^-8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0.83 0.19 0.55 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=8}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0 0 0 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=8}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^-8 ^ ^ unless entity @e[tag=territory,distance=..7.5] run particle dust 0 0 0 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=8}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0 0 0 1
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=8}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] positioned ^ ^ ^-8 unless entity @e[tag=territory,distance=..7.5] run particle dust 0 0 0 1

execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=9}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] run particle dust 1 1 1 1 ^8 ^ ^
execute as @a[nbt={SelectedItem:{id:"minecraft:compass",Count:1b}}] at @s run execute as @e[tag=territory,distance=..100,scores={landcolor=9}] at @s rotated as @e[tag=rotatorfx,sort=nearest,limit=1] run particle dust 1 1 1 1 ^-8 ^ ^


execute as @e[tag=rotatorfx] at @s run tp @s ~ ~ ~ ~7.5 ~
execute as @e[tag=rotatorfy] at @s run tp @s ~ ~ ~ ~ ~10
execute as @e[tag=rotatorfy,x_rotation=90] at @s run tp @s ~ ~ ~ ~ -90

execute as @e[scores={f_claim=1..}] at @s positioned ~ 256 ~ unless score @s faction_id = @e[limit=1,sort=nearest,tag=rotatorfx,distance=..16] faction_id run tag @s add denyclaim
execute as @e[tag=denyclaim] at @s run tellraw @s {"text":"You cannot claim land that would overlap another faction's territory!","color":"yellow"}
execute as @e[tag=denyclaim] at @s run scoreboard players set @s f_claim 0
execute as @e[tag=denyclaim] at @s run tag @s remove denyclaim


execute as @a[scores={f_claim=1..}] at @s run scoreboard players operation @e[tag=ttset,limit=1,sort=nearest] territory_id = @s faction_id
execute as @e[tag=factionph] at @s if score @s faction_id = @p[scores={f_claim=1..}] faction_id run tag @p[scores={f_claim=1..}] add fvalid
execute as @e[scores={f_claim=1..},tag=!fvalid] at @s run tellraw @s {"text":"You are not in a faction!","color":"yellow"}
execute as @e[scores={f_claim=1..},tag=!fvalid] at @s run scoreboard players set @s faction_id 0
execute as @e[scores={f_claim=1..},tag=!fvalid] at @s run scoreboard players set @s f_claim 0
execute as @a[scores={f_claim=1..}] at @s run summon area_effect_cloud ~ ~ ~ {Radius:8,Duration:9999999,Particle:"block air",Tags:["territory","ttset"]}
execute as @e[tag=factionph] at @s if score @s faction_id = @e[tag=territory,tag=ttset,limit=1] territory_id run scoreboard players operation @e[tag=territory,tag=ttset,limit=1] landcolor = @s landcolor
execute as @a[scores={f_claim=1..}] at @s run scoreboard players operation @e[tag=ttset,limit=1,sort=nearest] territory_id = @s faction_id
execute as @a[scores={f_claim=1..}] at @s run tag @e[tag=ttset,limit=1,sort=nearest] remove ttset
execute as @a[scores={f_claim=1..}] at @s run tag @s remove fvalid
execute as @a[scores={f_claim=1..}] at @s run tellraw @s {"text":"Successfully claimed land!","color":"yellow"}
execute as @a[scores={f_claim=1..}] at @s run scoreboard players set @s f_claim 0

execute as @a[scores={f_unclaim=1..}] at @s run execute as @e[tag=territory,distance=..8,limit=1,sort=nearest] at @s if score @s territory_id = @p[scores={f_unclaim=1..}] faction_id run tag @s add unclaim
execute as @e[tag=unclaim] at @s run tellraw @p[scores={f_unclaim=1..}] {"text":"Successfully unclaimed land!","color":"yellow"}
execute as @e[tag=unclaim] at @s run summon armor_stand ~ ~ ~ {Small:1b,Invisible:1b,Invulnerable:1b,NoGravity:1b,Tags:["uctracer"]}
execute as @e[tag=unclaim] at @s run kill @s
execute as @a[scores={f_unclaim=1..}] at @s run scoreboard players set @s f_unclaim 0

execute as @e[tag=uctracer] at @s run tp @s ~ ~1 ~
execute as @e[tag=uctracer] at @s store success score @s f_lighting run tag @e[tag=rotatorfx,limit=1,distance=..1] add uc
execute as @e[tag=uctracer,scores={f_lighting=1..}] at @s run kill @s
execute as @e[tag=uctracer] at @s run tp @s ~ ~1 ~
execute as @e[tag=uctracer] at @s store success score @s f_lighting run tag @e[tag=rotatorfx,limit=1,distance=..1] add uc
execute as @e[tag=uctracer,scores={f_lighting=1..}] at @s run kill @s
execute as @e[tag=uctracer] at @s run tp @s ~ ~1 ~
execute as @e[tag=uctracer] at @s store success score @s f_lighting run tag @e[tag=rotatorfx,limit=1,distance=..1] add uc
execute as @e[tag=uctracer,scores={f_lighting=1..}] at @s run kill @s
execute as @e[tag=uctracer] at @s run tp @s ~ ~1 ~
execute as @e[tag=uctracer] at @s store success score @s f_lighting run tag @e[tag=rotatorfx,limit=1,distance=..1] add uc
execute as @e[tag=uctracer,scores={f_lighting=1..}] at @s run kill @s
execute as @e[tag=uctracer] at @s run tp @s ~ ~1 ~
execute as @e[tag=uctracer] at @s store success score @s f_lighting run tag @e[tag=rotatorfx,limit=1,distance=..1] add uc
execute as @e[tag=uctracer,scores={f_lighting=1..}] at @s run kill @s
execute as @e[tag=uctracer] at @s run tp @s ~ ~1 ~
execute as @e[tag=uctracer] at @s store success score @s f_lighting run tag @e[tag=rotatorfx,limit=1,distance=..1] add uc
execute as @e[tag=uctracer,scores={f_lighting=1..}] at @s run kill @s
execute as @e[tag=uctracer] at @s run tp @s ~ ~1 ~
execute as @e[tag=uctracer] at @s store success score @s f_lighting run tag @e[tag=rotatorfx,limit=1,distance=..1] add uc
execute as @e[tag=uctracer,scores={f_lighting=1..}] at @s run kill @s
execute as @e[tag=uctracer] at @s run tp @s ~ ~1 ~
execute as @e[tag=uctracer] at @s store success score @s f_lighting run tag @e[tag=rotatorfx,limit=1,distance=..1] add uc
execute as @e[tag=uctracer,scores={f_lighting=1..}] at @s run kill @s
execute as @e[tag=uctracer] at @s run tp @s ~ ~1 ~
execute as @e[tag=uctracer] at @s store success score @s f_lighting run tag @e[tag=rotatorfx,limit=1,distance=..1] add uc
execute as @e[tag=uctracer,scores={f_lighting=1..}] at @s run kill @s
execute as @e[tag=uctracer] at @s run tp @s ~ ~1 ~
execute as @e[tag=uctracer] at @s store success score @s f_lighting run tag @e[tag=rotatorfx,limit=1,distance=..1] add uc
execute as @e[tag=uctracer,scores={f_lighting=1..}] at @s run kill @s

execute as @e[scores={f_list=1..}] at @s run execute as @e[tag=factionph,scores={landcolor=1}] run tellraw @p[scores={f_list=1..}] ["",{"text":"Faction ","color":"yellow"},{"score":{"name":"@s","objective":"faction_id"},"color":"red"},{"text":" - ","color":"yellow"},{"selector":"@s","color":"yellow"}]
execute as @e[scores={f_list=1..}] at @s run execute as @e[tag=factionph,scores={landcolor=2}] run tellraw @p[scores={f_list=1..}] ["",{"text":"Faction ","color":"yellow"},{"score":{"name":"@s","objective":"faction_id"},"color":"gold"},{"text":" - ","color":"yellow"},{"selector":"@s","color":"yellow"}]
execute as @e[scores={f_list=1..}] at @s run execute as @e[tag=factionph,scores={landcolor=3}] run tellraw @p[scores={f_list=1..}] ["",{"text":"Faction ","color":"yellow"},{"score":{"name":"@s","objective":"faction_id"},"color":"yellow"},{"text":" - ","color":"yellow"},{"selector":"@s","color":"yellow"}]
execute as @e[scores={f_list=1..}] at @s run execute as @e[tag=factionph,scores={landcolor=4}] run tellraw @p[scores={f_list=1..}] ["",{"text":"Faction ","color":"yellow"},{"score":{"name":"@s","objective":"faction_id"},"color":"green"},{"text":" - ","color":"yellow"},{"selector":"@s","color":"yellow"}]
execute as @e[scores={f_list=1..}] at @s run execute as @e[tag=factionph,scores={landcolor=5}] run tellraw @p[scores={f_list=1..}] ["",{"text":"Faction ","color":"yellow"},{"score":{"name":"@s","objective":"faction_id"},"color":"blue"},{"text":" - ","color":"yellow"},{"selector":"@s","color":"yellow"}]
execute as @e[scores={f_list=1..}] at @s run execute as @e[tag=factionph,scores={landcolor=6}] run tellraw @p[scores={f_list=1..}] ["",{"text":"Faction ","color":"yellow"},{"score":{"name":"@s","objective":"faction_id"},"color":"dark_purple"},{"text":" - ","color":"yellow"},{"selector":"@s","color":"yellow"}]
execute as @e[scores={f_list=1..}] at @s run execute as @e[tag=factionph,scores={landcolor=7}] run tellraw @p[scores={f_list=1..}] ["",{"text":"Faction ","color":"yellow"},{"score":{"name":"@s","objective":"faction_id"},"color":"light_purple"},{"text":" - ","color":"yellow"},{"selector":"@s","color":"yellow"}]
execute as @e[scores={f_list=1..}] at @s run execute as @e[tag=factionph,scores={landcolor=8}] run tellraw @p[scores={f_list=1..}] ["",{"text":"Faction ","color":"yellow"},{"score":{"name":"@s","objective":"faction_id"},"color":"black"},{"text":" - ","color":"yellow"},{"selector":"@s","color":"yellow"}]
execute as @e[scores={f_list=1..}] at @s run execute as @e[tag=factionph,scores={landcolor=9}] run tellraw @p[scores={f_list=1..}] ["",{"text":"Faction ","color":"yellow"},{"score":{"name":"@s","objective":"faction_id"},"color":"white"},{"text":" - ","color":"yellow"},{"selector":"@s","color":"yellow"}]
scoreboard players set @e[scores={f_list=1..}] f_list 0



execute as @a at @s anchored eyes positioned ~ 256 ~ unless entity @e[tag=rotatorfx,distance=0..8] run scoreboard players set @s in_territory 0
execute as @a at @s anchored eyes positioned ^ ^ ^1 positioned ~ 256 ~ unless entity @e[tag=rotatorfx,distance=0..8] run scoreboard players set @s in_territory 0
execute as @a at @s anchored eyes positioned ^ ^ ^2 positioned ~ 256 ~ unless entity @e[tag=rotatorfx,distance=0..8] run scoreboard players set @s in_territory 0
execute as @a at @s anchored eyes positioned ^ ^ ^3 positioned ~ 256 ~ unless entity @e[tag=rotatorfx,distance=0..8] run scoreboard players set @s in_territory 0
execute as @a at @s anchored eyes positioned ^ ^ ^4 positioned ~ 256 ~ unless entity @e[tag=rotatorfx,distance=0..8] run scoreboard players set @s in_territory 0
execute as @a at @s anchored eyes positioned ^ ^ ^5 positioned ~ 256 ~ unless entity @e[tag=rotatorfx,distance=0..8] run scoreboard players set @s in_territory 0

execute as @a at @s anchored eyes positioned ~ 256 ~ if entity @e[distance=0..8,tag=rotatorfx] store result score @s in_territory run scoreboard players get @e[type=minecraft:area_effect_cloud,distance=0..8,tag=territory,limit=1,sort=nearest] territory_id
execute as @a at @s anchored eyes positioned ^ ^ ^1 positioned ~ 256 ~ if entity @e[tag=rotatorfx,distance=0..8] store result score @s in_territory run scoreboard players get @e[distance=0..8,tag=rotatorfx,limit=1,sort=nearest] faction_id
execute as @a at @s anchored eyes positioned ^ ^ ^2 positioned ~ 256 ~ if entity @e[tag=rotatorfx,distance=0..8] store result score @s in_territory run scoreboard players get @e[distance=0..8,tag=rotatorfx,limit=1,sort=nearest] faction_id
execute as @a at @s anchored eyes positioned ^ ^ ^3 positioned ~ 256 ~ if entity @e[tag=rotatorfx,distance=0..8] store result score @s in_territory run scoreboard players get @e[distance=0..8,tag=rotatorfx,limit=1,sort=nearest] faction_id
execute as @a at @s anchored eyes positioned ^ ^ ^4 positioned ~ 256 ~ if entity @e[tag=rotatorfx,distance=0..8] store result score @s in_territory run scoreboard players get @e[distance=0..8,tag=rotatorfx,limit=1,sort=nearest] faction_id
execute as @a at @s anchored eyes positioned ^ ^ ^5 positioned ~ 256 ~ if entity @e[tag=rotatorfx,distance=0..8] store result score @s in_territory run scoreboard players get @e[distance=0..8,tag=rotatorfx,limit=1,sort=nearest] faction_id
execute as @a at @s anchored eyes positioned ^ ^ ^5 positioned ~ 256 ~ if entity @e[tag=rotatorfx,distance=0..8] store result score @s in_territory run scoreboard players get @e[distance=0..8,tag=rotatorfx,limit=1,sort=nearest] faction_id

execute as @a[gamemode=survival] at @s unless score @s faction_id = @s in_territory unless score @s in_territory matches 0 run gamemode adventure @s
execute as @a[gamemode=adventure] at @s if score @s faction_id = @s in_territory run gamemode survival @s
execute as @a[gamemode=adventure] at @s if score @s in_territory matches 0 run gamemode survival @s