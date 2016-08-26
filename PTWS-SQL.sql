CREATE TABLE `ptws` (
  `dateID` varchar(8) NOT NULL,
  `date` text NOT NULL,
  `weather` text NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`dateID`),
  KEY `dateID` (`dateID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
