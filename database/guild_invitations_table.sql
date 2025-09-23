-- Tabela para convites de guild
CREATE TABLE `guild_invitations` (
  `player_id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL,
  `expiration` int(11) NOT NULL,
  `rank_name` varchar(255) NOT NULL,
  PRIMARY KEY (`player_id`, `guild_id`),
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;