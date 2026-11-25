local L0_1, L1_1
L0_1 = Citizen
L0_1 = L0_1.CreateThread
function L1_1()
  local L0_2, L1_2, L2_2
  L0_2 = prepare
  L1_2 = "createBoostConfig"
  L2_2 = [[
 CREATE TABLE IF NOT EXISTS `five_boost` (
        `user_id` int(11) NOT NULL,
        `config` text DEFAULT '{}',
        PRIMARY KEY (`user_id`)
    )
    COLLATE='utf8mb4_general_ci'
    ENGINE=InnoDB
    ; ]]
  L0_2(L1_2, L2_2)
  L0_2 = prepare
  L1_2 = "checkDBBoostConfig"
  L2_2 = " SELECT * FROM information_schema.tables WHERE table_schema = @db AND table_name = 'five_boost'; "
  L0_2(L1_2, L2_2)
  L0_2 = prepare
  L1_2 = "getBoostConfig"
  L2_2 = " SELECT * FROM five_boost WHERE user_id = @id; "
  L0_2(L1_2, L2_2)
  L0_2 = prepare
  L1_2 = "initBoostConfig"
  L2_2 = " INSERT IGNORE INTO five_boost (user_id, config) VALUES (@user_id, @config) "
  L0_2(L1_2, L2_2)
  L0_2 = prepare
  L1_2 = "saveBoostConfig"
  L2_2 = " UPDATE five_boost SET config = @config WHERE user_id = @id; "
  L0_2(L1_2, L2_2)
end
L0_1(L1_1)
