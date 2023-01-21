scoreboard objectives add f_lighting dummy
scoreboard objectives add f_permissions trigger
scoreboard objectives add f_timeout dummy
scoreboard objectives add faction_id dummy
scoreboard objectives add territory_id dummy
scoreboard objectives add landcolor dummy
scoreboard objectives add in_territory dummy
scoreboard objectives add invited_to dummy
scoreboard objectives add f_claim trigger
scoreboard objectives add f_title trigger
scoreboard objectives add f_unclaim trigger
scoreboard objectives add f_kick trigger
scoreboard objectives add f_sethome trigger
scoreboard objectives add f_home trigger
scoreboard objectives add f_list trigger
scoreboard objectives add fmembers dummy
scoreboard objectives add f_info trigger
scoreboard objectives add yposf dummy
scoreboard objectives add f_invite trigger
scoreboard objectives add permlevel dummy
scoreboard objectives add f_inspect trigger
scoreboard objectives add f_join trigger
scoreboard objectives add f_leave trigger
scoreboard objectives add f_create trigger
scoreboard players set colorroll f_lighting 1
tellraw @a ["",{"text":"[nFactions] ","color":"yellow"},{"text":"Datapack Successfully Loaded! Version 1.1","color":"none"}]