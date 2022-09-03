-- __    __  __        ________  _______    ______  
-- /  |  /  |/  |      /        |/       \  /      \ 
-- $$ |  $$ |$$ |      $$$$$$$$/ $$$$$$$  |/$$$$$$  |
-- $$ |  $$ |$$ |         $$ |   $$ |__$$ |$$ |__$$ |
-- $$ |  $$ |$$ |         $$ |   $$    $$< $$    $$ |
-- $$ |  $$ |$$ |         $$ |   $$$$$$$  |$$$$$$$$ |
-- $$ \__$$ |$$ |_____    $$ |   $$ |  $$ |$$ |  $$ |
-- $$    $$/ $$       |   $$ |   $$ |  $$ |$$ |  $$ |
--  $$$$$$/  $$$$$$$$/    $$/    $$/   $$/ $$/   $$/ 
--  https://discord.gg/Qk9XcPA9BH                        
                                                  
--  ID SYSTEM WITH NOTIFICATION                                              

Config = {}

Config.EnableAnim   = false                     -- ACTIVATE THE ANIMATION TO SEE THE ID IF YOU WANT
Config.PropAnim     = 'prop_notepad_01'         -- IF Config.EnableAnim = true. HERE YOU CAN PUT THE PROP, WHAT YOU WANT WHEN YOU SEE THE ID IF YOU ACTIVATE THE ANIMATION
Config.CommandId    = 'showid'                  -- COMMANDS TO SEE THE IDs
Config.Cooldown     = 10                        -- COOLDOWN FOR WHEN SOMEONE SPAM KEY
Config.ShowTime     = 5                         -- TIME TO SEE ID   
Config.EnableKey    = true                      -- ENABLE KEY TO SHOW IDS
Config.Key          = 212                       -- IF Config.EnableKey = true THEN SEARCH KEY CODE THERE (https://docs.fivem.net/docs/game-references/controls/)

-- HERE YOU CAN CHANGE THE COLORS YOU LIKE
Config.R = 255
Config.G = 255
Config.B = 255

-- -- TRANSLATIONS
Config.Secconds =       'Seconds..-'                                                                   
Config.Notif =          'Nearby players have been notified that you are verifying their IDs'          
Config.Spam1 =          'SPAM PREVENTION! You are on Cooldown for '                                                 
Config.Spam2 =          ' seconds!'                                                           
Config.NotiPlayer1 =    ' Player ID: '                                                                 
Config.NotiPlayer2 =    ' is verifying your id!'                                                       

