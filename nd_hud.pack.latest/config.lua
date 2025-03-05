HUD = {}

--This is the framework changer!
HUD.qbcore = true
-- HUD.esx = false --Removed due to slow development time! Will work in it later!

--pma-voice only right now! (IT WILL AUTOMATICLY DETECT IT)
--HUD.voicesystem = 'pma-voice' --Later it can be pma,salty,tokovoip (I am not going to make support for these: mumble-voip, esx-voice, vVoice)
HUD.voiceerror = 'Voice nincs bekapcsolva! \n Menj a beállításokba és kapcsolt be a voice chat-et és konfiguráld be Push To talk-ra!'  --This is a warning if player is not turned on the voice! 
HUD.voiceerroronoroff = false --enabling it it will give warnings to  a player if he is not connceted to the voice! (only pma for now!)
HUD.radioanimation = false --This is new radio for 0.2.6 version!

--rc_alert config
HUD.rcalert = false
HUD.alerttitle = 'Motor indítása'  --For english users this is 'Starting the engine' turorial title
HUD.alertdesc = 'G betűvel indítod el a motort!'--FOer english users this is 'You can staert the engine with the button G'



--QBCORE CONFIGS

--Stress config
--The code was from qb-hud! (I will try to make it better if possible)
HUD.StressChance = 0.1 -- Default: 10% -- Percentage Stress Chance When Shooting (0-1)
HUD.calculating = 10 --This will calculate when player is in vehicle driveing! so vehicle speed * the number you type
HUD.MinimumStress = 50 -- Minimum Stress Level For Screen Shaking
HUD.MinimumSpeedUnbuckled = 50 -- Going Over This Speed Will Cause Stress
HUD.MinimumSpeed = 100 -- Going Over This Speed Will Cause Stress
HUD.DisablePoliceStress = false --Disable stress for cops
HUD.stressgain = 'Stressz szint feljebb ment!' --Notify when stress is gained
HUD.stressremoved = 'Stressz szint le ment!' --Notify when stress is giong down
HUD.unbuckled = 'Övet kicsatoltad!' --notify when unbuckled
HUD.buckled = 'övet becsatoltad!' --notify when buckled 
HUD.removemoney = 'Elveszítettél egy kis pénzt'
HUD.getemoney = 'Kaptál egy kis pénzt'
HUD.bankremove = 'Levonás történt a számládról'
HUD.bankget = 'Utalás történt a számládra'


HUD.commandhelp1 = 'Banki egyenleg megnézése!' --Bank command help
HUD.commandhelp2 = 'Készpénzed megnézése!' --Cash command help

--Dont edit It can break the hud
HUD.health = 50 
HUD.armour = 50 
HUD.hunger = 50
HUD.thirst = 50
HUD.fuel = 50 
HUD.stamina = 50
HUD.voice = 50 
HUD.stress = 50