DROP PROCEDURE IF EXISTS `updateSql`;

DELIMITER ;;
CREATE PROCEDURE `updateSql`()
BEGIN
	DECLARE lastVersion INT DEFAULT 1;
	DECLARE lastVersion1 INT DEFAULT 1;
	DECLARE versionNotes VARCHAR(255) DEFAULT '';
	
	SELECT MAX(tb_database_version.version) INTO lastVersion FROM tb_database_version;
	
	SET lastVersion=IFNULL((lastVersion),1);
	SET lastVersion1 = lastVersion;
##++++++++++++++++++++表格修改开始++++++++++++++++++++++++++++++
#***************************************************************

#***************************************************************
IF lastVersion<296 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_fuwen_info`;
	CREATE TABLE `tb_player_fuwen_info` (
		`charguid` 	bigint(20) 	NOT NULL COMMENT '玩家id',
		`select_page` 	int(11)		NOT NULL DEFAULT '0' COMMENT '选中符文页',
		`page_bits` 		int(11)		NOT NULL DEFAULT '0' COMMENT '符文页开启状态',
		PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='符文信息表';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_fuwen_item`;
	CREATE TABLE `tb_player_fuwen_item` (
		`charguid` 	bigint(20) 	NOT NULL COMMENT '玩家id',
		`itemgid` 	bigint(20) 	NOT NULL DEFAULT '0' COMMENT '物品ID',
		`itemtid` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '物品TID',
		`pos` 		int(11)		NOT NULL DEFAULT '0' COMMENT '位置',
		`type` 		int(11)		NOT NULL DEFAULT '0' COMMENT '背包类型',
		`star` 		int(11)		NOT NULL DEFAULT '0' COMMENT '星级',
		`level` 	int(11)		NOT NULL DEFAULT '0' COMMENT '等级',
		`exp` 		int(11)		NOT NULL DEFAULT '0' COMMENT '等级经验',
		`time_stamp` bigint(20) NOT NULL DEFAULT '0' COMMENT '时间戳',
		PRIMARY KEY (`charguid`,`itemgid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='符文物品表';
#----------------------------------------------------------------------
	SET lastVersion = 296; 
	SET versionNotes = 'Add fuwen';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<297 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_advice`;
	CREATE TABLE `tb_player_advice` (
		`id` 			int(11) 		NOT NULL AUTO_INCREMENT,
		`charguid` 		bigint(20) 		NOT NULL COMMENT '玩家id',
		`type`			int(11)			NOT NULL DEFAULT '0' COMMENT '类型',
		`title`			varchar(256)  	NOT NULL DEFAULT ''  COMMENT '标题',
		`content`		varchar(1024)  	NOT NULL DEFAULT ''  COMMENT '内容',
		PRIMARY KEY (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='意见建议表';
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_extra`
	ADD COLUMN `advice`  int(11) NOT NULL DEFAULT '0' COMMENT '你提我改标识';
#----------------------------------------------------------------------
	SET lastVersion = 297; 
	SET versionNotes = 'Add advice';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<298 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_color_stone`;
	CREATE TABLE `tb_player_color_stone` (
  `charguid` bigint(22) NOT NULL DEFAULT '0' COMMENT '人物Id',
  `stone_id` int(11) NOT NULL DEFAULT '0' COMMENT '灵石Id',
  `stage_level` int(11) NOT NULL DEFAULT '0' COMMENT '灵石阶段',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT '灵石阶段等级',
  `equip_pos` int(11) NOT NULL DEFAULT '0' COMMENT '装备位',
  PRIMARY KEY (`charguid`,`stone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='七彩灵石';
#----------------------------------------------------------------------
	SET lastVersion = 298; 
	SET versionNotes = 'color_stone';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<299 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_slayer_quest`;
	CREATE TABLE `tb_player_slayer_quest` (
  `charguid` bigint(22) NOT NULL DEFAULT '0' COMMENT '角色GUI',
  `quest_id` int(11) NOT NULL DEFAULT '0' COMMENT '任务ID',
  `grade` int(11) NOT NULL DEFAULT '0' COMMENT '任务品质',
  `levelup` int(11) NOT NULL DEFAULT '0' COMMENT '接取任务时的等级',
  `accepttime` bigint(22) NOT NULL DEFAULT '0' COMMENT '接取任务时的时间',
  PRIMARY KEY (`charguid`,`quest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='除魔任务';
#----------------------------------------------------------------------
	SET lastVersion = 299; 
	SET versionNotes = 'slayer_quest';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<300 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_info`
	ADD COLUMN `slayerQuestNum`  int(11) NOT NULL DEFAULT '0' COMMENT '当天除魔任务接取数量';
#----------------------------------------------------------------------
	SET lastVersion = 300; 
	SET versionNotes = 'Add slayerQuestNum';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<301 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_treasure_dulp`;
	CREATE TABLE `tb_player_treasure_dulp` (
	  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色guid',
	  `item_time` int(11) DEFAULT '0' COMMENT '能使用道具增加的时长(分);',
	  `use_time` int(11) DEFAULT '0' COMMENT '可在镇妖塔剩余的时长(秒)',
	  `new_day_time` bigint(20) DEFAULT '0' COMMENT '新的一天重置数据时间',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家镇妖塔数据';
#----------------------------------------------------------------------
	SET lastVersion = 301; 
	SET versionNotes = 'Add TreasureDulp';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<302 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_zhuzairoad`
	ADD COLUMN `star_state`  int(11) NOT NULL DEFAULT '0' COMMENT '首通三星奖励领取状态';
#----------------------------------------------------------------------
	SET lastVersion = 302; 
	SET versionNotes = 'Add star_state';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<303 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_info`
	ADD COLUMN `magickey`  int(11) NOT NULL DEFAULT '0' COMMENT '法宝是否第一次合成';
#----------------------------------------------------------------------
	SET lastVersion = 303; 
	SET versionNotes = 'Add magickey';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<304 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_slayer_num`;
CREATE TABLE `tb_player_slayer_num` (
  `charguid` bigint(20) NOT NULL DEFAULT '0',
  `num_total` int(11) DEFAULT '0' COMMENT '总完成数',
  PRIMARY KEY (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='除魔任务次数';
#----------------------------------------------------------------------
	SET lastVersion = 304; 
	SET versionNotes = 'Add slayer_num';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<305 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_equip_pos`;
CREATE TABLE `tb_player_equip_pos` (
  `charguid` bigint(20) NOT NULL COMMENT '玩家id',
  `pos` int(11) NOT NULL COMMENT '装备位',
  `idx` int(11) NOT NULL COMMENT '位置',
  `groupid` int(11) NOT NULL COMMENT '套装ID',
  `lvl` int(11) NOT NULL COMMENT '套装等级',
  `time_stamp` bigint(20) NOT NULL DEFAULT '0' COMMENT '时间戳',
  PRIMARY KEY (`charguid`,`pos`,`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='装备位套装';
#----------------------------------------------------------------------
	SET lastVersion = 305; 
	SET versionNotes = 'Add equip group';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<306 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_player_slayer_num` 
CHANGE COLUMN `num_total` `num_total` INT(11) NOT NULL DEFAULT '0' COMMENT '总完成数' ,
ADD COLUMN `cur_day_total` INT(11) NULL DEFAULT 0 AFTER `num_total`;
#----------------------------------------------------------------------
	SET lastVersion = 306; 
	SET versionNotes = 'Add slayerQuest curr_day_Num';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<307 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_player_slayer_quest` 
ADD COLUMN `accept_index` INT(11) NOT NULL DEFAULT 0 AFTER `accepttime`;
#----------------------------------------------------------------------
	SET lastVersion = 307; 
	SET versionNotes = 'Add slayerQuest accept_index';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<308 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_player_info`
ADD COLUMN `datangcnt`  int(11) NOT NULL DEFAULT '0' COMMENT '大唐奇遇次数';
#----------------------------------------------------------------------
	SET lastVersion = 308; 
	SET versionNotes = 'Add datangcnt';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<309 THEN
#----------------------------------------------------------------------
	SET lastVersion = 309; 
	SET versionNotes = 'rank add glorylevel';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<310 THEN
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_guanzhi`;
	CREATE TABLE `tb_player_guanzhi` (
	  `charguid` INT(20) NOT NULL DEFAULT 0,
	  `curr_id` INT(11) NOT NULL DEFAULT 0 COMMENT '当前官职ID',
	  PRIMARY KEY (`charguid`))
	COMMENT = '官职系统';
#----------------------------------------------------------------------
	SET lastVersion = 310; 
	SET versionNotes = 'add guanzhi';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<311 THEN
#----------------------------------------------------------------------
ALTER TABLE `tb_player_equips` 
ADD COLUMN `NewGroupLevel` INT(11) NOT NULL DEFAULT 0 COMMENT '新套装等级' AFTER `wash`;
#----------------------------------------------------------------------
	SET lastVersion = 311; 
	SET versionNotes = 'add equip gorup';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<312 THEN 
#----------------------------------------------------------------------
#----------------------------------------------------------------------
	SET lastVersion = 312; 
	SET versionNotes = 'Add ws human glorylevel';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<313 THEN 
#----------------------------------------------------------------------
#----------------------------------------------------------------------
	SET lastVersion = 313; 
	SET versionNotes = 'Add simple user glorylevel';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<314 THEN
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_equip_pos_upstar`;
	CREATE TABLE `tb_equip_pos_upstar` (
	  `charguid` BIGINT(20) NOT NULL DEFAULT 0,
	  `pos` INT NOT NULL DEFAULT 0 COMMENT '装备位',
	  `level` INT NOT NULL DEFAULT 0 COMMENT '等级',
	  `exp` INT NOT NULL DEFAULT 0 COMMENT '级验',
	  PRIMARY KEY (`charguid`))
	COMMENT = '装备位升星';
#----------------------------------------------------------------------
	SET lastVersion = 314; 
	SET versionNotes = 'Add equip pos up star';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<315 THEN
#----------------------------------------------------------------------
	ALTER TABLE `tb_equip_pos_upstar` 
	ADD COLUMN `id` INT(11) NOT NULL DEFAULT 0 AFTER `exp`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`charguid`, `id`);
#----------------------------------------------------------------------
	SET lastVersion = 315; 
	SET versionNotes = 'change equip pos up star';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<316 THEN
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_super_bag`;
	CREATE TABLE `tb_player_super_bag` (
	  `charguid` BIGINT(20) NOT NULL DEFAULT 0,
	  `gid` INT NOT NULL DEFAULT 0 COMMENT '背包中位置',
	  `mindex` INT NOT NULL DEFAULT 0 COMMENT '索引',
	  `num` INT NOT NULL DEFAULT 0 COMMENT '值',
	  `id` INT NOT NULL DEFAULT 0 COMMENT '属性id',
	  PRIMARY KEY (`gid`, `charguid`))
	COMMENT = '稀有属性背包';
#----------------------------------------------------------------------
	SET lastVersion = 316; 
	SET versionNotes = 'Add player super bag';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<317 THEN
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_info` 
	DROP COLUMN `canjuan`,
	ADD COLUMN `CuMoJiFen` INT(11) NOT NULL DEFAULT '0' COMMENT '除魔积分' AFTER `gloryexp` ;
#----------------------------------------------------------------------
	SET lastVersion = 317; 
	SET versionNotes = 'change canjuan to CuMoJiFen ';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<318 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_guild_newwar`;
	CREATE TABLE `tb_guild_newwar` (
		`gid` 	bigint(20) 	NOT NULL COMMENT '帮派Id',
		`power` bigint(20)	NOT NULL DEFAULT '0' COMMENT '战斗力',
		`score` int(11)		NOT NULL DEFAULT '0' COMMENT '积分',
		`rank`  int(11)		NOT NULL DEFAULT '0' COMMENT '排名',
		`start_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '时间戳',
		PRIMARY KEY (`gid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='参加本次帮派战的帮派列表';
#----------------------------------------------------------------------
	SET lastVersion = 318; 
	SET versionNotes = 'Add Guild War';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<319 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_wing_skin`;
	CREATE TABLE `tb_player_wing_skin` (
	  `charguid` BIGINT(20) NOT NULL DEFAULT 0,
	  `last_id` INT(11) NOT NULL DEFAULT 0 COMMENT '激活的最大皮肤ID',
	  `use_id` INT(11) NOT NULL DEFAULT 0 COMMENT '当前使用ID',
	  `use_type` INT(11) NOT NULL DEFAULT 0 COMMENT '类型: 1翅膀 2皮肤',
	  PRIMARY KEY (`charguid`))
	COMMENT = '翅膀皮肤';
#----------------------------------------------------------------------
	SET lastVersion = 319; 
	SET versionNotes = 'Add wing skin';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<320 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_extra` 
	ADD COLUMN `vitality_total` INT(11) NOT NULL DEFAULT 0 COMMENT '活跃度总数' AFTER `advice`;
#----------------------------------------------------------------------
	SET lastVersion = 320; 
	SET versionNotes = 'Add vitality total';
#----------------------------------------------------------------------
END IF;

IF lastVersion > lastVersion1 THEN 
	INSERT INTO tb_database_version(version, updateDate, lastSql) values(lastVersion, now(), versionNotes);
END IF;

#***************************************************************
IF lastVersion<321 THEN 
#----------------------------------------------------------------------
	SET lastVersion = 321; 
	SET versionNotes = 'Add wing skin info';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<322 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_againstquest`;
CREATE TABLE `tb_player_againstquest` (
  `charguid` bigint(20) NOT NULL COMMENT '玩家GUID',
  `quest_id` int(11) NOT NULL DEFAULT '0' COMMENT '任务ID',
  `quest_star` int(11) NOT NULL DEFAULT '0' COMMENT '日环星级',
  `quest_double` int(11) NOT NULL DEFAULT '0' COMMENT '日环倍率',
  `quest_counter` int(11) NOT NULL DEFAULT '0' COMMENT '当前环数',
  `quest_auto_star` int(11) NOT NULL DEFAULT '0' COMMENT '是否自动升星',
  `quest_counter_id` varchar(256) NOT NULL DEFAULT '0' COMMENT '今日完成日环信息',
  `quest_reward_id` varchar(128) NOT NULL DEFAULT '' COMMENT '日环奖励信息',
  PRIMARY KEY (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日环信息表';
#----------------------------------------------------------------------
	SET lastVersion = 322; 
	SET versionNotes = 'Add against';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<323 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_player_wing_skin` 
ADD COLUMN `ids` VARCHAR(512) NOT NULL DEFAULT '' COMMENT '已激活ID列表' AFTER `use_type`;
#----------------------------------------------------------------------
	SET lastVersion = 323; 
	SET versionNotes = 'change wing skin';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<324 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_guildquest`;
CREATE TABLE `tb_player_guildquest` (
  `charguid` bigint(20) NOT NULL COMMENT '玩家GUID',
  `quest_id` int(11) NOT NULL DEFAULT '0' COMMENT '任务ID',
  `quest_star` int(11) NOT NULL DEFAULT '0' COMMENT '日环星级',
  `quest_double` int(11) NOT NULL DEFAULT '0' COMMENT '日环倍率',
  `quest_counter` int(11) NOT NULL DEFAULT '0' COMMENT '当前环数',
  `quest_auto_star` int(11) NOT NULL DEFAULT '0' COMMENT '是否自动升星',
  `quest_counter_id` varchar(256) NOT NULL DEFAULT '0' COMMENT '今日完成日环信息',
  `quest_reward_id` varchar(128) NOT NULL DEFAULT '' COMMENT '日环奖励信息',
  PRIMARY KEY (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日环信息表';
#----------------------------------------------------------------------
	SET lastVersion = 324; 
	SET versionNotes = 'Add guild quest';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<325 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_player_guanzhi` 
CHANGE COLUMN `charguid` `charguid` BIGINT(20) NOT NULL DEFAULT '0' ;
#----------------------------------------------------------------------
	SET lastVersion = 325; 
	SET versionNotes = 'change guan zhi';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<326 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_magickeys` 
	ADD COLUMN `godid`  bigint(20) NOT NULL DEFAULT '0' COMMENT '法宝仙灵id' AFTER `totalexp`,
	ADD COLUMN `passiveskill` varchar(256) NOT NULL DEFAULT '' COMMENT '被动技能列表' AFTER `totalexp`;
	
	DROP TABLE IF EXISTS `tb_magickeygod_bag`;
	CREATE TABLE `tb_magickeygod_bag` (
	`charguid` bigint(20) NOT NULL COMMENT '玩家GUID',
	`gid` bigint(20) NOT NULL COMMENT '法宝仙灵id',
	`tid` int(11) NOT NULL DEFAULT '0' COMMENT '仙灵配置id',
	`magickeyid` int(11) NOT NULL DEFAULT '0' COMMENT '法宝gid',
	PRIMARY KEY (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='法宝信息';
#----------------------------------------------------------------------
	SET lastVersion = 326; 
	SET versionNotes = 'Add magickey passiveskill';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<327 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_player_guildquest` 
ADD COLUMN `guild_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '帮派GUID';
#----------------------------------------------------------------------
	SET lastVersion = 327; 
	SET versionNotes = 'Add guild id';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<328 THEN
#----------------------------------------------------------------------
ALTER TABLE `tb_magickeygod_bag` 
CHANGE COLUMN `charguid` `charguid` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '玩家GUID' ,
CHANGE COLUMN `gid` `gid` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '法宝仙灵id' ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`charguid`, `gid`);
#----------------------------------------------------------------------
	SET lastVersion = 328; 
	SET versionNotes = 'change magickey bag';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<329 THEN
#----------------------------------------------------------------------
ALTER TABLE `tb_magickeygod_bag` 
CHANGE COLUMN `magickeyid` `magickeyid` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '法宝gid' ;
#----------------------------------------------------------------------
	SET lastVersion = 329; 
	SET versionNotes = 'change magickey bag';
#----------------------------------------------------------------------
END IF;

#***************************************************************
#***************************************************************
IF lastVersion<330 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_extra` 
	ADD COLUMN `petstate` int(11) NOT NULL DEFAULT '0' COMMENT '宠物状态' AFTER `vitality_total`;
#----------------------------------------------------------------------
	SET lastVersion = 330; 
	SET versionNotes = 'Add pet state';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<331 THEN
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_pifeng`;
CREATE TABLE `tb_player_pifeng` (
  `charguid` BIGINT(20) NOT NULL DEFAULT 0,
  `level` INT(11) NOT NULL DEFAULT 0 COMMENT '最高等阶',
  `wish` INT(11) NOT NULL DEFAULT 0 COMMENT '祝福值',
  `use_level` INT(11) NOT NULL DEFAULT 0 COMMENT '使用等级',
  `attr_dan` INT(11) NOT NULL DEFAULT 0 COMMENT '属性丹数量',
  PRIMARY KEY (`charguid`))
COMMENT = '披风';
#----------------------------------------------------------------------
	SET lastVersion = 331; 
	SET versionNotes = 'add PiFeng';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<332 THEN
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_crossboss_history`;
	CREATE TABLE `tb_crossboss_history` (
		`id` 			int(11) 		NOT NULL DEFAULT '0' COMMENT 'ID',
		`avglv` 		int(11) 		NOT NULL DEFAULT '0' COMMENT '平均等级',
		`firstname1` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname1` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
		`firstname2` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname2` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
		`firstname3` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname3` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
		`firstname4` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname4` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
		`firstname5` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname5` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
	  PRIMARY KEY  (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='跨服BOSS记录表';
#----------------------------------------------------------------------
	SET lastVersion = 332; 
	SET versionNotes = 'add cross boss';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<333 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_shengling`;
	CREATE TABLE `tb_player_shengling` (
	  `charguid` bigint(20) NOT NULL COMMENT '角色GUID',
	  `level` int(11) NOT NULL DEFAULT '0' COMMENT '当前等阶',
	  `process` int(11) NOT NULL DEFAULT '0' COMMENT '进度',
	  `sel` int(11) NOT NULL DEFAULT '0' COMMENT '当前切换圣灵',
	  `proce_num` int(11) NOT NULL DEFAULT '0' COMMENT '失败次数',
	  `total_proce` int(11) NOT NULL DEFAULT '0'  COMMENT '总失败次数',
	  `attrdan` int(11) NOT NULL DEFAULT '0' COMMENT '属性丹数量',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='生灵表';
	
	DROP TABLE IF EXISTS `tb_player_shengling_skin`;
	CREATE TABLE `tb_player_shengling_skin` (
	  `charguid` bigint(20) NOT NULL COMMENT '角色GUID',
	  `skin_id` int(11) NOT NULL COMMENT '皮肤ID',
	  `skin_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '皮肤到期时间',
	  PRIMARY KEY (`charguid`,`skin_id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='圣灵皮肤表';
#----------------------------------------------------------------------
	SET lastVersion = 333; 
	SET versionNotes = 'Add tb_player_shengling';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<334 THEN
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_rank_pifeng`;
CREATE TABLE `tb_rank_pifeng` (
  `rank` int(11) NOT NULL COMMENT '排行',
  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
  `lastrank` int(11) NOT NULL DEFAULT '0' COMMENT '上次排行',
  `rankvalue` bigint(20) NOT NULL DEFAULT '0' COMMENT '披风等级',
  PRIMARY KEY (`rank`),
  KEY `guid_idx` (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='披风排行';
#----------------------------------------------------------------------
	SET lastVersion = 334; 
	SET versionNotes = 'add PiFeng rank';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<335 THEN
#----------------------------------------------------------------------
ALTER TABLE `tb_player_equips` 
ADD COLUMN `jinglian` INT(11) NOT NULL DEFAULT 0 COMMENT '装备精炼状态' AFTER `NewGroupLevel`;
#----------------------------------------------------------------------
	SET lastVersion = 335; 
	SET versionNotes = 'add equip jinglianState';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<336 THEN
#----------------------------------------------------------------------
ALTER TABLE `tb_player_extra` 
CHANGE COLUMN `func_flags` `func_flags` VARCHAR(256) NOT NULL DEFAULT '' COMMENT '功能开启标识' ;
#----------------------------------------------------------------------
	SET lastVersion = 336; 
	SET versionNotes = 'extra func open';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<337 THEN
#----------------------------------------------------------------------
	SET lastVersion = 337; 
	SET versionNotes = 'exts';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<338 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_magickeys` 
	ADD COLUMN `strenlv`  int(11) NOT NULL DEFAULT '0' COMMENT '星级' AFTER `godid`;
#----------------------------------------------------------------------
	SET lastVersion = 338; 
	SET versionNotes = 'Add magickey starlv';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<339 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_player_wing_skin` 
DROP COLUMN `ids`;

DROP TABLE IF EXISTS `tb_player_wing_skin_detail`;
CREATE TABLE `tb_player_wing_skin_detail` (
  `charguid` bigint(20) NOT NULL COMMENT '角色GUID',
  `skin_id` int(11) NOT NULL COMMENT '皮肤ID',
  `skin_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '皮肤到期时间',
  PRIMARY KEY (`charguid`,`skin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='翅膀皮肤表';
#----------------------------------------------------------------------
	SET lastVersion = 339; 
	SET versionNotes = 'add wing skin card';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<340 THEN
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_vip` 
	ADD COLUMN `horse_allnum`  int(11) NOT NULL DEFAULT '0' COMMENT '坐骑升阶总使用的石头数量',
	ADD COLUMN `horse_yigeinum`  int(11) NOT NULL DEFAULT '0' COMMENT '已经给的升阶石数量',
	ADD COLUMN `shengbin_allnum`  int(11) NOT NULL DEFAULT '0' COMMENT '神兵升阶总使用的石头数量',
	ADD COLUMN `shengbin_yigeinum`  int(11) NOT NULL DEFAULT '0' COMMENT '神兵已经给的升阶石数量';
#----------------------------------------------------------------------
	SET lastVersion = 340; 
	SET versionNotes = 'add vip horse and shengbing';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<341 THEN
#----------------------------------------------------------------------
#----------------------------------------------------------------------
	SET lastVersion = 341; 
	SET versionNotes = 'Add magickey starlv';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<342 THEN
#----------------------------------------------------------------------
#----------------------------------------------------------------------
	SET lastVersion = 342;  
	SET versionNotes = 'Del Super Bag';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<343 THEN
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_vip` 
	DROP COLUMN `horse_allnum`,
	DROP COLUMN `horse_yigeinum`,
	DROP COLUMN `shengbin_allnum`,
	DROP COLUMN `shengbin_yigeinum`;
#----------------------------------------------------------------------
#----------------------------------------------------------------------
	ALTER TABLE `tb_ride` 
	ADD COLUMN `horse_allnum`  int(11) NOT NULL DEFAULT '0' COMMENT '坐骑升阶总使用的石头数量',
	ADD COLUMN `horse_yilingqunum`  int(11) NOT NULL DEFAULT '0' COMMENT '坐骑已经领取的进阶石数量',
	ADD COLUMN `horse_kelingqunum`  int(11) NOT NULL DEFAULT '0' COMMENT '坐骑可领取的进阶石数量';
#----------------------------------------------------------------------
	SET lastVersion = 343; 
	SET versionNotes = 'add vip horse';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<344 THEN
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_shenbing` 
	ADD COLUMN `shengbing_allnum`  int(11) NOT NULL DEFAULT '0' COMMENT '神兵升阶总使用的升阶石数量',
	ADD COLUMN `shengbing_kelingqunum`  int(11) NOT NULL DEFAULT '0' COMMENT '神兵坐骑可领取的升阶石数量',
	ADD COLUMN `shengbing_yilingqunum`  int(11) NOT NULL DEFAULT '0' COMMENT '神兵已经领取的进阶石数量';
#----------------------------------------------------------------------
	SET lastVersion = 344; 
	SET versionNotes = 'add vip shenbing';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<345 THEN
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_gem_bag_info`;
CREATE TABLE `tb_gem_bag_info` (
  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `pos` int(11) DEFAULT '0',
  `is_open` int(11) DEFAULT '0' COMMENT '是否开启',
  PRIMARY KEY (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='装备位（背包）信息';
#----------------------------------------------------------------------
	SET lastVersion = 345; 
	SET versionNotes = 'add gem bag';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<346 THEN 
#----------------------------------------------------------------------
	ALTER TABLE tb_player_extra
	ADD COLUMN `draw_cnt` int(11) NOT NULL DEFAULT '0'  COMMENT '转盘次数';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_draw_record`;
	CREATE TABLE `tb_player_draw_record` (
	  `charguid` 	    bigint(20) 	NOT NULL DEFAULT '0' COMMENT 'guid',
	  `index`			int(11)		NOT NULL DEFAULT '0' COMMEnT '索引',
	  `reward`			int(11)		NOT NULL DEFAULT '0' COMMEnT '奖励',
	  `param`			int(11)		NOT NULL DEFAULT '0' COMMENT '参数',
	  PRIMARY KEY (`charguid`, `index`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '转盘抽奖';
#----------------------------------------------------------------------
	SET lastVersion = 346;
	SET versionNotes = 'add lucky draw';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<347 THEN 
#----------------------------------------------------------------------
#----------------------------------------------------------------------
	SET lastVersion = 347;
	SET versionNotes = 'add pifeng rank';
#----------------------------------------------------------------------
END IF;

#***************************************************************
IF lastVersion<348 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_gem_bag_info` 
CHANGE COLUMN `pos` `pos` INT(11) NOT NULL DEFAULT '0' ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`charguid`, `pos`);
#----------------------------------------------------------------------
	SET lastVersion = 348;
	SET versionNotes = 'add pifeng rank';
#----------------------------------------------------------------------
END IF;
#***************************************************************

#***************************************************************
IF lastVersion<349 THEN 
#----------------------------------------------------------------------
	ALTER TABLE tb_player_info
	ADD COLUMN `luck_point` int(11) NOT NULL DEFAULT '0'  COMMENT '抽奖积分';
#----------------------------------------------------------------------
	SET lastVersion = 349;
	SET versionNotes = 'add luck point';
#----------------------------------------------------------------------
END IF;
#***************************************************************

#***************************************************************
IF lastVersion<350 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_hunlingxianyu`;
CREATE TABLE `tb_hunlingxianyu` (
  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '挑战玩家guid',
  `FinishLayer` int(11) NOT NULL DEFAULT '0' COMMENT '已通关的层数',
  `MyMaxLayer` int(11) NOT NULL DEFAULT '0' COMMENT '我的最好层数',
  `ResetNum` int(11) NOT NULL DEFAULT '0' COMMENT '已重置次数',
  PRIMARY KEY (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='灵兽墓地配表';

DROP TABLE IF EXISTS `tb_hunlingxianyu_rank`;
CREATE TABLE `tb_hunlingxianyu_rank` (
  `rank` int(11) NOT NULL DEFAULT '0' COMMENT '玩家排名',
  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '玩家GUID',
  `player_name` varchar(32) NOT NULL DEFAULT '' COMMENT '玩家名',
  `layer` int(11) NOT NULL DEFAULT '0' COMMENT '挑战层数',
  `rank_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '记录时间',
  `prof` int(11) NOT NULL DEFAULT '0' COMMENT '玩家职业',
  PRIMARY KEY (`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='灵兽墓地排行表';
#----------------------------------------------------------------------
	SET lastVersion = 350;
	SET versionNotes = 'add hun ling';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<351 THEN 
#----------------------------------------------------------------------
	ALTER TABLE tb_player_info
    ADD COLUMN `txvipflag` int(11) NOT NULL DEFAULT '0'  COMMENT '',
    ADD COLUMN `txbvipflag` int(11) NOT NULL DEFAULT '0'  COMMENT '';
#----------------------------------------------------------------------
  	ALTER TABLE tb_exchange_record
    CHANGE COLUMN `order_id` `order_id` varchar(64) NOT NULL COMMENT '充值订单ID',
    CHANGE COLUMN `uid` `uid` varchar(64) NOT NULL DEFAULT '' COMMENT '账号ID';
#----------------------------------------------------------------------
    DROP TABLE IF EXISTS `tb_player_txvip`;
    CREATE TABLE `tb_player_txvip` (
	  `charguid` bigint(20) NOT NULL COMMENT '玩家id',
	  `dayflag` int(11) NOT NULL DEFAULT '0' COMMENT '每日礼包标识',
	  `dayyearflag` int(11) NOT NULL DEFAULT '0' COMMENT '每日礼包年费标识',
	  `newflag` int(11) NOT NULL DEFAULT '0' COMMENT '新手礼包标识',
	  `levelflag` varchar(128) NOT NULL DEFAULT '' COMMENT '等级礼包标识',
	  `bdayflag` int(11) NOT NULL DEFAULT '0' COMMENT '每日礼包标识',
	  `bdayyearflag` int(11) NOT NULL DEFAULT '0' COMMENT '每日礼包年费标识',
	  `bdayhighflag` int(11) NOT NULL DEFAULT '0' COMMENT '每日豪华标识',
	  `bnewflag` int(11) NOT NULL DEFAULT '0' COMMENT '新手礼包标识',
	  `blevelflag` varchar(128) NOT NULL DEFAULT '' COMMENT '等级礼包标识',
	  `tgpdayflag` int(11) NOT NULL DEFAULT '0' COMMENT 'TGP每日礼包标识',
	  `tgpweekflag` int(11) NOT NULL DEFAULT '0' COMMENT 'TGP每周礼包标识',
	  `tgpnewflag` int(11) NOT NULL DEFAULT '0' COMMENT 'TGP新手礼包标识',
	  `tgplevelflag` varchar(128) NOT NULL DEFAULT '' COMMENT 'TGP等级礼包标识',
	  `gamedayflag` int(11) NOT NULL DEFAULT '0' COMMENT 'Game每日礼包标识',
	  `gameweekflag` int(11) NOT NULL DEFAULT '0' COMMENT 'Game每周礼包标识',
	  `gamenewflag` int(11) NOT NULL DEFAULT '0' COMMENT 'Game新手礼包标识',
	  `gamelevelflag` varchar(128) NOT NULL DEFAULT '' COMMENT 'Game等级礼包标识',
	  `zonedayflag` int(11) NOT NULL DEFAULT '0' COMMENT 'Zone每日礼包标识',
	  `zoneweekflag` int(11) NOT NULL DEFAULT '0' COMMENT 'Zone每周礼包标识',
	  `zonenewflag` int(11) NOT NULL DEFAULT '0' COMMENT 'Zone新手礼包标识',
	  `zonelevelflag` varchar(128) NOT NULL DEFAULT '' COMMENT 'Zone等级礼包标识',
	  `seven_day_login` int(11) NOT NULL DEFAULT 0 COMMENT '是否七天登陆',
      `cont_login_day` int(11) NOT NULL DEFAULT 0 COMMENT '连续登陆天数',
	  `channel_id` int(11) NOT NULL DEFAULT '0' COMMENT '渠道',
	  `bhlflag` int(11) NOT NULL DEFAULT 0 COMMENT '蓝钻豪礼',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='腾讯黄钻信息表';
#----------------------------------------------------------------------
	SET lastVersion = 351; 
	SET versionNotes = 'tencent version';
#----------------------------------------------------------------------
END IF;
#***************************************************************


#***************************************************************
IF lastVersion<352 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS tb_player_zhiyuanfb;
CREATE TABLE tb_player_zhiyuanfb (
  `charguid` bigint(20) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT '关卡',
  `level_star` int(11) NOT NULL DEFAULT '0' COMMENT '星级',
  `challenge` int(11) NOT NULL DEFAULT '0' COMMENT '挑战次数',
  `buy_num` int(11) NOT NULL DEFAULT '0' COMMENT '购买次数',
  `sweep_state` int(11) NOT NULL DEFAULT '0' COMMENT '扫荡状态',
  `sweep_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '扫荡时间',
  `road_box` varchar(32) NOT NULL DEFAULT '' COMMENT '宝箱',
  `time_stamp` bigint(20) NOT NULL DEFAULT '0',
  `sweep_times` int(11) NOT NULL DEFAULT '0' COMMENT '扫荡次数',
  `star_state` int(11) NOT NULL DEFAULT '0' COMMENT '首通三星奖励领取状态',
  PRIMARY KEY (`charguid`,`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源副本表';

DROP TABLE IF EXISTS `tb_zhiyuanfb_box`;
CREATE TABLE `tb_zhiyuanfb_box` (
  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
  `road_box` varchar(32) NOT NULL DEFAULT '' COMMENT '宝箱信息',
  `buy_num` int(11) NOT NULL DEFAULT '0' COMMENT '购买精力次数',
  `tick` int(11) NOT NULL DEFAULT '0' COMMENT '精力值回复时间计数',
  `challenge_count` int(11) NOT NULL DEFAULT '0' COMMENT '挑战共享次数',
  `roadlv_max` int(11) NOT NULL DEFAULT '0' COMMENT '挑战最高等级',
  PRIMARY KEY (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源副本宝箱表';

ALTER TABLE `tb_player_extra` 
ADD COLUMN `vitality_vip` INT(11) NULL DEFAULT 0 AFTER `draw_cnt`;
#----------------------------------------------------------------------
	SET lastVersion = 352; 
	SET versionNotes = 'add zhiyuan fb';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<353 THEN 
#----------------------------------------------------------------------
    DROP TABLE IF EXISTS `tb_player_licai`;
    CREATE TABLE `tb_player_licai` (
	  `charguid` bigint(20) NOT NULL COMMENT '玩家id',
	  `id` int(11) NOT NULL DEFAULT '0' COMMENT 'id',
	  `param1` bigint(20) NOT NULL DEFAULT '0' COMMENT '参数1',
	  `param2` bigint(20) NOT NULL DEFAULT '0' COMMENT '参数2',
	  `reward` varchar(256) NOT NULL DEFAULT '' COMMENT '奖励信息',
	  PRIMARY KEY (`charguid`,`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家理财表';
#----------------------------------------------------------------------
	SET lastVersion = 353; 
	SET versionNotes = 'add licai';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<354 THEN 
#----------------------------------------------------------------------
    DROP TABLE IF EXISTS `tb_player_xiuwei`;
    CREATE TABLE `tb_player_xiuwei` (
	  `charguid` bigint(20) NOT NULL COMMENT '玩家id',
	  `group` int(11) NOT NULL DEFAULT '0' COMMENT '组id',
	  `level` int(20) NOT NULL DEFAULT '0' COMMENT '等级',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家修为等级表';
#----------------------------------------------------------------------
	SET lastVersion = 354; 
	SET versionNotes = 'add xiu wei';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<355 THEN 
#----------------------------------------------------------------------
    DROP TABLE IF EXISTS `tb_player_hongyan`;
    CREATE TABLE `tb_player_hongyan` (
	  `charguid` bigint(20) NOT NULL COMMENT '玩家id',
	  `hongyan_id` int(11) NOT NULL DEFAULT '0' COMMENT '红颜ID',
	  `jiedian` int(11) NOT NULL DEFAULT '0' COMMENT '激活节点',
	  `jiedian_level` int(11) NOT NULL DEFAULT '0' COMMENT '激活节点对应等级',
	  `is_jihuo` int(11) NOT NULL DEFAULT '0' COMMENT '是否激活',
	  `level` int(11) NOT NULL DEFAULT '0' COMMENT '阶数',
	  `star` int(11) NOT NULL DEFAULT '0' COMMENT '阶数对应星数',
	  `wish` int(11) NOT NULL DEFAULT '0' COMMENT '星对应祝福值',
	  `chu_zhan` int(11) NOT NULL DEFAULT '0' COMMENT '是否出战',
	  `starlevel` int(11) NOT NULL DEFAULT '0' COMMENT '星经验',
	  PRIMARY KEY (`charguid`, `hongyan_id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家红颜表';
#----------------------------------------------------------------------
	SET lastVersion = 355; 
	SET versionNotes = 'add hong yan';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<356 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_player_personboss` 
ADD COLUMN `exit_time` BIGINT(20) NOT NULL DEFAULT 0 AFTER `first`;
#----------------------------------------------------------------------
	SET lastVersion = 356; 
	SET versionNotes = 'person boss';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<357 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_nei_gong` 
ADD INDEX `neigong_ix` (`charguid` ASC);
#----------------------------------------------------------------------
	SET lastVersion = 357; 
	SET versionNotes = 'neigong add index';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<358 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_nei_gong` 
ADD COLUMN `GroupID` INT(11) NOT NULL DEFAULT 0 AFTER `NodeLevel`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`charguid`, `GroupID`),
DROP INDEX `neigong_ix` ;
#----------------------------------------------------------------------
	SET lastVersion = 358; 
	SET versionNotes = 'neigong change';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<359 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_player_pifeng` 
ADD COLUMN `AllNum` INT(11) NOT NULL DEFAULT 0 COMMENT '披风升阶总使用的升阶石数量' AFTER `attr_dan`,
ADD COLUMN `KeLingQuNum` INT(11) NOT NULL DEFAULT 0 COMMENT '披风可领取的升阶石数量' AFTER `AllNum`,
ADD COLUMN `YiLingQuNum` INT(11) NOT NULL DEFAULT 0 COMMENT '披风已经领取的升阶石数量' AFTER `KeLingQuNum`;
#----------------------------------------------------------------------
	SET lastVersion = 359; 
	SET versionNotes = 'pifeng vip';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<360 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_guild` 
ADD COLUMN `is_first` INT(11) NOT NULL DEFAULT 0 COMMENT '是否帮派战第一';
#----------------------------------------------------------------------
	SET lastVersion = 360; 
	SET versionNotes = 'add first guild title';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<361 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_history`;
CREATE TABLE `tb_player_history` (
  charguid BIGINT(20) NOT NULL DEFAULT 0,
  day_1 BIGINT(20) NOT NULL DEFAULT 0 COMMENT '日期',
  level_1 INT(11) NOT NULL DEFAULT 0 COMMENT '角色等级',
  lingshoumudi_1 INT(11) NOT NULL DEFAULT 0 COMMENT '灵兽墓地层数',
  secret_1 INT(11) NOT NULL DEFAULT 0 COMMENT '试炼密境层数',
  zhuzairoad_1 INT(11) NULL DEFAULT 0 COMMENT '等级副本层数',  
  day_2 BIGINT(20) NOT NULL DEFAULT 0 COMMENT '日期',
  level_2 INT(11) NOT NULL DEFAULT 0 COMMENT '角色等级',
  lingshoumudi_2 INT(11) NOT NULL DEFAULT 0 COMMENT '灵兽墓地层数',
  secret_2 INT(11) NOT NULL DEFAULT 0 COMMENT '试炼密境层数',
  zhuzairoad_2 INT(11) NULL DEFAULT 0 COMMENT '等级副本层数',
  PRIMARY KEY (`charguid`))
COMMENT = '角色历史等级';
#----------------------------------------------------------------------
	SET lastVersion = 361; 
	SET versionNotes = 'add history level';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<362 THEN
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_rank_xiuwei`;
CREATE TABLE `tb_rank_xiuwei` (
  `rank` int(11) NOT NULL COMMENT '排行',
  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
  `lastrank` int(11) NOT NULL DEFAULT '0' COMMENT '上次排行',
  `rankvalue` bigint(20) NOT NULL DEFAULT '0' COMMENT '修为等级',
  PRIMARY KEY (`rank`),
  KEY `guid_idx` (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='修为排行';
#----------------------------------------------------------------------
	SET lastVersion = 362; 
	SET versionNotes = 'add xiuwei rank';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<363 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_zhiyuanfb_box` 
CHANGE COLUMN `challenge_count` `challenge_count` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '挑战共享次数' ;
#----------------------------------------------------------------------
	SET lastVersion = 363; 
	SET versionNotes = 'zhi yuan fb';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<364 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_extra` 
    ADD COLUMN `choujiang_num` int(11) NOT NULL DEFAULT 0  COMMENT '高阶法宝抽奖次数';
#----------------------------------------------------------------------
	SET lastVersion = 364; 
	SET versionNotes = 'alter choujiang_num';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<365 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_txvip` 
    ADD COLUMN `lastrenew` bigint(20) NOT NULL DEFAULT 0  COMMENT '';
#----------------------------------------------------------------------
	SET lastVersion = 365; 
	SET versionNotes = 'alter tx vip';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<366 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_player_items` 
ADD COLUMN `param4` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '参数4' AFTER `param3`;
#----------------------------------------------------------------------
	SET lastVersion = 366; 
	SET versionNotes = 'alter player items';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<367 THEN 
#----------------------------------------------------------------------
    DROP TABLE IF EXISTS `tb_player_worldboss_wabao`;
    CREATE TABLE `tb_player_worldboss_wabao` (
	  `charguid` bigint(20) NOT NULL COMMENT '角色GUID',
	  `bossid` int(11) NOT NULL DEFAULT '0' COMMENT '世界BOSS ID',
	  `state` int(11) NOT NULL DEFAULT '0' COMMENT '领取状态',
	  `keling_num` int(11) NOT NULL DEFAULT '0' COMMENT '领取次数',
	  `cur_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '当天时间',
	  PRIMARY KEY (`charguid`, `bossid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='世界BOSS 挖宝';
#----------------------------------------------------------------------
	SET lastVersion = 367; 
	SET versionNotes = 'add worldboss wabao';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<368 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_magickeys` 
    ADD COLUMN `strelevelVal` int(11) NOT NULL DEFAULT 0  COMMENT '星对应的进度值';
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_extra` 
    ADD COLUMN `magickey_kl_num` int(11) NOT NULL DEFAULT 0  COMMENT '法宝经验丹可领取数',
	ADD COLUMN `magickey_yl_num` int(11) NOT NULL DEFAULT 0  COMMENT '法宝经验丹已领取数',
	ADD COLUMN `magickey_all_num` int(11) NOT NULL DEFAULT 0  COMMENT '法宝经验丹总分解数';
#----------------------------------------------------------------------
	SET lastVersion = 368; 
	SET versionNotes = 'add magickey num';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<369 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_crossboss_history`;
	CREATE TABLE `tb_crossboss_history` (
		`id` 			int(11) 		NOT NULL DEFAULT '0' COMMENT 'ID',
		`avglv` 		int(11) 		NOT NULL DEFAULT '0' COMMENT '平均等级',
		`firstname1` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname1` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
		`firstname2` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname2` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
		`firstname3` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname3` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
		`firstname4` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname4` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
		`firstname5` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname5` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
	  PRIMARY KEY  (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='跨服BOSS记录表';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_crossarena_history`;
	CREATE TABLE `tb_crossarena_history` (
	  `seasonid` int(11) NOT NULL COMMENT '赛季ID',
	  `arenaid` int(11) NOT NULL DEFAULT '0' COMMENT '竞技ID',
	  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '玩家名字',
	  `prof` int(11) NOT NULL DEFAULT '0' COMMENT '职业',
	  `power` bigint(20) NOT NULL DEFAULT '0' COMMENT '战力',
	  PRIMARY KEY (`seasonid`, `arenaid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='跨服擂台表';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_crossarena_xiazhu`;
	CREATE TABLE `tb_crossarena_xiazhu` (
	 `charguid` 	    bigint(20) 	NOT NULL DEFAULT '0' COMMENT '玩家id',
	 `seasonid` 	    int(10) 	NOT NULL DEFAULT '0' COMMENT '赛季ID',
	 `targetguid` 		bigint(20) 	NOT NULL DEFAULT '0' COMMENT '目标玩家guid',
	 `xiazhunum` 		int(11) 	NOT NULL DEFAULT '0' COMMENT '下注金额',
	  PRIMARY KEY  (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家下注信息表';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_crosstask`;
	CREATE TABLE `tb_player_crosstask` (
	  `charguid` bigint(20) NOT NULL COMMENT '角色GUID',
	  `quest_id` int(11) NOT NULL COMMENT '任务ID',
	  `questgid` bigint(20) NOT NULL COMMENT '任务唯一ID',
	  `quest_state` int(11) NOT NULL DEFAULT '0' COMMENT '任务状态',
	  `goal1` bigint(20) NOT NULL DEFAULT '0' COMMENT '任务目标ID',
	  `goal_count1` int(11) NOT NULL DEFAULT '0' COMMENT '任务目标计数',
	  `time_stamp` bigint(20) NOT NULL DEFAULT '0',
	  PRIMARY KEY (`charguid`,`quest_id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='跨服任务表';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_crosstask_extra`;
	CREATE TABLE `tb_player_crosstask_extra` (
	  `charguid` bigint(20) NOT NULL COMMENT '角色GUID',
	  `score` int(11) NOT NULL COMMENT '积分',
	  `onlinetime` int(11) NOT NULL COMMENT '在线时间',
	  `refreshtimes` int(11) NOT NULL DEFAULT '0' COMMENT '剩余刷新次数',
	  `lastrefreshtime` bigint(20) NOT NULL DEFAULT '0' COMMENT '上次刷新时间',
	  `questlist` varchar(128) NOT NULL DEFAULT '' COMMENT '任务列表',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='跨服任务额外信息表';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_military`;
	CREATE TABLE `tb_player_military` (
	  `charguid` bigint(20) NOT NULL COMMENT '角色GUID',
	  `level` int(11) NOT NULL DEFAULT '0' COMMENT '等级',
	  `exploit` int(11) NOT NULL DEFAULT '0' COMMENT '军功',
	  `todayexploit` int(11) NOT NULL DEFAULT '0' COMMENT '今日活动军功',
	  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '标记',
	  `updatetime` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='军衔表';
#----------------------------------------------------------------------
	ALTER TABLE `tb_arena_att`
	ADD COLUMN `parryrate` double NOT NULL DEFAULT '0',
	ADD COLUMN `supper` double NOT NULL DEFAULT '0',
	ADD COLUMN `suppervalue` double NOT NULL DEFAULT '0';
#----------------------------------------------------------------------
	SET lastVersion = 369; 
	SET versionNotes = 'add cross boss and cross arena';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<370 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_crosstask_extra` 
    ADD COLUMN `finishcnt` int(11) NOT NULL DEFAULT 0  COMMENT '';
#----------------------------------------------------------------------
	SET lastVersion = 370; 
	SET versionNotes = 'alter cross task';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<372 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_crosstask_extra` 
    ADD COLUMN `rewardinfo` varchar(128) NOT NULL DEFAULT ''  COMMENT '',
    ADD COLUMN `param1` int(11) NOT NULL DEFAULT 0  COMMENT '',
    ADD COLUMN `param2` int(11) NOT NULL DEFAULT 0  COMMENT '';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_crosstask_history`;
	CREATE TABLE `tb_crosstask_history` (
	  `id` int(11) NOT NULL COMMENT 'id',
	  `exploit` int(11) NOT NULL DEFAULT 0 COMMENT '军功',
	  `score` int(11) NOT NULL DEFAULT 0 COMMENT '积分',
	  `param1` int(11) NOT NULL DEFAULT 0 COMMENT '参数1',
	  `param2` int(11) NOT NULL DEFAULT 0 COMMENT '参数2',
	  `rankinfo` varchar(128) NOT NULL DEFAULT '' COMMENT '排名信息',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='跨服任务信息表';
#----------------------------------------------------------------------
	SET lastVersion = 372; 
	SET versionNotes = 'add cross task';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<373 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_cross_consume`;
	CREATE TABLE `tb_player_cross_consume` (
	  `charguid` bigint(20) NOT NULL COMMENT '角色GUID',
	  `consumeinfo` varchar(256) NOT NULL DEFAULT 0 COMMENT '消耗信息',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='跨服消耗';
#----------------------------------------------------------------------
	SET lastVersion = 373; 
	SET versionNotes = 'add cross consume';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<374 THEN 
#----------------------------------------------------------------------
    ALTER TABLE  `tb_player_txvip`
	ADD COLUMN `browserdayflag` int(11) NOT NULL DEFAULT '0' COMMENT 'Browser每日礼包标识',
	ADD COLUMN `browserweekflag` int(11) NOT NULL DEFAULT '0' COMMENT 'Browser每周礼包标识',
	ADD COLUMN `browsernewflag` int(11) NOT NULL DEFAULT '0' COMMENT 'Browser新手礼包标识',
	ADD COLUMN `browserlevelflag` varchar(128) NOT NULL DEFAULT '' COMMENT 'Browser等级礼包标识',
	ADD COLUMN `guanjiadayflag` int(11) NOT NULL DEFAULT '0' COMMENT '管家每日礼包标识',
	ADD COLUMN `guanjiaweekflag` int(11) NOT NULL DEFAULT '0' COMMENT '管家每周礼包标识',
	ADD COLUMN `guanjianewflag` int(11) NOT NULL DEFAULT '0' COMMENT '管家新手礼包标识',
	ADD COLUMN `guanjialevelflag` varchar(128) NOT NULL DEFAULT '' COMMENT '管家等级礼包标识';
#----------------------------------------------------------------------
	SET lastVersion = 374; 
	SET versionNotes = 'add tx ';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<375 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_magickeygod_bag` 
	ADD COLUMN `grow_value` int(11) NOT NULL DEFAULT 0  COMMENT '对应的资质值',
    ADD COLUMN `pinzhi` int(11) NOT NULL DEFAULT 0  COMMENT '对应当前品质';
#----------------------------------------------------------------------
	SET lastVersion = 375; 
	SET versionNotes = 'alter god info';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<376 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_magickeygod_bag`
    ADD COLUMN `isnew` int(11) NOT NULL DEFAULT 0  COMMENT '是否最新数据';
#----------------------------------------------------------------------
	SET lastVersion = 376; 
	SET versionNotes = 'alter add is new';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<377 THEN 
#----------------------------------------------------------------------
    ALTER TABLE  `tb_player_extra`
	ADD COLUMN `monthcharge` int(11) NOT NULL DEFAULT 0 COMMENT '每月累计充值',
	ADD COLUMN `maxcharge` int(11) NOT NULL DEFAULT '0' COMMENT '单次最大充值';
#----------------------------------------------------------------------
	SET lastVersion = 377; 
	SET versionNotes = 'add xiyou bind ';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<378 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_baojia`;
CREATE TABLE `tb_player_baojia` (
  `charguid` bigint(20) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT '最高等阶',
  `wish` int(11) NOT NULL DEFAULT '0' COMMENT '祝福值',
  `use_level` int(11) NOT NULL DEFAULT '0' COMMENT '使用等级',
  `attr_dan` int(11) NOT NULL DEFAULT '0' COMMENT '属性丹数量',
  `AllNum` int(11) NOT NULL DEFAULT '0' COMMENT '升阶总使用的升阶石数量',
  `KeLingQuNum` int(11) NOT NULL DEFAULT '0' COMMENT '可领取的升阶石数量',
  `YiLingQuNum` int(11) NOT NULL DEFAULT '0' COMMENT '已经领取的升阶石数量',
  PRIMARY KEY (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='宝甲';

DROP TABLE IF EXISTS `tb_rank_baojia`;
CREATE TABLE `tb_rank_baojia` (
  `rank` int(11) NOT NULL COMMENT '排行',
  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
  `lastrank` int(11) NOT NULL DEFAULT '0' COMMENT '上次排行',
  `rankvalue` bigint(20) NOT NULL DEFAULT '0' COMMENT '宝甲等级',
  PRIMARY KEY (`rank`),
  KEY `guid_idx` (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='宝甲排行';
#----------------------------------------------------------------------
	SET lastVersion = 378; 
	SET versionNotes = 'add bao jia';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<379 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_rank_ride_war`;
CREATE TABLE `tb_rank_ride_war` (
  `rank` int(11) NOT NULL COMMENT '排行',
  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
  `lastrank` int(11) NOT NULL DEFAULT '0' COMMENT '上次排行',
  `rankvalue` bigint(20) NOT NULL DEFAULT '0' COMMENT '骑战等阶',
  PRIMARY KEY (`rank`),
  KEY `guid_idx` (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='骑战排行';
#----------------------------------------------------------------------
	SET lastVersion = 379; 
	SET versionNotes = 'add rank ridewar';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<380 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_tiangang`;
CREATE TABLE `tb_player_tiangang` (
  `charguid` bigint(20) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT '最高等阶',
  `wish` int(11) NOT NULL DEFAULT '0' COMMENT '祝福值',
  `use_level` int(11) NOT NULL DEFAULT '0' COMMENT '使用等级',
  `attr_dan` int(11) NOT NULL DEFAULT '0' COMMENT '属性丹数量',
  `AllNum` int(11) NOT NULL DEFAULT '0' COMMENT '升阶总使用的升阶石数量',
  `KeLingQuNum` int(11) NOT NULL DEFAULT '0' COMMENT '可领取的升阶石数量',
  `YiLingQuNum` int(11) NOT NULL DEFAULT '0' COMMENT '已经领取的升阶石数量',
  PRIMARY KEY (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='天罡';

DROP TABLE IF EXISTS `tb_rank_tiangang`;
CREATE TABLE `tb_rank_tiangang` (
  `rank` int(11) NOT NULL COMMENT '排行',
  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
  `lastrank` int(11) NOT NULL DEFAULT '0' COMMENT '上次排行',
  `rankvalue` bigint(20) NOT NULL DEFAULT '0' COMMENT '天罡等级',
  PRIMARY KEY (`rank`),
  KEY `guid_idx` (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='天罡排行';
#----------------------------------------------------------------------
	SET lastVersion = 380; 
	SET versionNotes = 'add tian gang';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<381 THEN
#----------------------------------------------------------------------
    ALTER TABLE  `tb_player_extra`
	ADD COLUMN `hongyan_power` int(11) NOT NULL DEFAULT 0 COMMENT '红颜战力',
	ADD COLUMN `hongyan_id` int(11) NOT NULL DEFAULT '0' COMMENT '红颜优先显示ID';
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_rank_hongyan`;
CREATE TABLE `tb_rank_hongyan` (
  `rank` int(11) NOT NULL COMMENT '排行',
  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
  `lastrank` int(11) NOT NULL DEFAULT '0' COMMENT '上次排行',
  `rankvalue` bigint(20) NOT NULL DEFAULT '0' COMMENT '红颜Id',
  PRIMARY KEY (`rank`),
  KEY `guid_idx` (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='红颜排行';
#----------------------------------------------------------------------
	SET lastVersion = 381; 
	SET versionNotes = 'add hongyan rank';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<382 THEN 
#----------------------------------------------------------------------
	SET lastVersion = 382; 
	SET versionNotes = 'Add hongyan rank ';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<383 THEN
#----------------------------------------------------------------------
    ALTER TABLE  `tb_player_guanzhi`
	ADD COLUMN `curr_value` int(11) NOT NULL DEFAULT 0 COMMENT '上报的功勋';
#----------------------------------------------------------------------
	SET lastVersion = 383; 
	SET versionNotes = 'change guanzhi';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<384 THEN
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_party_guild_purchase`;
	CREATE TABLE `tb_party_guild_purchase` (
	`id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
	`gid` bigint(20) NOT NULL DEFAULT '0' COMMENT '帮派GUID',
	`cnt` int(11) NOT NULL DEFAULT '0' COMMENT '次数',
	`name` varchar(64) NOT NULL DEFAULT 0 COMMENT '帮派名称',
	`param1` int(11) NOT NULL DEFAULT '0' COMMENT '参数1',
	`param2` int(11) NOT NULL DEFAULT '0' COMMENT '参数2',
	PRIMARY KEY (`id`,`gid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮派团购表';
#----------------------------------------------------------------------
    ALTER TABLE  `tb_player_party`
	ADD COLUMN `param4` bigint(20) NOT NULL DEFAULT 0 COMMENT '参数4',
	ADD COLUMN `param5` bigint(20) NOT NULL DEFAULT 0 COMMENT '参数5';
#----------------------------------------------------------------------
	SET lastVersion = 384; 
	SET versionNotes = 'add guild purchase';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<385 THEN
#----------------------------------------------------------------------
	ALTER TABLE  `tb_player_guanzhi`
	ADD COLUMN `huoyuedu` int(11) NOT NULL DEFAULT 0 COMMENT '活跃度';
#----------------------------------------------------------------------
	SET lastVersion = 385; 
	SET versionNotes = 'save eaHuoYueDu';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<386 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_zhannu`;
	CREATE TABLE `tb_player_zhannu` (
	  `charguid` bigint(20) NOT NULL COMMENT '角色GUID',
	  `level` int(11) NOT NULL DEFAULT '0' COMMENT '当前等阶',
	  `process` int(11) NOT NULL DEFAULT '0' COMMENT '进度',
	  `sel` int(11) NOT NULL DEFAULT '0' COMMENT '当前切换战弩',
	  `proce_num` int(11) NOT NULL DEFAULT '0' COMMENT '失败次数',
	  `total_proce` int(11) NOT NULL DEFAULT '0'  COMMENT '总失败次数',
	  `attrdan` int(11) NOT NULL DEFAULT '0' COMMENT '属性丹数量',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='战弩表';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_rank_zhannu`;
	CREATE TABLE `tb_rank_zhannu` (
	  `rank` int(11) NOT NULL COMMENT '排行',
	  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
	  `lastrank` int(11) NOT NULL DEFAULT '0' COMMENT '上次排行',
	  `rankvalue` bigint(20) NOT NULL DEFAULT '0' COMMENT '战弩等级',
	  PRIMARY KEY (`rank`),
	  KEY `guid_idx` (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='战弩排行';
#---------------------------------------------------------
	SET lastVersion = 386; 
	SET versionNotes = 'Add zhannu';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<387 THEN
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_party_guild_duobao`;
	CREATE TABLE `tb_party_guild_duobao` (
	`id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
	`gid` bigint(20) NOT NULL DEFAULT '0' COMMENT '帮派GUID',
	`cnt` int(11) NOT NULL DEFAULT '0' COMMENT '次数',
	`name` varchar(64) NOT NULL DEFAULT 0 COMMENT '帮派名称',
	`winername` varchar(64) NOT NULL DEFAULT 0 COMMENT '胜利者名称',
	`duobaoinfo` varchar(1024) NOT NULL DEFAULT 0 COMMENT '夺宝信息',
	`param1` int(11) NOT NULL DEFAULT '0' COMMENT '参数1',
	`param2` int(11) NOT NULL DEFAULT '0' COMMENT '参数2',
	PRIMARY KEY (`id`,`gid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮派团购表';
#----------------------------------------------------------------------
	SET lastVersion = 387; 
	SET versionNotes = 'add guild duobao';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<388 THEN
#----------------------------------------------------------------------
    ALTER TABLE  `tb_player_extra`
	ADD COLUMN `hongyan_chuzhan_id` int(11) NOT NULL DEFAULT 0 COMMENT '红颜出战Id';
#----------------------------------------------------------------------
	SET lastVersion = 388; 
	SET versionNotes = 'add hongyan pifu';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<389 THEN 
#----------------------------------------------------------------------
ALTER TABLE `tb_zhiyuanfb_box` 
ADD COLUMN `challenge_count2` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '挑战共享次数2',
ADD COLUMN `challenge_count3` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '挑战共享次数3';
#----------------------------------------------------------------------
	SET lastVersion = 389; 
	SET versionNotes = 'zhiyuanfb count';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<390 THEN 
#----------------------------------------------------------------------
	SET lastVersion = 390; 
	SET versionNotes = 'acc lock';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<391 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_cross_citywar_history`;
	CREATE TABLE `tb_cross_citywar_history` (
	  `id` int(11) NOT NULL COMMENT 'id',
	  `citygid` bigint(20) NOT NULL DEFAULT 0 COMMENT '城主id',
	  `citygroup` int(11) NOT NULL DEFAULT 0 COMMENT '城主区服',
	  `godgid` bigint(20) NOT NULL DEFAULT 0 COMMENT '战神id',
	  `godgroup` int(11) NOT NULL DEFAULT 0 COMMENT '战神区服',
	  `rankinfo` varchar(128) NOT NULL DEFAULT '' COMMENT '排名信息',
	  `role1` varchar(256) NOT NULL DEFAULT '' COMMENT '角色1',
	  `role2` varchar(256) NOT NULL DEFAULT '' COMMENT '角色2',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='跨服王城战信息';
#----------------------------------------------------------------------
	SET lastVersion = 391; 
	SET versionNotes = 'corss citywar';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<392 THEN
#----------------------------------------------------------------------
    ALTER TABLE  `tb_player_extra`
	ADD COLUMN `HongYanHeTiTimes` bigint(20) NOT NULL DEFAULT 0 COMMENT '红颜合体技能时间';
#----------------------------------------------------------------------
	SET lastVersion = 392; 
	SET versionNotes = 'add hongyan heti';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<393 THEN
#----------------------------------------------------------------------
    ALTER TABLE  `tb_player_shop_item`
	ADD COLUMN `forevercnt` int(11) NOT NULL DEFAULT 0 COMMENT '永久次数';
#----------------------------------------------------------------------
	SET lastVersion = 393; 
	SET versionNotes = 'add shop buy';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<394 THEN
#----------------------------------------------------------------------
	SET lastVersion = 394; 
	SET versionNotes = 'add forbidden';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<395 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_festivalact`;
	CREATE TABLE `tb_festivalact` (
	  `id`			int(11) 		NOT NULL DEFAULT '0' COMMENT 'id',
	  `param_1`     int(11) 		NOT NULL DEFAULT '0' COMMENT '参数1',
	  `param_2`     int(11) 		NOT NULL DEFAULT '0' COMMENT '参数2',
	  `param_3`     int(11) 		NOT NULL DEFAULT '0' COMMENT '参数3',
	  `param_4`     int(11) 		NOT NULL DEFAULT '0' COMMENT '参数4',
	  `param_5`     int(11) 		NOT NULL DEFAULT '0' COMMENT '参数5',
	  `param_6`     int(11) 		NOT NULL DEFAULT '0' COMMENT '参数6',	  
	  `param_str`   varchar(32) NOT NULL DEFAULT '' COMMENT '参数str',
	  PRIMARY KEY  (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节日活动';
#----------------------------------------------------------------------
	SET lastVersion = 395; 
	SET versionNotes = 'corss tb_festivalact';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<396 THEN
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_crosstask_extra` 
    ADD COLUMN `yabiaocnt` int(11) NOT NULL DEFAULT 0  COMMENT '',
    ADD COLUMN `yabiaoid` int(11) NOT NULL DEFAULT 0  COMMENT '',
    ADD COLUMN `jiebiaocnt` int(11) NOT NULL DEFAULT 0  COMMENT '',
    ADD COLUMN `sharecnt` int(11) NOT NULL DEFAULT 0  COMMENT '';
#----------------------------------------------------------------------
	SET lastVersion = 396; 
	SET versionNotes = 'add cross yabiao';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<397 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_christmas_tree`;
	CREATE TABLE `tb_player_christmas_tree` (
	  `charguid`	bigint(20) 		NOT NULL DEFAULT '0' COMMENT 'charguid',
	  `id`     		int(11) 		NOT NULL DEFAULT '0' COMMENT 'ID',
	  `num`     	int(11) 		NOT NULL DEFAULT '0' COMMENT '捐赠总数量',
	  `openday`		bigint(20) 		NOT NULL DEFAULT '0' COMMENT '活动开启时间',
	  PRIMARY KEY  (`charguid`,`openday`,`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='圣诞树';
#----------------------------------------------------------------------
	SET lastVersion = 397; 
	SET versionNotes = 'christmas tree';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<398 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_yuandan`;
	CREATE TABLE  `tb_player_yuandan` (
	  `charguid`	bigint(20) 		NOT NULL DEFAULT '0' COMMENT 'charguid',
	  `id`     		int(11) 		NOT NULL DEFAULT '0' COMMENT 'ID',
	  `num`     	int(11) 		NOT NULL DEFAULT '0' COMMENT '已领次数',
	  `type`		bigint(20) 		NOT NULL DEFAULT '0' COMMENT '1道具领取 2登录领取',
	  PRIMARY KEY  (`charguid`,`type`,`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='元旦领奖';
#----------------------------------------------------------------------
	SET lastVersion = 398; 
	SET versionNotes = 'yuandan lingjiang';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<399 THEN 
#----------------------------------------------------------------------	
	ALTER TABLE `tb_player_shenbing` 
    ADD COLUMN `attr_dan_per` int(11) NOT NULL DEFAULT 0  COMMENT '资质丹数量';
	ALTER TABLE `tb_ride` 
    ADD COLUMN `attr_dan_per` int(11) NOT NULL DEFAULT 0  COMMENT '资质丹数量';
	ALTER TABLE `tb_player_ridewar` 
    ADD COLUMN `ridewar_attrdanpernum` int(11) NOT NULL DEFAULT 0  COMMENT '资质丹数量';
#----------------------------------------------------------------------
	SET lastVersion = 399; 
	SET versionNotes = 'attr dan per';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<400 THEN
#----------------------------------------------------------------------	
	ALTER TABLE `tb_player_items`
	ADD COLUMN `param5` bigint(20) NOT NULL DEFAULT '0' COMMENT '物品参数5',
	ADD COLUMN `param6` varchar(64) NOT NULL DEFAULT '' COMMENT '物品参数6',
	ADD COLUMN `param7` varchar(64) NOT NULL DEFAULT '' COMMENT '物品参数7';
#----------------------------------------------------------------------		
	CREATE TABLE `tb_player_marry_info` (
	  `charguid` bigint(20) NOT NULL COMMENT '玩家ID',
	  `mateguid` bigint(20) NOT NULL COMMENT '配偶ID',
	  `marryState` int(11) NOT NULL DEFAULT '0' COMMENT '婚姻状态',
	  `marryTime` bigint(20) NOT NULL COMMENT '结婚时间',
	  `marryType` int(11) NOT NULL DEFAULT '0' COMMENT '婚礼类型',
	  `marryTraveled` int(11) NOT NULL DEFAULT '0' COMMENT '是否巡游过0否 1是',
	  `marryDinnered` int(11) NOT NULL DEFAULT '0' COMMENT '是否开启过婚宴0否 1是',
	  `marryRingCfgId` int(11) NOT NULL DEFAULT '0' COMMENT '婚戒档次ID',
	  `marryIntimate` int(11) NOT NULL DEFAULT '0' COMMENT '亲密度',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='结婚信息表';
#----------------------------------------------------------------------		
	CREATE TABLE `tb_player_marry_schedule` (
	  `charguid` bigint(20) NOT NULL COMMENT '预订人ID',
	  `mateguid` bigint(20) NOT NULL COMMENT '配偶ID',
	   `roleName` varchar(32) NOT NULL DEFAULT '' COMMENT '预订人名字',
	  `mateName` varchar(32) NOT NULL DEFAULT '' COMMENT '配偶名字',
	  `roleProfId` int(11) NOT NULL DEFAULT '0' COMMENT '预订人职业',
	  `mateProfId` int(11) NOT NULL DEFAULT '0' COMMENT '配偶职业',
	  `scheduleId` int(11) NOT NULL DEFAULT '0' COMMENT '预约时间段ID',
	  `scheduleTime` bigint(20) NOT NULL COMMENT '时间戳',	   
	  `invites` varchar(2048) NOT NULL DEFAULT '' COMMENT '被邀请的玩家ID',	 
	  PRIMARY KEY (`charguid`, `mateguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='婚礼预约表';
#----------------------------------------------------------------------		
	CREATE TABLE `tb_player_marry_invite_card` (
	  `charguid` bigint(20) NOT NULL COMMENT '玩家id',
	  `mailGid` bigint(20) NOT NULL DEFAULT '0' COMMENT '邮件Gid',
	  `inviteTime` bigint(20) NOT NULL COMMENT '请帖的时间戳',
	  `scheduleId` int(11) NOT NULL COMMENT '预定时间配置表ID',
	  `inviteRoleName` varchar(32) NOT NULL DEFAULT '' COMMENT '邀请人名字',
	  `inviteMateName` varchar(32) NOT NULL DEFAULT '' COMMENT '邀请人配偶字',
	  `profId` int(11) NOT NULL DEFAULT '0' COMMENT '职业',
	  PRIMARY KEY (`charguid`, `mailGid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='请帖表';
#----------------------------------------------------------------------
	ALTER TABLE tb_player_extra
	ADD COLUMN `marrystren` int(11) NOT NULL DEFAULT '0'  COMMENT '婚戒强化等级',
	ADD COLUMN `marrystrenwish` int(11) NOT NULL DEFAULT '0'  COMMENT '婚戒强化祝福值';
#----------------------------------------------------------------------
	SET lastVersion = 400; 
	SET versionNotes = 'add marry';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<401 THEN 
#----------------------------------------------------------------------
	SET lastVersion = 401; 
	SET versionNotes = 'delete magickey_god';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<402 THEN 
#----------------------------------------------------------------------	
	DROP TABLE IF EXISTS `tb_player_XNzhuanpan`;
	CREATE TABLE  `tb_player_XNzhuanpan` (
		`charguid`	bigint(20)	NOT NULL DEFAULT '0' COMMENT 'charguid',
		`currLoginTime`	bigint(20)	NOT NULL DEFAULT '0' COMMENT '当天第一次登录时间',
		`currCount`	int(11)	NOT NULL DEFAULT '0' COMMENT '当天能领取免费取抽奖道具',
		`freeCount`	int(11)	NOT NULL DEFAULT '0' COMMENT '已领取的免费次数',
		`comPosList`	varchar(64)	NOT NULL DEFAULT '' COMMENT '已领位置清单',
		PRIMARY KEY  (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新年转盘';
#----------------------------------------------------------------------
	SET lastVersion = 402;
	SET versionNotes = 'XN zhuan pan';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<403 THEN 
#----------------------------------------------------------------------	
	DROP TABLE IF EXISTS `tb_player_XNhongbao`;
	CREATE TABLE  `tb_player_XNhongbao` (
		`charguid`	bigint(20)	NOT NULL DEFAULT '0' COMMENT 'charguid',
		`actId`	bigint(20)	NOT NULL DEFAULT '0' COMMENT '活动id',
		`id`	int(11)	NOT NULL DEFAULT '0' COMMENT '轮次id',
		`num`	int(11)	NOT NULL DEFAULT '0' COMMENT '领取次数',
		PRIMARY KEY  (`charguid`,`actId`,`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新年红包';
#----------------------------------------------------------------------
	SET lastVersion = 403;
	SET versionNotes = 'XN hong bao';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<404 THEN 
#----------------------------------------------------------------------	
	DROP TABLE IF EXISTS `tb_player_lunpan`;
	CREATE TABLE `tb_player_lunpan` (
	  `charguid` 	    bigint(20) 	 NOT NULL DEFAULT '0' COMMENT 'guid',
	  `lunpan_attr`		varchar(128) NOT NULL DEFAULT '' COMMENT '轮盘属性',
	  PRIMARY KEY  (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='轮盘';
#----------------------------------------------------------------------
	SET lastVersion = 404; 
	SET versionNotes = 'Add tb_player_lunpan';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion < 405 THEN
#----------------------------------------------------------------------	
	DROP TABLE IF EXISTS `tb_player_xnbaojiaozi`;
	CREATE TABLE  `tb_player_xnbaojiaozi` (
	  `charguid`	bigint(20) 		NOT NULL DEFAULT '0' COMMENT 'charguid',
	  `id`     		int(11) 		NOT NULL DEFAULT '0' COMMENT '活动兑换id',
	  `num`     	int(11) 		NOT NULL DEFAULT '0' COMMENT '已领次数',
	  PRIMARY KEY  (`charguid`,`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新年包饺子';
#----------------------------------------------------------------------
	SET lastVersion = 405; 
	SET versionNotes = 'xn bao jiao zi';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<406 THEN 
#----------------------------------------------------------------------
    CREATE TABLE `tb_player_wuxing_pro` (
	  `charguid` bigint(20) NOT NULL COMMENT '玩家id',
	  `lv` int(11) NOT NULL DEFAULT '0' COMMENT '五行等阶',
	  `progress` int(11) NOT NULL DEFAULT '0' COMMENT '进度',
	  `attrdan` int(11) NOT NULL DEFAULT '0'  COMMENT '属性丹数量',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='五行升阶信息表';
#----------------------------------------------------------------------
    CREATE TABLE `tb_player_wuxing_item` (
	  `charguid` bigint(20) NOT NULL COMMENT '玩家id',
	  `itemgid` bigint(20) NOT NULL DEFAULT '0' COMMENT '物品ID',
	  `itemtid` int(11) NOT NULL DEFAULT '0' COMMENT '物品TID', 
	  `pos` int(11) NOT NULL DEFAULT '0' COMMENT '位置',
	  `type` int(11) NOT NULL DEFAULT '0' COMMENT '背包类型', 
	  `att1` varchar(64) NOT NULL DEFAULT '' COMMENT '属性1',
	  `att2` varchar(64) NOT NULL DEFAULT '' COMMENT '属性2',
	  `att3` varchar(64) NOT NULL DEFAULT '' COMMENT '属性3',
	  `att4` varchar(64) NOT NULL DEFAULT '' COMMENT '属性4',
	  `att5` varchar(64) NOT NULL DEFAULT '' COMMENT '属性5',
	  `time_stamp` bigint(20) NOT NULL DEFAULT '0' COMMENT '时间戳',
	  PRIMARY KEY (`charguid`, `itemgid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='五行物品表';
#----------------------------------------------------------------------
	SET lastVersion = 406;
	SET versionNotes = 'add wuxing';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<407 THEN
#----------------------------------------------------------------------
	ALTER TABLE tb_player_smelt
	ADD COLUMN `smelt_level_1` int(11) NOT NULL DEFAULT '0'  COMMENT '熔炼等级',
	ADD COLUMN `smelt_curr_exp` int(11) NOT NULL DEFAULT '0'  COMMENT '熔炼经验',
	ADD COLUMN `smelt_curr_exp_1` int(11) NOT NULL DEFAULT '0'  COMMENT '熔炼经验';
#----------------------------------------------------------------------
	SET lastVersion = 407;
	SET versionNotes = 'equip smelt';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<408 THEN 
#----------------------------------------------------------------------
	SET lastVersion = 408; 
	SET versionNotes = 'alter mail';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<409 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_magic_fix`;
CREATE TABLE `tb_player_magic_fix` (
  `charguid` bigint(20) NOT NULL COMMENT '玩家id',
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '物品ID',
  `giveCount` int(11) NOT NULL DEFAULT '0' COMMENT '提交次数',
  PRIMARY KEY (`charguid`, `id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='法宝图鉴';
#----------------------------------------------------------------------
	SET lastVersion = 409; 
	SET versionNotes = 'magic fix';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<410 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_extra` 
	CHANGE COLUMN `daily_count` `daily_count` varchar(512) NOT NULL DEFAULT '' COMMENT '每日计数',
	CHANGE COLUMN `actcode_flags` `actcode_flags` varchar(1024) NOT NULL DEFAULT '' COMMENT '激活码标识';
#----------------------------------------------------------------------
	SET lastVersion = 410; 
	SET versionNotes = 'alter count';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<411 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_minglun`;
	CREATE TABLE `tb_player_minglun` (
	  `charguid` bigint(20) NOT NULL COMMENT '角色GUID',
	  `level` int(11) NOT NULL DEFAULT '0' COMMENT '当前等级',
	  `process` int(11) NOT NULL DEFAULT '0' COMMENT '星数对应的进度',
	  `sel` int(11) NOT NULL DEFAULT '0' COMMENT '当前切换命轮',
	  `proce_num` int(11) NOT NULL DEFAULT '0' COMMENT '对应星数',
	  `total_proce` int(11) NOT NULL DEFAULT '0'  COMMENT '资质丹数量',
	  `attrdan` int(11) NOT NULL DEFAULT '0' COMMENT '属性丹数量',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='命轮表';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_rank_minglun`;
	CREATE TABLE `tb_rank_minglun` (
	  `rank` int(11) NOT NULL COMMENT '排行',
	  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
	  `lastrank` int(11) NOT NULL DEFAULT '0' COMMENT '上次排行',
	  `rankvalue` bigint(20) NOT NULL DEFAULT '0' COMMENT '命轮等级',
	  PRIMARY KEY (`rank`),
	  KEY `guid_idx` (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='命轮排行';
#---------------------------------------------------------
	SET lastVersion = 411; 
	SET versionNotes = 'Add minglun';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<412 THEN 
#----------------------------------------------------------------------
	SET lastVersion = 412; 
	SET versionNotes = 'add jiang jin chi';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion < 413 THEN
#----------------------------------------------------------------------	
	DROP TABLE IF EXISTS `tb_player_yuanxiaoduihuan`;
	CREATE TABLE  `tb_player_yuanxiaoduihuan` (
	  `charguid`	bigint(20) 		NOT NULL DEFAULT '0' COMMENT 'charguid',
	  `id`     		int(11) 		NOT NULL DEFAULT '0' COMMENT '活动兑换id',
	  `num`     	int(11) 		NOT NULL DEFAULT '0' COMMENT '已领次数',
	  PRIMARY KEY  (`charguid`,`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新年元宵兑换';
#----------------------------------------------------------------------
	SET lastVersion = 413; 
	SET versionNotes = 'yuanxiao duihuan';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<414 THEN 
#----------------------------------------------------------------------
	ALTER TABLE tb_player_wuxing_pro
	ADD COLUMN `attrdanper` int(11) NOT NULL DEFAULT '0'  COMMENT '资质丹数量';
#----------------------------------------------------------------------
	SET lastVersion = 414;
	SET versionNotes = 'add wuxing attrdanper';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<415 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_hunqi`;
CREATE TABLE `tb_player_hunqi` (
  `charguid` bigint(20) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT '最高等阶',
  `wish` int(11) NOT NULL DEFAULT '0' COMMENT '祝福值',
  `use_level` int(11) NOT NULL DEFAULT '0' COMMENT '使用等级',
  `attr_dan` int(11) NOT NULL DEFAULT '0' COMMENT '属性丹数量',
  `AllNum` int(11) NOT NULL DEFAULT '0' COMMENT '升阶总使用的升阶石数量',
  `KeLingQuNum` int(11) NOT NULL DEFAULT '0' COMMENT '可领取的升阶石数量',
  `YiLingQuNum` int(11) NOT NULL DEFAULT '0' COMMENT '已经领取的升阶石数量',
  PRIMARY KEY (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='魂器';

DROP TABLE IF EXISTS `tb_rank_hunqi`;
CREATE TABLE `tb_rank_hunqi` (
  `rank` int(11) NOT NULL COMMENT '排行',
  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
  `lastrank` int(11) NOT NULL DEFAULT '0' COMMENT '上次排行',
  `rankvalue` bigint(20) NOT NULL DEFAULT '0' COMMENT '天罡等级',
  PRIMARY KEY (`rank`),
  KEY `guid_idx` (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='魂器排行';
#----------------------------------------------------------------------
	SET lastVersion = 415; 
	SET versionNotes = 'add hun qi';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<416 THEN 
#----------------------------------------------------------------------
	ALTER TABLE tb_player_lunpan
	ADD COLUMN `lunpan_num` int(11) NOT NULL DEFAULT '0'  COMMENT '轮盘今日次数';
#----------------------------------------------------------------------
	SET lastVersion = 416;
	SET versionNotes = 'add lunpan num';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<417 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_gunxueqiu`;
CREATE TABLE `tb_player_gunxueqiu` (
	`charguid` bigint(20) NOT NULL DEFAULT '0',
	`day_1` int(11) NOT NULL DEFAULT '-1' COMMENT '第1天祈福值',
	`day_2` int(11) NOT NULL DEFAULT '-1' COMMENT '第2天祈福值',
	`day_3` int(11) NOT NULL DEFAULT '-1' COMMENT '第3天祈福值',
	`lingqu` int(11) NOT NULL DEFAULT '0' COMMENT '是否领取',
	PRIMARY KEY (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='滚雪球';
#----------------------------------------------------------------------
	SET lastVersion = 417;
	SET versionNotes = 'add gun xue qiu';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<418 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_sbbingling`;
CREATE TABLE `tb_player_sbbingling` (
	`charguid` bigint(20) NOT NULL DEFAULT '0',
	`type` int(11) NOT NULL DEFAULT '0' COMMENT '类型',
	`level` int(11) NOT NULL DEFAULT '0' COMMENT '等级',
	PRIMARY KEY (`charguid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='神兵兵灵';
#----------------------------------------------------------------------
	SET lastVersion = 418;
	SET versionNotes = 'add sbbingling';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion < 419 THEN
#----------------------------------------------------------------------	
	DROP TABLE IF EXISTS `tb_xnhongbao`;
	CREATE TABLE  `tb_xnhongbao` (
	  `actId`     	bigint(20) 		NOT NULL DEFAULT '0' COMMENT '活动ID',
	  `id`     		int(11) 		NOT NULL DEFAULT '0' COMMENT '轮次',
	  `num`     	int(11) 		NOT NULL DEFAULT '0' COMMENT '已领次数',
	  PRIMARY KEY  (`actId`,`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新年红包';
#----------------------------------------------------------------------
	SET lastVersion = 419; 
	SET versionNotes = 'XN hong bao';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<420 THEN 
#----------------------------------------------------------------------
	ALTER TABLE tb_player_gunxueqiu
	ADD COLUMN `qifutime` bigint(20) NOT NULL DEFAULT '0'  COMMENT '免费祈福时间点';
#----------------------------------------------------------------------
	SET lastVersion = 420;
	SET versionNotes = 'add qifu time';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<421 THEN 
#----------------------------------------------------------------------
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_horse_gem`;
	CREATE TABLE `tb_player_horse_gem` (
	  `charguid` 	bigint(20)  NOT NULL COMMENT '角色GUID',
	  `id`			int(11)		NOT NULL COMMENT '当前ID',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='坐骑宝石表';
#----------------------------------------------------------------------
	CREATE TABLE `tb_player_horse_gem_item` (
		`charguid` bigint(20) NOT NULL COMMENT '玩家id',
		`itemgid` bigint(20) NOT NULL DEFAULT '0' COMMENT '物品ID',
		`itemtid` int(11) NOT NULL DEFAULT '0' COMMENT '物品TID',
		`pos` int(11) NOT NULL DEFAULT '0' COMMENT '位置',
		`type` int(11) NOT NULL DEFAULT '0' COMMENT '背包类型',
		`time_stamp` bigint(20) NOT NULL DEFAULT '0' COMMENT '时间戳',
		PRIMARY KEY (`charguid`,`itemgid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='坐骑宝石物品表';
#----------------------------------------------------------------------
	SET lastVersion = 421;
	SET versionNotes = 'add horse gem';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<422 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_shengqi`;
	CREATE TABLE `tb_player_shengqi` (
	  `charguid` bigint(20) NOT NULL COMMENT '角色GUID',
	  `level` int(11) NOT NULL DEFAULT '0' COMMENT '当前等阶',
	  `process` int(11) NOT NULL DEFAULT '0' COMMENT '进度',
	  `sel` int(11) NOT NULL DEFAULT '0' COMMENT '当前切换圣器',
	  `proce_num` int(11) NOT NULL DEFAULT '0' COMMENT '失败次数',
	  `total_proce` int(11) NOT NULL DEFAULT '0'  COMMENT '总失败次数',
	  `attrdan` int(11) NOT NULL DEFAULT '0' COMMENT '属性丹数量',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='圣器表';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_rank_shengqi`;
	CREATE TABLE `tb_rank_shengqi` (
	  `rank` int(11) NOT NULL COMMENT '排行',
	  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
	  `lastrank` int(11) NOT NULL DEFAULT '0' COMMENT '上次排行',
	  `rankvalue` bigint(20) NOT NULL DEFAULT '0' COMMENT '圣器等级',
	  PRIMARY KEY (`rank`),
	  KEY `guid_idx` (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='圣器排行';
#---------------------------------------------------------
	SET lastVersion = 422; 
	SET versionNotes = 'Add shengqi';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<423 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_pifengext`;
CREATE TABLE `tb_player_pifengext` (
	`charguid` bigint(20) NOT NULL DEFAULT '0',
	`type` int(11) NOT NULL DEFAULT '0' COMMENT '类型',
	`level` int(11) NOT NULL DEFAULT '0' COMMENT '等级',
	PRIMARY KEY (`charguid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='披风扩展';
#----------------------------------------------------------------------
	SET lastVersion = 423;
	SET versionNotes = 'add pifengext';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<424 THEN 
#----------------------------------------------------------------------
	ALTER TABLE tb_player_crosspvp
	ADD COLUMN `crossscore3` int(11) NOT NULL DEFAULT '0'  COMMENT '跨服3v3积分',
	ADD COLUMN `crosscnt3` int(11) NOT NULL DEFAULT '0'  COMMENT '跨服3v3次数';
#----------------------------------------------------------------------
	SET lastVersion = 424;
	SET versionNotes = 'add cross 3v3';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<425 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_star`;
	CREATE TABLE `tb_player_star` (
	  `charguid` 		bigint(20) 	NOT NULL DEFAULT '0' COMMENT 'guid',
	  `star`   int(11) 	NOT NULL DEFAULT '0' COMMENT '星座ID',
	  `point`			int(11)		NOT NULL DEFAULT '0' COMMENT '星点',
	  `round`			int(11)		NOT NULL DEFAULT '0' COMMENT '轮',
	  PRIMARY KEY (`charguid`, `star`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='星座表';
#----------------------------------------------------------------------
	SET lastVersion = 425;
	SET versionNotes = 'add star';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<426 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_secret_sweep`;
	CREATE TABLE `tb_player_secret_sweep` (
	  `charguid`	bigint(20)	NOT NULL DEFAULT '0' COMMENT 'guid',
	  `id`	int(11)	NOT NULL DEFAULT '0' COMMENT 'id',
	  `num`	int(11)	NOT NULL DEFAULT '0' COMMENT '扫荡数量',
	  `time`	bigint(20)	NOT NULL DEFAULT '0' COMMENT '扫荡时间',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='个人秘境扫荡';
#----------------------------------------------------------------------
	SET lastVersion = 426;
	SET versionNotes = 'secret sweep';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<427 THEN 
#----------------------------------------------------------------------
	ALTER TABLE tb_player_equips
	ADD COLUMN `godlevel` int(11) NOT NULL DEFAULT '-1'  COMMENT '神化等级';
#----------------------------------------------------------------------
	SET lastVersion = 427;
	SET versionNotes = 'add equip god';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<428 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_new_babel`;
	CREATE TABLE `tb_new_babel` (
	  `charguid` bigint(20) NOT NULL COMMENT '角色GUID',
	  `level` int(11) NOT NULL COMMENT '当前挑战层数',
	  `time` int(11) NOT NULL DEFAULT '0' COMMENT '最短通关时间s',
	  `count` int(11) NOT NULL DEFAULT '0' COMMENT '挑战次数',
	  PRIMARY KEY (`charguid`,`level`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='损神之地记录表';
#----------------------------------------------------------------------
	SET lastVersion = 428;
	SET versionNotes = 'add new babel';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<429 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_wingexit_active`;
	CREATE TABLE `tb_player_wingexit_active` (
	  `charguid`	bigint(20)	NOT NULL DEFAULT '0' COMMENT 'guid',
	  `id`	int(11)	NOT NULL DEFAULT '0' COMMENT 'id',
	  `isactive`	int(11)	NOT NULL DEFAULT '0' COMMENT '是否激活',
	  PRIMARY KEY (`charguid`,`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='翅膀扩展激活';
	
	DROP TABLE IF EXISTS `tb_player_wingexit_count`;
	CREATE TABLE `tb_player_wingexit_count` (
	  `charguid`	bigint(20)	NOT NULL DEFAULT '0' COMMENT 'guid',
	  `id`	int(11)	NOT NULL DEFAULT '0' COMMENT 'id',
	  `type`	int(11)	NOT NULL DEFAULT '0' COMMENT '类型',
	  `num`	int(11)	NOT NULL DEFAULT '0' COMMENT '数量',
	  `time`	bigint(20)	NOT NULL DEFAULT '0' COMMENT '时间戳',
	  PRIMARY KEY (`charguid`,`id`,`type`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='翅膀扩展计数';
#----------------------------------------------------------------------
	SET lastVersion = 429;
	SET versionNotes = 'add wing ext';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<430 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_new_babel_rank`;
	CREATE TABLE `tb_new_babel_rank` (
	  `rank` int(11) NOT NULL COMMENT '损神之地排名',
	  `guid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
	  `value` int(11) NOT NULL DEFAULT '0' COMMENT '时间或者层数',
	  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '玩家名字',
	  `level` int(11) NOT NULL DEFAULT '0' COMMENT '玩家等级',
	  PRIMARY KEY (`rank`),
	  KEY `guid_idx` (`guid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='损神之地排行表';
#----------------------------------------------------------------------
	SET lastVersion = 430;
	SET versionNotes = 'add new babel rank';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<431 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_zhannu_gem`;
	CREATE TABLE `tb_player_zhannu_gem` (
	  `charguid` 	bigint(20)  NOT NULL COMMENT '角色GUID',
	  `id`			int(11)		NOT NULL COMMENT '当前ID',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='战弩扩展表';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_zhannu_gem_item`;
	CREATE TABLE `tb_player_zhannu_gem_item` (
		`charguid` bigint(20) NOT NULL COMMENT '玩家id',
		`itemgid` bigint(20) NOT NULL DEFAULT '0' COMMENT '物品ID',
		`itemtid` int(11) NOT NULL DEFAULT '0' COMMENT '物品TID',
		`pos` int(11) NOT NULL DEFAULT '0' COMMENT '位置',
		`type` int(11) NOT NULL DEFAULT '0' COMMENT '背包类型',
		`time_stamp` bigint(20) NOT NULL DEFAULT '0' COMMENT '时间戳',
		PRIMARY KEY (`charguid`,`itemgid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='战弩扩展物品表';
#----------------------------------------------------------------------
	SET lastVersion = 431;
	SET versionNotes = 'add zhannu gem';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<432 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_app_info`;
	CREATE TABLE `tb_player_app_info` (
		`charguid` bigint(20) NOT NULL COMMENT '玩家id',
		`token` varchar(64) NOT NULL DEFAULT '' COMMENT 'token',
		`param` varchar(256) NOT NULL DEFAULT '' COMMENT '参数',
		PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机助手表';
#----------------------------------------------------------------------
	SET lastVersion = 432;
	SET versionNotes = 'add app info';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<433 THEN 
#----------------------------------------------------------------------
	ALTER TABLE tb_player_vip
	ADD COLUMN `vip_weekrewardlevel` int(11) NOT NULL DEFAULT '0'  COMMENT '周礼包领取等级';
#----------------------------------------------------------------------
	SET lastVersion = 433;
	SET versionNotes = 'add vip week';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<434 THEN 
#----------------------------------------------------------------------
	ALTER TABLE tb_player_magickeys
	ADD COLUMN `awake` int(11) NOT NULL DEFAULT '0'  COMMENT '觉醒';
#----------------------------------------------------------------------
	SET lastVersion = 434;
	SET versionNotes = 'add magickey awake';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<435 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_ridewarext`;
CREATE TABLE `tb_player_ridewarext` (
	`charguid` bigint(20) NOT NULL DEFAULT '0',
	`id` int(11) NOT NULL DEFAULT '0' COMMENT '类型',
	`level` int(11) NOT NULL DEFAULT '0' COMMENT '等级',
	PRIMARY KEY (`charguid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='骑兵扩展';
#----------------------------------------------------------------------
	SET lastVersion = 435;
	SET versionNotes = 'add ridewarext';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<436 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_info`
	ADD COLUMN `changeproftag`  int(11) NOT NULL DEFAULT '0' COMMENT '是否转职';
#----------------------------------------------------------------------
	SET lastVersion = 436; 
	SET versionNotes = 'Add change prof';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<437 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_tiangangext`;
CREATE TABLE `tb_player_tiangangext` (
	`charguid` bigint(20) NOT NULL DEFAULT '0',
	`type` int(11) NOT NULL DEFAULT '0' COMMENT '类型',
	`level` int(11) NOT NULL DEFAULT '0' COMMENT '等级',
	PRIMARY KEY (`charguid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='天罡扩展';
#----------------------------------------------------------------------
	SET lastVersion = 437;
	SET versionNotes = 'add tiangangext';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<438 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_app_res`;
	CREATE TABLE `tb_player_app_res` (
		`charguid` bigint(20) NOT NULL DEFAULT '0',
		`id` int(11) NOT NULL DEFAULT '0' COMMENT 'id',
		`type` int(11) NOT NULL DEFAULT '0' COMMENT '类型',
		`cnt` int(11) NOT NULL DEFAULT '0' COMMENT '次数',
		`param` int(11) NOT NULL DEFAULT '0' COMMENT '参数',
		PRIMARY KEY (`charguid`,`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机助手资源';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_app_op_res`;
	CREATE TABLE `tb_player_app_op_res` (
		`bid` bigint(20) NOT NULL DEFAULT '0',
		`charguid` bigint(20) NOT NULL DEFAULT '0',
		`id` int(11) NOT NULL DEFAULT '0' COMMENT 'id',
		`type` int(11) NOT NULL DEFAULT '0' COMMENT '类型',
		`time` int(11) NOT NULL DEFAULT '0' COMMENT '次数',
		`param` int(11) NOT NULL DEFAULT '0' COMMENT '参数',
		PRIMARY KEY (`bid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机助手操作';
#----------------------------------------------------------------------
	SET lastVersion = 438;
	SET versionNotes = 'add app';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<439 THEN 
#----------------------------------------------------------------------
    DROP TABLE IF EXISTS `tb_player_zhuanzhi`;
    CREATE TABLE `tb_player_zhuanzhi` (
	  `charguid` bigint(20) NOT NULL COMMENT '玩家id',
	  `questid` int(11) NOT NULL DEFAULT '0' COMMENT '任务ID',
	  `todayquestcnt` int(11) NOT NULL DEFAULT '0' COMMENT '当日任务数',
	  `questcnt` int(11) NOT NULL DEFAULT '0' COMMENT '任务数',
	  `step` int(11) NOT NULL DEFAULT '0' COMMENT '转职步骤',
	  `progress` varchar(128) NOT NULL DEFAULT '' COMMENT '转职进度',
	  `zhuanzhi` int(11) NOT NULL DEFAULT '0' COMMENT '转职状态1转成功为1',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='转职表';
#----------------------------------------------------------------------
	SET lastVersion = 439;
	SET versionNotes = 'add zhuanzhi';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<440 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_zhenfa`;
	CREATE TABLE `tb_player_zhenfa` (
	  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT 'guid',
	  `selecttype` int(11) NOT NULL DEFAULT '0' COMMENT '选中类型',
	  `zhenfa` varchar(300) NOT NULL DEFAULT ''  COMMENT '阵法信息',
	  `attrdan` int(11) NOT NULL DEFAULT '0' COMMENT '属性丹数量',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
#----------------------------------------------------------------------
	SET lastVersion = 440;
	SET versionNotes = 'add zhenfa';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<441 THEN 
#----------------------------------------------------------------------
	ALTER TABLE tb_player_extra
	ADD COLUMN `expend_storage2` 	int(11) NOT NULL DEFAULT '0'  COMMENT '仓库2格子',
	ADD COLUMN `storage2_online` 	int(11) NOT NULL DEFAULT '0'  COMMENT '仓库2时间',
	ADD COLUMN `expend_storage3` 	int(11) NOT NULL DEFAULT '0'  COMMENT '仓库3格子',
	ADD COLUMN `storage3_online` 	int(11) NOT NULL DEFAULT '0'  COMMENT '仓库3时间',
	ADD COLUMN `expend_storage4` 	int(11) NOT NULL DEFAULT '0'  COMMENT '仓库4格子',
	ADD COLUMN `storage4_online` 	int(11) NOT NULL DEFAULT '0'  COMMENT '仓库4时间';
#----------------------------------------------------------------------
	SET lastVersion = 441;
	SET versionNotes = 'add Storage 2,3,4';
#----------------------------------------------------------------------
END IF;
#----------------------------------------------------------------------
#***************************************************************
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<442 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_zhenfa`
	ADD COLUMN `attrdanper`  int(11) NOT NULL DEFAULT '0' COMMENT '资质丹数量';
#----------------------------------------------------------------------
	SET lastVersion = 442;
	SET versionNotes = 'add att per';
#----------------------------------------------------------------------
END IF;
#----------------------------------------------------------------------
#***************************************************************
#***************************************************************
IF lastVersion<443 THEN 
#----------------------------------------------------------------------
    DROP TABLE IF EXISTS `tb_player_marryquest`;
	CREATE TABLE `tb_player_marryquest` (
	  `charguid` bigint(20) NOT NULL COMMENT '玩家GUID',
	  `quest_id` int(11) NOT NULL DEFAULT '0' COMMENT '任务ID',
	  `quest_star` int(11) NOT NULL DEFAULT '0' COMMENT '日环星级',
	  `quest_double` int(11) NOT NULL DEFAULT '0' COMMENT '日环倍率',
	  `quest_counter` int(11) NOT NULL DEFAULT '0' COMMENT '当前环数',
	  `quest_auto_star` int(11) NOT NULL DEFAULT '0' COMMENT '是否已接任务',
	  `quest_counter_id` varchar(256) NOT NULL DEFAULT '0' COMMENT '今日完成日环信息',
	  `quest_reward_id` varchar(128) NOT NULL DEFAULT '' COMMENT '日环奖励信息',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='结婚日环信息表';
#----------------------------------------------------------------------
	SET lastVersion = 443;
	SET versionNotes = 'add zhuanzhi';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<444 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_qiming_tree`;
	CREATE TABLE `tb_player_qiming_tree` (
	  `charguid`	bigint(20) 		NOT NULL DEFAULT '0' COMMENT 'charguid',
	  `id`     		int(11) 		NOT NULL DEFAULT '0' COMMENT 'ID',
	  `num`     	int(11) 		NOT NULL DEFAULT '0' COMMENT '捐赠总数量',
	  `openday`		bigint(20) 		NOT NULL DEFAULT '0' COMMENT '活动开启时间',
	  PRIMARY KEY  (`charguid`,`openday`,`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='清明树';
#----------------------------------------------------------------------
	SET lastVersion = 444; 
	SET versionNotes = 'qiming tree';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<445 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_talent`;
	CREATE TABLE `tb_player_talent` (
	  `charguid` 	    bigint(20) 	NOT NULL DEFAULT '0' COMMENT 'guid',
	  `talent_id`		int(11)		NOT NULL DEFAULT '0' COMMEnT '天赋ID',
	  `talent_lvl`		int(11)		NOT NULL DEFAULT '0' COMMEnT '天赋等级',
	  PRIMARY KEY (`charguid`, `talent_id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '天赋表';
#----------------------------------------------------------------------
	ALTER TABLE tb_player_info	
	ADD COLUMN `talent_point` 	int(11) NOT NULL DEFAULT '0'  COMMENT '天赋点数';
#----------------------------------------------------------------------
	SET lastVersion = 445;
	SET versionNotes = 'add talent';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<446 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_shenwu`;
	CREATE TABLE `tb_player_shenwu` (
	  `charguid` 	    bigint(20) 	NOT NULL DEFAULT '0' COMMENT 'guid',
	  `shenwu_level` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '神武等级',
	  `shenwu_star` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '神武星级',
	  `shenwu_stone` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '神武成功石',
	  `shenwu_failnum` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '神武升星失败次数',
	  PRIMARY KEY  (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='神武';	
	DROP TABLE IF EXISTS `tb_rank_shenwu`;
	CREATE TABLE `tb_rank_shenwu` (
	  `rank` int(11) NOT NULL COMMENT '排行',
	  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
	  `lastrank` int(11) NOT NULL DEFAULT '0' COMMENT '上次排行',
	  `rankvalue` bigint(20) NOT NULL DEFAULT '0' COMMENT '神武等级',
	  PRIMARY KEY (`rank`),
	  KEY `guid_idx` (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='神武排行';
#----------------------------------------------------------------------
	SET lastVersion = 446; 
	SET versionNotes = 'Add tb_player_shenwu';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<447 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_xuetong`;
	CREATE TABLE `tb_player_xuetong` (
	  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT 'guid',
	  `xuetong` varchar(300) NOT NULL DEFAULT ''  COMMENT '血统信息',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
#----------------------------------------------------------------------
	SET lastVersion = 447;
	SET versionNotes = 'add xuetong';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<448 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_sbjianyi`;
	CREATE TABLE `tb_player_sbjianyi` (
	  `charguid` 	    bigint(20) 	NOT NULL DEFAULT '0' COMMENT 'guid',
	  `id` 	int(11) 	NOT NULL DEFAULT '0' COMMENT 'id',
	  `level` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '等级',
	  `star` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '星数',
	  PRIMARY KEY  (`charguid`, `id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='剑意';
#----------------------------------------------------------------------
	SET lastVersion = 448; 
	SET versionNotes = 'Add tb_player_sbjianyi';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<449 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_new_crossboss_history`;
	CREATE TABLE `tb_new_crossboss_history` (
		`id` 			int(11) 		NOT NULL DEFAULT '0' COMMENT 'ID',
		`avglv` 		int(11) 		NOT NULL DEFAULT '0' COMMENT '平均等级',
		`firstname1` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname1` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
		`firstname2` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname2` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
		`firstname3` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname3` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
		`firstname4` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname4` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
		`firstname5` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '第一玩家',
		`killname5` 	varchar(32) 	NOT NULL DEFAULT '' COMMENT '击杀玩家',
	  PRIMARY KEY  (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='跨服BOSS记录表';
#----------------------------------------------------------------------
	SET lastVersion = 449; 
	SET versionNotes = 'Add crossboss';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<450 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_shenwufb`;
	CREATE TABLE `tb_shenwufb` (
	  `charguid` bigint(20) NOT NULL COMMENT '角色GUID',
	  `level` int(11) NOT NULL COMMENT '当前挑战层数',
	  `time` int(11) NOT NULL DEFAULT '0' COMMENT '最短通关时间s',
	  `count` int(11) NOT NULL DEFAULT '0' COMMENT '挑战次数',
	  PRIMARY KEY (`charguid`,`level`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='神武FB记录表';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_shenwufb_rank`;
	CREATE TABLE `tb_shenwufb_rank` (
	  `rank` int(11) NOT NULL COMMENT '神武FB排名',
	  `guid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
	  `value` int(11) NOT NULL DEFAULT '0' COMMENT '时间或者层数',
	  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '玩家名字',
	  `level` int(11) NOT NULL DEFAULT '0' COMMENT '玩家等级',
	  PRIMARY KEY (`rank`),
	  KEY `guid_idx` (`guid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='神武FB排行表';
#----------------------------------------------------------------------
	SET lastVersion = 450;
	SET versionNotes = 'add shenwu fb';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<451 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_extra` 
	ADD COLUMN `shenwufb_num` int(11) NOT NULL DEFAULT '0' COMMENT '今天已挑战神武FB次数';
#----------------------------------------------------------------------
	SET lastVersion = 451; 
	SET versionNotes = 'Add shenwufb num';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<452 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_shenwuext`;
	CREATE TABLE `tb_player_shenwuext` (
	  `charguid` 	    bigint(20) 	NOT NULL DEFAULT '0' COMMENT 'guid',
	  `level` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '等级',
	  `star` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '星数',
	  PRIMARY KEY  (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='神武淬炼';
#----------------------------------------------------------------------
	SET lastVersion = 452; 
	SET versionNotes = 'Add tb_player_shenwuext';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<453 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_baojiaext`;
	CREATE TABLE `tb_player_baojiaext` (
	  `charguid` 	    bigint(20) 	NOT NULL DEFAULT '0' COMMENT 'guid',
	  `id` 	int(11) 	NOT NULL DEFAULT '0' COMMENT 'id',
	  `level` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '等级',
	  `star` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '星数',
	  PRIMARY KEY  (`charguid`, `id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='宝甲扩展';
#----------------------------------------------------------------------
	SET lastVersion = 453; 
	SET versionNotes = 'Add tb_player_baojiaext';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<454 THEN
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_extra` 
    ADD COLUMN `max_timingid` int(11) NOT NULL DEFAULT 0  COMMENT '灵阵封妖通关难度',
	ADD COLUMN `max_timinglevel` int(11) NOT NULL DEFAULT 0  COMMENT '灵阵封妖通关等级';	
#----------------------------------------------------------------------
	SET lastVersion = 454; 
	SET versionNotes = 'add timing info';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<455 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_wuxingext`;
	CREATE TABLE `tb_player_wuxingext` (
	  `charguid` 	    bigint(20) 	NOT NULL DEFAULT '0' COMMENT 'guid',
	  `id` 	int(11) 	NOT NULL DEFAULT '0' COMMENT 'id',
	  `level` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '等级',
	  `star` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '星数',
	  PRIMARY KEY  (`charguid`, `id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='灵阵扩展';
#----------------------------------------------------------------------
	SET lastVersion = 455; 
	SET versionNotes = 'Add tb_player_wuxingext';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<456 THEN 
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_magickeys` 
	ADD COLUMN `feishengid`  int(11) NOT NULL DEFAULT '0' COMMENT '飞升等级',
	ADD COLUMN `feishengext`  int(11) NOT NULL DEFAULT '0' COMMENT '飞升经验';
#----------------------------------------------------------------------
	SET lastVersion = 456; 
	SET versionNotes = 'Add magickey feisheng';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<457 THEN
#----------------------------------------------------------------------
	ALTER TABLE `tb_player_crosspvp` 
    ADD COLUMN `crossteamcnt` int(11) NOT NULL DEFAULT 0  COMMENT '跨服组队次数';	
#----------------------------------------------------------------------
	SET lastVersion = 457; 
	SET versionNotes = 'add crossteam';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<458 THEN
#----------------------------------------------------------------------
	SET lastVersion = 458; 
	SET versionNotes = 'alter charge';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<459 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_qilinbi`;
	CREATE TABLE `tb_player_qilinbi` (
	  `charguid` bigint(20) NOT NULL DEFAULT '0',
	  `level` int(11) NOT NULL DEFAULT '0' COMMENT '最高等阶',
	  `wish` int(11) NOT NULL DEFAULT '0' COMMENT '祝福值',
	  `use_level` int(11) NOT NULL DEFAULT '0' COMMENT '使用等级',
	  `attr_dan` int(11) NOT NULL DEFAULT '0' COMMENT '属性丹数量',
	  `AllNum` int(11) NOT NULL DEFAULT '0' COMMENT '升阶总使用的升阶石数量',
	  `KeLingQuNum` int(11) NOT NULL DEFAULT '0' COMMENT '可领取的升阶石数量',
	  `YiLingQuNum` int(11) NOT NULL DEFAULT '0' COMMENT '已经领取的升阶石数量',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='麒麟臂';
	
	DROP TABLE IF EXISTS `tb_rank_qilinbi`;
	CREATE TABLE `tb_rank_qilinbi` (
	  `rank` int(11) NOT NULL COMMENT '排行',
	  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
	  `lastrank` int(11) NOT NULL DEFAULT '0' COMMENT '上次排行',
	  `rankvalue` bigint(20) NOT NULL DEFAULT '0' COMMENT '等级',
	  PRIMARY KEY (`rank`),
	  KEY `guid_idx` (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='麒麟臂排行';
#----------------------------------------------------------------------
	SET lastVersion = 459; 
	SET versionNotes = 'Add qilinbi';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<460 THEN 
#----------------------------------------------------------------------
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_minglun_gem`;
	CREATE TABLE `tb_player_minglun_gem` (
	  `charguid` 	bigint(20)  NOT NULL COMMENT '角色GUID',
	  `id`			int(11)		NOT NULL COMMENT '当前ID',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='命轮宝石表';
#----------------------------------------------------------------------
	CREATE TABLE `tb_player_minglun_gem_item` (
		`charguid` bigint(20) NOT NULL COMMENT '玩家id',
		`itemgid` bigint(20) NOT NULL DEFAULT '0' COMMENT '物品ID',
		`itemtid` int(11) NOT NULL DEFAULT '0' COMMENT '物品TID',
		`pos` int(11) NOT NULL DEFAULT '0' COMMENT '位置',
		`type` int(11) NOT NULL DEFAULT '0' COMMENT '背包类型',
		`time_stamp` bigint(20) NOT NULL DEFAULT '0' COMMENT '时间戳',
		PRIMARY KEY (`charguid`,`itemgid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='命轮宝石物品表';
#----------------------------------------------------------------------
	SET lastVersion = 460;
	SET versionNotes = 'add minglun gem';
#----------------------------------------------------------------------
END IF;
#***************************************************************
IF lastVersion<461 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_fabao_skillup`;
	CREATE TABLE `tb_player_fabao_skillup` (
	  `charguid` 	    bigint(20) 	NOT NULL DEFAULT '0' COMMENT 'guid',
	  `skillup_id` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '法宝被动技能强化id',
	  `level_id` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '法宝被动技能强化等级id',
	  `level_exp` 	int(11) 	NOT NULL DEFAULT '0' COMMENT '法宝被动技能强化等级经验值',
	  PRIMARY KEY  (`charguid`, `skillup_id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='法宝被动技能强化';
#----------------------------------------------------------------------
	SET lastVersion = 461; 
	SET versionNotes = 'Add fabao skillup';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<462 THEN 
#----------------------------------------------------------------------
	ALTER TABLE tb_player_equips
	ADD COLUMN `blesslevel` int(11) NOT NULL DEFAULT '-1'  COMMENT '神化神佑';
#----------------------------------------------------------------------
	SET lastVersion = 462;
	SET versionNotes = 'add equip bless';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
IF lastVersion<463 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_jianyu`;
	CREATE TABLE `tb_player_jianyu` (
	  `charguid` bigint(20) NOT NULL COMMENT '角色GUID',
	  `level` int(11) NOT NULL DEFAULT '0' COMMENT '当前等阶',
	  `proce_num` int(11) NOT NULL DEFAULT '0' COMMENT '对应星数',
	  `process` int(11) NOT NULL DEFAULT '0' COMMENT '星对应的进度',
	  `sel` int(11) NOT NULL DEFAULT '0' COMMENT '当前切换剑域',	  
	  `attrperdan` int(11) NOT NULL DEFAULT '0'  COMMENT '资质丹数量',
	  `attrdan` int(11) NOT NULL DEFAULT '0' COMMENT '属性丹数量',
	  PRIMARY KEY (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='剑域表';
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_rank_jianyu`;
	CREATE TABLE `tb_rank_jianyu` (
	  `rank` int(11) NOT NULL COMMENT '排行',
	  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色GUID',
	  `lastrank` int(11) NOT NULL DEFAULT '0' COMMENT '上次排行',
	  `rankvalue` bigint(20) NOT NULL DEFAULT '0' COMMENT '剑域等级',
	  PRIMARY KEY (`rank`),
	  KEY `guid_idx` (`charguid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='剑域排行';
#---------------------------------------------------------
	SET lastVersion = 463; 
	SET versionNotes = 'Add jianyu';
#----------------------------------------------------------------------
END IF;
#***************************************************************
#***************************************************************
#----------------------------------------------------------------------
IF lastVersion<464 THEN 
#----------------------------------------------------------------------
	DROP TABLE IF EXISTS `tb_player_pifengqixing`;
	CREATE TABLE `tb_player_pifengqixing` (
	  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT 'guid',
	  `id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'id',
	  `level` bigint(20) NOT NULL DEFAULT '0' COMMENT 'level',
	  `progress` bigint(20) NOT NULL DEFAULT '0' COMMENT 'progress',
	  PRIMARY KEY (`charguid`, `id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
#----------------------------------------------------------------------
	SET lastVersion = 464;
	SET versionNotes = 'add pifengqixing';
#----------------------------------------------------------------------
END IF;

#***************************************************************
#***************************************************************
IF lastVersion < 465 THEN 
#----------------------------------------------------------------------
DROP TABLE IF EXISTS `tb_player_change`;
CREATE TABLE `tb_player_change` (
  `charguid` bigint(20) NOT NULL DEFAULT '0' COMMENT '玩家guid',
  `changeid` int(11) NOT NULL DEFAULT '0' COMMENT '变身ID',
  `begin_time` int(11) NOT NULL DEFAULT '0' COMMENT '变身开始时间',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '变身结束时间',
  PRIMARY KEY (`charguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='变身系统数据';

#----------------------------------------------------------------------
	SET lastVersion = 465;
	SET versionNotes = 'add player_change';
#----------------------------------------------------------------------
END IF;


#***************************************************************
##++++++++++++++++++++表格修改完成++++++++++++++++++++++++++++++

IF lastVersion > lastVersion1 THEN 
	INSERT INTO tb_database_version(version, updateDate, lastSql) values(lastVersion, now(), versionNotes);
END IF;

END
;;
DELIMITER ;
call updateSql ();
DROP PROCEDURE IF EXISTS `updateSql`;

#↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
################################################################################
###############################过程修改开始#####################################
DELIMITER ;;

#***************************************************************
##版本296修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_player_fuwen_info
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_fuwen_info`;
CREATE PROCEDURE `sp_select_player_fuwen_info`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_fuwen_info WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_fuwen_info_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_fuwen_info_insert_update`;
CREATE PROCEDURE `sp_player_fuwen_info_insert_update`(IN `in_charguid` bigint, IN `in_select` int, IN `in_page` int)
BEGIN
	INSERT INTO tb_player_fuwen_info(charguid, select_page, page_bits)
	VALUES (in_charguid, in_select, in_page)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, select_page = in_select, page_bits = in_page;
END ;;
-- ----------------------------
-- Procedure structure for sp_select_player_fuwen_item
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_fuwen_item`;
CREATE PROCEDURE `sp_select_player_fuwen_item`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_fuwen_item WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_fuwen_item_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_fuwen_item_insert_update`;
CREATE PROCEDURE `sp_player_fuwen_item_insert_update`(IN `in_charguid` bigint, IN `in_itemgid` bigint, IN `in_itemtid` int, IN `in_pos` int, IN `in_type` int,
	 IN `in_star` int, IN `in_level` int, IN `in_exp` int,IN `in_time_stamp` bigint)
BEGIN
	INSERT INTO tb_player_fuwen_item(charguid, itemgid, itemtid, pos, type, star, level, exp, time_stamp)
	VALUES (in_charguid, in_itemgid,in_itemtid,in_pos,in_type,in_star, in_level, in_exp, in_time_stamp)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, itemtid = in_itemgid, itemtid = in_itemtid, pos = in_pos, type = in_type,
		star = in_star, level = in_level, exp = in_exp, time_stamp = in_time_stamp;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_fuwen_item_delete_by_id_and_timestamp
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_fuwen_item_delete_by_id_and_timestamp`;
CREATE PROCEDURE `sp_player_fuwen_item_delete_by_id_and_timestamp`(IN `in_charguid` bigint, IN `in_time_stamp` bigint)
BEGIN
  DELETE FROM tb_player_fuwen_item WHERE charguid = in_charguid AND time_stamp <> in_time_stamp;
END;;
#***************************************************************
##版本296修改完成
#***************************************************************
#***************************************************************
##版本297修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_add_advice
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_add_advice`;
CREATE PROCEDURE `sp_player_add_advice`(IN `in_guid` bigint, IN `in_type` int, IN `in_title` varchar(256), IN `in_content` varchar(1024))
BEGIN
	INSERT INTO tb_player_advice(charguid, type, title, content)
	VALUES(in_guid, in_type, in_title, in_content);
END ;;
-- ----------------------------
-- Procedure structure for sp_player_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_extra_insert_update`;
CREATE  PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(128), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
		IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
		IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(256), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
		IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
		IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
		IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
		IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
		IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
		IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(350),
		IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
		IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int)
BEGIN
	INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
		storage_online, babel_count, timing_count, offmin, awardstatus,
		vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
		zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
		fatigue, reward_bits,huizhang_lvl,huizhang_times,
		huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
		zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
		lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
		flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
		lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
		magickey_tili, crystal_minetask, zhanyinlv, advice)
	VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
		in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
		in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
		in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
		in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
		in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
		in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
		in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
		in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
		in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
		in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice) 
	ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
		bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
		babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
		awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
		vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
		baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
		fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
		huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
		huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
		sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
		item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
		flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
		lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
		platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
		magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice;
END;;
#***************************************************************
##版本297修改完成
#***************************************************************

#***************************************************************
##版本298修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_player_color_stone
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_color_stone`;
CREATE PROCEDURE `sp_select_player_color_stone`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_color_stone WHERE charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_insert_update_color_stone
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_color_stone`;
CREATE PROCEDURE `sp_insert_update_color_stone`(IN `in_charguid` bigint,  IN `in_stoneid` int, IN `in_stagelevel` int, IN `in_level` int, IN `in_equippos` int)
BEGIN
  INSERT INTO tb_player_color_stone(charguid, stone_id, stage_level, level, equip_pos)
  VALUES (in_charguid, in_stoneid, in_stagelevel, in_level, in_equippos) 
  ON DUPLICATE KEY UPDATE charguid=in_charguid, stone_id=in_stoneid, stage_level=in_stagelevel,level=in_level,equip_pos=in_equippos;
END;;
#***************************************************************
##版本298修改完成
#***************************************************************
#***************************************************************
##版本299修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_player_slayer_quest
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_slayer_quest`;
CREATE PROCEDURE `sp_select_player_slayer_quest`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_slayer_quest WHERE charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_insert_update_slayer_quest
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_slayer_quest`;
CREATE PROCEDURE `sp_insert_update_slayer_quest`(IN `in_charguid` bigint,IN `quest_id` int,IN `grade` int,IN `levelup` int,IN `accepttime` bigint)
BEGIN
  INSERT INTO tb_player_slayer_quest(charguid, quest_id, grade, levelup, accepttime)
  VALUES (in_charguid, quest_id, grade, levelup, accepttime) 
  ON DUPLICATE KEY UPDATE charguid=in_charguid, quest_id=quest_id,grade = grade,levelup = levelup, accepttime = accepttime;
END;;
-- ----------------------------
-- Procedure structure for sp_delete_slayer_quest
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_delete_slayer_quest`;
CREATE PROCEDURE `sp_delete_slayer_quest`(IN `in_charguid` bigint)
BEGIN
	DELETE FROM tb_player_slayer_quest WHERE charguid = in_charguid;
END;;
#***************************************************************
##版本299修改完成
#***************************************************************
#***************************************************************
##版本300修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_info_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_info_insert_update`;
CREATE  PROCEDURE `sp_player_info_insert_update`(IN `in_id` bigint,  IN `in_name` varchar(32), IN `in_level` int, IN `in_exp` bigint, IN `in_vip_level` int, IN `in_vip_exp` int,
				IN `in_power` bigint, IN `in_hp` int, IN `in_mp` int, IN `in_hunli` int, IN `in_tipo` int, IN `in_shenfa` int, IN `in_jingshen` int, 
				IN `in_leftpoint` int, IN `in_totalpoint` int, IN `in_sp` int, IN `in_max_sp` int, IN `in_sp_recover` int, IN `in_bindgold` bigint, 
				IN `in_unbindgold` bigint, IN `in_bindmoney` bigint, IN `in_unbindmoney` bigint, IN `in_zhenqi` bigint, IN `in_soul` int, IN `in_pk_mode` int, IN `in_pk_status` int,
				IN `in_pk_flags` int,IN `in_pk_evil` int,IN `in_redname_time` bigint, IN `in_grayname_time` bigint, IN `in_pk_count` int, IN `in_yao_hun` int,
				IN `in_arms` int, IN `in_dress` int, IN `in_online_time` int, IN `in_head` int, IN `in_suit` int, IN `in_weapon` int, IN `in_drop_val` int, IN `in_drop_lv` int, 
				IN `in_killtask_count` int, IN `in_onlinetime_day` int, IN `in_honor` int, IN `in_hearthstone_time` bigint, IN `in_lingzhi` int, IN `in_jingjie_exp` int, IN `in_vplan` int,
				IN `in_blesstime` bigint,IN `in_equipval` bigint, IN `in_wuhunid` int, IN `in_shenbingid` int,IN `in_extremityval` bigint, IN `in_wingid` int,
				IN `in_blesstime2` bigint,IN `in_blesstime3` bigint, IN `in_suitflag` int, IN `in_crossscore` int, IN `in_crossexploit` int, IN `in_crossseasonid` int, 
				IN `in_pvplevel` int, IN `in_sheild` bigint, IN `in_glorylevel` int, IN `in_gloryexp` int, IN `in_canjuan` int, IN `in_slayerQuestNum` int)
BEGIN
	INSERT INTO tb_player_info(charguid, name, level, exp, vip_level, vip_exp,
		power, hp, mp, hunli, tipo, shenfa, jingshen, 
		leftpoint, totalpoint, sp, max_sp, sp_recover,bindgold,
		unbindgold, bindmoney, unbindmoney,zhenqi, soul, pk_mode, pk_status,
		pk_flags, pk_evil, redname_time, grayname_time, pk_count, yao_hun, 
		arms, dress, online_time, head, suit, weapon, drop_val, drop_lv, 
		killtask_count, onlinetime_day, honor,hearthstone_time,lingzhi,jingjie_exp,
		vplan, blesstime,equipval, wuhunid, shenbingid,extremityval, wingid,
		blesstime2, blesstime3, suitflag, crossscore, crossexploit, crossseasonid, pvplevel, sheild, glorylevel, gloryexp,canjuan, slayerQuestNum)
	VALUES (in_id, in_name, in_level, in_exp, in_vip_level, in_vip_exp,
			in_power, in_hp, in_mp, in_hunli, in_tipo, in_shenfa, in_jingshen, 
			in_leftpoint, in_totalpoint, in_sp, in_max_sp, in_sp_recover, in_bindgold, 
			in_unbindgold, in_bindmoney, in_unbindmoney, in_zhenqi, in_soul, in_pk_mode, in_pk_status,
			in_pk_flags,in_pk_evil, in_redname_time, in_grayname_time, in_pk_count, in_yao_hun, in_arms, 
			in_dress, in_online_time, in_head, in_suit, in_weapon, in_drop_val, in_drop_lv, in_killtask_count,
			in_onlinetime_day, in_honor,in_hearthstone_time,in_lingzhi,in_jingjie_exp,
			in_vplan, in_blesstime,in_equipval, in_wuhunid, in_shenbingid,in_extremityval, in_wingid, 
			in_blesstime2, in_blesstime3, in_suitflag, in_crossscore, in_crossexploit, in_crossseasonid, in_pvplevel, in_sheild, in_glorylevel, in_gloryexp, in_canjuan, in_slayerQuestNum) 
	ON DUPLICATE KEY UPDATE name=in_name, level=in_level, exp = in_exp, vip_level = in_vip_level, vip_exp = in_vip_exp,
		power=in_power, hp=in_hp, mp=in_mp, hunli=in_hunli, tipo=in_tipo, shenfa=in_shenfa, jingshen=in_jingshen, 
		leftpoint=in_leftpoint, totalpoint=in_totalpoint, sp = in_sp, max_sp = in_max_sp, sp_recover = in_sp_recover, bindgold=in_bindgold, 
		unbindgold=in_unbindgold, bindmoney=in_bindmoney, unbindmoney=in_unbindmoney, zhenqi=in_zhenqi, soul = in_soul, pk_mode=in_pk_mode, pk_status = in_pk_status,
		pk_flags = in_pk_flags, pk_evil = in_pk_evil, redname_time = in_redname_time, grayname_time = in_grayname_time, pk_count = in_pk_count, yao_hun=in_yao_hun,
		arms = in_arms, dress = in_dress, online_time = in_online_time, head = in_head, suit = in_suit, weapon = in_weapon, drop_val = in_drop_val, drop_lv = in_drop_lv, 
		killtask_count = in_killtask_count, onlinetime_day=in_onlinetime_day, honor = in_honor,hearthstone_time=in_hearthstone_time,lingzhi=in_lingzhi,jingjie_exp=in_jingjie_exp,vplan=in_vplan,
		blesstime = in_blesstime,equipval = in_equipval, wuhunid = in_wuhunid, shenbingid = in_shenbingid, extremityval = in_extremityval, wingid = in_wingid,
		blesstime2 = in_blesstime2, blesstime3 = in_blesstime3, suitflag = in_suitflag, crossscore = in_crossscore, crossexploit = in_crossexploit,
		crossseasonid = in_crossseasonid, pvplevel = in_pvplevel, sheild = in_sheild, glorylevel = in_glorylevel, gloryexp = in_gloryexp, canjuan = in_canjuan, slayerQuestNum = in_slayerQuestNum;
END;;
#***************************************************************
##版本300修改完成
#***************************************************************

#***************************************************************
##版本301修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_info_insert_update
-- ----------------------------
	DROP PROCEDURE IF EXISTS `sp_insert_update_player_treasure_dulp`;
	CREATE PROCEDURE `sp_insert_update_player_treasure_dulp`(IN `in_charguid` bigint, IN `in_item_time` int, IN `in_use_time` int, in `in_new_day_time` bigint)
	BEGIN
		INSERT INTO tb_player_treasure_dulp(charguid, item_time, use_time, new_day_time)
		VALUES (in_charguid, in_item_time, in_use_time, in_new_day_time) 
		ON DUPLICATE KEY UPDATE  item_time = in_item_time, use_time = in_use_time, new_day_time=in_new_day_time;
	END;;
-- ----------------------------
-- Procedure structure for sp_player_info_insert_update
-- ----------------------------
	DROP PROCEDURE IF EXISTS `sp_select_player_treasure_dulp`;
	CREATE PROCEDURE `sp_select_player_treasure_dulp`(in `in_charguid` bigint)
	BEGIN
		select * from tb_player_treasure_dulp where charguid=in_charguid;
	END;;
#***************************************************************
##版本301修改完成
#***************************************************************

#***************************************************************
##版本302修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_zhuzairoad_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhuzairoad_insert_update`;
CREATE  PROCEDURE `sp_player_zhuzairoad_insert_update`(IN `in_charguid` bigint, IN `in_level` int, IN `in_level_star` int, 
IN `in_challenge` int, IN `in_sweep_state` int, IN `in_sweep_time` bigint, IN `in_sweep_times` int, IN `in_time_stamp` bigint, IN `in_star_state` int)
BEGIN
	INSERT INTO tb_player_zhuzairoad(charguid, level, level_star, challenge, sweep_state, sweep_time, sweep_times,time_stamp,star_state)
	VALUES (in_charguid, in_level, in_level_star, in_challenge, in_sweep_state, in_sweep_time, in_sweep_times,in_time_stamp,in_star_state) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid, level=in_level, level_star=in_level_star, challenge=in_challenge, 
	sweep_state=in_sweep_state, sweep_time=in_sweep_time, sweep_times=in_sweep_times, time_stamp = in_time_stamp, star_state = in_star_state;
END;;
#***************************************************************
##版本302修改完成
#***************************************************************
#***************************************************************
##版本303修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_info_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_info_insert_update`;
CREATE  PROCEDURE `sp_player_info_insert_update`(IN `in_id` bigint,  IN `in_name` varchar(32), IN `in_level` int, IN `in_exp` bigint, IN `in_vip_level` int, IN `in_vip_exp` int,
				IN `in_power` bigint, IN `in_hp` int, IN `in_mp` int, IN `in_hunli` int, IN `in_tipo` int, IN `in_shenfa` int, IN `in_jingshen` int, 
				IN `in_leftpoint` int, IN `in_totalpoint` int, IN `in_sp` int, IN `in_max_sp` int, IN `in_sp_recover` int, IN `in_bindgold` bigint, 
				IN `in_unbindgold` bigint, IN `in_bindmoney` bigint, IN `in_unbindmoney` bigint, IN `in_zhenqi` bigint, IN `in_soul` int, IN `in_pk_mode` int, IN `in_pk_status` int,
				IN `in_pk_flags` int,IN `in_pk_evil` int,IN `in_redname_time` bigint, IN `in_grayname_time` bigint, IN `in_pk_count` int, IN `in_yao_hun` int,
				IN `in_arms` int, IN `in_dress` int, IN `in_online_time` int, IN `in_head` int, IN `in_suit` int, IN `in_weapon` int, IN `in_drop_val` int, IN `in_drop_lv` int, 
				IN `in_killtask_count` int, IN `in_onlinetime_day` int, IN `in_honor` int, IN `in_hearthstone_time` bigint, IN `in_lingzhi` int, IN `in_jingjie_exp` int, IN `in_vplan` int,
				IN `in_blesstime` bigint,IN `in_equipval` bigint, IN `in_wuhunid` int, IN `in_shenbingid` int,IN `in_extremityval` bigint, IN `in_wingid` int,
				IN `in_blesstime2` bigint,IN `in_blesstime3` bigint, IN `in_suitflag` int, IN `in_crossscore` int, IN `in_crossexploit` int, IN `in_crossseasonid` int, 
				IN `in_pvplevel` int, IN `in_sheild` bigint, IN `in_glorylevel` int, IN `in_gloryexp` int, IN `in_canjuan` int, IN `in_slayerQuestNum` int, IN `in_magickey` int)
BEGIN
	INSERT INTO tb_player_info(charguid, name, level, exp, vip_level, vip_exp,
		power, hp, mp, hunli, tipo, shenfa, jingshen, 
		leftpoint, totalpoint, sp, max_sp, sp_recover,bindgold,
		unbindgold, bindmoney, unbindmoney,zhenqi, soul, pk_mode, pk_status,
		pk_flags, pk_evil, redname_time, grayname_time, pk_count, yao_hun, 
		arms, dress, online_time, head, suit, weapon, drop_val, drop_lv, 
		killtask_count, onlinetime_day, honor,hearthstone_time,lingzhi,jingjie_exp,
		vplan, blesstime,equipval, wuhunid, shenbingid,extremityval, wingid,
		blesstime2, blesstime3, suitflag, crossscore, crossexploit, crossseasonid, pvplevel, sheild, glorylevel, gloryexp,canjuan, slayerQuestNum, magickey)
	VALUES (in_id, in_name, in_level, in_exp, in_vip_level, in_vip_exp,
			in_power, in_hp, in_mp, in_hunli, in_tipo, in_shenfa, in_jingshen, 
			in_leftpoint, in_totalpoint, in_sp, in_max_sp, in_sp_recover, in_bindgold, 
			in_unbindgold, in_bindmoney, in_unbindmoney, in_zhenqi, in_soul, in_pk_mode, in_pk_status,
			in_pk_flags,in_pk_evil, in_redname_time, in_grayname_time, in_pk_count, in_yao_hun, in_arms, 
			in_dress, in_online_time, in_head, in_suit, in_weapon, in_drop_val, in_drop_lv, in_killtask_count,
			in_onlinetime_day, in_honor,in_hearthstone_time,in_lingzhi,in_jingjie_exp,
			in_vplan, in_blesstime,in_equipval, in_wuhunid, in_shenbingid,in_extremityval, in_wingid, 
			in_blesstime2, in_blesstime3, in_suitflag, in_crossscore, in_crossexploit, in_crossseasonid, in_pvplevel, in_sheild, in_glorylevel, in_gloryexp, in_canjuan, in_slayerQuestNum, in_magickey) 
	ON DUPLICATE KEY UPDATE name=in_name, level=in_level, exp = in_exp, vip_level = in_vip_level, vip_exp = in_vip_exp,
		power=in_power, hp=in_hp, mp=in_mp, hunli=in_hunli, tipo=in_tipo, shenfa=in_shenfa, jingshen=in_jingshen, 
		leftpoint=in_leftpoint, totalpoint=in_totalpoint, sp = in_sp, max_sp = in_max_sp, sp_recover = in_sp_recover, bindgold=in_bindgold, 
		unbindgold=in_unbindgold, bindmoney=in_bindmoney, unbindmoney=in_unbindmoney, zhenqi=in_zhenqi, soul = in_soul, pk_mode=in_pk_mode, pk_status = in_pk_status,
		pk_flags = in_pk_flags, pk_evil = in_pk_evil, redname_time = in_redname_time, grayname_time = in_grayname_time, pk_count = in_pk_count, yao_hun=in_yao_hun,
		arms = in_arms, dress = in_dress, online_time = in_online_time, head = in_head, suit = in_suit, weapon = in_weapon, drop_val = in_drop_val, drop_lv = in_drop_lv, 
		killtask_count = in_killtask_count, onlinetime_day=in_onlinetime_day, honor = in_honor,hearthstone_time=in_hearthstone_time,lingzhi=in_lingzhi,jingjie_exp=in_jingjie_exp,vplan=in_vplan,
		blesstime = in_blesstime,equipval = in_equipval, wuhunid = in_wuhunid, shenbingid = in_shenbingid, extremityval = in_extremityval, wingid = in_wingid,
		blesstime2 = in_blesstime2, blesstime3 = in_blesstime3, suitflag = in_suitflag, crossscore = in_crossscore, crossexploit = in_crossexploit,
		crossseasonid = in_crossseasonid, pvplevel = in_pvplevel, sheild = in_sheild, glorylevel = in_glorylevel, gloryexp = in_gloryexp, canjuan = in_canjuan, slayerQuestNum = in_slayerQuestNum, magickey = in_magickey;
END;;
#***************************************************************
##版本303修改完成
#***************************************************************


#***************************************************************
##版本304修改开始
#***************************************************************

-- ----------------------------
-- Procedure structure for sp_insert_update_player_slayer_num
-- ----------------------------
DROP procedure IF EXISTS `sp_insert_update_player_slayer_num`;
CREATE PROCEDURE `sp_insert_update_player_slayer_num` (IN `in_charguid` bigint(20),IN `in_num_total` int)
BEGIN
	INSERT INTO tb_player_slayer_num(charguid,num_total)
		VALUES (in_charguid,in_num_total) 
		ON DUPLICATE KEY UPDATE num_total = in_num_total;
END;;

-- ----------------------------
-- Procedure structure for `sp_select_player_slayer_num`
-- ----------------------------
DROP procedure IF EXISTS `sp_select_player_slayer_num`;
CREATE PROCEDURE `sp_select_player_slayer_num` (IN `in_charguid` bigint(20))
BEGIN
	select * from tb_player_slayer_num where charguid=in_charguid;
END;;

#***************************************************************
##版本304修改完成
#***************************************************************


#***************************************************************
##版本305修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_equip_pos_select_by_id`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_equip_pos_select_by_id`;
CREATE PROCEDURE `sp_player_equip_pos_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_equip_pos WHERE charguid=in_charguid;
END;;

-- ----------------------------
-- Procedure structure for `sp_player_equip_pos_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_equip_pos_insert_update`;
CREATE PROCEDURE `sp_player_equip_pos_insert_update`(IN `in_charguid` bigint, IN `in_pos` int, IN `in_idx` int, IN `in_groupid` int, IN `in_lvl` int, IN `in_time_stamp` bigint)
BEGIN
	INSERT INTO tb_player_equip_pos(charguid, pos,idx,groupid,lvl,time_stamp)
	VALUES (in_charguid, in_pos,in_idx,in_groupid,in_lvl,in_time_stamp)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, pos = in_pos, idx = in_idx, groupid = in_groupid, lvl = in_lvl, time_stamp = in_time_stamp;
END;;

-- ----------------------------
-- Procedure structure for `sp_player_equip_pos_delete_by_id_and_timestamp`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_equip_pos_delete_by_id_and_timestamp`;
CREATE PROCEDURE `sp_player_equip_pos_delete_by_id_and_timestamp`(IN `in_charguid` bigint, IN `in_time_stamp` bigint)
BEGIN
  DELETE FROM `tb_player_equip_pos` where charguid = in_charguid AND time_stamp <> in_time_stamp;
END;;
#***************************************************************
##版本305修改完成
#***************************************************************


#***************************************************************
##版本305修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_insert_update_player_slayer_num`
-- ----------------------------
DROP procedure IF EXISTS `sp_insert_update_player_slayer_num`;
CREATE PROCEDURE `sp_insert_update_player_slayer_num`(IN `in_charguid` bigint(20),IN `in_num_total` int,IN `in_cur_day_total` int)
BEGIN
	INSERT INTO tb_player_slayer_num(charguid,num_total,cur_day_total)
		VALUES (in_charguid,in_num_total,in_cur_day_total) 
		ON DUPLICATE KEY UPDATE num_total = in_num_total, cur_day_total=in_cur_day_total;
END;;

#***************************************************************
##版本306修改完成
#***************************************************************

#***************************************************************
##版本307修改开始
#***************************************************************
DROP procedure IF EXISTS `sp_insert_update_slayer_quest`;
CREATE PROCEDURE `sp_insert_update_slayer_quest`(IN `in_charguid` bigint,IN `quest_id` int,IN `grade` int,IN `levelup` int,IN `accepttime` bigint,IN `in_accept_index` int)
BEGIN
  INSERT INTO tb_player_slayer_quest(charguid, quest_id, grade, levelup, accepttime,accept_index)
  VALUES (in_charguid, quest_id, grade, levelup, accepttime,in_accept_index) 
  ON DUPLICATE KEY UPDATE charguid=in_charguid, quest_id=quest_id,grade = grade,levelup = levelup, accepttime = accepttime,accept_index = in_accept_index;
END;;
#***************************************************************
##版本307修改完成
#***************************************************************
#***************************************************************
##版本308修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_info_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_info_insert_update`;
CREATE  PROCEDURE `sp_player_info_insert_update`(IN `in_id` bigint,  IN `in_name` varchar(32), IN `in_level` int, IN `in_exp` bigint, IN `in_vip_level` int, IN `in_vip_exp` int,
				IN `in_power` bigint, IN `in_hp` int, IN `in_mp` int, IN `in_hunli` int, IN `in_tipo` int, IN `in_shenfa` int, IN `in_jingshen` int, 
				IN `in_leftpoint` int, IN `in_totalpoint` int, IN `in_sp` int, IN `in_max_sp` int, IN `in_sp_recover` int, IN `in_bindgold` bigint, 
				IN `in_unbindgold` bigint, IN `in_bindmoney` bigint, IN `in_unbindmoney` bigint, IN `in_zhenqi` bigint, IN `in_soul` int, IN `in_pk_mode` int, IN `in_pk_status` int,
				IN `in_pk_flags` int,IN `in_pk_evil` int,IN `in_redname_time` bigint, IN `in_grayname_time` bigint, IN `in_pk_count` int, IN `in_yao_hun` int,
				IN `in_arms` int, IN `in_dress` int, IN `in_online_time` int, IN `in_head` int, IN `in_suit` int, IN `in_weapon` int, IN `in_drop_val` int, IN `in_drop_lv` int, 
				IN `in_killtask_count` int, IN `in_onlinetime_day` int, IN `in_honor` int, IN `in_hearthstone_time` bigint, IN `in_lingzhi` int, IN `in_jingjie_exp` int, IN `in_vplan` int,
				IN `in_blesstime` bigint,IN `in_equipval` bigint, IN `in_wuhunid` int, IN `in_shenbingid` int,IN `in_extremityval` bigint, IN `in_wingid` int,
				IN `in_blesstime2` bigint,IN `in_blesstime3` bigint, IN `in_suitflag` int, IN `in_crossscore` int, IN `in_crossexploit` int, IN `in_crossseasonid` int, 
				IN `in_pvplevel` int, IN `in_sheild` bigint, IN `in_glorylevel` int, IN `in_gloryexp` int, IN `in_canjuan` int, IN `in_slayerQuestNum` int, IN `in_magickey` int, IN `in_datangcnt` int)
BEGIN
	INSERT INTO tb_player_info(charguid, name, level, exp, vip_level, vip_exp,
		power, hp, mp, hunli, tipo, shenfa, jingshen, 
		leftpoint, totalpoint, sp, max_sp, sp_recover,bindgold,
		unbindgold, bindmoney, unbindmoney,zhenqi, soul, pk_mode, pk_status,
		pk_flags, pk_evil, redname_time, grayname_time, pk_count, yao_hun, 
		arms, dress, online_time, head, suit, weapon, drop_val, drop_lv, 
		killtask_count, onlinetime_day, honor,hearthstone_time,lingzhi,jingjie_exp,
		vplan, blesstime,equipval, wuhunid, shenbingid,extremityval, wingid,
		blesstime2, blesstime3, suitflag, crossscore, crossexploit, crossseasonid, pvplevel, sheild, glorylevel, gloryexp,canjuan, slayerQuestNum, magickey, datangcnt)
	VALUES (in_id, in_name, in_level, in_exp, in_vip_level, in_vip_exp,
			in_power, in_hp, in_mp, in_hunli, in_tipo, in_shenfa, in_jingshen, 
			in_leftpoint, in_totalpoint, in_sp, in_max_sp, in_sp_recover, in_bindgold, 
			in_unbindgold, in_bindmoney, in_unbindmoney, in_zhenqi, in_soul, in_pk_mode, in_pk_status,
			in_pk_flags,in_pk_evil, in_redname_time, in_grayname_time, in_pk_count, in_yao_hun, in_arms, 
			in_dress, in_online_time, in_head, in_suit, in_weapon, in_drop_val, in_drop_lv, in_killtask_count,
			in_onlinetime_day, in_honor,in_hearthstone_time,in_lingzhi,in_jingjie_exp,
			in_vplan, in_blesstime,in_equipval, in_wuhunid, in_shenbingid,in_extremityval, in_wingid, 
			in_blesstime2, in_blesstime3, in_suitflag, in_crossscore, in_crossexploit, in_crossseasonid, in_pvplevel, in_sheild, in_glorylevel, in_gloryexp, in_canjuan, in_slayerQuestNum, in_magickey, in_datangcnt) 
	ON DUPLICATE KEY UPDATE name=in_name, level=in_level, exp = in_exp, vip_level = in_vip_level, vip_exp = in_vip_exp,
		power=in_power, hp=in_hp, mp=in_mp, hunli=in_hunli, tipo=in_tipo, shenfa=in_shenfa, jingshen=in_jingshen, 
		leftpoint=in_leftpoint, totalpoint=in_totalpoint, sp = in_sp, max_sp = in_max_sp, sp_recover = in_sp_recover, bindgold=in_bindgold, 
		unbindgold=in_unbindgold, bindmoney=in_bindmoney, unbindmoney=in_unbindmoney, zhenqi=in_zhenqi, soul = in_soul, pk_mode=in_pk_mode, pk_status = in_pk_status,
		pk_flags = in_pk_flags, pk_evil = in_pk_evil, redname_time = in_redname_time, grayname_time = in_grayname_time, pk_count = in_pk_count, yao_hun=in_yao_hun,
		arms = in_arms, dress = in_dress, online_time = in_online_time, head = in_head, suit = in_suit, weapon = in_weapon, drop_val = in_drop_val, drop_lv = in_drop_lv, 
		killtask_count = in_killtask_count, onlinetime_day=in_onlinetime_day, honor = in_honor,hearthstone_time=in_hearthstone_time,lingzhi=in_lingzhi,jingjie_exp=in_jingjie_exp,vplan=in_vplan,
		blesstime = in_blesstime,equipval = in_equipval, wuhunid = in_wuhunid, shenbingid = in_shenbingid, extremityval = in_extremityval, wingid = in_wingid,
		blesstime2 = in_blesstime2, blesstime3 = in_blesstime3, suitflag = in_suitflag, crossscore = in_crossscore, crossexploit = in_crossexploit,
		crossseasonid = in_crossseasonid, pvplevel = in_pvplevel, sheild = in_sheild, glorylevel = in_glorylevel, gloryexp = in_gloryexp, canjuan = in_canjuan, slayerQuestNum = in_slayerQuestNum, magickey = in_magickey, datangcnt = in_datangcnt;
END;;
#***************************************************************
##版本308修改完成
#***************************************************************

#***************************************************************
##版本309修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_select_rank_human_info_base`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_human_info_base`;
CREATE PROCEDURE `sp_select_rank_human_info_base`(IN `in_id` bigint)
BEGIN
	SELECT charguid, name, prof, level, hp, mp, power, vip_level, sex, dress, glorylevel,
	arms, head, suit, weapon, hunli, tipo, shenfa, jingshen, vplan, wingid, shenbingid, suitflag,crossscore
	FROM tb_player_info WHERE charguid = in_id;
END;;
#***************************************************************
##版本309修改完成
#***************************************************************

#***************************************************************
##版本310修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_guanzhi_select_by_id`
-- ----------------------------
	DROP procedure IF EXISTS `sp_player_guanzhi_select_by_id`;
	CREATE PROCEDURE `sp_player_guanzhi_select_by_id` (IN in_charguid bigint)
	BEGIN
		select * from tb_player_guanzhi where charguid=in_charguid;
	END;;
-- ----------------------------
-- Procedure structure for `sp_player_guanzhi_insert_update`
-- ----------------------------
	DROP procedure IF EXISTS `sp_player_guanzhi_insert_update`;
	CREATE PROCEDURE `sp_player_guanzhi_insert_update`(IN `in_charguid` bigint,IN `in_curr_id` int)
	BEGIN
			INSERT INTO tb_player_guanzhi(charguid, curr_id) VALUES (in_charguid,in_curr_id) 
			ON DUPLICATE KEY UPDATE curr_id=in_curr_id;
	END;;
#***************************************************************
##版本310修改完成
#***************************************************************

#***************************************************************
##版本311修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_equips_insert_update`
-- ----------------------------
	DROP procedure IF EXISTS `sp_player_equips_insert_update`;
	CREATE PROCEDURE `sp_player_equips_insert_update`(IN `in_charguid` bigint, IN `in_item_id` bigint, IN `in_item_tid` int, IN `in_slot_id` int,
	 IN `in_stack_num` int, IN `in_flags` bigint,IN `in_bag` int, IN `in_strenid` int, IN `in_strenval` int, IN `in_proval` int, IN `in_extralv` int,
	 IN `in_superholenum` int, IN `in_super1` varchar(64),IN `in_super2` varchar(64),IN `in_super3` varchar(64),IN `in_super4` varchar(64),
	 IN `in_super5` varchar(64), IN `in_super6` varchar(64), IN `in_super7` varchar(64), IN `in_newsuper` varchar(64), IN `in_time_stamp` bigint,
	 IN `in_newgroup` int, IN `in_newgroupbind` bigint, IN `in_wash` varchar(64), IN `in_NewGroupLevel` int)
	BEGIN
		INSERT INTO tb_player_equips(charguid, item_id, item_tid, slot_id, stack_num, flags, bag, strenid, strenval, proval, extralv,
		superholenum, super1, super2, super3, super4, super5, super6, super7, newsuper, time_stamp, newgroup, newgroupbind, wash, NewGroupLevel)
		VALUES (in_charguid, in_item_id, in_item_tid, in_slot_id, in_stack_num, in_flags, in_bag, in_strenid, in_strenval, in_proval, in_extralv,
		in_superholenum, in_super1, in_super2, in_super3, in_super4, in_super5, in_super6, in_super7, in_newsuper, in_time_stamp, 
	    in_newgroup, in_newgroupbind, in_wash, in_NewGroupLevel) 
		ON DUPLICATE KEY UPDATE charguid=in_charguid, item_id=in_item_id, item_tid=in_item_tid, slot_id=in_slot_id, 
		stack_num=in_stack_num, flags=in_flags, bag=in_bag, strenid=in_strenid, strenval=in_strenval,proval=in_proval, extralv=in_extralv, 
		superholenum=in_superholenum, super1=in_super1, super2=in_super2, super3=in_super3, super4=in_super4, 
		super5=in_super5,super6=in_super6,super7=in_super7,newsuper=in_newsuper,time_stamp = in_time_stamp,newgroup=in_newgroup,newgroupbind = in_newgroupbind,
		wash = in_wash, NewGroupLevel=in_NewGroupLevel;
	END;;
#***************************************************************
##版本311修改完成
#***************************************************************
#***************************************************************
##版本312修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_select_ws_human_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_ws_human_info`;
CREATE PROCEDURE `sp_select_ws_human_info`(IN `in_charguid` bigint)
BEGIN
	SELECT P.charguid,P.level,P.name,P.prof,P.blesstime, P.exts, M.base_map,M.game_map,P.blesstime2,P.blesstime3,
	P.glorylevel, P.forb_chat_time, P.forb_chat_last, P.forb_acc_time, P.forb_acc_last,
	UNIX_TIMESTAMP(P.create_time) as create_time, UNIX_TIMESTAMP(P.last_logout) as last_logout, P.forb_type , P.lock_reason 
	FROM tb_player_info AS P,tb_player_map_info AS M where in_charguid = P.charguid AND in_charguid = M.charguid;
END;;

-- ----------------------------
-- Procedure structure for `sp_select_human_forbidden_type`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_human_forbidden_type`;
CREATE PROCEDURE `sp_select_human_forbidden_type`(IN `in_charguid` bigint)
BEGIN
	SELECT forb_type FROM tb_player_info WHERE charguid = in_charguid ;	
END;;

#***************************************************************
##版本312修改完成
#***************************************************************
#***************************************************************
##版本313修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_select_simple_user_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_simple_user_info`;
CREATE PROCEDURE `sp_select_simple_user_info`(IN `in_guid` bigint)
BEGIN
	SELECT tb_player_info.charguid as charguid, name, prof, iconid, 
	level, power, arms, dress, head, suit, weapon, valid, 
	forb_chat_time, forb_chat_last, forb_acc_time, forb_acc_last, 
	UNIX_TIMESTAMP(tb_account.last_logout) as last_logout, account, vip_level, vplan, wuhunid, shenbingid, wingid, suitflag, glorylevel from tb_player_info 
	left join tb_account
	on tb_player_info.account_id = tb_account.account_id
	where tb_player_info.charguid = in_guid;
END;;
#***************************************************************
##版本313修改完成
#***************************************************************

#***************************************************************
##版本314修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_equip_pos_upstar_select`
-- ----------------------------
	DROP procedure IF EXISTS `sp_equip_pos_upstar_select`;
	CREATE PROCEDURE `sp_equip_pos_upstar_select` (IN in_charguid bigint)
	BEGIN
		select * from tb_equip_pos_upstar where charguid=in_charguid;
	END;;
-- ----------------------------
-- Procedure structure for `sp_equip_pos_upstar_insert_update`
-- ----------------------------
	DROP procedure IF EXISTS `sp_equip_pos_upstar_insert_update`;
	CREATE PROCEDURE `sp_equip_pos_upstar_insert_update` (IN in_charguid bigint, IN in_pos int, IN in_level int, IN in_exp int)
	BEGIN
		INSERT INTO tb_equip_pos_upstar(charguid, pos, `level`, exp)
		VALUES (in_charguid, in_pos, in_level, in_exp)
		ON DUPLICATE KEY UPDATE charguid = in_charguid, pos = in_pos, `level` = in_level, exp = in_exp;
	END;;
#***************************************************************
##版本314修改完成
#***************************************************************

#***************************************************************
##版本315修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_equip_pos_upstar_insert_update`
-- ----------------------------
	DROP procedure IF EXISTS `sp_equip_pos_upstar_insert_update`;
	CREATE PROCEDURE `sp_equip_pos_upstar_insert_update`(IN in_charguid bigint, IN in_id int, IN in_pos int, IN in_level int, IN in_exp int)
	BEGIN
		INSERT INTO tb_equip_pos_upstar(charguid, id, pos, `level`, exp)
		VALUES (in_charguid, in_id, in_pos, in_level, in_exp)
		ON DUPLICATE KEY UPDATE pos = in_pos, `level` = in_level, exp = in_exp;
	END;;
#***************************************************************
##版本315修改完成
#***************************************************************

#***************************************************************
##版本316修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_select_player_super_bag`
-- ----------------------------
	DROP procedure IF EXISTS `sp_select_player_super_bag`;
	CREATE PROCEDURE `sp_select_player_super_bag` (IN in_charguid bigint)
	BEGIN
		SELECT * FROM tb_player_super_bag WHERE charguid = in_charguid;
	END;;
-- ----------------------------
-- Procedure structure for `sp_insert_update_player_super_bag`
-- ----------------------------
	DROP procedure IF EXISTS `sp_insert_update_player_super_bag`;
	CREATE PROCEDURE `sp_insert_update_player_super_bag` (IN `in_charguid` bigint, IN `in_gid` int,  IN `in_index` int, IN `in_num` int, IN `in_id` int)
	BEGIN
		INSERT INTO tb_player_super_bag(charguid, gid, mindex, num, id)
		VALUES (in_charguid, in_gid, in_index, in_num,in_id) 
		ON DUPLICATE KEY UPDATE charguid=in_charguid, gid=in_gid, mindex=in_index, num=in_num, id=in_id;
	END;;
#***************************************************************
##版本316修改完成
#***************************************************************

#***************************************************************
##版本317修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_info_insert_update`
-- ----------------------------
	DROP procedure IF EXISTS `sp_player_info_insert_update`;
	CREATE PROCEDURE `sp_player_info_insert_update`(IN `in_id` bigint,  IN `in_name` varchar(32), IN `in_level` int, IN `in_exp` bigint, IN `in_vip_level` int, IN `in_vip_exp` int,
			IN `in_power` bigint, IN `in_hp` int, IN `in_mp` int, IN `in_hunli` int, IN `in_tipo` int, IN `in_shenfa` int, IN `in_jingshen` int, 
			IN `in_leftpoint` int, IN `in_totalpoint` int, IN `in_sp` int, IN `in_max_sp` int, IN `in_sp_recover` int, IN `in_bindgold` bigint, 
			IN `in_unbindgold` bigint, IN `in_bindmoney` bigint, IN `in_unbindmoney` bigint, IN `in_zhenqi` bigint, IN `in_soul` int, IN `in_pk_mode` int, IN `in_pk_status` int,
			IN `in_pk_flags` int,IN `in_pk_evil` int,IN `in_redname_time` bigint, IN `in_grayname_time` bigint, IN `in_pk_count` int, IN `in_yao_hun` int,
			IN `in_arms` int, IN `in_dress` int, IN `in_online_time` int, IN `in_head` int, IN `in_suit` int, IN `in_weapon` int, IN `in_drop_val` int, IN `in_drop_lv` int, 
			IN `in_killtask_count` int, IN `in_onlinetime_day` int, IN `in_honor` int, IN `in_hearthstone_time` bigint, IN `in_lingzhi` int, IN `in_jingjie_exp` int, IN `in_vplan` int,
			IN `in_blesstime` bigint,IN `in_equipval` bigint, IN `in_wuhunid` int, IN `in_shenbingid` int,IN `in_extremityval` bigint, IN `in_wingid` int,
			IN `in_blesstime2` bigint,IN `in_blesstime3` bigint, IN `in_suitflag` int, IN `in_crossscore` int, IN `in_crossexploit` int, IN `in_crossseasonid` int, 
			IN `in_pvplevel` int, IN `in_sheild` bigint, IN `in_glorylevel` int, IN `in_gloryexp` int, IN `in_CuMoJiFen` int, IN `in_slayerQuestNum` int, 
			IN `in_magickey` int, IN `in_datangcnt` int)
	BEGIN
		INSERT INTO tb_player_info(charguid, name, level, exp, vip_level, vip_exp,
			power, hp, mp, hunli, tipo, shenfa, jingshen, 
			leftpoint, totalpoint, sp, max_sp, sp_recover,bindgold,
			unbindgold, bindmoney, unbindmoney,zhenqi, soul, pk_mode, pk_status,
			pk_flags, pk_evil, redname_time, grayname_time, pk_count, yao_hun, 
			arms, dress, online_time, head, suit, weapon, drop_val, drop_lv, 
			killtask_count, onlinetime_day, honor,hearthstone_time,lingzhi,jingjie_exp,
			vplan, blesstime,equipval, wuhunid, shenbingid,extremityval, wingid,
			blesstime2, blesstime3, suitflag, crossscore, crossexploit, crossseasonid, pvplevel, sheild, glorylevel, gloryexp,
			CuMoJiFen, slayerQuestNum, magickey, datangcnt)
		VALUES (in_id, in_name, in_level, in_exp, in_vip_level, in_vip_exp,
			in_power, in_hp, in_mp, in_hunli, in_tipo, in_shenfa, in_jingshen, 
			in_leftpoint, in_totalpoint, in_sp, in_max_sp, in_sp_recover, in_bindgold, 
			in_unbindgold, in_bindmoney, in_unbindmoney, in_zhenqi, in_soul, in_pk_mode, in_pk_status,
			in_pk_flags,in_pk_evil, in_redname_time, in_grayname_time, in_pk_count, in_yao_hun, in_arms, 
			in_dress, in_online_time, in_head, in_suit, in_weapon, in_drop_val, in_drop_lv, in_killtask_count,
			in_onlinetime_day, in_honor,in_hearthstone_time,in_lingzhi,in_jingjie_exp,
			in_vplan, in_blesstime,in_equipval, in_wuhunid, in_shenbingid,in_extremityval, in_wingid, 
			in_blesstime2, in_blesstime3, in_suitflag, in_crossscore, in_crossexploit, in_crossseasonid, in_pvplevel, in_sheild, in_glorylevel, in_gloryexp, 
			in_CuMoJiFen, in_slayerQuestNum, in_magickey, in_datangcnt) 
		ON DUPLICATE KEY UPDATE name=in_name, level=in_level, exp = in_exp, vip_level = in_vip_level, vip_exp = in_vip_exp,
			power=in_power, hp=in_hp, mp=in_mp, hunli=in_hunli, tipo=in_tipo, shenfa=in_shenfa, jingshen=in_jingshen, 
			leftpoint=in_leftpoint, totalpoint=in_totalpoint, sp = in_sp, max_sp = in_max_sp, sp_recover = in_sp_recover, bindgold=in_bindgold, 
			unbindgold=in_unbindgold, bindmoney=in_bindmoney, unbindmoney=in_unbindmoney, zhenqi=in_zhenqi, soul = in_soul, pk_mode=in_pk_mode, pk_status = in_pk_status,
			pk_flags = in_pk_flags, pk_evil = in_pk_evil, redname_time = in_redname_time, grayname_time = in_grayname_time, pk_count = in_pk_count, yao_hun=in_yao_hun,
			arms = in_arms, dress = in_dress, online_time = in_online_time, head = in_head, suit = in_suit, weapon = in_weapon, drop_val = in_drop_val, drop_lv = in_drop_lv, 
			killtask_count = in_killtask_count, onlinetime_day=in_onlinetime_day, honor = in_honor,hearthstone_time=in_hearthstone_time,lingzhi=in_lingzhi,jingjie_exp=in_jingjie_exp,vplan=in_vplan,
			blesstime = in_blesstime,equipval = in_equipval, wuhunid = in_wuhunid, shenbingid = in_shenbingid, extremityval = in_extremityval, wingid = in_wingid,
			blesstime2 = in_blesstime2, blesstime3 = in_blesstime3, suitflag = in_suitflag, crossscore = in_crossscore, crossexploit = in_crossexploit,
			crossseasonid = in_crossseasonid, pvplevel = in_pvplevel, sheild = in_sheild, glorylevel = in_glorylevel, gloryexp = in_gloryexp, 
			CuMoJiFen = in_CuMoJiFen, slayerQuestNum = in_slayerQuestNum, magickey = in_magickey, datangcnt = in_datangcnt;
	END;;
#***************************************************************
##版本317修改完成
#***************************************************************
#***************************************************************
##版本318修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_insert_update_guild_newwar`
-- ----------------------------
	DROP procedure IF EXISTS `sp_insert_update_guild_newwar`;
	CREATE PROCEDURE `sp_insert_update_guild_newwar`(IN `in_gid` bigint, IN `in_power` bigint,IN `in_secore` int,IN `in_rank` int, IN `in_create_time` bigint)
	BEGIN
		INSERT INTO tb_guild_newwar(gid, power, score, rank, start_time)
		VALUES (in_gid, in_power, in_secore, in_rank, in_create_time)
		ON DUPLICATE KEY UPDATE gid = in_gid, power = in_power, score = in_secore, rank = in_rank, start_time = in_create_time;
	END;;
-- ----------------------------
-- Procedure structure for `sp_select_guild_newwar`
-- ----------------------------
	DROP procedure IF EXISTS `sp_select_guild_newwar`;
	CREATE PROCEDURE `sp_select_guild_newwar`()
	BEGIN
		SELECT * FROM tb_guild_newwar;
	END;;
-- ----------------------------
-- Procedure structure for `sp_delete_guild_newwar`
-- ----------------------------
	DROP procedure IF EXISTS `sp_delete_guild_newwar`;
	CREATE PROCEDURE `sp_delete_guild_newwar`()
	BEGIN
		DELETE FROM tb_guild_newwar;
	END;;
#***************************************************************
##版本318修改完成
#***************************************************************

#***************************************************************
##版本319修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_wing_skin_select_by_id`
-- ----------------------------
	DROP procedure IF EXISTS `sp_player_wing_skin_select_by_id`;
	CREATE PROCEDURE `sp_player_wing_skin_select_by_id` (in in_charguid bigint)
	BEGIN
		select * from tb_player_wing_skin where charguid=in_charguid;
	END;;
-- ----------------------------
-- Procedure structure for `sp_player_wing_skin_insert_update`
-- ----------------------------
	DROP procedure IF EXISTS `sp_player_wing_skin_insert_update`;
	CREATE PROCEDURE `sp_player_wing_skin_insert_update` (in in_charguid bigint, in in_last_id int, in in_use_id int, in in_use_type int)
	BEGIN
		INSERT INTO tb_player_wing_skin(charguid, last_id, use_id, use_type,ids) VALUES (in_charguid, in_last_id, in_use_id, in_use_type) 
		ON DUPLICATE KEY UPDATE last_id=in_last_id, use_id=in_use_id, use_type=in_use_type;
	END;;
#***************************************************************
##版本319修改完成
#***************************************************************

#***************************************************************
##版本320修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_extra_insert_update`
-- ----------------------------
	DROP procedure IF EXISTS `sp_player_extra_insert_update`;
	CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(128), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(256), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(350),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int)
	BEGIN
		INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total)
		VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total) 
		ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total;
	END;;
#***************************************************************
##版本320修改完成
#***************************************************************

#***************************************************************
##版本321修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_select_player_info_by_ls`
-- ----------------------------
	DROP procedure IF EXISTS `sp_select_player_info_by_ls`;
	CREATE PROCEDURE `sp_select_player_info_by_ls`(IN `in_account_id` bigint)
	BEGIN
		SELECT name, level, prof, iconid, power, vip_level, head, suit, weapon, wingid, suitflag, exts, forb_type, forb_acc_time, forb_acc_last, charguid, UNIX_TIMESTAMP(tb_player_info.last_logout) as last_logout, 
		    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin
		FROM tb_player_info 
		WHERE in_account_id = account_id;
	END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_human_info_base`
-- ----------------------------
	DROP procedure IF EXISTS `sp_select_rank_human_info_base`;
	CREATE PROCEDURE `sp_select_rank_human_info_base`(IN `in_id` bigint)
	BEGIN
		SELECT charguid, name, prof, level, hp, mp, power, vip_level, sex, dress, glorylevel,
		arms, head, suit, weapon, hunli, tipo, shenfa, jingshen, vplan, wingid, shenbingid, suitflag,crossscore,
		    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin
		FROM tb_player_info WHERE charguid = in_id;
	END;;
#***************************************************************
##版本321修改完成
#***************************************************************

#***************************************************************
##版本322修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_againstquests_select_by_id`
-- ----------------------------
	DROP procedure IF EXISTS `sp_player_againstquests_select_by_id`;
	CREATE PROCEDURE `sp_player_againstquests_select_by_id`(IN `in_charguid` bigint)
	BEGIN
	  SELECT * FROM tb_player_againstquest WHERE charguid = in_charguid;
	END;;
-- ----------------------------
-- Procedure structure for `sp_player_againstquests_insert_update`
-- ----------------------------
	DROP procedure IF EXISTS `sp_player_againstquests_insert_update`;
	CREATE PROCEDURE `sp_player_againstquests_insert_update`(IN `in_charguid` bigint,IN `in_quest_id` int,
	IN `in_quest_star` int, IN `in_quest_counter` int, IN `in_quest_counter_id` varchar(256),
	IN `in_quest_reward_id` varchar(128), IN `in_quest_double` int, IN `in_quest_auto_star` int)
	BEGIN
	  INSERT INTO tb_player_againstquest(charguid, quest_id, quest_star,quest_counter,
	  quest_counter_id,quest_reward_id,quest_double,quest_auto_star)
	  VALUES (in_charguid, in_quest_id,in_quest_star,in_quest_counter,
	  in_quest_counter_id,in_quest_reward_id,in_quest_double,in_quest_auto_star) 
	  ON DUPLICATE KEY UPDATE charguid=in_charguid, quest_id=in_quest_id, quest_star=in_quest_star,
	  quest_counter=in_quest_counter,quest_counter_id=in_quest_counter_id,quest_reward_id=in_quest_reward_id,
	  quest_double=in_quest_double,quest_auto_star=in_quest_auto_star;
	END;;
#***************************************************************
##版本322修改完成
#***************************************************************

#***************************************************************
##版本323修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_wing_skin_insert_update`
-- ----------------------------
	DROP procedure IF EXISTS `sp_player_wing_skin_insert_update`;
	CREATE PROCEDURE `sp_player_wing_skin_insert_update` (in in_charguid bigint, in in_last_id int, in in_use_id int, in in_use_type int, in in_ids varchar(512))
	BEGIN
		INSERT INTO tb_player_wing_skin(charguid, last_id, use_id, use_type,ids) VALUES (in_charguid, in_last_id, in_use_id, in_use_type,in_ids) 
		ON DUPLICATE KEY UPDATE last_id=in_last_id, use_id=in_use_id, use_type=in_use_type,ids=in_ids;
	END;;
#***************************************************************
##版本323修改完成
#***************************************************************
#***************************************************************
##版本324修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_insert_update_player_guildquest`
-- ----------------------------
	DROP procedure IF EXISTS `sp_insert_update_player_guildquest`;
	CREATE PROCEDURE `sp_insert_update_player_guildquest` (IN `in_charguid` bigint,  IN `in_quest_id` int,IN`in_quest_star` int,  IN `in_quest_counter` int, 
	IN `in_quest_counter_id` varchar(256), IN`in_quest_reward_id` varchar(128),IN `in_quest_double` int, IN `in_quest_auto_star` int)
	BEGIN
	  INSERT INTO tb_player_guildquest(charguid, quest_id, quest_star,quest_counter,
	  quest_counter_id,quest_reward_id,quest_double,quest_auto_star)
	  VALUES (in_charguid, in_quest_id,in_quest_star,in_quest_counter,
	  in_quest_counter_id,in_quest_reward_id,in_quest_double,in_quest_auto_star) 
	  ON DUPLICATE KEY UPDATE charguid=in_charguid, quest_id=in_quest_id, quest_star=in_quest_star,
	  quest_counter=in_quest_counter,quest_counter_id=in_quest_counter_id,quest_reward_id=in_quest_reward_id,
	  quest_double=in_quest_double,quest_auto_star=in_quest_auto_star;
	END;;
	-- ----------------------------
-- Procedure structure for `sp_select_player_guildquest`
-- ----------------------------
	DROP procedure IF EXISTS `sp_select_player_guildquest`;
	CREATE PROCEDURE `sp_select_player_guildquest` (IN `in_charguid` bigint)
	BEGIN
	  SELECT * FROM tb_player_guildquest WHERE charguid = in_charguid;
	END;;
#***************************************************************
##版本324修改完成
#***************************************************************
#***************************************************************
##版本326修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_magickey_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_magickey_insert_update`;
CREATE  PROCEDURE `sp_player_magickey_insert_update`(IN `in_charguid` bigint, IN `in_item_id` bigint, IN `in_item_tid` int, IN `in_slot_id` int,  IN `in_stack_num` int, 
IN `in_flags` bigint, IN `in_bag` int, IN `in_level` int, IN `in_wuxing` int, IN `in_totalexp` bigint, IN `in_passiveskill` varchar(256), IN `in_godid` bigint,IN `in_time_stamp` bigint)
BEGIN
	INSERT INTO tb_player_magickeys(charguid, item_id, item_tid, slot_id, stack_num, flags, bag,
		level, wuxing, totalexp, passiveskill, godid, time_stamp)
	VALUES (in_charguid, in_item_id, in_item_tid, in_slot_id, in_stack_num, in_flags, in_bag,
		in_level, in_wuxing, in_totalexp, in_passiveskill, in_godid, in_time_stamp) 
	ON DUPLICATE KEY UPDATE  item_id = in_item_id, item_tid = in_item_tid, slot_id = in_slot_id, stack_num = in_stack_num,
	flags = in_flags, bag = in_bag, level = in_level, wuxing = in_wuxing, totalexp = in_totalexp, passiveskill = in_passiveskill, godid = in_godid, time_stamp = in_time_stamp;
END;;
-- ----------------------------
-- Procedure structure for `sp_insert_update_player_magickeygod_bag`
-- ----------------------------
	DROP procedure IF EXISTS `sp_insert_update_player_magickeygod_bag`;
	CREATE PROCEDURE `sp_insert_update_player_magickeygod_bag` (IN `in_charguid` bigint, IN `in_gid` bigint,  IN `in_tid` int, IN `in_magickeyid`bigint)
BEGIN
	INSERT INTO tb_magickeygod_bag(charguid, gid, tid, magickeyid)
	VALUES (in_charguid, in_gid, in_tid, in_magickeyid) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid, gid=in_gid, tid=in_tid, magickeyid=in_magickeyid;
END;;
	-- ----------------------------
-- Procedure structure for `sp_select_player_magickeygod_bag`
-- ----------------------------
	DROP procedure IF EXISTS `sp_select_player_magickeygod_bag`;
	CREATE PROCEDURE `sp_select_player_magickeygod_bag` (IN `in_charguid` bigint)
	BEGIN
	  SELECT * FROM tb_magickeygod_bag WHERE charguid = in_charguid;
	END;;
#***************************************************************
##版本326修改完成
#***************************************************************
#***************************************************************
##版本327修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_insert_update_player_guildquest
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_player_guildquest`;
CREATE  PROCEDURE `sp_insert_update_player_guildquest`(IN `in_charguid` bigint,  IN `in_quest_id` int,IN`in_quest_star` int,  IN `in_quest_counter` int,
IN `in_quest_counter_id` varchar(256), IN`in_quest_reward_id` varchar(128),IN `in_quest_double` int, IN `in_quest_auto_star` int,IN `in_guildguid` bigint)
BEGIN
  INSERT INTO tb_player_guildquest(charguid, quest_id, quest_star,quest_counter,
  quest_counter_id,quest_reward_id,quest_double,quest_auto_star, guild_id)
  VALUES (in_charguid, in_quest_id,in_quest_star,in_quest_counter,
  in_quest_counter_id,in_quest_reward_id,in_quest_double,in_quest_auto_star, in_guildguid) 
  ON DUPLICATE KEY UPDATE charguid=in_charguid, quest_id=in_quest_id, quest_star=in_quest_star,
  quest_counter=in_quest_counter,quest_counter_id=in_quest_counter_id,quest_reward_id=in_quest_reward_id,
  quest_double=in_quest_double,quest_auto_star=in_quest_auto_star, guild_id = in_guildguid;
END;;
#***************************************************************
##版本327修改完成
#***************************************************************

#***************************************************************
##版本330修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_extra_insert_update`
-- ----------------------------
	DROP procedure IF EXISTS `sp_player_extra_insert_update`;
	CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(128), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(256), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(350),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int)
	BEGIN
		INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate)
		VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate) 
		ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, petstate = in_petstate;
	END;;
#***************************************************************
##版本330修改完成
#***************************************************************

#***************************************************************
##版本331修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_pifeng_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_pifeng_insert_update`;
CREATE PROCEDURE `sp_player_pifeng_insert_update`(IN `in_charguid` bigint, IN `in_level` int, IN `in_wish` int, IN `in_use_level` int, IN `in_attr_dan` int)
BEGIN
	INSERT INTO tb_player_pifeng(charguid, level, wish, use_level, attr_dan)
	VALUES (in_charguid, in_level, in_wish, in_use_level, in_attr_dan)
	ON DUPLICATE KEY UPDATE level=in_level, wish=in_wish, use_level=in_use_level, attr_dan=in_attr_dan;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_pifeng_select_by_id`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_pifeng_select_by_id`;
CREATE PROCEDURE `sp_player_pifeng_select_by_id` (in in_charguid bigint)
BEGIN
	select * from tb_player_pifeng where charguid=in_charguid;
END;;
#***************************************************************
##版本331修改完成
#***************************************************************
#***************************************************************
##版本332修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_cross_boss_history
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_cross_boss_history`;
CREATE PROCEDURE `sp_select_cross_boss_history`()
BEGIN
	select * from tb_crossboss_history;
END;;

-- ----------------------------
-- Procedure structure for sp_update_cross_boss_history
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_cross_boss_history`;
CREATE PROCEDURE `sp_update_cross_boss_history`(IN `in_id` int, IN `in_avglv` int, 
	IN `in_firstname1` varchar(32), IN `in_killname1` varchar(32),
	IN `in_firstname2` varchar(32), IN `in_killname2` varchar(32),
	IN `in_firstname3` varchar(32), IN `in_killname3` varchar(32),
	IN `in_firstname4` varchar(32), IN `in_killname4` varchar(32),
	IN `in_firstname5` varchar(32), IN `in_killname5` varchar(32))
BEGIN
	INSERT INTO tb_crossboss_history(id, avglv, firstname1, killname1, firstname2, killname2, firstname3, killname3, firstname4, killname4, firstname5, killname5)
	VALUES (in_id, in_avglv, in_firstname1, in_killname1, in_firstname2, in_killname2, in_firstname3, in_killname3, in_firstname4, in_killname4, in_firstname5, in_killname5) 
	ON DUPLICATE KEY UPDATE id=in_id, avglv=in_avglv, firstname1=in_firstname1, killname1=in_killname1, firstname2=in_firstname2, killname2=in_killname2
	, firstname3=in_firstname3, killname3=in_killname3, firstname4=in_firstname4, killname4=in_killname4, firstname5=in_firstname5, killname5=in_killname5;
END;;
#***************************************************************
##版本332修改完成

#***************************************************************
##版本333修改开始
#***************************************************************
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_shengling_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_shengling_insert_update`;
CREATE PROCEDURE `sp_player_shengling_insert_update`(IN `in_charguid` bigint, IN `in_lvl` int, IN `in_process` int, IN `in_sel` int
, IN `in_proce_num` int,IN `in_total_proce` int, IN `in_attrdan` int)
BEGIN
	INSERT INTO tb_player_shengling(charguid, level, process, sel, proce_num, total_proce, attrdan)
	VALUES (in_charguid, in_lvl, in_process, in_sel, in_proce_num, in_total_proce, in_attrdan)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, level = in_lvl, process = in_process, sel = in_sel, proce_num = in_proce_num, total_proce = in_total_proce, attrdan = in_attrdan;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_shengling_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_shengling_select_by_id`;
CREATE PROCEDURE `sp_player_shengling_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_shengling WHERE charguid=in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_shenglingskins_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_shenglingskins_insert_update`;
CREATE PROCEDURE `sp_player_shenglingskins_insert_update`(IN `in_charguid` bigint, IN `in_skin_id` int, IN `in_skin_time` bigint)
BEGIN
	INSERT INTO tb_player_shengling_skin(charguid, skin_id, skin_time)
	VALUES (in_charguid, in_skin_id, in_skin_time) 
	ON DUPLICATE KEY UPDATE charguid = in_charguid, skin_id = in_skin_id, skin_time = in_skin_time;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_shenglingskins_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_shenglingskins_select_by_id`;
CREATE PROCEDURE `sp_player_shenglingskins_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_shengling_skin WHERE charguid = in_charguid;
END ;;
#***************************************************************
##版本333修改完成
#***************************************************************


#***************************************************************
##版本334修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_rank_pifeng`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_rank_pifeng`;
CREATE PROCEDURE `sp_rank_pifeng` ()
BEGIN
SELECT a.charguid AS uid, a.level AS rankvalue FROM tb_player_pifeng as a left join tb_player_info as b
on a.charguid = b.charguid WHERE a.level > 0 ORDER BY a.level DESC, a.wish DESC, b.power DESC LIMIT 100;
END;;
-- ----------------------------
-- Procedure structure for `sp_update_rank_pifeng`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_rank_pifeng`;
CREATE PROCEDURE `sp_update_rank_pifeng`(IN `in_rank` int, IN `in_charguid` bigint, IN `in_lastrank` int, IN `in_rankvalue` bigint)
BEGIN
	INSERT INTO tb_rank_pifeng(rank, charguid, lastrank, rankvalue)
	VALUES (in_rank, in_charguid, in_lastrank, in_rankvalue)
	ON DUPLICATE KEY UPDATE rank = in_rank, charguid = in_charguid, lastrank = in_lastrank, rankvalue = in_rankvalue;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_pifeng`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_pifeng`;
CREATE PROCEDURE `sp_select_rank_pifeng`()
BEGIN
	SELECT * FROM tb_rank_pifeng;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_human_info_base`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_human_info_base`;
CREATE PROCEDURE `sp_select_rank_human_info_base`(IN `in_id` bigint)
BEGIN
	SELECT charguid, name, prof, level, hp, mp, power, vip_level, sex, dress, glorylevel,
	arms, head, suit, weapon, hunli, tipo, shenfa, jingshen, vplan, wingid, shenbingid, suitflag,crossscore,
	IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
	IFNULL((select level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as pifeng
	FROM tb_player_info WHERE charguid = in_id;
END;;
#***************************************************************
##版本334修改完成
#***************************************************************


#***************************************************************
##版本335修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_equips_insert_update`
-- ----------------------------
	DROP procedure IF EXISTS `sp_player_equips_insert_update`;
	CREATE PROCEDURE `sp_player_equips_insert_update`(IN `in_charguid` bigint, IN `in_item_id` bigint, IN `in_item_tid` int, IN `in_slot_id` int,
	 IN `in_stack_num` int, IN `in_flags` bigint,IN `in_bag` int, IN `in_strenid` int, IN `in_strenval` int, IN `in_proval` int, IN `in_extralv` int,
	 IN `in_superholenum` int, IN `in_super1` varchar(64),IN `in_super2` varchar(64),IN `in_super3` varchar(64),IN `in_super4` varchar(64),
	 IN `in_super5` varchar(64), IN `in_super6` varchar(64), IN `in_super7` varchar(64), IN `in_newsuper` varchar(64), IN `in_time_stamp` bigint,
	 IN `in_newgroup` int, IN `in_newgroupbind` bigint, IN `in_wash` varchar(64), IN `in_NewGroupLevel` int,  IN `in_jinglian` int)
	BEGIN
		INSERT INTO tb_player_equips(charguid, item_id, item_tid, slot_id, stack_num, flags, bag, strenid, strenval, proval, extralv,
		superholenum, super1, super2, super3, super4, super5, super6, super7, newsuper, time_stamp, newgroup, newgroupbind, wash, NewGroupLevel, jinglian)
		VALUES (in_charguid, in_item_id, in_item_tid, in_slot_id, in_stack_num, in_flags, in_bag, in_strenid, in_strenval, in_proval, in_extralv,
		in_superholenum, in_super1, in_super2, in_super3, in_super4, in_super5, in_super6, in_super7, in_newsuper, in_time_stamp, 
	    in_newgroup, in_newgroupbind, in_wash, in_NewGroupLevel, in_jinglian) 
		ON DUPLICATE KEY UPDATE charguid=in_charguid, item_id=in_item_id, item_tid=in_item_tid, slot_id=in_slot_id, 
		stack_num=in_stack_num, flags=in_flags, bag=in_bag, strenid=in_strenid, strenval=in_strenval,proval=in_proval, extralv=in_extralv, 
		superholenum=in_superholenum, super1=in_super1, super2=in_super2, super3=in_super3, super4=in_super4, 
		super5=in_super5,super6=in_super6,super7=in_super7,newsuper=in_newsuper,time_stamp = in_time_stamp,newgroup=in_newgroup,newgroupbind = in_newgroupbind,
		wash = in_wash, NewGroupLevel=in_NewGroupLevel, jinglian=in_jinglian;
	END;;
#***************************************************************
##版本335修改完成
#***************************************************************

#***************************************************************
##版本336修改开始
#***************************************************************
DROP procedure IF EXISTS `sp_player_extra_insert_update`;
CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(256), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(256), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(350),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int)
BEGIN
		INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate)
		VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate) 
		ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, petstate = in_petstate;
	END;;
#***************************************************************
##版本336修改完成
#***************************************************************
#***************************************************************
##版本337修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_select_ws_human_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_ws_human_info`;
CREATE PROCEDURE `sp_select_ws_human_info`(IN `in_charguid` bigint)
BEGIN
	SELECT P.charguid,P.level,P.name,P.prof,P.blesstime, P.exts, M.base_map,M.game_map,P.blesstime2,P.blesstime3, P.glorylevel, 
	P.forb_type, P.forb_acc_time, P.forb_acc_last, P.forb_chat_time, P.forb_chat_last, UNIX_TIMESTAMP(P.create_time) as create_time, P.lock_reason, UNIX_TIMESTAMP(P.last_logout) as last_logout
	FROM tb_player_info AS P,tb_player_map_info AS M where in_charguid = P.charguid AND in_charguid = M.charguid;
END;;
#***************************************************************
##版本337修改完成
#***************************************************************
#***************************************************************
##版本338修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_magickey_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_magickey_insert_update`;
CREATE  PROCEDURE `sp_player_magickey_insert_update`(IN `in_charguid` bigint, IN `in_item_id` bigint, IN `in_item_tid` int, IN `in_slot_id` int,  IN `in_stack_num` int, 
IN `in_flags` bigint, IN `in_bag` int, IN `in_level` int, IN `in_wuxing` int, IN `in_totalexp` bigint, IN `in_passiveskill` varchar(256), IN `in_godid` bigint, IN `in_strenlv` int,IN `in_time_stamp` bigint)
BEGIN
	INSERT INTO tb_player_magickeys(charguid, item_id, item_tid, slot_id, stack_num, flags, bag,
		level, wuxing, totalexp, passiveskill, godid, strenlv, time_stamp)
	VALUES (in_charguid, in_item_id, in_item_tid, in_slot_id, in_stack_num, in_flags, in_bag,
		in_level, in_wuxing, in_totalexp, in_passiveskill, in_godid, in_time_stamp) 
	ON DUPLICATE KEY UPDATE  item_id = in_item_id, item_tid = in_item_tid, slot_id = in_slot_id, stack_num = in_stack_num,
	flags = in_flags, bag = in_bag, level = in_level, wuxing = in_wuxing, totalexp = in_totalexp, passiveskill = in_passiveskill, godid = in_godid, strenlv=in_strenlv, time_stamp = in_time_stamp;
END;;
#***************************************************************
##版本338修改完成
#***************************************************************
#***************************************************************
##版本339修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_wing_skin_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_wing_skin_insert_update`;
CREATE PROCEDURE `sp_player_wing_skin_insert_update` (in in_charguid bigint, in in_last_id int, in in_use_id int, in in_use_type int)
BEGIN
	INSERT INTO tb_player_wing_skin(charguid, last_id, use_id, use_type) VALUES (in_charguid, in_last_id, in_use_id, in_use_type) 
	ON DUPLICATE KEY UPDATE last_id=in_last_id, use_id=in_use_id, use_type=in_use_type;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_wing_skin_detail_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_wing_skin_detail_insert_update`;
CREATE PROCEDURE `sp_player_wing_skin_detail_insert_update`(IN `in_charguid` bigint, IN `in_skin_id` int, IN `in_skin_time` bigint)
BEGIN
	INSERT INTO tb_player_wing_skin_detail(charguid, skin_id, skin_time)
	VALUES (in_charguid, in_skin_id, in_skin_time) 
	ON DUPLICATE KEY UPDATE skin_time = in_skin_time;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_wing_skin_detail_select_by_id`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_wing_skin_detail_select_by_id`;
CREATE PROCEDURE `sp_player_wing_skin_detail_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_wing_skin_detail WHERE charguid = in_charguid;
END;;
#***************************************************************
##版本339修改完成
#***************************************************************

#***************************************************************
##版本340修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_vip_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_vip_insert_update`;
CREATE PROCEDURE `sp_player_vip_insert_update` (IN `in_charguid` bigint, IN `in_vip_exp` bigint, IN `in_vip_lvlreward` int, IN `in_vip_weekrewardtime` bigint,
IN `in_vip_typelasttime1` bigint, IN `in_vip_typelasttime2` bigint, IN `in_vip_typelasttime3` bigint, IN `in_redpacketcnt` int, IN `in_horse_allnum` int,
IN `in_horse_yigeinum` int, IN `in_shengbin_allnum` int, IN `in_shengbin_yigeinum` int)
BEGIN
	INSERT INTO tb_player_vip(charguid,vip_exp,vip_lvlreward,vip_weekrewardtime,vip_typelasttime1,vip_typelasttime2,vip_typelasttime3,redpacketcnt,
	horse_allnum,horse_yigeinum,shengbin_allnum,shengbin_yigeinum)
	VALUES (in_charguid,in_vip_exp,in_vip_lvlreward,in_vip_weekrewardtime,in_vip_typelasttime1,in_vip_typelasttime2,in_vip_typelasttime3,in_redpacketcnt,
	in_horse_allnum,in_horse_yigeinum,in_shengbin_allnum,in_shengbin_yigeinum) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid,vip_lvlreward=in_vip_lvlreward,vip_exp=in_vip_exp,vip_weekrewardtime=in_vip_weekrewardtime,
	vip_typelasttime1=in_vip_typelasttime1,vip_typelasttime2=in_vip_typelasttime2,vip_typelasttime3=in_vip_typelasttime3,redpacketcnt=in_redpacketcnt,
	horse_allnum=in_horse_allnum,horse_yigeinum=in_horse_yigeinum,shengbin_allnum=in_shengbin_allnum,shengbin_yigeinum=in_shengbin_yigeinum;
END;;
#***************************************************************
##版本340修改完成
#***************************************************************
#***************************************************************
##版本341修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_magickey_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_magickey_insert_update`;
CREATE  PROCEDURE `sp_player_magickey_insert_update`(IN `in_charguid` bigint, IN `in_item_id` bigint, IN `in_item_tid` int, IN `in_slot_id` int,  IN `in_stack_num` int, 
IN `in_flags` bigint, IN `in_bag` int, IN `in_level` int, IN `in_wuxing` int, IN `in_totalexp` bigint, IN `in_passiveskill` varchar(256), IN `in_godid` bigint, IN `in_strenlv` int,IN `in_time_stamp` bigint)
BEGIN
	INSERT INTO tb_player_magickeys(charguid, item_id, item_tid, slot_id, stack_num, flags, bag,
		level, wuxing, totalexp, passiveskill, godid, strenlv, time_stamp)
	VALUES (in_charguid, in_item_id, in_item_tid, in_slot_id, in_stack_num, in_flags, in_bag,
		in_level, in_wuxing, in_totalexp, in_passiveskill, in_godid, in_strenlv, in_time_stamp) 
	ON DUPLICATE KEY UPDATE  item_id = in_item_id, item_tid = in_item_tid, slot_id = in_slot_id, stack_num = in_stack_num,
	flags = in_flags, bag = in_bag, level = in_level, wuxing = in_wuxing, totalexp = in_totalexp, passiveskill = in_passiveskill, godid = in_godid, strenlv=in_strenlv, time_stamp = in_time_stamp;
END;;
#***************************************************************
##版本341修改完成
#***************************************************************

#***************************************************************
##版本342修改开始
#***************************************************************
DROP PROCEDURE IF EXISTS `sp_delete_super_bag`;
CREATE PROCEDURE `sp_delete_super_bag`(IN `in_charguid` bigint)
BEGIN
	DELETE FROM tb_player_super_bag WHERE charguid = in_charguid;
END;;
#***************************************************************
##版本342修改完成
#***************************************************************
#***************************************************************
##版本343修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_insert_update_ride
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_ride`;
CREATE  PROCEDURE `sp_insert_update_ride`(IN `in_charguid` bigint, IN `in_step` int, IN `in_select` int, IN `in_state` int, IN `in_process` int,
IN `in_attrdan` int, IN `in_proce_num` int, IN `in_total_proce` int, IN `in_fh_zhenqi` bigint, IN `in_consum_zhenqi` bigint, 
IN `in_uplevel_num` bigint, IN `in_horse_allnum` int, IN `in_horse_yilingqunum` int, IN `in_horse_kelingqunum` int)
BEGIN
	INSERT INTO tb_ride(charguid, ride_step, ride_select, ride_state, ride_process, attrdan, proce_num, total_proce,fh_zhenqi,consum_zhenqi,uplevel_num,
horse_allnum,horse_yilingqunum,horse_kelingqunum)
	VALUES (in_charguid, in_step, in_select, in_state, in_process, in_attrdan,in_proce_num, in_total_proce,in_fh_zhenqi,in_consum_zhenqi,in_uplevel_num,
horse_allnum,horse_yilingqunum,horse_kelingqunum)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, ride_step=in_step, ride_select = in_select, ride_state = in_state, ride_process = in_process, 
		attrdan=in_attrdan, proce_num=in_proce_num, total_proce=in_total_proce, fh_zhenqi=in_fh_zhenqi, consum_zhenqi=in_consum_zhenqi, uplevel_num = in_uplevel_num,
horse_allnum=in_horse_allnum,horse_yilingqunum=in_horse_yilingqunum,horse_kelingqunum=in_horse_kelingqunum;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_vip_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_vip_insert_update`;
CREATE PROCEDURE `sp_player_vip_insert_update` (IN `in_charguid` bigint, IN `in_vip_exp` bigint, IN `in_vip_lvlreward` int, IN `in_vip_weekrewardtime` bigint,
IN `in_vip_typelasttime1` bigint, IN `in_vip_typelasttime2` bigint, IN `in_vip_typelasttime3` bigint, IN `in_redpacketcnt` int)
BEGIN
	INSERT INTO tb_player_vip(charguid,vip_exp,vip_lvlreward,vip_weekrewardtime,vip_typelasttime1,vip_typelasttime2,vip_typelasttime3,redpacketcnt)
	VALUES (in_charguid,in_vip_exp,in_vip_lvlreward,in_vip_weekrewardtime,in_vip_typelasttime1,in_vip_typelasttime2,in_vip_typelasttime3,in_redpacketcnt) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid,vip_lvlreward=in_vip_lvlreward,vip_exp=in_vip_exp,vip_weekrewardtime=in_vip_weekrewardtime,
	vip_typelasttime1=in_vip_typelasttime1,vip_typelasttime2=in_vip_typelasttime2,vip_typelasttime3=in_vip_typelasttime3,redpacketcnt=in_redpacketcnt;
END;;
#***************************************************************
##版本343修改完成
#***************************************************************
#***************************************************************
##版本344修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_shenbing_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_shenbing_insert_update`;
CREATE PROCEDURE `sp_player_shenbing_insert_update` (IN `in_charguid` bigint, IN `in_level` int, IN `in_wish` int, IN `in_proficiency` int
, IN `in_proficiencylvl` int, IN `in_procenum` int, IN `in_skinlevel` int, IN `in_attr_num` int, IN `in_uplevel_num` int, IN `in_shengbing_allnum` int, 
IN `in_shengbing_kelingqunum` int, IN `in_shengbing_yilingqunum` int)
BEGIN
  INSERT INTO tb_player_shenbing(charguid, level, wish, proficiency, proficiencylvl, procenum, skinlevel, attr_num, uplevel_num,
shengbing_allnum,shengbing_kelingqunum,shengbing_yilingqunum)
  VALUES (in_charguid, in_level, in_wish, in_proficiency, in_proficiencylvl, in_procenum, in_skinlevel, in_attr_num, in_uplevel_num,
shengbing_allnum,shengbing_kelingqunum,shengbing_yilingqunum) 
  ON DUPLICATE KEY UPDATE charguid=in_charguid, level=in_level, wish=in_wish, proficiency=in_proficiency, proficiencylvl=in_proficiencylvl
  , procenum=in_procenum,skinlevel = in_skinlevel,attr_num = in_attr_num, uplevel_num = in_uplevel_num,shengbing_allnum=in_shengbing_allnum,
shengbing_kelingqunum=in_shengbing_kelingqunum,shengbing_yilingqunum=in_shengbing_yilingqunum;
END;;
#***************************************************************
##版本344修改完成
#***************************************************************

##版本345修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_insert_update_gem_bag`
-- ----------------------------
DROP procedure IF EXISTS `sp_insert_update_gem_bag`;
CREATE PROCEDURE `sp_insert_update_gem_bag`(IN `in_charguid` bigint, IN `in_pos` int, IN `in_is_open` int)
BEGIN
  INSERT INTO `tb_gem_bag_info`(charguid, pos, is_open)
  VALUES (in_charguid, in_pos, in_is_open) 
  ON DUPLICATE KEY UPDATE charguid=in_charguid, pos=in_pos, is_open=in_is_open;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_gem_bag`
-- ----------------------------
DROP procedure IF EXISTS `sp_select_gem_bag`;
CREATE PROCEDURE `sp_select_gem_bag`(IN `in_charguid` bigint)
BEGIN
  select * from `tb_gem_bag_info` where charguid=in_charguid;
END;;
#***************************************************************
##版本345修改完成
#***************************************************************
#***************************************************************
##版本346修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_extra_insert_update`;
CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(256), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(256), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(350),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int, IN `in_draw_cnt` int)
BEGIN
	INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate,draw_cnt)
	VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate, in_draw_cnt)
	ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, petstate = in_petstate,draw_cnt=in_draw_cnt;
END;;
-- ----------------------------
-- Procedure structure for sp_select_draw_record
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_draw_record`;
CREATE PROCEDURE `sp_select_draw_record`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_draw_record WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_update_draw_record
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_draw_record`;
CREATE PROCEDURE `sp_update_draw_record`(IN `in_charguid` bigint, IN `in_index` int, IN `in_reward` int, IN `in_param` int)
BEGIN
	INSERT INTO tb_player_draw_record(charguid, `index`, reward, param)
	VALUES (in_charguid, in_index, in_reward, in_param)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, `index` = in_index, reward = in_reward, param = in_param;
END ;;
#***************************************************************
##版本346修改完成
#***************************************************************

#***************************************************************
##版本347修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_select_rank_human_pifeng`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_human_pifeng`;
CREATE PROCEDURE `sp_select_rank_human_pifeng`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_pifeng WHERE charguid = in_charguid;
END ;;
#***************************************************************
##版本347修改完成
#***************************************************************

#***************************************************************
##版本348修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_select_player_info_by_ls`
-- ----------------------------
	DROP procedure IF EXISTS `sp_select_player_info_by_ls`;
	CREATE PROCEDURE `sp_select_player_info_by_ls`(IN `in_guid` bigint)
	BEGIN
		SELECT name, level, prof, iconid, power, vip_level, head, suit, weapon, wingid, suitflag, exts,
		    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
		    IFNULL((select use_level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as piFengLevel
		FROM tb_player_info 
		WHERE in_guid = charguid;
	END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_human_info_base`
-- ----------------------------
	DROP procedure IF EXISTS `sp_select_rank_human_info_base`;
	CREATE PROCEDURE `sp_select_rank_human_info_base`(IN `in_id` bigint)
	BEGIN
		SELECT charguid, name, prof, level, hp, mp, power, vip_level, sex, dress, glorylevel,
		arms, head, suit, weapon, hunli, tipo, shenfa, jingshen, vplan, wingid, shenbingid, suitflag,crossscore,
		    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
		    IFNULL((select use_level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as piFengLevel
		FROM tb_player_info WHERE charguid = in_id;
	END;;
#***************************************************************
##版本348修改完成
#***************************************************************

#***************************************************************
##版本349修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_info_insert_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_info_insert_update`;
CREATE PROCEDURE `sp_player_info_insert_update`(IN `in_id` bigint,  IN `in_name` varchar(32), IN `in_level` int, IN `in_exp` bigint, IN `in_vip_level` int, IN `in_vip_exp` int,
			IN `in_power` bigint, IN `in_hp` int, IN `in_mp` int, IN `in_hunli` int, IN `in_tipo` int, IN `in_shenfa` int, IN `in_jingshen` int, 
			IN `in_leftpoint` int, IN `in_totalpoint` int, IN `in_sp` int, IN `in_max_sp` int, IN `in_sp_recover` int, IN `in_bindgold` bigint, 
			IN `in_unbindgold` bigint, IN `in_bindmoney` bigint, IN `in_unbindmoney` bigint, IN `in_zhenqi` bigint, IN `in_soul` int, IN `in_pk_mode` int, IN `in_pk_status` int,
			IN `in_pk_flags` int,IN `in_pk_evil` int,IN `in_redname_time` bigint, IN `in_grayname_time` bigint, IN `in_pk_count` int, IN `in_yao_hun` int,
			IN `in_arms` int, IN `in_dress` int, IN `in_online_time` int, IN `in_head` int, IN `in_suit` int, IN `in_weapon` int, IN `in_drop_val` int, IN `in_drop_lv` int, 
			IN `in_killtask_count` int, IN `in_onlinetime_day` int, IN `in_honor` int, IN `in_hearthstone_time` bigint, IN `in_lingzhi` int, IN `in_jingjie_exp` int, IN `in_vplan` int,
			IN `in_blesstime` bigint,IN `in_equipval` bigint, IN `in_wuhunid` int, IN `in_shenbingid` int,IN `in_extremityval` bigint, IN `in_wingid` int,
			IN `in_blesstime2` bigint,IN `in_blesstime3` bigint, IN `in_suitflag` int, IN `in_crossscore` int, IN `in_crossexploit` int, IN `in_crossseasonid` int, 
			IN `in_pvplevel` int, IN `in_sheild` bigint, IN `in_glorylevel` int, IN `in_gloryexp` int, IN `in_CuMoJiFen` int, IN `in_slayerQuestNum` int, 
			IN `in_magickey` int, IN `in_datangcnt` int, IN `in_luck_point` int)
BEGIN
INSERT INTO tb_player_info(charguid, name, level, exp, vip_level, vip_exp,
		power, hp, mp, hunli, tipo, shenfa, jingshen, 
		leftpoint, totalpoint, sp, max_sp, sp_recover,bindgold,
		unbindgold, bindmoney, unbindmoney,zhenqi, soul, pk_mode, pk_status,
		pk_flags, pk_evil, redname_time, grayname_time, pk_count, yao_hun, 
		arms, dress, online_time, head, suit, weapon, drop_val, drop_lv, 
		killtask_count, onlinetime_day, honor,hearthstone_time,lingzhi,jingjie_exp,
		vplan, blesstime,equipval, wuhunid, shenbingid,extremityval, wingid,
		blesstime2, blesstime3, suitflag, crossscore, crossexploit, crossseasonid, pvplevel, sheild, glorylevel, gloryexp,
		CuMoJiFen, slayerQuestNum, magickey, datangcnt,luck_point)
	VALUES (in_id, in_name, in_level, in_exp, in_vip_level, in_vip_exp,
		in_power, in_hp, in_mp, in_hunli, in_tipo, in_shenfa, in_jingshen, 
		in_leftpoint, in_totalpoint, in_sp, in_max_sp, in_sp_recover, in_bindgold, 
		in_unbindgold, in_bindmoney, in_unbindmoney, in_zhenqi, in_soul, in_pk_mode, in_pk_status,
		in_pk_flags,in_pk_evil, in_redname_time, in_grayname_time, in_pk_count, in_yao_hun, in_arms, 
		in_dress, in_online_time, in_head, in_suit, in_weapon, in_drop_val, in_drop_lv, in_killtask_count,
		in_onlinetime_day, in_honor,in_hearthstone_time,in_lingzhi,in_jingjie_exp,
		in_vplan, in_blesstime,in_equipval, in_wuhunid, in_shenbingid,in_extremityval, in_wingid, 
		in_blesstime2, in_blesstime3, in_suitflag, in_crossscore, in_crossexploit, in_crossseasonid, in_pvplevel, in_sheild, in_glorylevel, in_gloryexp, 
		in_CuMoJiFen, in_slayerQuestNum, in_magickey, in_datangcnt,in_luck_point) 
	ON DUPLICATE KEY UPDATE name=in_name, level=in_level, exp = in_exp, vip_level = in_vip_level, vip_exp = in_vip_exp,
		power=in_power, hp=in_hp, mp=in_mp, hunli=in_hunli, tipo=in_tipo, shenfa=in_shenfa, jingshen=in_jingshen, 
		leftpoint=in_leftpoint, totalpoint=in_totalpoint, sp = in_sp, max_sp = in_max_sp, sp_recover = in_sp_recover, bindgold=in_bindgold, 
		unbindgold=in_unbindgold, bindmoney=in_bindmoney, unbindmoney=in_unbindmoney, zhenqi=in_zhenqi, soul = in_soul, pk_mode=in_pk_mode, pk_status = in_pk_status,
		pk_flags = in_pk_flags, pk_evil = in_pk_evil, redname_time = in_redname_time, grayname_time = in_grayname_time, pk_count = in_pk_count, yao_hun=in_yao_hun,
		arms = in_arms, dress = in_dress, online_time = in_online_time, head = in_head, suit = in_suit, weapon = in_weapon, drop_val = in_drop_val, drop_lv = in_drop_lv, 
		killtask_count = in_killtask_count, onlinetime_day=in_onlinetime_day, honor = in_honor,hearthstone_time=in_hearthstone_time,lingzhi=in_lingzhi,jingjie_exp=in_jingjie_exp,vplan=in_vplan,
		blesstime = in_blesstime,equipval = in_equipval, wuhunid = in_wuhunid, shenbingid = in_shenbingid, extremityval = in_extremityval, wingid = in_wingid,
		blesstime2 = in_blesstime2, blesstime3 = in_blesstime3, suitflag = in_suitflag, crossscore = in_crossscore, crossexploit = in_crossexploit,
		crossseasonid = in_crossseasonid, pvplevel = in_pvplevel, sheild = in_sheild, glorylevel = in_glorylevel, gloryexp = in_gloryexp, 
		CuMoJiFen = in_CuMoJiFen, slayerQuestNum = in_slayerQuestNum, magickey = in_magickey, datangcnt = in_datangcnt, luck_point = in_luck_point;
END;;
#***************************************************************
##版本349修改完成
#***************************************************************

#***************************************************************
##版本350修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_select_hunlingxianyu`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_hunlingxianyu`;
CREATE PROCEDURE `sp_select_hunlingxianyu`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_hunlingxianyu where charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for `sp_insert_update_hunlingxianyu`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_hunlingxianyu`;
CREATE PROCEDURE `sp_insert_update_hunlingxianyu`(IN `in_charguid` bigint,IN `in_FinishLayer` int, IN `in_MyMaxLayer` int, IN `in_ResetNum` int)
BEGIN
	INSERT INTO tb_hunlingxianyu(charguid, FinishLayer, MyMaxLayer, ResetNum)
	VALUES (in_charguid,in_FinishLayer, in_MyMaxLayer, in_ResetNum) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid, 
	FinishLayer=in_FinishLayer,
	MyMaxLayer = in_MyMaxLayer,
	ResetNum = in_ResetNum;
END;;

-- ----------------------------
-- Procedure structure for `sp_select_hunlingxianyu_rank`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_hunlingxianyu_rank`;
CREATE PROCEDURE `sp_select_hunlingxianyu_rank`()
BEGIN
	SELECT * FROM tb_hunlingxianyu_rank;
END;;
-- ----------------------------
-- Procedure structure for `sp_insert_update_hunlingxianyu_rank`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_hunlingxianyu_rank`;
CREATE PROCEDURE `sp_insert_update_hunlingxianyu_rank`(IN `in_rank` int,IN `in_charguid` bigint, IN `in_player_name` varchar(32),IN `in_layer` int,IN `in_rank_time` bigint, IN `in_prof` int)
BEGIN
	INSERT INTO tb_hunlingxianyu_rank (rank, charguid, player_name, layer, rank_time, prof)
	VALUES (in_rank,in_charguid, in_player_name, in_layer, in_rank_time, in_prof) 
	ON DUPLICATE KEY UPDATE rank=in_rank, charguid=in_charguid, player_name = in_player_name, layer = in_layer, rank_time = in_rank_time, prof = in_prof;
END;;

-- ----------------------------
-- Procedure structure for `sp_select_player_info_by_ls`
-- ----------------------------
	DROP procedure IF EXISTS `sp_select_player_info_by_ls`;
	CREATE PROCEDURE `sp_select_player_info_by_ls`(IN `in_guid` bigint)
	BEGIN
		SELECT name, level, prof, iconid, power, vip_level, head, suit, weapon, wingid, suitflag, exts,
		    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
		    IFNULL((select use_level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as piFengLevel,
		    IFNULL((select curr_id from tb_player_guanzhi where charguid=tb_player_info.charguid limit 1),0) as guanzhi
		FROM tb_player_info 
		WHERE in_guid = charguid;
	END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_human_info_base`
-- ----------------------------
	DROP procedure IF EXISTS `sp_select_rank_human_info_base`;
	CREATE PROCEDURE `sp_select_rank_human_info_base`(IN `in_id` bigint)
	BEGIN
		SELECT charguid, name, prof, level, hp, mp, power, vip_level, sex, dress, glorylevel,
		arms, head, suit, weapon, hunli, tipo, shenfa, jingshen, vplan, wingid, shenbingid, suitflag,crossscore,
		    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
		    IFNULL((select use_level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as piFengLevel,
		    IFNULL((select curr_id from tb_player_guanzhi where charguid=tb_player_info.charguid limit 1),0) as guanzhi
		FROM tb_player_info WHERE charguid = in_id;
	END;;
#***************************************************************
##版本350修改完成
#***************************************************************
#***************************************************************
##版本351修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_info_insert_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_info_insert_update`;
CREATE PROCEDURE `sp_player_info_insert_update`(IN `in_id` bigint,  IN `in_name` varchar(32), IN `in_level` int, IN `in_exp` bigint, IN `in_vip_level` int, IN `in_vip_exp` int,
			IN `in_power` bigint, IN `in_hp` int, IN `in_mp` int, IN `in_hunli` int, IN `in_tipo` int, IN `in_shenfa` int, IN `in_jingshen` int, 
			IN `in_leftpoint` int, IN `in_totalpoint` int, IN `in_sp` int, IN `in_max_sp` int, IN `in_sp_recover` int, IN `in_bindgold` bigint, 
			IN `in_unbindgold` bigint, IN `in_bindmoney` bigint, IN `in_unbindmoney` bigint, IN `in_zhenqi` bigint, IN `in_soul` int, IN `in_pk_mode` int, IN `in_pk_status` int,
			IN `in_pk_flags` int,IN `in_pk_evil` int,IN `in_redname_time` bigint, IN `in_grayname_time` bigint, IN `in_pk_count` int, IN `in_yao_hun` int,
			IN `in_arms` int, IN `in_dress` int, IN `in_online_time` int, IN `in_head` int, IN `in_suit` int, IN `in_weapon` int, IN `in_drop_val` int, IN `in_drop_lv` int, 
			IN `in_killtask_count` int, IN `in_onlinetime_day` int, IN `in_honor` int, IN `in_hearthstone_time` bigint, IN `in_lingzhi` int, IN `in_jingjie_exp` int, IN `in_vplan` int,
			IN `in_blesstime` bigint,IN `in_equipval` bigint, IN `in_wuhunid` int, IN `in_shenbingid` int,IN `in_extremityval` bigint, IN `in_wingid` int,
			IN `in_blesstime2` bigint,IN `in_blesstime3` bigint, IN `in_suitflag` int, IN `in_crossscore` int, IN `in_crossexploit` int, IN `in_crossseasonid` int, 
			IN `in_pvplevel` int, IN `in_sheild` bigint, IN `in_glorylevel` int, IN `in_gloryexp` int, IN `in_CuMoJiFen` int, IN `in_slayerQuestNum` int, 
			IN `in_magickey` int, IN `in_datangcnt` int, IN `in_luck_point` int, IN `in_txvipflag` int, IN `in_txbvipflag` int)
BEGIN
INSERT INTO tb_player_info(charguid, name, level, exp, vip_level, vip_exp,
		power, hp, mp, hunli, tipo, shenfa, jingshen, 
		leftpoint, totalpoint, sp, max_sp, sp_recover,bindgold,
		unbindgold, bindmoney, unbindmoney,zhenqi, soul, pk_mode, pk_status,
		pk_flags, pk_evil, redname_time, grayname_time, pk_count, yao_hun, 
		arms, dress, online_time, head, suit, weapon, drop_val, drop_lv, 
		killtask_count, onlinetime_day, honor,hearthstone_time,lingzhi,jingjie_exp,
		vplan, blesstime,equipval, wuhunid, shenbingid,extremityval, wingid,
		blesstime2, blesstime3, suitflag, crossscore, crossexploit, crossseasonid, pvplevel, sheild, glorylevel, gloryexp,
		CuMoJiFen, slayerQuestNum, magickey, datangcnt,luck_point, txvipflag, txbvipflag)
	VALUES (in_id, in_name, in_level, in_exp, in_vip_level, in_vip_exp,
		in_power, in_hp, in_mp, in_hunli, in_tipo, in_shenfa, in_jingshen, 
		in_leftpoint, in_totalpoint, in_sp, in_max_sp, in_sp_recover, in_bindgold, 
		in_unbindgold, in_bindmoney, in_unbindmoney, in_zhenqi, in_soul, in_pk_mode, in_pk_status,
		in_pk_flags,in_pk_evil, in_redname_time, in_grayname_time, in_pk_count, in_yao_hun, in_arms, 
		in_dress, in_online_time, in_head, in_suit, in_weapon, in_drop_val, in_drop_lv, in_killtask_count,
		in_onlinetime_day, in_honor,in_hearthstone_time,in_lingzhi,in_jingjie_exp,
		in_vplan, in_blesstime,in_equipval, in_wuhunid, in_shenbingid,in_extremityval, in_wingid, 
		in_blesstime2, in_blesstime3, in_suitflag, in_crossscore, in_crossexploit, in_crossseasonid, in_pvplevel, in_sheild, in_glorylevel, in_gloryexp, 
		in_CuMoJiFen, in_slayerQuestNum, in_magickey, in_datangcnt,in_luck_point, in_txvipflag, in_txbvipflag) 
	ON DUPLICATE KEY UPDATE name=in_name, level=in_level, exp = in_exp, vip_level = in_vip_level, vip_exp = in_vip_exp,
		power=in_power, hp=in_hp, mp=in_mp, hunli=in_hunli, tipo=in_tipo, shenfa=in_shenfa, jingshen=in_jingshen, 
		leftpoint=in_leftpoint, totalpoint=in_totalpoint, sp = in_sp, max_sp = in_max_sp, sp_recover = in_sp_recover, bindgold=in_bindgold, 
		unbindgold=in_unbindgold, bindmoney=in_bindmoney, unbindmoney=in_unbindmoney, zhenqi=in_zhenqi, soul = in_soul, pk_mode=in_pk_mode, pk_status = in_pk_status,
		pk_flags = in_pk_flags, pk_evil = in_pk_evil, redname_time = in_redname_time, grayname_time = in_grayname_time, pk_count = in_pk_count, yao_hun=in_yao_hun,
		arms = in_arms, dress = in_dress, online_time = in_online_time, head = in_head, suit = in_suit, weapon = in_weapon, drop_val = in_drop_val, drop_lv = in_drop_lv, 
		killtask_count = in_killtask_count, onlinetime_day=in_onlinetime_day, honor = in_honor,hearthstone_time=in_hearthstone_time,lingzhi=in_lingzhi,jingjie_exp=in_jingjie_exp,vplan=in_vplan,
		blesstime = in_blesstime,equipval = in_equipval, wuhunid = in_wuhunid, shenbingid = in_shenbingid, extremityval = in_extremityval, wingid = in_wingid,
		blesstime2 = in_blesstime2, blesstime3 = in_blesstime3, suitflag = in_suitflag, crossscore = in_crossscore, crossexploit = in_crossexploit,
		crossseasonid = in_crossseasonid, pvplevel = in_pvplevel, sheild = in_sheild, glorylevel = in_glorylevel, gloryexp = in_gloryexp, 
		CuMoJiFen = in_CuMoJiFen, slayerQuestNum = in_slayerQuestNum, magickey = in_magickey, datangcnt = in_datangcnt, luck_point = in_luck_point,
		txvipflag = in_txvipflag, txbvipflag = in_txbvipflag;
END;;

-- ----------------------------
-- Procedure structure for sp_exchange_record_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_exchange_record_insert_update`;
CREATE PROCEDURE `sp_exchange_record_insert_update`(IN `in_order_id` varchar(64), IN `in_uid` varchar(64), IN `in_role_id` bigint, 
	IN `in_platform` int, IN `in_money` int, IN `in_coins` int, IN `in_time` int, IN `in_recharge` int)
BEGIN
  INSERT INTO tb_exchange_record(order_id, uid, role_id, platform, money, coins, time, recharge)
  VALUES (in_order_id, in_uid, in_role_id, in_platform, in_money, in_coins, in_time, in_recharge);
END;;

-- ----------------------------
-- Procedure structure for sp_player_txvip_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_txvip_select_by_id`;
CREATE PROCEDURE `sp_player_txvip_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_txvip WHERE charguid=in_charguid;
END ;;

-- ----------------------------
-- Procedure structure for `sp_select_simple_user_info`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_simple_user_info`;
CREATE PROCEDURE `sp_select_simple_user_info`(IN `in_guid` bigint)
BEGIN
	SELECT tb_player_info.charguid as charguid, name, prof, iconid, 
	level, power, arms, dress, head, suit, weapon, valid, 
	forb_chat_time, forb_chat_last, forb_acc_time, forb_acc_last, 
	UNIX_TIMESTAMP(tb_account.last_logout) as last_logout, account, vip_level, vplan, wuhunid, shenbingid, wingid, suitflag, glorylevel, txvipflag, txbvipflag from tb_player_info 
	left join tb_account
	on tb_player_info.account_id = tb_account.account_id
	where tb_player_info.charguid = in_guid;
END;;

-- ----------------------------
-- Procedure structure for `sp_select_rank_human_info_base`
-- ----------------------------
DROP procedure IF EXISTS `sp_select_rank_human_info_base`;
CREATE PROCEDURE `sp_select_rank_human_info_base`(IN `in_id` bigint)
BEGIN
	SELECT charguid, name, prof, level, hp, mp, power, vip_level, sex, dress, glorylevel,
	arms, head, suit, weapon, hunli, tipo, shenfa, jingshen, vplan, wingid, shenbingid, suitflag,crossscore,txvipflag, txbvipflag,
	    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
	    IFNULL((select use_level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as piFengLevel,
	    IFNULL((select curr_id from tb_player_guanzhi where charguid=tb_player_info.charguid limit 1),0) as guanzhi
	FROM tb_player_info WHERE charguid = in_id;
END;;

-- ----------------------------
-- Procedure structure for sp_player_txvip_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_txvip_insert_update`;
CREATE PROCEDURE `sp_player_txvip_insert_update`(IN `in_charguid` bigint, IN `in_dayflag` int, IN `in_dayyearflag` int, IN `in_newflag` int
, IN `in_levelflag` varchar(128), IN `in_bdayflag` int, IN `in_bdayyearflag` int, IN `in_bdayhighflag` int, IN `in_bnewflag` int, IN `in_blevelflag` varchar(128),
IN `in_tgpdayflag` int, IN `in_tgpweekflag` int, IN `in_tgpnewflag` int, IN `in_tgplevelflag` varchar(128),
IN `in_gamedayflag` int, IN `in_gameweekflag` int, IN `in_gamenewflag` int, IN `in_gamelevelflag` varchar(128),
IN `in_seven_day_login` int, IN `in_cont_login_day` int, IN `in_channel_id` int, IN `in_bhlflag` int,
IN `in_zonedayflag` int, IN `in_zoneweekflag` int, IN `in_zonenewflag` int, IN `in_zonelevelflag` varchar(128))
BEGIN
	INSERT INTO tb_player_txvip(charguid, dayflag, dayyearflag, newflag, levelflag,
		bdayflag, bdayyearflag, bdayhighflag, bnewflag, blevelflag,
		tgpdayflag, tgpweekflag, tgpnewflag, tgplevelflag,
		gamedayflag, gameweekflag, gamenewflag, gamelevelflag,
		seven_day_login, cont_login_day, channel_id, bhlflag,
		zonedayflag, zoneweekflag, zonenewflag, zonelevelflag)
	VALUES (in_charguid, in_dayflag, in_dayyearflag, in_newflag, in_levelflag,
		in_bdayflag, in_bdayyearflag, in_bdayhighflag, in_bnewflag, in_blevelflag,
		in_tgpdayflag, in_tgpweekflag, in_tgpnewflag, in_tgplevelflag,
		in_gamedayflag, in_gameweekflag, in_gamenewflag, in_gamelevelflag,
		in_seven_day_login, in_cont_login_day, in_channel_id, in_bhlflag,
		in_zonedayflag, in_zoneweekflag, in_zonenewflag, in_zonelevelflag)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, dayflag = in_dayflag, dayyearflag = in_dayyearflag, newflag = in_newflag, levelflag = in_levelflag,
	bdayflag = in_bdayflag, bdayyearflag = in_bdayyearflag, bdayhighflag = in_bdayhighflag, bnewflag = in_bnewflag, blevelflag = in_blevelflag,
	tgpdayflag = in_tgpdayflag, tgpweekflag = in_tgpweekflag, tgpnewflag = in_tgpnewflag, tgplevelflag = in_tgplevelflag,
	gamedayflag = in_gamedayflag, gameweekflag = in_gameweekflag, gamenewflag = in_gamenewflag, gamelevelflag = in_gamelevelflag,
	seven_day_login = in_seven_day_login, cont_login_day = in_cont_login_day, channel_id = in_channel_id, bhlflag = in_bhlflag,
	zonedayflag = in_zonedayflag, zoneweekflag = in_zoneweekflag, zonenewflag = in_zonenewflag, zonelevelflag = in_zonelevelflag;
END ;;
#***************************************************************
##版本351修改完成
#***************************************************************

#***************************************************************
##版本352修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_zhiyuanfb_delete_by_id_and_timestamp`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhiyuanfb_delete_by_id_and_timestamp`;
CREATE PROCEDURE `sp_player_zhiyuanfb_delete_by_id_and_timestamp`(IN `in_charguid` bigint, IN `in_time_stamp` bigint)
BEGIN
  DELETE FROM `tb_player_zhiyuanfb` where charguid = in_charguid AND time_stamp <> in_time_stamp;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_zhiyuanfb_insert_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhiyuanfb_insert_update`;
CREATE PROCEDURE `sp_player_zhiyuanfb_insert_update`(IN `in_charguid` bigint, IN `in_level` int, IN `in_level_star` int, 
IN `in_challenge` int, IN `in_sweep_state` int, IN `in_sweep_time` bigint, IN `in_sweep_times` int, IN `in_time_stamp` bigint, IN `in_star_state` int)
BEGIN
	INSERT INTO tb_player_zhiyuanfb(charguid, level, level_star, challenge, sweep_state, sweep_time, sweep_times,time_stamp,star_state)
	VALUES (in_charguid, in_level, in_level_star, in_challenge, in_sweep_state, in_sweep_time, in_sweep_times,in_time_stamp,in_star_state) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid, level=in_level, level_star=in_level_star, challenge=in_challenge, 
	sweep_state=in_sweep_state, sweep_time=in_sweep_time, sweep_times=in_sweep_times, time_stamp = in_time_stamp, star_state = in_star_state;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_zhiyuanfbbox_insert_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhiyuanfbbox_insert_update`;
CREATE PROCEDURE `sp_player_zhiyuanfbbox_insert_update`(IN `in_charguid` bigint, IN `in_road_box` varchar(32), IN `in_buy_num` int, IN `in_tick` int,
IN `in_challenge_count` int, IN `in_roadlv_max` int)
BEGIN
	INSERT INTO tb_zhiyuanfb_box(charguid, road_box, buy_num, tick, challenge_count, roadlv_max)
	VALUES (in_charguid, in_road_box, in_buy_num, in_tick, in_challenge_count, in_roadlv_max)
	ON DUPLICATE KEY UPDATE charguid=in_charguid, road_box=in_road_box, buy_num=in_buy_num, tick = in_tick,
	 challenge_count = in_challenge_count, roadlv_max = in_roadlv_max;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_select_zhiyuanfb`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_select_zhiyuanfb`;
CREATE PROCEDURE `sp_player_select_zhiyuanfb`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_zhiyuanfb WHERE charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_select_zhiyuanfbbox`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_select_zhiyuanfbbox`;
CREATE PROCEDURE `sp_player_select_zhiyuanfbbox`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_zhiyuanfb_box WHERE charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_extra_insert_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_extra_insert_update`;
CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(256), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(256), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(350),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int, IN `in_draw_cnt` int, IN `in_vitality_vip` int)
BEGIN
	INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate,draw_cnt,vitality_vip)
	VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate, in_draw_cnt,in_vitality_vip)
	ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, petstate = in_petstate,draw_cnt=in_draw_cnt, vitality_vip = in_vitality_vip;
END;;
#***************************************************************
##版本352修改完成
#***************************************************************
#***************************************************************
##版本353修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_licai_insert_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_licai_insert_update`;
CREATE PROCEDURE `sp_player_licai_insert_update`(IN `in_charguid` bigint, IN `in_id` int, IN `in_param1` bigint, IN `in_param2` bigint, IN `in_reward` varchar(256))
BEGIN
	INSERT INTO tb_player_licai(charguid, id, param1, param2, reward)
	VALUES (in_charguid, in_id, in_param1, in_param2, in_reward)
	ON DUPLICATE KEY UPDATE charguid=in_charguid, id=in_id, param1=in_param1, param2 = in_param2,
	 reward = in_reward;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_select_licai`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_select_licai`;
CREATE PROCEDURE `sp_player_select_licai`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_licai WHERE charguid = in_charguid;
END;;
#***************************************************************
##版本353修改完成
#***************************************************************
#***************************************************************
##版本354修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_xiuwei_insert_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_xiuwei_insert_update`;
CREATE PROCEDURE `sp_player_xiuwei_insert_update`(IN `in_charguid` bigint, IN `in_group` int, IN `in_level` int)
BEGIN
	INSERT INTO tb_player_xiuwei(charguid, `group`, `level`)
	VALUES (in_charguid, in_group, in_level)
	ON DUPLICATE KEY UPDATE `group`=in_group, `level`=in_level;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_select_xiuwei`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_select_xiuwei`;
CREATE PROCEDURE `sp_player_select_xiuwei`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_xiuwei WHERE charguid = in_charguid;
END;;
#***************************************************************
##版本354修改完成
#***************************************************************
#***************************************************************
##版本355修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_insert_update_hongyan`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_insert_update_hongyan`;
CREATE PROCEDURE `sp_player_insert_update_hongyan`(IN `in_charguid` bigint, IN `in_hy_id` int,IN `in_jiandian` int,IN `in_jiandian_level` int,
IN `in_jihuo` int,IN `in_level` int,IN `in_star` int,IN `in_wish` int,IN `in_chu_zhan` int,IN `in_starlevel` int)
BEGIN
	INSERT INTO tb_player_hongyan(charguid, hongyan_id, jiedian, jiedian_level, is_jihuo, level, star, wish, chu_zhan, starlevel)
	VALUES (in_charguid, in_hy_id, in_jiandian, in_jiandian_level, in_jihuo, in_level, in_star, in_wish, in_chu_zhan, in_starlevel)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, hongyan_id = in_hy_id, jiedian = in_jiandian,	jiedian_level = in_jiandian_level, 
	is_jihuo = in_jihuo, level = in_level, star = in_star, wish = in_wish, chu_zhan = in_chu_zhan, starlevel = in_starlevel;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_select_hongyan`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_select_hongyan`;
CREATE PROCEDURE `sp_player_select_hongyan`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_hongyan where charguid = in_charguid;
END;;
#***************************************************************
##版本355修改完成
#***************************************************************

#***************************************************************
##版本356修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_insert_update_player_personboss`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_player_personboss`;
CREATE PROCEDURE `sp_insert_update_player_personboss`(IN `in_charguid` bigint, IN `in_id` int,
IN `in_cur_count` int, IN `in_first` int, IN `in_time_stamp` bigint, IN `in_exit_time` bigint)
BEGIN
	INSERT INTO tb_player_personboss(charguid, id, cur_count, first, time_stamp, exit_time)
	VALUES (in_charguid, in_id, in_cur_count, in_first, in_time_stamp, in_exit_time) 
	ON DUPLICATE KEY UPDATE charguid = in_charguid, id = in_id,	cur_count = in_cur_count, first = in_first,
	 time_stamp = in_time_stamp, exit_time=in_exit_time;
END;;
#***************************************************************
##版本356修改完成
#***************************************************************
#***************************************************************
##版本358修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_insert_update_nei_gong`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_nei_gong`;
CREATE PROCEDURE `sp_insert_update_nei_gong`(IN in_charguid bigint, IN in_id int, IN in_NodeID int, IN in_NodeLevel int, IN in_GroupID int)
BEGIN
	INSERT INTO `tb_nei_gong` (`charguid`, `Id`, `NodeID`, `NodeLevel`, `GroupID`) 
    VALUES (in_charguid, in_id, in_NodeID, in_NodeLevel, in_GroupID)
    ON DUPLICATE KEY UPDATE charguid=in_charguid, Id=in_Id,
	NodeID = in_NodeID,	NodeLevel = in_NodeLevel, GroupID=in_GroupID;
END;;
#***************************************************************
##版本358修改完成
#***************************************************************
#***************************************************************
##版本359修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_pifeng_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_pifeng_insert_update`;
CREATE PROCEDURE `sp_player_pifeng_insert_update`(IN `in_charguid` bigint, IN `in_level` int, IN `in_wish` int, IN `in_use_level` int, IN `in_attr_dan` int,IN `in_AllNum` int, IN `in_KeLingQuNum` int, IN `in_YiLingQuNum` int)
BEGIN
	INSERT INTO tb_player_pifeng(charguid, level, wish, use_level, attr_dan, AllNum, KeLingQuNum, YiLingQuNum)
	VALUES (in_charguid, in_level, in_wish, in_use_level, in_attr_dan, in_AllNum, in_KeLingQuNum, in_YiLingQuNum)
	ON DUPLICATE KEY UPDATE level=in_level, wish=in_wish, use_level=in_use_level, attr_dan=in_attr_dan, AllNum=in_AllNum, KeLingQuNum=in_KeLingQuNum, YiLingQuNum=in_YiLingQuNum;
END;;
#***************************************************************
##版本359修改完成
#***************************************************************
#***************************************************************
##版本360修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_insert_update_guild`
-- ----------------------------
DROP procedure IF EXISTS `sp_insert_update_guild`;
CREATE PROCEDURE `sp_insert_update_guild`(IN `in_gid` bigint, IN `in_capital` double, IN `in_name` varchar(50), IN `in_notice` varchar(256), IN `in_level` int,
IN `in_flag` int, IN `in_count1` int, IN `in_count2` int, IN `in_count3` int, IN `in_create_time` bigint, IN `in_alianceid` bigint, IN `in_liveness` int,
IN `in_extendnum` int, IN `in_statuscnt` int,IN `in_is_first` int)
BEGIN
	INSERT INTO tb_guild(gid, capital, name, notice, level, flag, count1, count2, count3, create_time, alianceid, liveness, extendnum, statuscnt, is_first)
	VALUES (in_gid, in_capital, in_name, in_notice, in_level, in_flag, in_count1, in_count2, in_count3, in_create_time, in_alianceid, in_liveness, in_extendnum, in_statuscnt, in_is_first)
	ON DUPLICATE KEY UPDATE gid = in_gid, capital = in_capital, name = in_name, notice = in_notice, level = in_level, 
	flag = in_flag, count1 = in_count1, count2 = in_count2, count3 = in_count3, create_time=in_create_time, alianceid=in_alianceid, 
	liveness = in_liveness, extendnum = in_extendnum, statuscnt = in_statuscnt, is_first = in_is_first;
END;;
#***************************************************************
##版本360修改完成
#***************************************************************

#***************************************************************
##版本361修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_history_select`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_history_select`;
CREATE PROCEDURE `sp_player_history_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_history where charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_history_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_history_insert_update`;
CREATE PROCEDURE `sp_player_history_insert_update`(IN in_charguid bigint,IN in_day_1 bigint,in_level_1 int,IN in_lingshoumudi_1 int,IN in_secret_1 int,IN in_zhuzairoad_1 int,IN in_day_2 bigint,IN in_level_2 int,IN in_lingshoumudi_2 int,IN in_secret_2 int,IN in_zhuzairoad_2 int)
BEGIN
	INSERT INTO tb_player_history(charguid,day_1,level_1,lingshoumudi_1,secret_1,zhuzairoad_1,day_2,level_2,lingshoumudi_2,secret_2,zhuzairoad_2)
	VALUES (in_charguid,in_day_1,in_level_1,in_lingshoumudi_1,in_secret_1,in_zhuzairoad_1,in_day_2,in_level_2,in_lingshoumudi_2,in_secret_2,in_zhuzairoad_2)
	ON DUPLICATE KEY UPDATE charguid=in_charguid,day_1=in_day_1,level_1=in_level_1,lingshoumudi_1=in_lingshoumudi_1,secret_1=in_secret_1,zhuzairoad_1=in_zhuzairoad_1,day_2=in_day_2,level_2=in_level_2,lingshoumudi_2=in_lingshoumudi_2,secret_2=in_secret_2,zhuzairoad_2=in_zhuzairoad_2;
END;;
#***************************************************************
##版本361修改完成
#***************************************************************
#***************************************************************
##版本362修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_rank_xiuwei`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_rank_xiuwei`;
CREATE PROCEDURE `sp_rank_xiuwei` ()
BEGIN
SELECT a.charguid AS uid, a.glorylevel AS rankvalue FROM tb_player_info as a left join tb_player_info as b
on a.charguid = b.charguid WHERE a.glorylevel > 0 ORDER BY a.glorylevel DESC, b.gloryexp DESC, b.power DESC LIMIT 100;
END;;
-- ----------------------------
-- Procedure structure for `sp_update_rank_xiuwei`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_rank_xiuwei`;
CREATE PROCEDURE `sp_update_rank_xiuwei`(IN `in_rank` int, IN `in_charguid` bigint, IN `in_lastrank` int, IN `in_rankvalue` bigint)
BEGIN
	INSERT INTO tb_rank_xiuwei(rank, charguid, lastrank, rankvalue)
	VALUES (in_rank, in_charguid, in_lastrank, in_rankvalue)
	ON DUPLICATE KEY UPDATE rank = in_rank, charguid = in_charguid, lastrank = in_lastrank, rankvalue = in_rankvalue;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_xiuwei`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_xiuwei`;
CREATE PROCEDURE `sp_select_rank_xiuwei`()
BEGIN
	SELECT * FROM tb_rank_xiuwei;
END;;
#***************************************************************
##版本362修改完成
#***************************************************************
#***************************************************************
##版本363修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_zhiyuanfbbox_insert_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhiyuanfbbox_insert_update`;
CREATE PROCEDURE `sp_player_zhiyuanfbbox_insert_update`(IN `in_charguid` bigint, IN `in_road_box` varchar(32), IN `in_buy_num` int, IN `in_tick` int,
IN `in_challenge_count` bigint, IN `in_roadlv_max` int)
BEGIN
	INSERT INTO tb_zhiyuanfb_box(charguid, road_box, buy_num, tick, challenge_count, roadlv_max)
	VALUES (in_charguid, in_road_box, in_buy_num, in_tick, in_challenge_count, in_roadlv_max)
	ON DUPLICATE KEY UPDATE charguid=in_charguid, road_box=in_road_box, buy_num=in_buy_num, tick = in_tick,
	 challenge_count = in_challenge_count, roadlv_max = in_roadlv_max;
END;;
#***************************************************************
##版本363修改完成
#***************************************************************
#***************************************************************
##版本364修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_cross_boss_history
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_cross_boss_history`;
CREATE PROCEDURE `sp_select_cross_boss_history`()
BEGIN
	select * from tb_crossboss_history;
END;;
-- ----------------------------
-- Procedure structure for sp_update_cross_boss_history
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_cross_boss_history`;
CREATE PROCEDURE `sp_update_cross_boss_history`(IN `in_id` int, IN `in_avglv` int, 
	IN `in_firstname1` varchar(32), IN `in_killname1` varchar(32),
	IN `in_firstname2` varchar(32), IN `in_killname2` varchar(32),
	IN `in_firstname3` varchar(32), IN `in_killname3` varchar(32),
	IN `in_firstname4` varchar(32), IN `in_killname4` varchar(32),
	IN `in_firstname5` varchar(32), IN `in_killname5` varchar(32))
BEGIN
	INSERT INTO tb_crossboss_history(id, avglv, firstname1, killname1, firstname2, killname2, firstname3, killname3, firstname4, killname4, firstname5, killname5)
	VALUES (in_id, in_avglv, in_firstname1, in_killname1, in_firstname2, in_killname2, in_firstname3, in_killname3, in_firstname4, in_killname4, in_firstname5, in_killname5) 
	ON DUPLICATE KEY UPDATE id=in_id, avglv=in_avglv, firstname1=in_firstname1, killname1=in_killname1, firstname2=in_firstname2, killname2=in_killname2
	, firstname3=in_firstname3, killname3=in_killname3, firstname4=in_firstname4, killname4=in_killname4, firstname5=in_firstname5, killname5=in_killname5;
END;;
-- ----------------------------
-- Procedure structure for sp_select_all_arena_history()
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_all_arena_history`;
CREATE PROCEDURE `sp_select_all_arena_history`()
BEGIN
	SELECT * FROM tb_crossarena_history;
END;;

-- ----------------------------
-- Procedure structure for sp_update_cross_arena_history()
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_cross_arena_history`;
CREATE PROCEDURE `sp_update_cross_arena_history`(IN `in_seasonid` int, IN `in_arenaid` int, IN `in_name` varchar(64), IN `in_prof` int, IN `in_power` bigint(20))
BEGIN
  INSERT INTO tb_crossarena_history(seasonid, arenaid, name, prof, power)
  VALUES (in_seasonid, in_arenaid, in_name, in_prof, in_power) 
  ON DUPLICATE KEY UPDATE seasonid=in_seasonid, arenaid=in_arenaid, name=in_name, prof=in_prof, power=in_power;
END;;

-- ----------------------------
-- Procedure structure for sp_select_cross_arena_xiazhu
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_cross_arena_xiazhu`;
CREATE PROCEDURE `sp_select_cross_arena_xiazhu`(IN `in_seasonid` int)
BEGIN
	SELECT * FROM tb_crossarena_xiazhu WHERE seasonid = in_seasonid;
END;;

-- ----------------------------
-- Procedure structure for sp_update_cross_arena_xiazhu
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_cross_arena_xiazhu`;
CREATE PROCEDURE `sp_update_cross_arena_xiazhu`(IN `in_charguid` bigint, IN `in_seasonid` int, IN `in_targetguid` bigint, IN `in_xiazhunum` int)
BEGIN
	INSERT INTO tb_crossarena_xiazhu(charguid, seasonid, targetguid, xiazhunum)
	VALUES (in_charguid, in_seasonid, in_targetguid, in_xiazhunum) 
	ON DUPLICATE KEY UPDATE charguid = in_charguid, seasonid = in_seasonid,	targetguid = in_targetguid, xiazhunum = in_xiazhunum;
END;;

-- ----------------------------
-- Procedure structure for sp_delete_cross_arena_xiazhu
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_delete_cross_arena_xiazhu`;
CREATE PROCEDURE `sp_delete_cross_arena_xiazhu`(IN `in_seasonid` int)
BEGIN
	DELETE FROM tb_crossarena_xiazhu WHERE seasonid = in_seasonid;
END;;

-- ----------------------------
-- Procedure structure for sp_player_crosstask_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_crosstask_insert_update`;
CREATE PROCEDURE `sp_player_crosstask_insert_update`(IN `in_charguid` bigint,IN `in_quest_id` int, IN `in_questgid` bigint,
IN `in_quest_state` int, IN `in_goal1` bigint, IN `in_goal_count1` int, IN `in_time_stamp` bigint)
BEGIN
	INSERT INTO tb_player_crosstask(charguid,quest_id,questgid,quest_state,goal1,goal_count1,time_stamp)
	VALUES (in_charguid,in_quest_id,in_questgid,in_quest_state,in_goal1,in_goal_count1,in_time_stamp)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, quest_id = in_quest_id, questgid = in_questgid, 
	quest_state = in_quest_state, goal1 = in_goal1, goal_count1 = in_goal_count1, time_stamp = in_time_stamp;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_crosstask_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_crosstask_select_by_id`;
CREATE PROCEDURE `sp_player_crosstask_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_crosstask WHERE charguid=in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_crosstask_delete_by_id_and_timestamp
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_crosstask_delete_by_id_and_timestamp`;
CREATE PROCEDURE `sp_player_crosstask_delete_by_id_and_timestamp`(IN `in_charguid` bigint, IN `in_time_stamp` bigint)
BEGIN
  DELETE FROM tb_player_crosstask WHERE charguid = in_charguid AND time_stamp <> in_time_stamp;
END;;
-- ----------------------------
-- Procedure structure for sp_player_crosstask_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_crosstask_extra_insert_update`;
CREATE PROCEDURE `sp_player_crosstask_extra_insert_update`(IN `in_charguid` bigint,IN `in_score` int, IN `in_onlinetime` int,
IN `in_refreshtimes` int, IN `in_lastrefreshtime` bigint, IN `in_questlist` varchar(128))
BEGIN
	INSERT INTO tb_player_crosstask_extra(charguid,score,onlinetime,refreshtimes,lastrefreshtime,questlist)
	VALUES (in_charguid,in_score,in_onlinetime,in_refreshtimes,in_lastrefreshtime,in_questlist)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, score = in_score, onlinetime = in_onlinetime, 
	refreshtimes = in_refreshtimes, lastrefreshtime = in_lastrefreshtime, questlist = in_questlist;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_crosstask_extra_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_crosstask_extra_select_by_id`;
CREATE PROCEDURE `sp_player_crosstask_extra_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_crosstask_extra WHERE charguid=in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_military_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_military_insert_update`;
CREATE PROCEDURE `sp_player_military_insert_update`(IN `in_charguid` bigint, IN `in_level` int, IN `in_exploit` int, 
	IN `in_todayexploit` int, IN `in_flag` int, IN `in_updatetime` bigint)
BEGIN                                                                                                                                                                                                                                                                                         
	INSERT INTO tb_player_military(charguid, level, exploit, todayexploit, flag, updatetime)
	VALUES (in_charguid, in_level, in_exploit, in_todayexploit, in_flag, in_updatetime)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, level = in_level, exploit = in_exploit,
	todayexploit = in_todayexploit, flag = in_flag, updatetime = in_updatetime;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_military_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_military_select_by_id`;
CREATE PROCEDURE `sp_player_military_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_military WHERE charguid=in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_military_rank
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_military_rank`;
CREATE PROCEDURE `sp_player_military_rank`()
BEGIN
	SELECT tb_player_info.charguid as charguid, name, prof, 
	tb_player_info.level as level, arms, dress, head, suit, weapon, vip_level, wuhunid, wingid, suitflag, tb_player_military.todayexploit as todayexploit from tb_player_military 
	left join tb_player_info
	on tb_player_info.charguid = tb_player_military.charguid
	where tb_player_military.exploit > 0 and tb_player_military.todayexploit > 0 
	ORDER BY tb_player_military.todayexploit DESC, tb_player_military.updatetime DESC, tb_player_info.power DESC LIMIT 10;
END ;;

DROP PROCEDURE IF EXISTS `sp_insert_update_arena_att`;
CREATE PROCEDURE `sp_insert_update_arena_att`(IN `in_charguid` bigint, IN `in_atk` double, IN `in_hp` double, IN `in_hit` double, IN `in_dodge` double, IN `in_subdef` double
, IN `in_def` double, IN `in_cri` double, IN `in_crivalue` double, IN `in_absatk` double, IN `in_defcri` double, IN `in_subcri` double, IN `in_parryvalue` double
, IN `in_dmgsub` double, IN `in_dmgadd` double, IN `in_skill1` int, IN `in_skill2` int, IN `in_skill3` int, IN `in_skill4` int, IN `in_skill5` int, IN `in_skill6` int
, IN `in_skill7` int, IN `in_skill8` int, IN `in_skill9` int, IN `in_skill10` int, IN `in_parryrate` double, IN `in_supper` double, IN `in_suppervalue` double)
BEGIN
  INSERT INTO tb_arena_att(charguid, atk, hp, hit, dodge, subdef, def, cri, crivalue, absatk, defcri, subcri, parryvalue, dmgsub, dmgadd,
	skill1, skill2, skill3, skill4, skill5, skill6, skill7, skill8, skill9, skill10, parryrate, supper, suppervalue)
	VALUES (in_charguid, in_atk, in_hp, in_hit, in_dodge, in_subdef, in_def, in_cri, in_crivalue, in_absatk, in_defcri,
	in_subcri, in_parryvalue, in_dmgsub, in_dmgadd, in_skill1, in_skill2, in_skill3, in_skill4, in_skill5, in_skill6,
	in_skill7, in_skill8, in_skill9, in_skill10, in_parryrate, in_supper, in_suppervalue)
	ON DUPLICATE KEY UPDATE charguid=in_charguid, atk=in_atk, hp=in_hp, hit=in_hit, dodge=in_dodge, 
	subdef=in_subdef, def=in_def, cri=in_cri, crivalue=in_crivalue, absatk=in_absatk, defcri=in_defcri, subcri=in_subcri, parryvalue=in_parryvalue,
	dmgsub=in_dmgsub, dmgadd=in_dmgadd, skill1=in_skill1, skill2=in_skill2, skill3=in_skill3, skill4=in_skill4, skill5=in_skill5, skill6=in_skill6,
	skill7=in_skill7, skill8=in_skill8, skill9=in_skill9, skill10=in_skill10, parryrate=in_parryrate, supper=in_supper, suppervalue=in_suppervalue;
END;;

#***************************************************************
##版本364修改完成
#***************************************************************
#***************************************************************
##版本365修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_txvip_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_txvip_insert_update`;
CREATE PROCEDURE `sp_player_txvip_insert_update`(IN `in_charguid` bigint, IN `in_dayflag` int, IN `in_dayyearflag` int, IN `in_newflag` int
, IN `in_levelflag` varchar(128), IN `in_bdayflag` int, IN `in_bdayyearflag` int, IN `in_bdayhighflag` int, IN `in_bnewflag` int, IN `in_blevelflag` varchar(128),
IN `in_tgpdayflag` int, IN `in_tgpweekflag` int, IN `in_tgpnewflag` int, IN `in_tgplevelflag` varchar(128),
IN `in_gamedayflag` int, IN `in_gameweekflag` int, IN `in_gamenewflag` int, IN `in_gamelevelflag` varchar(128),
IN `in_seven_day_login` int, IN `in_cont_login_day` int, IN `in_channel_id` int, IN `in_bhlflag` int,
IN `in_zonedayflag` int, IN `in_zoneweekflag` int, IN `in_zonenewflag` int, IN `in_zonelevelflag` varchar(128), IN `in_lastrenew` bigint)
BEGIN
	INSERT INTO tb_player_txvip(charguid, dayflag, dayyearflag, newflag, levelflag,
		bdayflag, bdayyearflag, bdayhighflag, bnewflag, blevelflag,
		tgpdayflag, tgpweekflag, tgpnewflag, tgplevelflag,
		gamedayflag, gameweekflag, gamenewflag, gamelevelflag,
		seven_day_login, cont_login_day, channel_id, bhlflag,
		zonedayflag, zoneweekflag, zonenewflag, zonelevelflag, lastrenew)
	VALUES (in_charguid, in_dayflag, in_dayyearflag, in_newflag, in_levelflag,
		in_bdayflag, in_bdayyearflag, in_bdayhighflag, in_bnewflag, in_blevelflag,
		in_tgpdayflag, in_tgpweekflag, in_tgpnewflag, in_tgplevelflag,
		in_gamedayflag, in_gameweekflag, in_gamenewflag, in_gamelevelflag,
		in_seven_day_login, in_cont_login_day, in_channel_id, in_bhlflag,
		in_zonedayflag, in_zoneweekflag, in_zonenewflag, in_zonelevelflag, in_lastrenew)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, dayflag = in_dayflag, dayyearflag = in_dayyearflag, newflag = in_newflag, levelflag = in_levelflag,
	bdayflag = in_bdayflag, bdayyearflag = in_bdayyearflag, bdayhighflag = in_bdayhighflag, bnewflag = in_bnewflag, blevelflag = in_blevelflag,
	tgpdayflag = in_tgpdayflag, tgpweekflag = in_tgpweekflag, tgpnewflag = in_tgpnewflag, tgplevelflag = in_tgplevelflag,
	gamedayflag = in_gamedayflag, gameweekflag = in_gameweekflag, gamenewflag = in_gamenewflag, gamelevelflag = in_gamelevelflag,
	seven_day_login = in_seven_day_login, cont_login_day = in_cont_login_day, channel_id = in_channel_id, bhlflag = in_bhlflag,
	zonedayflag = in_zonedayflag, zoneweekflag = in_zoneweekflag, zonenewflag = in_zonenewflag, zonelevelflag = in_zonelevelflag,
	lastrenew = in_lastrenew;
END ;;
#***************************************************************
##版本365修改完成
#***************************************************************
#***************************************************************
##版本366修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_extra_insert_update`;
CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(256), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(256), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(350),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int, IN `in_draw_cnt` int, IN `in_vitality_vip` int, IN `in_choujiang_num` int)
BEGIN
	INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate,draw_cnt,vitality_vip, choujiang_num)
	VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate, in_draw_cnt,in_vitality_vip,in_choujiang_num)
	ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, 
			petstate = in_petstate,draw_cnt=in_draw_cnt, vitality_vip = in_vitality_vip,choujiang_num=in_choujiang_num;
END ;;
#***************************************************************
##版本366修改完成
#***************************************************************
#***************************************************************
##版本367修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_crosstask_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_crosstask_extra_insert_update`;
CREATE PROCEDURE `sp_player_crosstask_extra_insert_update`(IN `in_charguid` bigint,IN `in_score` int, IN `in_onlinetime` int,
IN `in_refreshtimes` int, IN `in_lastrefreshtime` bigint, IN `in_questlist` varchar(128), IN `in_finishcnt` int)
BEGIN
	INSERT INTO tb_player_crosstask_extra(charguid,score,onlinetime,refreshtimes,lastrefreshtime,questlist,finishcnt)
	VALUES (in_charguid,in_score,in_onlinetime,in_refreshtimes,in_lastrefreshtime,in_questlist,in_finishcnt)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, score = in_score, onlinetime = in_onlinetime, 
	refreshtimes = in_refreshtimes, lastrefreshtime = in_lastrefreshtime, questlist = in_questlist,
	finishcnt = in_finishcnt;
END ;;
#***************************************************************
##版本367修改完成
#***************************************************************
#***************************************************************
##版本368修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_items_insert_update
-- ----------------------------
DROP procedure IF EXISTS `sp_player_items_insert_update`;
CREATE PROCEDURE `sp_player_items_insert_update`(IN `in_charguid` bigint, IN `in_item_id` bigint, IN `in_item_tid` int, 
IN `in_slot_id` int, IN `in_stack_num` int, IN `in_flags` bigint, IN `in_bag` int ,IN `in_time_stamp` bigint,
IN `in_param1` int, IN `in_param2` int, IN `in_param3` int, IN `in_param4` bigint)
BEGIN
	INSERT INTO tb_player_items(charguid, item_id, item_tid, slot_id, stack_num, flags, bag, time_stamp,
	param1, param2, param3, param4)
	VALUES (in_charguid, in_item_id, in_item_tid, in_slot_id, in_stack_num, in_flags, in_bag, in_time_stamp,
	in_param1, in_param2, in_param3,in_param4) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid, item_id=in_item_id, item_tid=in_item_tid, slot_id=in_slot_id, 
	stack_num=in_stack_num, flags=in_flags, bag=in_bag, time_stamp = in_time_stamp, param1 = in_param1,
	param2 = in_param2, param3 = in_param3, param4=in_param4;
END ;;
#***************************************************************
##版本368修改完成
#***************************************************************
#***************************************************************
##版本369修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_worldboss_wabao_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_worldboss_wabao_insert_update`;
CREATE PROCEDURE `sp_worldboss_wabao_insert_update`(IN `in_charguid` bigint,IN `in_bossid` int,IN `in_state` int,IN `in_keling_num` int,IN `in_cur_time` bigint)
BEGIN
	INSERT INTO tb_player_worldboss_wabao(charguid, bossid, state, keling_num, cur_time)
	VALUES (in_charguid, in_bossid, in_state, in_keling_num, in_cur_time)
	ON DUPLICATE KEY UPDATE charguid=in_charguid, bossid=in_bossid,state=in_state,keling_num=in_keling_num,cur_time=in_cur_time;
END;;
-- ----------------------------
-- Procedure structure for sp_select_worldboss_wabao
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_worldboss_wabao`;
CREATE PROCEDURE `sp_select_worldboss_wabao`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_worldboss_wabao WHERE charguid = in_charguid;
END;;
#***************************************************************
##版本369修改完成
#***************************************************************
#***************************************************************
##版本370修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_crosstask_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_crosstask_extra_insert_update`;
CREATE PROCEDURE `sp_player_crosstask_extra_insert_update`(IN `in_charguid` bigint,IN `in_score` int, IN `in_onlinetime` int,
IN `in_refreshtimes` int, IN `in_lastrefreshtime` bigint, IN `in_questlist` varchar(128), IN `in_finishcnt` int, IN `in_param1` int, 
IN `in_param2` int, IN `in_rewardinfo` varchar(128))
BEGIN
	INSERT INTO tb_player_crosstask_extra(charguid,score,onlinetime,refreshtimes,lastrefreshtime,questlist,finishcnt, param1, param2, rewardinfo)
	VALUES (in_charguid,in_score,in_onlinetime,in_refreshtimes,in_lastrefreshtime,in_questlist,in_finishcnt, in_param1, in_param2, in_rewardinfo)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, score = in_score, onlinetime = in_onlinetime, 
	refreshtimes = in_refreshtimes, lastrefreshtime = in_lastrefreshtime, questlist = in_questlist,
	finishcnt = in_finishcnt, param1 = in_param1, param2 = in_param2, rewardinfo = in_rewardinfo;
END ;;
-- ----------------------------
-- Procedure structure for sp_select_cross_task_history
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_cross_task_history`;
CREATE PROCEDURE `sp_select_cross_task_history`()
BEGIN
	select * from tb_crosstask_history;
END;;
-- ----------------------------
-- Procedure structure for sp_update_cross_task_history
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_cross_task_history`;
CREATE PROCEDURE `sp_update_cross_task_history`(IN `in_id` int, IN `in_explot` int, IN `in_score` int,
IN `in_param1` int, IN `in_param2` int, IN `in_rankinfo` varchar(128))
BEGIN
	INSERT INTO tb_crosstask_history(id, exploit, score, param1, param2, rankinfo)
	VALUES (in_id, in_explot, in_score, in_param1, in_param2, in_rankinfo) 
	ON DUPLICATE KEY UPDATE id=in_id, exploit=in_explot, score=in_score, param1=in_param1, param2=in_param2, rankinfo=in_rankinfo;
END;;
#***************************************************************
##版本370修改完成
#***************************************************************
#***************************************************************
##版本371修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_magickey_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_magickey_insert_update`;
CREATE PROCEDURE `sp_player_magickey_insert_update`(IN `in_charguid` bigint, IN `in_item_id` bigint, IN `in_item_tid` int, IN `in_slot_id` int,  IN `in_stack_num` int, 
IN `in_flags` bigint, IN `in_bag` int, IN `in_level` int, IN `in_wuxing` int, IN `in_totalexp` bigint, IN `in_passiveskill` varchar(256), IN `in_godid` bigint, IN `in_strenlv` int,IN `in_time_stamp` bigint,IN `in_strelevelVal` int)
BEGIN
	INSERT INTO tb_player_magickeys(charguid, item_id, item_tid, slot_id, stack_num, flags, bag,
		level, wuxing, totalexp, passiveskill, godid, strenlv, time_stamp,strelevelVal)
	VALUES (in_charguid, in_item_id, in_item_tid, in_slot_id, in_stack_num, in_flags, in_bag,
		in_level, in_wuxing, in_totalexp, in_passiveskill, in_godid, in_strenlv, in_time_stamp, in_strelevelVal) 
	ON DUPLICATE KEY UPDATE  item_id = in_item_id, item_tid = in_item_tid, slot_id = in_slot_id, stack_num = in_stack_num,
	flags = in_flags, bag = in_bag, level = in_level, wuxing = in_wuxing, totalexp = in_totalexp, passiveskill = in_passiveskill, 
	godid = in_godid, strenlv=in_strenlv, time_stamp = in_time_stamp,strelevelVal=in_strelevelVal;
END;;
#***************************************************************
##版本371修改完成
#***************************************************************
#***************************************************************
##版本372修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_extra_insert_update`;
CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(256), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(256), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(350),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int, IN `in_draw_cnt` int, IN `in_vitality_vip` int, IN `in_choujiang_num` int, IN `in_magickey_kl_num` int, IN `in_magickey_yl_num` int, IN `in_magickey_all_num` int)
BEGIN
	INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate,draw_cnt,vitality_vip, choujiang_num,magickey_kl_num,magickey_yl_num,magickey_all_num)
	VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate, in_draw_cnt,in_vitality_vip,in_choujiang_num,in_magickey_kl_num,in_magickey_yl_num,in_magickey_all_num)
	ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, 
			petstate = in_petstate,draw_cnt=in_draw_cnt, vitality_vip = in_vitality_vip,choujiang_num=in_choujiang_num,magickey_kl_num=in_magickey_kl_num,magickey_yl_num=in_magickey_yl_num,magickey_all_num=in_magickey_all_num;
END;;
#***************************************************************
##版本372修改完成
#***************************************************************
#***************************************************************
##版本373修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_insert_update_player_magickeygod_bag
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_player_magickeygod_bag`;
CREATE PROCEDURE `sp_insert_update_player_magickeygod_bag`(IN `in_charguid` bigint, IN `in_gid` bigint,  IN `in_tid` int, IN `in_magickeyid`bigint,IN `in_grow_value` int,IN `in_pinzhi` int)
BEGIN
	INSERT INTO tb_magickeygod_bag(charguid, gid, tid, magickeyid,grow_value,pinzhi)
	VALUES (in_charguid, in_gid, in_tid, in_magickeyid,in_grow_value,in_pinzhi) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid, gid=in_gid, tid=in_tid, magickeyid=in_magickeyid,grow_value=in_grow_value,pinzhi=in_pinzhi;
END;;
#***************************************************************
##版本373修改完成
#***************************************************************
#***************************************************************
##版本374修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_insert_update_player_magickeygod_bag
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_player_magickeygod_bag`;
CREATE PROCEDURE `sp_insert_update_player_magickeygod_bag`(IN `in_charguid` bigint, IN `in_gid` bigint,  IN `in_tid` int, IN `in_magickeyid`bigint,IN `in_grow_value` int,IN `in_pinzhi` int,IN `in_isnew` int)
BEGIN
	INSERT INTO tb_magickeygod_bag(charguid, gid, tid, magickeyid,grow_value,pinzhi,isnew)
	VALUES (in_charguid, in_gid, in_tid, in_magickeyid,in_grow_value,in_pinzhi,in_isnew) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid, gid=in_gid, tid=in_tid, magickeyid=in_magickeyid,grow_value=in_grow_value,pinzhi=in_pinzhi,isnew=in_isnew;
END;;
#***************************************************************
##版本374修改完成
#***************************************************************
#***************************************************************
##版本375修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_select_cross_consume
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_select_cross_consume`;
CREATE PROCEDURE `sp_player_select_cross_consume`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_cross_consume WHERE charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_player_cross_consume_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_cross_consume_insert_update`;
CREATE PROCEDURE `sp_player_cross_consume_insert_update`(IN `in_charguid` bigint,IN `in_consumeinfo` varchar(256))
BEGIN
	INSERT INTO tb_player_cross_consume(charguid,consumeinfo)
	VALUES (in_charguid, in_consumeinfo)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, consumeinfo = in_consumeinfo;
END ;;
#***************************************************************
##版本375修改完成
#***************************************************************
#***************************************************************
##版本376修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_txvip_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_txvip_insert_update`;
CREATE PROCEDURE `sp_player_txvip_insert_update`(IN `in_charguid` bigint, IN `in_dayflag` int, IN `in_dayyearflag` int, IN `in_newflag` int
, IN `in_levelflag` varchar(128), IN `in_bdayflag` int, IN `in_bdayyearflag` int, IN `in_bdayhighflag` int, IN `in_bnewflag` int, IN `in_blevelflag` varchar(128),
IN `in_tgpdayflag` int, IN `in_tgpweekflag` int, IN `in_tgpnewflag` int, IN `in_tgplevelflag` varchar(128),
IN `in_gamedayflag` int, IN `in_gameweekflag` int, IN `in_gamenewflag` int, IN `in_gamelevelflag` varchar(128),
IN `in_seven_day_login` int, IN `in_cont_login_day` int, IN `in_channel_id` int, IN `in_bhlflag` int,
IN `in_zonedayflag` int, IN `in_zoneweekflag` int, IN `in_zonenewflag` int, IN `in_zonelevelflag` varchar(128), IN `in_lastrenew` bigint,
IN `in_browserdayflag` int, IN `in_browserweekflag` int, IN `in_browsernewflag` int, IN `in_browserlevelflag` varchar(128),
IN `in_guanjiadayflag` int, IN `in_guanjiaweekflag` int, IN `in_guanjianewflag` int, IN `in_guanjialevelflag` varchar(128))
BEGIN
	INSERT INTO tb_player_txvip(charguid, dayflag, dayyearflag, newflag, levelflag,
		bdayflag, bdayyearflag, bdayhighflag, bnewflag, blevelflag,
		tgpdayflag, tgpweekflag, tgpnewflag, tgplevelflag,
		gamedayflag, gameweekflag, gamenewflag, gamelevelflag,
		seven_day_login, cont_login_day, channel_id, bhlflag,
		zonedayflag, zoneweekflag, zonenewflag, zonelevelflag, lastrenew,
		browserdayflag, browserweekflag, browsernewflag, browserlevelflag,
		guanjiadayflag, guanjiaweekflag, guanjianewflag, guanjialevelflag)
	VALUES (in_charguid, in_dayflag, in_dayyearflag, in_newflag, in_levelflag,
		in_bdayflag, in_bdayyearflag, in_bdayhighflag, in_bnewflag, in_blevelflag,
		in_tgpdayflag, in_tgpweekflag, in_tgpnewflag, in_tgplevelflag,
		in_gamedayflag, in_gameweekflag, in_gamenewflag, in_gamelevelflag,
		in_seven_day_login, in_cont_login_day, in_channel_id, in_bhlflag,
		in_zonedayflag, in_zoneweekflag, in_zonenewflag, in_zonelevelflag, in_lastrenew,
		in_browserdayflag, in_browserweekflag, in_browsernewflag, in_browserlevelflag,
		in_guanjiadayflag, in_guanjiaweekflag, in_guanjianewflag, in_guanjialevelflag)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, dayflag = in_dayflag, dayyearflag = in_dayyearflag, newflag = in_newflag, levelflag = in_levelflag,
	bdayflag = in_bdayflag, bdayyearflag = in_bdayyearflag, bdayhighflag = in_bdayhighflag, bnewflag = in_bnewflag, blevelflag = in_blevelflag,
	tgpdayflag = in_tgpdayflag, tgpweekflag = in_tgpweekflag, tgpnewflag = in_tgpnewflag, tgplevelflag = in_tgplevelflag,
	gamedayflag = in_gamedayflag, gameweekflag = in_gameweekflag, gamenewflag = in_gamenewflag, gamelevelflag = in_gamelevelflag,
	seven_day_login = in_seven_day_login, cont_login_day = in_cont_login_day, channel_id = in_channel_id, bhlflag = in_bhlflag,
	zonedayflag = in_zonedayflag, zoneweekflag = in_zoneweekflag, zonenewflag = in_zonenewflag, zonelevelflag = in_zonelevelflag,
	browserdayflag = in_browserdayflag, browserweekflag = in_browserweekflag, browsernewflag = in_browsernewflag, browserlevelflag = in_browserlevelflag,
	guanjiadayflag = in_guanjiadayflag, guanjiaweekflag = in_guanjiaweekflag, guanjianewflag = in_guanjianewflag, guanjialevelflag = in_guanjialevelflag,
	lastrenew = in_lastrenew;
END ;;
#***************************************************************
##版本376修改完成
#***************************************************************\
#***************************************************************
##版本377修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_extra_insert_update`;
CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(256), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(256), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(350),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int, IN `in_draw_cnt` int, IN `in_vitality_vip` int, IN `in_choujiang_num` int,
			 IN `in_magickey_kl_num` int, IN `in_magickey_yl_num` int, IN `in_magickey_all_num` int, IN `in_monthcharge` int, IN `in_maxcharge` int)
BEGIN
	INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate,draw_cnt,vitality_vip, choujiang_num,magickey_kl_num,magickey_yl_num,magickey_all_num,
			monthcharge, maxcharge)
	VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate, in_draw_cnt,in_vitality_vip,in_choujiang_num,in_magickey_kl_num,in_magickey_yl_num,in_magickey_all_num,
			in_monthcharge, in_maxcharge)
	ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, 
			petstate = in_petstate,draw_cnt=in_draw_cnt, vitality_vip = in_vitality_vip,choujiang_num=in_choujiang_num,magickey_kl_num=in_magickey_kl_num,magickey_yl_num=in_magickey_yl_num,magickey_all_num=in_magickey_all_num,
			monthcharge = in_monthcharge, maxcharge = in_maxcharge;
END;;
#***************************************************************
##版本377修改完成
#***************************************************************
#***************************************************************
##版本378修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_baojia_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_baojia_insert_update`;
CREATE PROCEDURE `sp_player_baojia_insert_update`(IN `in_charguid` bigint, IN `in_level` int, IN `in_wish` int, IN `in_use_level` int, IN `in_attr_dan` int,IN `in_AllNum` int, IN `in_KeLingQuNum` int, IN `in_YiLingQuNum` int)
BEGIN
	INSERT INTO tb_player_baojia(charguid, level, wish, use_level, attr_dan, AllNum, KeLingQuNum, YiLingQuNum)
	VALUES (in_charguid, in_level, in_wish, in_use_level, in_attr_dan, in_AllNum, in_KeLingQuNum, in_YiLingQuNum)
	ON DUPLICATE KEY UPDATE level=in_level, wish=in_wish, use_level=in_use_level, attr_dan=in_attr_dan, AllNum=in_AllNum, KeLingQuNum=in_KeLingQuNum, YiLingQuNum=in_YiLingQuNum;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_baojia_select_by_id`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_baojia_select_by_id`;
CREATE PROCEDURE `sp_player_baojia_select_by_id` (in in_charguid bigint)
BEGIN
	select * from tb_player_baojia where charguid=in_charguid;
END;;
-- ----------------------------
-- Procedure structure for `sp_rank_baojia`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_rank_baojia`;
CREATE PROCEDURE `sp_rank_baojia` ()
BEGIN
SELECT a.charguid AS uid, a.level AS rankvalue FROM tb_player_baojia as a left join tb_player_info as b
on a.charguid = b.charguid WHERE a.level > 0 ORDER BY a.level DESC, a.wish DESC, b.power DESC LIMIT 100;
END;;
-- ----------------------------
-- Procedure structure for `sp_update_rank_baojia`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_rank_baojia`;
CREATE PROCEDURE `sp_update_rank_baojia`(IN `in_rank` int, IN `in_charguid` bigint, IN `in_lastrank` int, IN `in_rankvalue` bigint)
BEGIN
	INSERT INTO tb_rank_baojia(rank, charguid, lastrank, rankvalue)
	VALUES (in_rank, in_charguid, in_lastrank, in_rankvalue)
	ON DUPLICATE KEY UPDATE rank = in_rank, charguid = in_charguid, lastrank = in_lastrank, rankvalue = in_rankvalue;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_baojia`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_baojia`;
CREATE PROCEDURE `sp_select_rank_baojia`()
BEGIN
	SELECT * FROM tb_rank_baojia;
END;;

-- ----------------------------
-- Procedure structure for `sp_select_player_info_by_ls`
-- ----------------------------
DROP procedure IF EXISTS `sp_select_player_info_by_ls`;
CREATE PROCEDURE `sp_select_player_info_by_ls`(IN `in_guid` bigint)
BEGIN
	SELECT name, level, prof, iconid, power, vip_level, head, suit, weapon, wingid, suitflag, exts,
	    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
	    IFNULL((select use_level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as piFengLevel,
	    IFNULL((select curr_id from tb_player_guanzhi where charguid=tb_player_info.charguid limit 1),0) as guanzhi,
	    IFNULL((select use_level from tb_player_baojia where charguid=tb_player_info.charguid limit 1),0) as BaoJiaLevel
	FROM tb_player_info 
	WHERE in_guid = charguid;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_human_info_base`
-- ----------------------------
DROP procedure IF EXISTS `sp_select_rank_human_info_base`;
CREATE PROCEDURE `sp_select_rank_human_info_base`(IN `in_id` bigint)
BEGIN
	SELECT charguid, name, prof, level, hp, mp, power, vip_level, sex, dress, glorylevel,
arms, head, suit, weapon, hunli, tipo, shenfa, jingshen, vplan, wingid, shenbingid, suitflag,crossscore,txvipflag, txbvipflag,
    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
    IFNULL((select use_level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as piFengLevel,
    IFNULL((select curr_id from tb_player_guanzhi where charguid=tb_player_info.charguid limit 1),0) as guanzhi,
    IFNULL((select use_level from tb_player_baojia where charguid=tb_player_info.charguid limit 1),0) as BaoJiaLevel
FROM tb_player_info WHERE charguid = in_id;
END;;
#***************************************************************
##版本378修改完成
#***************************************************************
#***************************************************************
##版本379修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_rank_ride_war`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_rank_ride_war`;
CREATE PROCEDURE `sp_rank_ride_war` ()
BEGIN
	SELECT tb_player_ridewar.charguid AS uid, tb_player_ridewar.ridewar_id AS rankvalue 
	FROM tb_player_ridewar left join tb_player_info
	on tb_player_ridewar.charguid = tb_player_info.charguid
	WHERE ridewar_id > 0 ORDER BY ridewar_id DESC, ridewar_procenum DESC, tb_player_info.power DESC LIMIT 100;
END;;
-- ----------------------------
-- Procedure structure for `sp_update_rank_ride_war`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_rank_ride_war`;
CREATE PROCEDURE `sp_update_rank_ride_war`(IN `in_rank` int, IN `in_charguid` bigint, IN `in_lastrank` int, IN `in_rankvalue` bigint)
BEGIN
	INSERT INTO tb_rank_ride_war(rank, charguid, lastrank, rankvalue)
	VALUES (in_rank, in_charguid, in_lastrank, in_rankvalue)
	ON DUPLICATE KEY UPDATE rank = in_rank, charguid = in_charguid, lastrank = in_lastrank, rankvalue = in_rankvalue;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_ride_war`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_ride_war`;
CREATE PROCEDURE `sp_select_rank_ride_war`()
BEGIN
	SELECT * FROM tb_rank_ride_war;
END;;
#***************************************************************
##版本379修改完成
#***************************************************************
#***************************************************************
##版本380修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_tiangang_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_tiangang_insert_update`;
CREATE PROCEDURE `sp_player_tiangang_insert_update`(IN `in_charguid` bigint, IN `in_level` int, IN `in_wish` int, IN `in_use_level` int, IN `in_attr_dan` int,IN `in_AllNum` int, IN `in_KeLingQuNum` int, IN `in_YiLingQuNum` int)
BEGIN
	INSERT INTO tb_player_tiangang(charguid, level, wish, use_level, attr_dan, AllNum, KeLingQuNum, YiLingQuNum)
	VALUES (in_charguid, in_level, in_wish, in_use_level, in_attr_dan, in_AllNum, in_KeLingQuNum, in_YiLingQuNum)
	ON DUPLICATE KEY UPDATE level=in_level, wish=in_wish, use_level=in_use_level, attr_dan=in_attr_dan, AllNum=in_AllNum, KeLingQuNum=in_KeLingQuNum, YiLingQuNum=in_YiLingQuNum;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_tiangang_select_by_id`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_tiangang_select_by_id`;
CREATE PROCEDURE `sp_player_tiangang_select_by_id` (in in_charguid bigint)
BEGIN
	select * from tb_player_tiangang where charguid=in_charguid;
END;;
-- ----------------------------
-- Procedure structure for `sp_rank_tiangang`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_rank_tiangang`;
CREATE PROCEDURE `sp_rank_tiangang` ()
BEGIN
SELECT a.charguid AS uid, a.level AS rankvalue FROM tb_player_tiangang as a left join tb_player_info as b
on a.charguid = b.charguid WHERE a.level > 0 ORDER BY a.level DESC, a.wish DESC,b.power DESC LIMIT 100;
END;;
-- ----------------------------
-- Procedure structure for `sp_update_rank_tiangang`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_rank_tiangang`;
CREATE PROCEDURE `sp_update_rank_tiangang`(IN `in_rank` int, IN `in_charguid` bigint, IN `in_lastrank` int, IN `in_rankvalue` bigint)
BEGIN
	INSERT INTO tb_rank_tiangang(rank, charguid, lastrank, rankvalue)
	VALUES (in_rank, in_charguid, in_lastrank, in_rankvalue)
	ON DUPLICATE KEY UPDATE rank = in_rank, charguid = in_charguid, lastrank = in_lastrank, rankvalue = in_rankvalue;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_tiangang`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_tiangang`;
CREATE PROCEDURE `sp_select_rank_tiangang`()
BEGIN
	SELECT * FROM tb_rank_tiangang;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_player_info_by_ls`
-- ----------------------------
DROP procedure IF EXISTS `sp_select_player_info_by_ls`;
CREATE PROCEDURE `sp_select_player_info_by_ls`(IN `in_guid` bigint)
BEGIN
	SELECT name, level, prof, iconid, power, vip_level, head, suit, weapon, wingid, suitflag, exts,
	    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
	    IFNULL((select use_level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as piFengLevel,
	    IFNULL((select curr_id from tb_player_guanzhi where charguid=tb_player_info.charguid limit 1),0) as guanzhi,
	    IFNULL((select use_level from tb_player_baojia where charguid=tb_player_info.charguid limit 1),0) as BaoJiaLevel,
	    IFNULL((select use_level from tb_player_tiangang where charguid=tb_player_info.charguid limit 1),0) as TianGangLevel
	FROM tb_player_info 
	WHERE in_guid = charguid;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_human_info_base`
-- ----------------------------
DROP procedure IF EXISTS `sp_select_rank_human_info_base`;
CREATE PROCEDURE `sp_select_rank_human_info_base`(IN `in_id` bigint)
BEGIN
	SELECT charguid, name, prof, level, hp, mp, power, vip_level, sex, dress, glorylevel,
arms, head, suit, weapon, hunli, tipo, shenfa, jingshen, vplan, wingid, shenbingid, suitflag,crossscore,txvipflag, txbvipflag,
    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
    IFNULL((select use_level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as piFengLevel,
    IFNULL((select curr_id from tb_player_guanzhi where charguid=tb_player_info.charguid limit 1),0) as guanzhi,
    IFNULL((select use_level from tb_player_baojia where charguid=tb_player_info.charguid limit 1),0) as BaoJiaLevel,
    IFNULL((select use_level from tb_player_tiangang where charguid=tb_player_info.charguid limit 1),0) as TianGangLevel
FROM tb_player_info WHERE charguid = in_id;
END;;
#***************************************************************
##版本380修改完成
#***************************************************************
#***************************************************************
##版本381修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_extra_insert_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_extra_insert_update`;
CREATE PROCEDURE `sp_player_extra_insert_update` (IN `in_uid` bigint,  IN `in_func_flags` varchar(256), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(256), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(350),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int, IN `in_draw_cnt` int, IN `in_vitality_vip` int, IN `in_choujiang_num` int,
			 IN `in_magickey_kl_num` int, IN `in_magickey_yl_num` int, IN `in_magickey_all_num` int, IN `in_monthcharge` int, IN `in_maxcharge` int, IN `in_hongyan_power` int, IN `in_hongyan_id` int)
BEGIN
	INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate,draw_cnt,vitality_vip, choujiang_num,magickey_kl_num,magickey_yl_num,magickey_all_num,
			monthcharge, maxcharge,hongyan_power,hongyan_id)
	VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate, in_draw_cnt,in_vitality_vip,in_choujiang_num,in_magickey_kl_num,in_magickey_yl_num,in_magickey_all_num,
			in_monthcharge, in_maxcharge,in_hongyan_power,in_hongyan_id)
	ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, 
			petstate = in_petstate,draw_cnt=in_draw_cnt, vitality_vip = in_vitality_vip,choujiang_num=in_choujiang_num,magickey_kl_num=in_magickey_kl_num,magickey_yl_num=in_magickey_yl_num,magickey_all_num=in_magickey_all_num,
			monthcharge = in_monthcharge, maxcharge = in_maxcharge,hongyan_power=in_hongyan_power,hongyan_id=in_hongyan_id;
END;;
-- ----------------------------
-- Procedure structure for `sp_rank_hongyan`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_rank_hongyan`;
CREATE PROCEDURE `sp_rank_hongyan` ()
BEGIN
SELECT a.charguid AS uid, a.hongyan_power AS rankvalue FROM tb_player_extra as a left join tb_player_info as b
on a.charguid = b.charguid WHERE a.hongyan_power > 0 ORDER BY a.hongyan_power DESC, b.power DESC LIMIT 100;
END;;
-- ----------------------------
-- Procedure structure for `sp_update_rank_hongyan`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_rank_hongyan`;
CREATE PROCEDURE `sp_update_rank_hongyan`(IN `in_rank` int, IN `in_charguid` bigint, IN `in_lastrank` int, IN `in_rankvalue` bigint)
BEGIN
	INSERT INTO tb_rank_hongyan(rank, charguid, lastrank, rankvalue)
	VALUES (in_rank, in_charguid, in_lastrank, in_rankvalue)
	ON DUPLICATE KEY UPDATE rank = in_rank, charguid = in_charguid, lastrank = in_lastrank, rankvalue = in_rankvalue;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_hongyan`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_hongyan`;
CREATE PROCEDURE `sp_select_rank_hongyan`()
BEGIN
	SELECT * FROM tb_rank_hongyan;
END;;
#***************************************************************
##版本381修改完成
#***************************************************************
#***************************************************************
##版本382修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_player_info_by_ls
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_info_by_ls`;
CREATE PROCEDURE `sp_select_player_info_by_ls`(IN `in_guid` bigint)
BEGIN
	SELECT name, level, prof, iconid, power, vip_level, head, suit, weapon, wingid, suitflag, exts,
	    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
	    IFNULL((select use_level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as piFengLevel,
	    IFNULL((select curr_id from tb_player_guanzhi where charguid=tb_player_info.charguid limit 1),0) as guanzhi,
	    IFNULL((select use_level from tb_player_baojia where charguid=tb_player_info.charguid limit 1),0) as BaoJiaLevel,
	    IFNULL((select use_level from tb_player_tiangang where charguid=tb_player_info.charguid limit 1),0) as TianGangLevel,
		IFNULL((select hongyan_power from tb_player_extra where charguid=tb_player_info.charguid limit 1),0) as HongyanPower
	FROM tb_player_info 
	WHERE in_guid = charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_select_rank_human_info_base
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_human_info_base`;
CREATE PROCEDURE `sp_select_rank_human_info_base`(IN `in_id` bigint)
BEGIN
	SELECT charguid, name, prof, level, hp, mp, power, vip_level, sex, dress, glorylevel,
arms, head, suit, weapon, hunli, tipo, shenfa, jingshen, vplan, wingid, shenbingid, suitflag,crossscore,txvipflag, txbvipflag,
    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
    IFNULL((select use_level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as piFengLevel,
    IFNULL((select curr_id from tb_player_guanzhi where charguid=tb_player_info.charguid limit 1),0) as guanzhi,
    IFNULL((select use_level from tb_player_baojia where charguid=tb_player_info.charguid limit 1),0) as BaoJiaLevel,
    IFNULL((select use_level from tb_player_tiangang where charguid=tb_player_info.charguid limit 1),0) as TianGangLevel,
	IFNULL((select hongyan_power from tb_player_extra where charguid=tb_player_info.charguid limit 1),0) as HongyanPower
FROM tb_player_info WHERE charguid = in_id;
END;;
-- ----------------------------
-- Procedure structure for sp_select_rank_human_hongyan
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_human_hongyan`;
CREATE PROCEDURE `sp_select_rank_human_hongyan`(IN `in_charguid` bigint)
BEGIN
	select tb_player_extra.hongyan_id as hongyanid,  tb_player_hongyan.level as hongyanlevel
	from  tb_player_hongyan left join tb_player_extra 	
	on tb_player_hongyan.charguid = tb_player_extra.charguid and tb_player_hongyan.hongyan_id = tb_player_extra.hongyan_id
	where tb_player_extra.charguid = in_charguid;
END;;
#***************************************************************
##版本382修改完成
#***************************************************************

#***************************************************************
##版本383修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_guanzhi_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_guanzhi_insert_update`;
CREATE PROCEDURE `sp_player_guanzhi_insert_update`(IN `in_charguid` bigint,IN `in_curr_id` int,IN `in_curr_value` int)
BEGIN
	INSERT INTO tb_player_guanzhi(charguid, curr_id,curr_value) VALUES (in_charguid,in_curr_id,in_curr_value) 
	ON DUPLICATE KEY UPDATE curr_id=in_curr_id, curr_value=in_curr_value;
END;;
#***************************************************************
##版本383修改完成
#***************************************************************
#***************************************************************
##版本384修改开始
-- ----------------------------
-- Procedure structure for `sp_select_party_guild_purchase`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_party_guild_purchase`;
CREATE PROCEDURE `sp_select_party_guild_purchase`()
BEGIN
	SELECT * FROM tb_party_guild_purchase;
END;;
-- ----------------------------
-- Procedure structure for `sp_update_party_guild_purchase`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_party_guild_purchase`;
CREATE PROCEDURE `sp_update_party_guild_purchase`(IN `in_id` int, IN `in_gid` bigint, IN `in_name` varchar(64), IN `in_cnt` int, IN `in_param1` int, IN `in_param2` int)
BEGIN
	INSERT INTO tb_party_guild_purchase(id, gid, name, cnt, param1, param2)
	VALUES (in_id, in_gid, in_name, in_cnt, in_param1, in_param2)
	ON DUPLICATE KEY UPDATE id = in_id, gid = in_gid, name = in_name, cnt = in_cnt, param1 = in_param1, param2 = in_param2;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_update_party`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_update_party`;
CREATE PROCEDURE `sp_player_update_party`(IN `in_guid` bigint, IN `in_id` int, IN `in_progress` int, IN `in_award` int, 
IN `in_awardtimes` int, IN `in_param1` int, IN `in_param2` int, IN`in_param3` int, IN `in_time_stamp` bigint, IN `in_param4` bigint, IN `in_param5` bigint)
BEGIN
	INSERT INTO tb_player_party(charguid, id, progress, award, awardtimes, param1, param2, param3, time_stamp, param4, param5)
	VALUES (in_guid, in_id, in_progress, in_award, in_awardtimes, in_param1, in_param2, in_param3, in_time_stamp, in_param4, in_param5)
	ON DUPLICATE KEY UPDATE charguid = in_guid, id = in_id, progress = in_progress, 
	award = in_award, awardtimes = in_awardtimes, param1 = in_param1, 
	param2 = in_param2, param3 = in_param3, time_stamp = in_time_stamp,
	param4 = in_param4, param5 = in_param5;
END;;
#***************************************************************
##版本384修改完成
#***************************************************************
#***************************************************************
##版本385修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_guanzhi_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_guanzhi_insert_update`;
CREATE PROCEDURE `sp_player_guanzhi_insert_update`(IN `in_charguid` bigint,IN `in_curr_id` int,IN `in_curr_value` int,IN `in_huoyuedu` int)
BEGIN
	INSERT INTO tb_player_guanzhi(charguid, curr_id,curr_value,huoyuedu) VALUES (in_charguid,in_curr_id,in_curr_value,huoyuedu) 
	ON DUPLICATE KEY UPDATE curr_id=in_curr_id, curr_value=in_curr_value,huoyuedu=in_huoyuedu;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_human_baojia`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_human_baojia`;
CREATE PROCEDURE `sp_select_rank_human_baojia`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_baojia WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_human_tiangang`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_human_tiangang`;
CREATE PROCEDURE `sp_select_rank_human_tiangang`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_tiangang WHERE charguid = in_charguid;
END ;;
#***************************************************************
##版本385修改完成
#***************************************************************
#***************************************************************
##版本386修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_zhannu_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhannu_insert_update`;
CREATE PROCEDURE `sp_player_zhannu_insert_update`(IN `in_charguid` bigint, IN `in_lvl` int, IN `in_process` int, IN `in_sel` int
, IN `in_proce_num` int,IN `in_total_proce` int, IN `in_attrdan` int)
BEGIN
	INSERT INTO tb_player_zhannu(charguid, level, process, sel, proce_num, total_proce, attrdan)
	VALUES (in_charguid, in_lvl, in_process, in_sel, in_proce_num, in_total_proce, in_attrdan)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, level = in_lvl, process = in_process, sel = in_sel, proce_num = in_proce_num, total_proce = in_total_proce, attrdan = in_attrdan;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_zhannu_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhannu_select_by_id`;
CREATE PROCEDURE `sp_player_zhannu_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_zhannu WHERE charguid=in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_rank_zhannu
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_rank_zhannu`;
CREATE PROCEDURE `sp_rank_zhannu`()
BEGIN
	SELECT tb_player_zhannu.charguid AS uid, tb_player_zhannu.level AS rankvalue FROM tb_player_zhannu left join tb_player_info
	on tb_player_zhannu.charguid = tb_player_info.charguid
	WHERE tb_player_zhannu.level > 0 ORDER BY tb_player_zhannu.level DESC, process DESC, tb_player_info.power DESC LIMIT 100;
END;;
-- ----------------------------
-- Procedure structure for sp_select_rank_zhannu
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_zhannu`;
CREATE PROCEDURE `sp_select_rank_zhannu`()
BEGIN
	SELECT * FROM tb_rank_zhannu;
END;;
-- ----------------------------
-- Procedure structure for sp_update_rank_zhannu
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_rank_zhannu`;
CREATE PROCEDURE `sp_update_rank_zhannu`(IN `in_rank` int, IN `in_charguid` bigint, IN `in_lastrank` int, IN `in_rankvalue` bigint)
BEGIN
	INSERT INTO tb_rank_zhannu(rank, charguid, lastrank, rankvalue)
	VALUES (in_rank, in_charguid, in_lastrank, in_rankvalue)
	ON DUPLICATE KEY UPDATE rank = in_rank, charguid = in_charguid, lastrank = in_lastrank, rankvalue = in_rankvalue;
END;;
#***************************************************************
##版本386修改完成
#***************************************************************
#***************************************************************
##版本387修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_select_party_guild_duobao`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_party_guild_duobao`;
CREATE PROCEDURE `sp_select_party_guild_duobao`()
BEGIN
	SELECT * FROM tb_party_guild_duobao;
END;;
-- ----------------------------
-- Procedure structure for `sp_update_party_guild_duobao`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_party_guild_duobao`;
CREATE PROCEDURE `sp_update_party_guild_duobao`(IN `in_id` int, IN `in_gid` bigint, IN `in_name` varchar(64), IN `in_winername` varchar(64), IN `in_duobaoinfo` varchar(1024), IN `in_cnt` int, IN `in_param1` int, IN `in_param2` int)
BEGIN
	INSERT INTO tb_party_guild_duobao(id, gid, name, winername, duobaoinfo, cnt, param1, param2)
	VALUES (in_id, in_gid, in_name, in_winername, in_duobaoinfo, in_cnt, in_param1, in_param2)
	ON DUPLICATE KEY UPDATE id = in_id, gid = in_gid, name = in_name, cnt = in_cnt, param1 = in_param1, param2 = in_param2,
	winername = in_winername, duobaoinfo = in_duobaoinfo;
END;;
#***************************************************************
##版本387修改完成
#***************************************************************
#***************************************************************
##版本388修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_extra_insert_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_extra_insert_update`;
CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(256), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(256), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(350),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int, IN `in_draw_cnt` int, IN `in_vitality_vip` int, IN `in_choujiang_num` int,
			 IN `in_magickey_kl_num` int, IN `in_magickey_yl_num` int, IN `in_magickey_all_num` int, IN `in_monthcharge` int, IN `in_maxcharge` int, IN `in_hongyan_power` int, IN `in_hongyan_id` int, IN `in_hongyan_chuzhan_id` int)
BEGIN
	INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate,draw_cnt,vitality_vip, choujiang_num,magickey_kl_num,magickey_yl_num,magickey_all_num,
			monthcharge, maxcharge,hongyan_power,hongyan_id,hongyan_chuzhan_id)
	VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate, in_draw_cnt,in_vitality_vip,in_choujiang_num,in_magickey_kl_num,in_magickey_yl_num,in_magickey_all_num,
			in_monthcharge, in_maxcharge,in_hongyan_power,in_hongyan_id,in_hongyan_chuzhan_id)
	ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, 
			petstate = in_petstate,draw_cnt=in_draw_cnt, vitality_vip = in_vitality_vip,choujiang_num=in_choujiang_num,magickey_kl_num=in_magickey_kl_num,magickey_yl_num=in_magickey_yl_num,magickey_all_num=in_magickey_all_num,
			monthcharge = in_monthcharge, maxcharge = in_maxcharge,hongyan_power=in_hongyan_power,hongyan_id=in_hongyan_id,hongyan_chuzhan_id=in_hongyan_chuzhan_id;
END;;
#***************************************************************
##版本388修改完成
#***************************************************************
#***************************************************************
##版本389修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_zhiyuanfbbox_insert_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhiyuanfbbox_insert_update`;
CREATE PROCEDURE `sp_player_zhiyuanfbbox_insert_update`(IN `in_charguid` bigint, IN `in_road_box` varchar(32), IN `in_buy_num` int, IN `in_tick` int,
IN `in_challenge_count` bigint, IN `in_roadlv_max` int,IN `in_challenge_count2` bigint,IN `in_challenge_count3` bigint)
BEGIN
	INSERT INTO tb_zhiyuanfb_box(charguid, road_box, buy_num, tick, challenge_count, roadlv_max, challenge_count2, challenge_count3)
	VALUES (in_charguid, in_road_box, in_buy_num, in_tick, in_challenge_count, in_roadlv_max, in_challenge_count2, in_challenge_count3)
	ON DUPLICATE KEY UPDATE charguid=in_charguid, road_box=in_road_box, buy_num=in_buy_num, tick = in_tick,
	 challenge_count = in_challenge_count, roadlv_max = in_roadlv_max,challenge_count2 = in_challenge_count2,challenge_count3 = in_challenge_count3;
END;;
#***************************************************************
##版本389修改完成
#***************************************************************
#***************************************************************
##版本390修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_update_forbidden_acc_by_acc`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_forbidden_acc_by_acc`;
CREATE PROCEDURE `sp_update_forbidden_acc_by_acc`(IN `in_account` VARCHAR(64), IN `in_forb_acc_last` int, IN `in_forb_acc_time` int, IN `in_groupid` int)
BEGIN
  UPDATE tb_account SET  forb_acc_last = in_forb_acc_last, forb_acc_time = in_forb_acc_time
  WHERE account = in_account and groupid = in_groupid;
END ;;

-- ----------------------------
-- Procedure structure for `sp_update_forbidden_player_by_acc`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_forbidden_player_by_acc`;
CREATE PROCEDURE `sp_update_forbidden_player_by_acc`(IN `in_charguid` bigint, IN `in_forb_acc_last` int, IN `in_forb_acc_time` int)
BEGIN
  UPDATE tb_player_info SET  forb_acc_last = in_forb_acc_last, forb_acc_time = in_forb_acc_time
  WHERE charguid = in_charguid ;
END ;;

#***************************************************************
##版本390修改完成
#***************************************************************
#***************************************************************
##版本391修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_cross_citywar_history
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_cross_citywar_history`;
CREATE PROCEDURE `sp_select_cross_citywar_history`()
BEGIN
	select * from tb_cross_citywar_history;
END;;
-- ----------------------------
-- Procedure structure for sp_update_cross_citywar_history
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_cross_citywar_history`;
CREATE PROCEDURE `sp_update_cross_citywar_history`(IN `in_id` int, IN `in_citygid` bigint, IN `in_citygroup` int,
IN `in_godgid` bigint, IN `in_godgroup` int, IN `in_rankinfo` varchar(128), IN `in_role1` varchar(256), IN `in_role2` varchar(256))
BEGIN
	INSERT INTO tb_cross_citywar_history(id, citygid, citygroup, godgid, godgroup, rankinfo, role1, role2)
	VALUES (in_id, in_citygid, in_citygroup, in_godgid, in_godgroup, in_rankinfo, in_role1, in_role2) 
	ON DUPLICATE KEY UPDATE id=in_id, citygid=in_citygid, citygroup=in_citygroup, godgid=in_godgid, godgroup=in_godgroup, rankinfo=in_rankinfo,
	role1=in_role1, role2=in_role2;
END;;
#***************************************************************
##版本391修改完成
#***************************************************************
#***************************************************************
##版本392修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_extra_insert_update`;
CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(256), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(256), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(350),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int, IN `in_draw_cnt` int, IN `in_vitality_vip` int, IN `in_choujiang_num` int,
			 IN `in_magickey_kl_num` int, IN `in_magickey_yl_num` int, IN `in_magickey_all_num` int, IN `in_monthcharge` int, IN `in_maxcharge` int, IN `in_hongyan_power` int, IN `in_hongyan_id` int, IN `in_hongyan_chuzhan_id` int, IN `in_HongYanHeTiTimes` int)
BEGIN
	INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate,draw_cnt,vitality_vip, choujiang_num,magickey_kl_num,magickey_yl_num,magickey_all_num,
			monthcharge, maxcharge,hongyan_power,hongyan_id,hongyan_chuzhan_id,HongYanHeTiTimes)
	VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate, in_draw_cnt,in_vitality_vip,in_choujiang_num,in_magickey_kl_num,in_magickey_yl_num,in_magickey_all_num,
			in_monthcharge, in_maxcharge,in_hongyan_power,in_hongyan_id,in_hongyan_chuzhan_id,in_HongYanHeTiTimes)
	ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, 
			petstate = in_petstate,draw_cnt=in_draw_cnt, vitality_vip = in_vitality_vip,choujiang_num=in_choujiang_num,magickey_kl_num=in_magickey_kl_num,magickey_yl_num=in_magickey_yl_num,magickey_all_num=in_magickey_all_num,
			monthcharge = in_monthcharge, maxcharge = in_maxcharge,hongyan_power=in_hongyan_power,hongyan_id=in_hongyan_id,hongyan_chuzhan_id=in_hongyan_chuzhan_id,HongYanHeTiTimes=in_HongYanHeTiTimes;
END;;
#***************************************************************
##版本392修改完成
#***************************************************************
#***************************************************************
##版本393修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_update_shopitem
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_update_shopitem`;
CREATE PROCEDURE `sp_player_update_shopitem`(IN `in_guid` bigint, IN `in_shopItem` int, IN `in_count` int, IN `in_flags` bigint, IN `in_forevercnt` int)
BEGIN
	INSERT INTO tb_player_shop_item(charguid, shopitem, count, flags, forevercnt)
	VALUES (in_guid, in_shopitem, in_count, in_flags, in_forevercnt)
	ON DUPLICATE KEY UPDATE count = in_count, flags = in_flags, forevercnt = in_forevercnt;
END;;
#***************************************************************
##版本393修改完成
#***************************************************************
#***************************************************************
##版本394修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_update_forbidden_chat_by_acc
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_forbidden_chat_by_acc`;
CREATE PROCEDURE `sp_update_forbidden_chat_by_acc`(IN `in_account` VARCHAR(32), IN `in_forb_chat_last` int, IN `in_forb_chat_time` int, IN `in_groupid` int)
BEGIN
	UPDATE tb_account SET  forb_chat_last = in_forb_chat_last, forb_chat_time = in_forb_chat_time
	WHERE account = in_account and groupid = in_groupid;
END;;

-- ----------------------------
-- Procedure structure for sp_update_forbidden_player_chat_by_acc
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_forbidden_player_chat_by_acc`;
CREATE PROCEDURE `sp_update_forbidden_player_chat_by_acc`(IN `in_charguid` bigint, IN `in_forb_chat_last` int, IN `in_forb_chat_time` int)
BEGIN
	UPDATE tb_player_info SET  forb_chat_last = in_forb_chat_last, forb_chat_time = in_forb_chat_time
	WHERE in_charguid = charguid;
END;;

-- ----------------------------
-- Procedure structure for sp_platform_select_role_info
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_platform_select_role_info`;
CREATE PROCEDURE `sp_platform_select_role_info`(IN `in_account` VARCHAR(32), IN `in_groupid` int)
BEGIN
	SELECT * FROM tb_player_info 
	left join tb_player_map_info
	on tb_player_map_info.charguid = tb_player_info.charguid
	WHERE account_id=(select account_id from tb_account where account = in_account and groupid = in_groupid) ;	
END;;

-- ----------------------------
-- Procedure structure for sp_platform_select_role_little_info
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_platform_select_role_little_info`;
CREATE PROCEDURE `sp_platform_select_role_little_info`(IN `in_account` VARCHAR(32), IN `in_groupid` int)
BEGIN
	SELECT * FROM tb_player_info left join tb_account
	on tb_player_info.account_id = tb_account.account_id
	left join tb_player_map_info
	on tb_player_map_info.charguid = tb_player_info.charguid
	WHERE account = in_account and groupid = in_groupid;
END;;
#***************************************************************
##版本394修改完成
#***************************************************************
#***************************************************************
##版本395修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_update_festival_activity
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_festival_activity`;
CREATE PROCEDURE `sp_update_festival_activity`(IN `in_id` int, IN `in_param_1` int, IN `in_param_2` int,IN `in_param_3` int, IN `in_param_4` int, 
IN `in_param_5` bigint, IN `in_param_6` bigint, IN `in_param_str` varchar(32))
BEGIN
	INSERT INTO tb_festivalact(id, param_1, param_2, param_3, param_4, param_5, param_6, param_str)
	VALUES (in_id, in_param_1, in_param_2, in_param_3, in_param_4, in_param_5, in_param_6, in_param_str) 
	ON DUPLICATE KEY UPDATE id = in_id, param_1 = in_param_1, param_2 = in_param_2,
		param_3 = in_param_3, param_4 = in_param_4, param_5 = in_param_5, param_6 = in_param_6, param_str = in_param_str;
END;;
-- ----------------------------
-- Procedure structure for sp_select_festival_activity
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_festival_activity`;
CREATE PROCEDURE `sp_select_festival_activity`()
BEGIN
  SELECT * FROM tb_festivalact;
END;;
#***************************************************************
##版本395修改完成
#***************************************************************
#***************************************************************
##版本396修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_crosstask_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_crosstask_extra_insert_update`;
CREATE PROCEDURE `sp_player_crosstask_extra_insert_update`(IN `in_charguid` bigint,IN `in_score` int, IN `in_onlinetime` int,
IN `in_refreshtimes` int, IN `in_lastrefreshtime` bigint, IN `in_questlist` varchar(128), IN `in_finishcnt` int, IN `in_param1` int, 
IN `in_param2` int, IN `in_rewardinfo` varchar(128), IN `in_yabiaocnt` int, IN `in_yabiaoid` int, IN `in_jiebiaocnt` int, IN `in_sharecnt` int)
BEGIN
	INSERT INTO tb_player_crosstask_extra(charguid,score,onlinetime,refreshtimes,lastrefreshtime,questlist,finishcnt, param1, param2, rewardinfo, yabiaocnt, yabiaoid, jiebiaocnt, sharecnt)
	VALUES (in_charguid,in_score,in_onlinetime,in_refreshtimes,in_lastrefreshtime,in_questlist,in_finishcnt, in_param1, in_param2, in_rewardinfo, in_yabiaocnt, in_yabiaoid, in_jiebiaocnt, in_sharecnt)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, score = in_score, onlinetime = in_onlinetime, 
	refreshtimes = in_refreshtimes, lastrefreshtime = in_lastrefreshtime, questlist = in_questlist,
	finishcnt = in_finishcnt, param1 = in_param1, param2 = in_param2, rewardinfo = in_rewardinfo,
	yabiaocnt = in_yabiaocnt, yabiaoid = in_yabiaoid, jiebiaocnt = in_jiebiaocnt, sharecnt = in_sharecnt;
END ;;
#***************************************************************
##版本396修改完成
#***************************************************************
#***************************************************************
##版本397修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_christmas_tree_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_christmas_tree_insert_update`;
CREATE PROCEDURE `sp_player_christmas_tree_insert_update`(IN `in_charguid` bigint,IN `in_id` int, IN `in_num` int, IN `in_openday` bigint)
BEGIN
	INSERT INTO tb_player_christmas_tree(charguid,`id`,num,openday) VALUES (in_charguid,in_id,in_num,in_openday)
	ON DUPLICATE KEY UPDATE num = in_num;
END;;
-- ----------------------------
-- Procedure structure for sp_player_christmas_tree_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_christmas_tree_select`;
CREATE PROCEDURE `sp_player_christmas_tree_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_christmas_tree where charguid=in_charguid;
END;;
#***************************************************************
#***************************************************************
##版本398修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_yuandan_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_yuandan_insert_update`;
CREATE PROCEDURE `sp_player_yuandan_insert_update`(IN `in_charguid` bigint,IN `in_id` int, IN `in_num` int, IN `in_type` bigint)
BEGIN
	INSERT INTO tb_player_yuandan(charguid,`id`,num,`type`) VALUES (in_charguid,in_id,in_num,in_type)
	ON DUPLICATE KEY UPDATE num = in_num;
END;;
-- ----------------------------
-- Procedure structure for sp_player_yuandan_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_yuandan_select`;
CREATE PROCEDURE `sp_player_yuandan_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_yuandan where charguid=in_charguid;
END;;
#***************************************************************
##版本398修改完成
#***************************************************************
#***************************************************************
##版本399修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_shenbing_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_shenbing_insert_update`;
CREATE PROCEDURE `sp_player_shenbing_insert_update` (IN `in_charguid` bigint, IN `in_level` int, IN `in_wish` int, IN `in_proficiency` int
, IN `in_proficiencylvl` int, IN `in_procenum` int, IN `in_skinlevel` int, IN `in_attr_num` int, IN `in_uplevel_num` int, IN `in_shengbing_allnum` int, 
IN `in_shengbing_kelingqunum` int, IN `in_shengbing_yilingqunum` int,IN `in_attr_dan_per` int)
BEGIN
  INSERT INTO tb_player_shenbing(charguid, level, wish, proficiency, proficiencylvl, procenum, skinlevel, attr_num, uplevel_num,
shengbing_allnum,shengbing_kelingqunum,shengbing_yilingqunum, attr_dan_per)
  VALUES (in_charguid, in_level, in_wish, in_proficiency, in_proficiencylvl, in_procenum, in_skinlevel, in_attr_num, in_uplevel_num,
shengbing_allnum,shengbing_kelingqunum,shengbing_yilingqunum, in_attr_dan_per) 
  ON DUPLICATE KEY UPDATE charguid=in_charguid, level=in_level, wish=in_wish, proficiency=in_proficiency, proficiencylvl=in_proficiencylvl
  , procenum=in_procenum,skinlevel = in_skinlevel,attr_num = in_attr_num, uplevel_num = in_uplevel_num,shengbing_allnum=in_shengbing_allnum,
shengbing_kelingqunum=in_shengbing_kelingqunum,shengbing_yilingqunum=in_shengbing_yilingqunum, attr_dan_per=in_attr_dan_per;
END;;
-- ----------------------------
-- Procedure structure for sp_insert_update_ride
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_ride`;
CREATE  PROCEDURE `sp_insert_update_ride`(IN `in_charguid` bigint, IN `in_step` int, IN `in_select` int, IN `in_state` int, IN `in_process` int,
IN `in_attrdan` int, IN `in_proce_num` int, IN `in_total_proce` int, IN `in_fh_zhenqi` bigint, IN `in_consum_zhenqi` bigint, 
IN `in_uplevel_num` bigint, IN `in_horse_allnum` int, IN `in_horse_yilingqunum` int, IN `in_horse_kelingqunum` int,IN `in_attr_dan_per` int)
BEGIN
	INSERT INTO tb_ride(charguid, ride_step, ride_select, ride_state, ride_process, attrdan, proce_num, total_proce,fh_zhenqi,consum_zhenqi,uplevel_num,
horse_allnum,horse_yilingqunum,horse_kelingqunum,attr_dan_per)
	VALUES (in_charguid, in_step, in_select, in_state, in_process, in_attrdan,in_proce_num, in_total_proce,in_fh_zhenqi,in_consum_zhenqi,in_uplevel_num,
horse_allnum,horse_yilingqunum,horse_kelingqunum,in_attr_dan_per)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, ride_step=in_step, ride_select = in_select, ride_state = in_state, ride_process = in_process, 
		attrdan=in_attrdan, proce_num=in_proce_num, total_proce=in_total_proce, fh_zhenqi=in_fh_zhenqi, consum_zhenqi=in_consum_zhenqi, uplevel_num = in_uplevel_num,
horse_allnum=in_horse_allnum,horse_yilingqunum=in_horse_yilingqunum,horse_kelingqunum=in_horse_kelingqunum,attr_dan_per=in_attr_dan_per;
END;;
-- ----------------------------
-- Procedure structure for sp_insert_update_ridewar
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_ridewar`;
CREATE PROCEDURE `sp_insert_update_ridewar`(IN `in_charguid` bigint, IN `in_ridewar_id` int,
IN `in_ridewar_wish` int, IN `in_ridewar_procenum` int, IN `in_ridewar_attrnum` int, IN `in_ridewar_skin` int,IN `in_attr_dan_per` int)
BEGIN
	INSERT INTO tb_player_ridewar(charguid, ridewar_id, ridewar_wish, ridewar_procenum, ridewar_attrnum, ridewar_skin, ridewar_attrdanpernum)
	VALUES (in_charguid, in_ridewar_id, in_ridewar_wish, in_ridewar_procenum, in_ridewar_attrnum, in_ridewar_skin, in_attr_dan_per) 
	ON DUPLICATE KEY UPDATE charguid = in_charguid, ridewar_id = in_ridewar_id,	ridewar_wish = in_ridewar_wish,
	 ridewar_procenum = in_ridewar_procenum, ridewar_attrnum = in_ridewar_attrnum, ridewar_skin = in_ridewar_skin, ridewar_attrdanpernum=in_attr_dan_per;
END;;
#***************************************************************
##版本399修改完成
#***************************************************************
#***************************************************************
##版本400修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_marryInfo_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_marryInfo_select`;
CREATE PROCEDURE `sp_player_marryInfo_select`(IN `in_charguid` bigint(20))
BEGIN
	SELECT * FROM tb_player_marry_info WHERE charguid = in_charguid;
END;;

-- ----------------------------
-- Procedure structure for sp_player_marryInfo_replace
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_marryInfo_replace`;
CREATE PROCEDURE `sp_player_marryInfo_replace`(IN `in_charguid` bigint(20), IN `in_mateguid` bigint(20), IN `in_marryState` int(11), 
											   IN `in_marryTime` bigint(20), IN `in_marryType` int(11), IN `in_marryTraveled` int(11), 
											   IN `in_marryDinnered` int(11), IN `in_marryRingCfgId` int(11), IN `in_marryIntimate` int(11))
BEGIN
	REPLACE INTO tb_player_marry_info(charguid, mateguid, marryState, marryTime, marryType, marryTraveled, marryDinnered, marryRingCfgId, marryIntimate) 
	VALUES (in_charguid, in_mateguid, in_marryState, in_marryTime, in_marryType, in_marryTraveled, in_marryDinnered, in_marryRingCfgId, in_marryIntimate);
END;;

-- ----------------------------
-- Procedure structure for sp_player_marryInfo_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_marryInfo_update`;
CREATE PROCEDURE `sp_player_marryInfo_update`(IN `in_charguid` bigint(20))
BEGIN
	UPDATE tb_player_marry_info SET marryTime = 0, marryType = 0, marryTraveled = 0, marryDinnered = 0 WHERE charguid = in_charguid;
END;;



-- ----------------------------
-- Procedure structure for sp_player_marryInfo_schedule_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_marryInfo_schedule_select`;
CREATE PROCEDURE `sp_player_marryInfo_schedule_select`()
BEGIN
	SELECT * FROM tb_player_marry_schedule;
END;;
-- ----------------------------
-- Procedure structure for sp_player_marrySchedule_replace
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_marrySchedule_replace`;
CREATE PROCEDURE `sp_player_marrySchedule_replace`(IN `in_charguid` bigint, IN `in_mateguid` bigint,    
												   IN `in_roleName` varchar(32), IN `in_mateName` varchar(32), 
												   IN `in_roleProfId` int(10), IN `in_mateProfId` int(10),
												   IN `in_scheduleId` int, IN `in_scheduleTime` bigint, 
												   IN `in_invites` varchar(2048))
BEGIN
	REPLACE INTO tb_player_marry_schedule(`charguid`, `mateguid`, `roleName`, `mateName`, `roleProfId`, `mateProfId`, `scheduleId`, `scheduleTime`, invites) 
	VALUES(in_charguid, in_mateguid, in_roleName, in_mateName, in_roleProfId, in_mateProfId, in_scheduleId, in_scheduleTime, in_invites);
END;;
-- ----------------------------
-- Procedure structure for sp_player_marrySchedule_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_marrySchedule_clear`;
CREATE PROCEDURE `sp_player_marrySchedule_clear`(IN `in_charguid` bigint)
BEGIN
	DELETE FROM tb_player_marry_schedule WHERE charguid = in_charguid or mateguid = in_charguid;
END;;



-- ----------------------------
-- Procedure structure for tb_player_marry_invite_card
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_tb_player_marry_invite_card_query`;
CREATE PROCEDURE `sp_tb_player_marry_invite_card_query`(IN `in_charguid` bigint(20))
BEGIN
	SELECT * FROM tb_player_marry_invite_card WHERE charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_tb_player_marry_invite_card_add
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_tb_player_marry_invite_card_add`;
CREATE PROCEDURE `sp_tb_player_marry_invite_card_add`(IN `in_charguid` bigint(20), IN `in_mailGid` bigint(20), IN `in_inviteTime` bigint(20)
													 ,IN `in_scheduleId` int(10), IN `in_inviteRoleName` varchar(32), IN `in_inviteMateName` varchar(32)
													 ,IN `in_profId` int(10))
BEGIN
	REPLACE INTO tb_player_marry_invite_card(charguid, mailGid, inviteTime, scheduleId, inviteRoleName, inviteMateName, profId) 
	VALUES(in_charguid, in_mailGid, in_inviteTime, in_scheduleId, in_inviteRoleName, in_inviteMateName, in_profId);
END;;
-- ----------------------------
-- Procedure structure for sp_tb_player_marry_invite_card_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_tb_player_marry_invite_card_delete`;
CREATE PROCEDURE `sp_tb_player_marry_invite_card_delete`(IN `in_mailGid` bigint(20))
BEGIN
	DELETE FROM tb_player_marry_invite_card WHERE mailGid = in_mailGid AND inviteTime = 0;
END;;

-- ----------------------------
-- Procedure structure for sp_player_marryInfo_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_marryInfo_update_except_type`;
CREATE PROCEDURE `sp_player_marryInfo_update_except_type`(IN `in_charguid` bigint(20), IN `in_marryTime` bigint(20), IN `in_marryTraveled` int(11), IN `in_marryDinnered` int(11))
BEGIN
	UPDATE tb_player_marry_info SET marryTime = in_marryTime, marryTraveled = in_marryTraveled, marryDinnered = in_marryDinnered WHERE charguid = in_charguid;
END;;

-- ----------------------------
-- Procedure structure for sp_player_items
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_items_insert_update`;
CREATE PROCEDURE `sp_player_items_insert_update`(IN `in_charguid` bigint(20), IN `in_item_id` bigint, IN `in_item_tid` int, 
IN `in_slot_id` int, IN `in_stack_num` int, IN `in_flags` bigint, IN `in_bag` int ,IN `in_time_stamp` bigint,
IN `in_param1` int, IN `in_param2` int, IN `in_param3` int, IN `in_param4` bigint, IN `in_param5` bigint, IN `in_param6` varchar(64), IN `in_param7` varchar(64))
BEGIN
	INSERT INTO tb_player_items(charguid, item_id, item_tid, slot_id, stack_num, flags, bag, time_stamp,
	param1, param2, param3, param4, param5, param6, param7)
	VALUES (in_charguid, in_item_id, in_item_tid, in_slot_id, in_stack_num, in_flags, in_bag, in_time_stamp,
	in_param1, in_param2, in_param3, in_param4, in_param5, in_param6, in_param7) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid, item_id=in_item_id, item_tid=in_item_tid, slot_id=in_slot_id, 
	stack_num=in_stack_num, flags=in_flags, bag=in_bag, time_stamp = in_time_stamp, param1 = in_param1,
	param2 = in_param2, param3 = in_param3, param4 = in_param4, param5 = in_param5, param6 = in_param6, param7 = in_param7;
END;;

-- ----------------------------
-- Procedure structure for sp_player_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_extra_insert_update`;
CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(256), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(256), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(350),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int, IN `in_draw_cnt` int, IN `in_vitality_vip` int, IN `in_choujiang_num` int,
			IN `in_magickey_kl_num` int, IN `in_magickey_yl_num` int, IN `in_magickey_all_num` int, IN `in_monthcharge` int, IN `in_maxcharge` int, IN `in_hongyan_power` int, IN `in_hongyan_id` int, IN `in_hongyan_chuzhan_id` int, IN `in_HongYanHeTiTimes` int,
			IN `in_marrystren` int, IN `in_marrystrenwish` int)
BEGIN
	INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate,draw_cnt,vitality_vip, choujiang_num,magickey_kl_num,magickey_yl_num,magickey_all_num,
			monthcharge, maxcharge,hongyan_power,hongyan_id,hongyan_chuzhan_id,HongYanHeTiTimes,marrystren, marrystrenwish)
	VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate, in_draw_cnt,in_vitality_vip,in_choujiang_num,in_magickey_kl_num,in_magickey_yl_num,in_magickey_all_num,
			in_monthcharge, in_maxcharge,in_hongyan_power,in_hongyan_id,in_hongyan_chuzhan_id,in_HongYanHeTiTimes,
			in_marrystren, in_marrystrenwish)
	ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, 
			petstate = in_petstate,draw_cnt=in_draw_cnt, vitality_vip = in_vitality_vip,choujiang_num=in_choujiang_num,magickey_kl_num=in_magickey_kl_num,magickey_yl_num=in_magickey_yl_num,magickey_all_num=in_magickey_all_num,
			monthcharge = in_monthcharge, maxcharge = in_maxcharge,hongyan_power=in_hongyan_power,hongyan_id=in_hongyan_id,hongyan_chuzhan_id=in_hongyan_chuzhan_id,HongYanHeTiTimes=in_HongYanHeTiTimes,
			marrystren = in_marrystren, marrystrenwish = in_marrystrenwish;
END;;
#***************************************************************
##版本400修改完成
#***************************************************************
#***************************************************************
##版本401修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_delete_magickey_god
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_delete_magickey_god`;
CREATE PROCEDURE `sp_delete_magickey_god`(IN `in_charguid` bigint)
BEGIN
	DELETE FROM tb_magickeygod_bag WHERE charguid = in_charguid;
END;;
#***************************************************************
##版本401修改完成
#***************************************************************
#***************************************************************
##版本402修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_XNzhuanpan_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_XNzhuanpan_insert_update`;
CREATE PROCEDURE `sp_player_XNzhuanpan_insert_update` (IN `in_charguid` bigint, IN `in_currLoginTime` bigint, IN `in_currCount` int, IN `in_freeCount` int, IN in_comPosList varchar(64))
BEGIN
  INSERT INTO tb_player_XNzhuanpan(charguid, currLoginTime, currCount, freeCount, comPosList)
  VALUES (in_charguid, in_currLoginTime, in_currCount, in_freeCount, in_comPosList) 
  ON DUPLICATE KEY UPDATE charguid=in_charguid, currLoginTime=in_currLoginTime, currCount=in_currCount, freeCount=in_freeCount, comPosList=in_comPosList;
END;;
-- ----------------------------
-- Procedure structure for sp_player_XNzhuanpan_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_XNzhuanpan_select`;
CREATE  PROCEDURE `sp_player_XNzhuanpan_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_XNzhuanpan where charguid=in_charguid;
END;;
#***************************************************************
##版本402修改完成
#***************************************************************
#***************************************************************
##版本403修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_XNhongbao_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_XNhongbao_insert_update`;
CREATE PROCEDURE `sp_player_XNhongbao_insert_update` (IN `in_charguid` bigint, IN `in_actId` bigint, IN `in_id` int, IN `in_num` int)
BEGIN
  INSERT INTO tb_player_XNhongbao(charguid, actId, id, num)
  VALUES (in_charguid, in_actId, in_id, in_num) 
  ON DUPLICATE KEY UPDATE num=in_num;
END;;
-- ----------------------------
-- Procedure structure for sp_player_XNhongbao_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_XNhongbao_select`;
CREATE  PROCEDURE `sp_player_XNhongbao_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_XNhongbao where charguid=in_charguid;
END;;
#***************************************************************
##版本403修改完成
#***************************************************************
#***************************************************************
##版本404修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_lunpan_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_lunpan_select_by_id`;
CREATE PROCEDURE `sp_player_lunpan_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT *  FROM tb_player_lunpan WHERE charguid = in_charguid;
END;;
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_lunpan_insert_update`;
CREATE PROCEDURE `sp_lunpan_insert_update`(IN `in_charguid` bigint,  IN `in_lunpan_attr` varchar(128))
BEGIN
	INSERT INTO tb_player_lunpan(charguid, lunpan_attr)
	VALUES (in_charguid, in_lunpan_attr)
	ON DUPLICATE KEY UPDATE charguid=in_charguid, lunpan_attr=in_lunpan_attr;
END;;
#***************************************************************
##版本404修改完成
#***************************************************************
#***************************************************************
##版本405修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_xnbaojiaozi_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_xnbaojiaozi_insert_update`;
CREATE PROCEDURE `sp_player_xnbaojiaozi_insert_update`(IN `in_charguid` bigint,IN `in_id` int, IN `in_num` int)
BEGIN
	INSERT INTO tb_player_xnbaojiaozi(charguid,`id`,num) VALUES (in_charguid,in_id,in_num)
	ON DUPLICATE KEY UPDATE num = in_num;
END;;
-- ----------------------------
-- Procedure structure for sp_player_xnbaojiaozi_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_xnbaojiaozi_select`;
CREATE PROCEDURE `sp_player_xnbaojiaozi_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_xnbaojiaozi where charguid=in_charguid;
END;;
#***************************************************************
##版本405修改完成
#***************************************************************
#***************************************************************
##版本406修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_player_wuxing_pro
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_wuxing_pro`;
CREATE PROCEDURE `sp_select_player_wuxing_pro`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_wuxing_pro WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_wuxing_pro_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_wuxing_pro_insert_update`;
CREATE PROCEDURE `sp_player_wuxing_pro_insert_update`(IN `in_charguid` bigint, IN `in_lv` int, IN `in_progress` int, IN `in_attrdan` int)
BEGIN
	INSERT INTO tb_player_wuxing_pro(charguid, lv, progress,attrdan)
	VALUES (in_charguid, in_lv, in_progress,in_attrdan)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, lv = in_lv, progress = in_progress, attrdan = in_attrdan;
END ;;
-- ----------------------------
-- Procedure structure for sp_select_player_wuxing_item
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_wuxing_item`;
CREATE PROCEDURE `sp_select_player_wuxing_item`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_wuxing_item WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_wuxing_item_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_wuxing_item_insert_update`;
CREATE PROCEDURE `sp_player_wuxing_item_insert_update`(IN `in_charguid` bigint, IN `in_itemgid` bigint, IN `in_itemtid` int, IN `in_pos` int, IN `in_type` int,
IN `in_att1` varchar(60), IN `in_att2` varchar(60), IN `in_att3` varchar(60), IN `in_att4` varchar(60), IN `in_att5` varchar(60), IN `in_time_stamp` bigint)
BEGIN
	INSERT INTO tb_player_wuxing_item(charguid, itemgid, itemtid, pos, type, att1, att2, att3, att4, att5, time_stamp)
	VALUES (in_charguid, in_itemgid,in_itemtid,in_pos,in_type,in_att1,in_att2,in_att3,in_att4,in_att5,in_time_stamp)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, itemgid = in_itemgid, itemtid = in_itemtid, pos = in_pos, type = in_type,
	att1 = in_att1, att2 = in_att2, att3 = in_att3, att4 = in_att4, att5 = in_att5, time_stamp = in_time_stamp;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_wuxing_item_delete_by_id_and_timestamp
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_wuxing_item_delete_by_id_and_timestamp`;
CREATE PROCEDURE `sp_player_wuxing_item_delete_by_id_and_timestamp`(IN `in_charguid` bigint, IN `in_time_stamp` bigint)
BEGIN
  DELETE FROM tb_player_wuxing_item WHERE charguid = in_charguid AND time_stamp <> in_time_stamp;
END;;
#***************************************************************
##版本406修改完成
#***************************************************************
#***************************************************************
##版本407修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_insert_update_smelt
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_smelt`;
CREATE PROCEDURE `sp_insert_update_smelt`(IN `in_charguid` bigint, IN `in_smelt_level` int, IN `in_smelt_exp` int,
 IN `in_smelt_flags` bigint, IN `in_smelt_level_1` int, IN `in_smelt_curr_exp` int, IN `in_smelt_curr_exp_1` int)
BEGIN
	INSERT INTO tb_player_smelt(charguid,smelt_level,smelt_exp,smelt_flags, `smelt_level_1`, `smelt_curr_exp`, `smelt_curr_exp_1`)
	VALUES (in_charguid,in_smelt_level,in_smelt_exp,in_smelt_flags,`in_smelt_level_1`, `in_smelt_curr_exp`, `in_smelt_curr_exp_1`) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid, smelt_level=in_smelt_level, 
	smelt_exp=in_smelt_exp, smelt_flags=in_smelt_flags, smelt_level_1=`in_smelt_level_1`, smelt_curr_exp=`in_smelt_curr_exp`, smelt_curr_exp_1=`in_smelt_curr_exp_1`;
END;;
#***************************************************************
##版本407修改完成
#***************************************************************
#***************************************************************
##版本408修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_mail_info_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_mail_info_by_id`;
CREATE PROCEDURE `sp_select_mail_info_by_id`(IN `in_charguid` bigint, IN `in_createtime` bigint)
BEGIN
	DECLARE cur_time bigint DEFAULT '0';
	SET cur_time = UNIX_TIMESTAMP(now());
	
	SELECT * FROM (SELECT IFNULL(tb_mail.charguid, 0) AS guid, IFNULL(tb_mail.readflag, 0) AS readflag, IFNULL(tb_mail.deleteflag, 0) AS deleteflag, 
		IFNULL(tb_mail.recvflag, 0) AS recvflag, tb_mail_content.* FROM tb_mail RIGHT JOIN tb_mail_content 
	ON tb_mail.mailgid = tb_mail_content.mailgid AND tb_mail_content.validtime > cur_time WHERE charguid = in_charguid AND deleteflag = 0
	UNION ALL
	SELECT 0, 0, 0, 0, tb_mail_content.* FROM tb_mail_content WHERE refflag = 1 AND tb_mail_content.validtime > cur_time AND tb_mail_content.sendtime > in_createtime AND NOT EXISTS 
	(SELECT tb_mail.mailgid FROM tb_mail WHERE tb_mail_content.mailgid = tb_mail.mailgid AND charguid = in_charguid))t ORDER BY validtime DESC;
END;;
-- ----------------------------
-- Procedure structure for sp_relation_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_relation_select_by_id`;
CREATE PROCEDURE `sp_relation_select_by_id`(IN `in_charguid` bigint)
BEGIN
  SELECT * FROM tb_relation WHERE charguid=in_charguid and relation_type <> 0 ;
END;;
#***************************************************************
#***************************************************************
##版本409修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_magic_fix_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_magic_fix_insert_update`;
CREATE PROCEDURE `sp_player_magic_fix_insert_update`(IN `in_charguid` bigint, IN `in_id` int, IN `in_giveCount` int)
BEGIN
	INSERT INTO tb_player_magic_fix(charguid, id, giveCount)
	VALUES (in_charguid, in_id, in_giveCount) 
	ON DUPLICATE KEY UPDATE giveCount=`in_giveCount`;
END;;
-- ----------------------------
-- Procedure structure for sp_player_magic_fix_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_magic_fix_select`;
CREATE PROCEDURE `sp_player_magic_fix_select`(IN `in_charguid` bigint)
BEGIN
  SELECT * FROM tb_player_magic_fix WHERE charguid=in_charguid;
END;;
#***************************************************************
##版本409修改完成
#***************************************************************
#***************************************************************
##版本410修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_extra_insert_update`;
CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(256), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(1024), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(512),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int, IN `in_draw_cnt` int, IN `in_vitality_vip` int, IN `in_choujiang_num` int,
			IN `in_magickey_kl_num` int, IN `in_magickey_yl_num` int, IN `in_magickey_all_num` int, IN `in_monthcharge` int, IN `in_maxcharge` int, IN `in_hongyan_power` int, IN `in_hongyan_id` int, IN `in_hongyan_chuzhan_id` int, IN `in_HongYanHeTiTimes` int,
			IN `in_marrystren` int, IN `in_marrystrenwish` int)
BEGIN
	INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate,draw_cnt,vitality_vip, choujiang_num,magickey_kl_num,magickey_yl_num,magickey_all_num,
			monthcharge, maxcharge,hongyan_power,hongyan_id,hongyan_chuzhan_id,HongYanHeTiTimes,marrystren, marrystrenwish)
	VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate, in_draw_cnt,in_vitality_vip,in_choujiang_num,in_magickey_kl_num,in_magickey_yl_num,in_magickey_all_num,
			in_monthcharge, in_maxcharge,in_hongyan_power,in_hongyan_id,in_hongyan_chuzhan_id,in_HongYanHeTiTimes,
			in_marrystren, in_marrystrenwish)
	ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, 
			petstate = in_petstate,draw_cnt=in_draw_cnt, vitality_vip = in_vitality_vip,choujiang_num=in_choujiang_num,magickey_kl_num=in_magickey_kl_num,magickey_yl_num=in_magickey_yl_num,magickey_all_num=in_magickey_all_num,
			monthcharge = in_monthcharge, maxcharge = in_maxcharge,hongyan_power=in_hongyan_power,hongyan_id=in_hongyan_id,hongyan_chuzhan_id=in_hongyan_chuzhan_id,HongYanHeTiTimes=in_HongYanHeTiTimes,
			marrystren = in_marrystren, marrystrenwish = in_marrystrenwish;
END;;
#***************************************************************
##版本410修改完成
#***************************************************************
#***************************************************************
##版本411修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_minglun_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_minglun_insert_update`;
CREATE PROCEDURE `sp_player_minglun_insert_update`(IN `in_charguid` bigint, IN `in_lvl` int, IN `in_process` int, IN `in_sel` int
, IN `in_proce_num` int,IN `in_total_proce` int, IN `in_attrdan` int)
BEGIN
	INSERT INTO tb_player_minglun(charguid, level, process, sel, proce_num, total_proce, attrdan)
	VALUES (in_charguid, in_lvl, in_process, in_sel, in_proce_num, in_total_proce, in_attrdan)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, level = in_lvl, process = in_process, sel = in_sel, proce_num = in_proce_num, total_proce = in_total_proce, attrdan = in_attrdan;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_minglun_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_minglun_select_by_id`;
CREATE PROCEDURE `sp_player_minglun_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_minglun WHERE charguid=in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_rank_minglun
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_rank_minglun`;
CREATE PROCEDURE `sp_rank_minglun`()
BEGIN
	SELECT tb_player_minglun.charguid AS uid, tb_player_minglun.level AS rankvalue FROM tb_player_minglun left join tb_player_info
	on tb_player_minglun.charguid = tb_player_info.charguid
	WHERE tb_player_minglun.level > 0 ORDER BY tb_player_minglun.level DESC, process DESC, tb_player_info.power DESC LIMIT 100;
END;;
-- ----------------------------
-- Procedure structure for sp_select_rank_minglun
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_minglun`;
CREATE PROCEDURE `sp_select_rank_minglun`()
BEGIN
	SELECT * FROM tb_rank_minglun;
END;;
-- ----------------------------
-- Procedure structure for sp_update_rank_minglun
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_rank_minglun`;
CREATE PROCEDURE `sp_update_rank_minglun`(IN `in_rank` int, IN `in_charguid` bigint, IN `in_lastrank` int, IN `in_rankvalue` bigint)
BEGIN
	INSERT INTO tb_rank_minglun(rank, charguid, lastrank, rankvalue)
	VALUES (in_rank, in_charguid, in_lastrank, in_rankvalue)
	ON DUPLICATE KEY UPDATE rank = in_rank, charguid = in_charguid, lastrank = in_lastrank, rankvalue = in_rankvalue;
END;;
#***************************************************************
##版本411修改完成
#***************************************************************
#***************************************************************
##版本412修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_max_charge_role
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_max_charge_role`;
CREATE PROCEDURE `sp_select_max_charge_role`()
BEGIN
	select role_id, sum(money) as totalmoney from tb_exchange_record group by role_id order by sum(money) desc limit 1;
END;;

-- ----------------------------
-- Procedure structure for sp_select_total_charge_perday
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_total_charge_perday`;
CREATE PROCEDURE `sp_select_total_charge_perday`(IN `in_date` VARCHAR(32), IN `in_min` int)
BEGIN
	select IFNULL(sum(totalmoney),0) as allmoney from (select role_id, sum(money) as totalmoney from (select * from tb_exchange_record where TO_DAYS(FROM_UNIXTIME(time)) = TO_DAYS(in_date)) as total_charge group by role_id) as total where totalmoney > in_min;
END;;
#***************************************************************
##版本412修改完成
#***************************************************************
#***************************************************************
##版本413修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_yuanxiaoduihuan_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_yuanxiaoduihuan_insert_update`;
CREATE PROCEDURE `sp_player_yuanxiaoduihuan_insert_update`(IN `in_charguid` bigint,IN `in_id` int, IN `in_num` int)
BEGIN
	INSERT INTO tb_player_yuanxiaoduihuan(charguid,`id`,num) VALUES (in_charguid,in_id,in_num)
	ON DUPLICATE KEY UPDATE num = in_num;
END;;
-- ----------------------------
-- Procedure structure for sp_player_yuanxiaoduihuan_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_yuanxiaoduihuan_select`;
CREATE PROCEDURE `sp_player_yuanxiaoduihuan_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_yuanxiaoduihuan where charguid=in_charguid;
END;;
#***************************************************************
##版本413修改完成
#***************************************************************
#***************************************************************
##版本414修改开始
#***************************************************************
DROP PROCEDURE IF EXISTS `sp_player_wuxing_pro_insert_update`;
CREATE PROCEDURE `sp_player_wuxing_pro_insert_update`(IN `in_charguid` bigint, IN `in_lv` int, IN `in_progress` int, IN `in_attrdan` int, IN `in_attrdanper` int)
BEGIN
	INSERT INTO tb_player_wuxing_pro(charguid, lv, progress,attrdan, attrdanper)
	VALUES (in_charguid, in_lv, in_progress,in_attrdan,in_attrdanper)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, lv = in_lv, progress = in_progress, attrdan = in_attrdan, attrdanper = in_attrdanper;
END ;;
#***************************************************************
##版本414修改完成
#***************************************************************
#***************************************************************
##版本415修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_player_hunqi_insert_update`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_hunqi_insert_update`;
CREATE PROCEDURE `sp_player_hunqi_insert_update`(IN `in_charguid` bigint, IN `in_level` int, IN `in_wish` int, IN `in_use_level` int, IN `in_attr_dan` int,IN `in_AllNum` int, IN `in_KeLingQuNum` int, IN `in_YiLingQuNum` int)
BEGIN
	INSERT INTO tb_player_hunqi(charguid, level, wish, use_level, attr_dan, AllNum, KeLingQuNum, YiLingQuNum)
	VALUES (in_charguid, in_level, in_wish, in_use_level, in_attr_dan, in_AllNum, in_KeLingQuNum, in_YiLingQuNum)
	ON DUPLICATE KEY UPDATE level=in_level, wish=in_wish, use_level=in_use_level, attr_dan=in_attr_dan, AllNum=in_AllNum, KeLingQuNum=in_KeLingQuNum, YiLingQuNum=in_YiLingQuNum;
END;;
-- ----------------------------
-- Procedure structure for `sp_player_hunqi_select_by_id`
-- ----------------------------
DROP procedure IF EXISTS `sp_player_hunqi_select_by_id`;
CREATE PROCEDURE `sp_player_hunqi_select_by_id` (in in_charguid bigint)
BEGIN
	select * from tb_player_hunqi where charguid=in_charguid;
END;;
-- ----------------------------
-- Procedure structure for `sp_rank_hunqi`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_rank_hunqi`;
CREATE PROCEDURE `sp_rank_hunqi` ()
BEGIN
SELECT a.charguid AS uid, a.level AS rankvalue FROM tb_player_hunqi as a left join tb_player_info as b
on a.charguid = b.charguid WHERE a.level > 0 ORDER BY a.level DESC, a.wish DESC, b.power DESC LIMIT 100;
END;;
-- ----------------------------
-- Procedure structure for `sp_update_rank_hunqi`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_rank_hunqi`;
CREATE PROCEDURE `sp_update_rank_hunqi`(IN `in_rank` int, IN `in_charguid` bigint, IN `in_lastrank` int, IN `in_rankvalue` bigint)
BEGIN
	INSERT INTO tb_rank_hunqi(rank, charguid, lastrank, rankvalue)
	VALUES (in_rank, in_charguid, in_lastrank, in_rankvalue)
	ON DUPLICATE KEY UPDATE rank = in_rank, charguid = in_charguid, lastrank = in_lastrank, rankvalue = in_rankvalue;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_hunqi`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_hunqi`;
CREATE PROCEDURE `sp_select_rank_hunqi`()
BEGIN
	SELECT * FROM tb_rank_hunqi;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_player_info_by_ls`
-- ----------------------------
DROP procedure IF EXISTS `sp_select_player_info_by_ls`;
CREATE PROCEDURE `sp_select_player_info_by_ls`(IN `in_account_id` bigint)
BEGIN
	SELECT name, level, prof, iconid, power, vip_level, head, suit, weapon, wingid, suitflag, exts,charguid,UNIX_TIMESTAMP(tb_player_info.last_logout) as last_logout,forb_type,forb_acc_time,forb_acc_last,
	    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
	    IFNULL((select use_level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as piFengLevel,
	    IFNULL((select curr_id from tb_player_guanzhi where charguid=tb_player_info.charguid limit 1),0) as guanzhi,
	    IFNULL((select use_level from tb_player_baojia where charguid=tb_player_info.charguid limit 1),0) as BaoJiaLevel,
	    IFNULL((select use_level from tb_player_tiangang where charguid=tb_player_info.charguid limit 1),0) as TianGangLevel,
		IFNULL((select hongyan_power from tb_player_extra where charguid=tb_player_info.charguid limit 1),0) as HongyanPower,
	    IFNULL((select use_level from tb_player_hunqi where charguid=tb_player_info.charguid limit 1),0) as HunQiLevel
	FROM tb_player_info 
	WHERE in_account_id = account_id;
END;;
-- ----------------------------
-- Procedure structure for `sp_select_rank_human_info_base`
-- ----------------------------
DROP procedure IF EXISTS `sp_select_rank_human_info_base`;
CREATE PROCEDURE `sp_select_rank_human_info_base`(IN `in_id` bigint)
BEGIN
	SELECT charguid, name, prof, level, hp, mp, power, vip_level, sex, dress, glorylevel,
arms, head, suit, weapon, hunli, tipo, shenfa, jingshen, vplan, wingid, shenbingid, suitflag,crossscore,txvipflag, txbvipflag,
    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
    IFNULL((select use_level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as piFengLevel,
    IFNULL((select curr_id from tb_player_guanzhi where charguid=tb_player_info.charguid limit 1),0) as guanzhi,
    IFNULL((select use_level from tb_player_baojia where charguid=tb_player_info.charguid limit 1),0) as BaoJiaLevel,
    IFNULL((select use_level from tb_player_tiangang where charguid=tb_player_info.charguid limit 1),0) as TianGangLevel,
	IFNULL((select hongyan_id from tb_player_extra where charguid=tb_player_info.charguid limit 1),0) as HongyanId,
	IFNULL((select use_level from tb_player_hunqi where charguid=tb_player_info.charguid limit 1),0) as HunQiLevel
FROM tb_player_info WHERE charguid = in_id;
END;;
#***************************************************************
##版本415修改完成
#***************************************************************
#***************************************************************
##版本416修改开始
#***************************************************************
DROP PROCEDURE IF EXISTS `sp_lunpan_insert_update`;
CREATE PROCEDURE `sp_lunpan_insert_update`(IN `in_charguid` bigint,  IN `in_lunpan_attr` varchar(128), IN `in_lunpan_num` int)
BEGIN
	INSERT INTO tb_player_lunpan(charguid, lunpan_attr, lunpan_num)
	VALUES (in_charguid, in_lunpan_attr, in_lunpan_num)
	ON DUPLICATE KEY UPDATE charguid=in_charguid, lunpan_attr=in_lunpan_attr, lunpan_num = in_lunpan_num;
END;;
#***************************************************************
##版本416修改完成
#***************************************************************
#***************************************************************
##版本417修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_insert_update_gunxueqiu
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_insert_update_gunxueqiu`;
CREATE PROCEDURE `sp_player_insert_update_gunxueqiu`(IN `in_charguid` bigint, IN `in_day_1` int, IN `in_day_2` int, IN `in_day_3` int, IN `in_lingqu` int, IN `in_qifutime` bigint)
BEGIN
	INSERT INTO tb_player_gunxueqiu(charguid, day_1, day_2, day_3, lingqu, qifutime)
	VALUES (in_charguid, in_day_1, in_day_2, in_day_3, in_lingqu, in_qifutime)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, day_1 = in_day_1, day_2 = in_day_2, day_3 = in_day_3, lingqu = in_lingqu, qifutime = in_qifutime;
END;;
-- ----------------------------
-- Procedure structure for sp_player_select_gunxueqiu
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_select_gunxueqiu`;
CREATE PROCEDURE `sp_player_select_gunxueqiu`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_gunxueqiu where charguid = in_charguid;
END;;
#***************************************************************
##版本417修改完成
#***************************************************************
#***************************************************************
##版本418修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_sbbingling_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_sbbingling_insert_update`;
CREATE PROCEDURE `sp_player_sbbingling_insert_update`(IN `in_charguid` bigint, IN `in_type` int, IN `in_level` int)
BEGIN
	INSERT INTO tb_player_sbbingling(charguid, type, level)
	VALUES (in_charguid, in_type, in_level)
	ON DUPLICATE KEY UPDATE level = in_level;
END;;
-- ----------------------------
-- Procedure structure for sp_player_sbbingling_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_sbbingling_select`;
CREATE PROCEDURE `sp_player_sbbingling_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_sbbingling where charguid = in_charguid;
END;;
#***************************************************************
##版本418修改完成
#***************************************************************
#***************************************************************
##版本419修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_insert_update_xnhongbao_activity
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_xnhongbao_activity`;
CREATE PROCEDURE `sp_insert_update_xnhongbao_activity`(IN `in_actId` bigint, IN `in_id` int, IN `in_num` int)
BEGIN
	INSERT INTO tb_xnhongbao(actId, id, num)
	VALUES (in_actId,in_id, in_num)
	ON DUPLICATE KEY UPDATE num = in_num;
END;;
-- ----------------------------
-- Procedure structure for sp_select_xnhongbao_activity
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_xnhongbao_activity`;
CREATE PROCEDURE `sp_select_xnhongbao_activity`()
BEGIN
	select * from tb_xnhongbao;
END;;
-- ----------------------------
-- Procedure structure for sp_clear_xnhongbao_activity
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_clear_xnhongbao_activity`;
CREATE PROCEDURE `sp_clear_xnhongbao_activity`(IN `in_actId` bigint)
BEGIN
	delete from tb_xnhongbao where actId = in_actId;
END;;
#***************************************************************
##版本419修改完成
#***************************************************************
#***************************************************************
##版本421修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_player_horse_gem
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_horse_gem`;
CREATE PROCEDURE `sp_select_player_horse_gem`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_horse_gem WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_horse_gem_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_horse_gem_insert_update`;
CREATE PROCEDURE `sp_player_horse_gem_insert_update`(IN `in_charguid` bigint, IN `in_id` int)
BEGIN
	INSERT INTO tb_player_horse_gem(charguid, id)
	VALUES (in_charguid, in_id)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, id = in_id;
END ;;
-- ----------------------------
-- Procedure structure for sp_select_player_horse_gem_item
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_horse_gem_item`;
CREATE PROCEDURE `sp_select_player_horse_gem_item`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_horse_gem_item WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_horse_gem_item_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_horse_gem_item_insert_update`;
CREATE PROCEDURE `sp_player_horse_gem_item_insert_update`(IN `in_charguid` bigint, IN `in_itemgid` bigint, IN `in_itemtid` int, IN `in_pos` int, IN `in_type` int,
 IN `in_time_stamp` bigint)
BEGIN
	INSERT INTO tb_player_horse_gem_item(charguid, itemgid, itemtid, pos, type, time_stamp)
	VALUES (in_charguid, in_itemgid,in_itemtid,in_pos,in_type,in_time_stamp)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, itemgid = in_itemgid, itemtid = in_itemtid, pos = in_pos, type = in_type,
	 time_stamp = in_time_stamp;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_horse_gem_item_delete_by_id_and_timestamp
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_horse_gem_item_delete_by_id_and_timestamp`;
CREATE PROCEDURE `sp_player_horse_gem_item_delete_by_id_and_timestamp`(IN `in_charguid` bigint, IN `in_time_stamp` bigint)
BEGIN
  DELETE FROM tb_player_horse_gem_item WHERE charguid = in_charguid AND time_stamp <> in_time_stamp;
END;;
#***************************************************************
##版本421修改完成
#***************************************************************
#***************************************************************
##版本422修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_shengqi_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_shengqi_insert_update`;
CREATE PROCEDURE `sp_player_shengqi_insert_update`(IN `in_charguid` bigint, IN `in_lvl` int, IN `in_process` int, IN `in_sel` int
, IN `in_proce_num` int,IN `in_total_proce` int, IN `in_attrdan` int)
BEGIN
	INSERT INTO tb_player_shengqi(charguid, level, process, sel, proce_num, total_proce, attrdan)
	VALUES (in_charguid, in_lvl, in_process, in_sel, in_proce_num, in_total_proce, in_attrdan)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, level = in_lvl, process = in_process, sel = in_sel, proce_num = in_proce_num, total_proce = in_total_proce, attrdan = in_attrdan;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_shengqi_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_shengqi_select_by_id`;
CREATE PROCEDURE `sp_player_shengqi_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_shengqi WHERE charguid=in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_rank_shengqi
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_rank_shengqi`;
CREATE PROCEDURE `sp_rank_shengqi`()
BEGIN
	SELECT tb_player_shengqi.charguid AS uid, tb_player_shengqi.level AS rankvalue FROM tb_player_shengqi left join tb_player_info
	on tb_player_shengqi.charguid = tb_player_info.charguid
	WHERE tb_player_shengqi.level > 0 ORDER BY tb_player_shengqi.level DESC, process DESC, tb_player_info.power DESC LIMIT 100;
END;;
-- ----------------------------
-- Procedure structure for sp_select_rank_shengqi
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_shengqi`;
CREATE PROCEDURE `sp_select_rank_shengqi`()
BEGIN
	SELECT * FROM tb_rank_shengqi;
END;;
-- ----------------------------
-- Procedure structure for sp_update_rank_shengqi
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_rank_shengqi`;
CREATE PROCEDURE `sp_update_rank_shengqi`(IN `in_rank` int, IN `in_charguid` bigint, IN `in_lastrank` int, IN `in_rankvalue` bigint)
BEGIN
	INSERT INTO tb_rank_shengqi(rank, charguid, lastrank, rankvalue)
	VALUES (in_rank, in_charguid, in_lastrank, in_rankvalue)
	ON DUPLICATE KEY UPDATE rank = in_rank, charguid = in_charguid, lastrank = in_lastrank, rankvalue = in_rankvalue;
END;;
#***************************************************************
##版本422修改完成
#***************************************************************
#***************************************************************
##版本423修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_pifengext_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_pifengext_insert_update`;
CREATE PROCEDURE `sp_player_pifengext_insert_update`(IN `in_charguid` bigint, IN `in_type` int, IN `in_level` int)
BEGIN
	INSERT INTO tb_player_pifengext(charguid, type, level)
	VALUES (in_charguid, in_type, in_level)
	ON DUPLICATE KEY UPDATE level = in_level;
END;;
-- ----------------------------
-- Procedure structure for sp_player_pifengext_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_pifengext_select`;
CREATE PROCEDURE `sp_player_pifengext_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_pifengext where charguid = in_charguid;
END;;
#***************************************************************
##版本423修改完成
#***************************************************************
#***************************************************************
##版本424修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_insert_or_update_player_pvp_info
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_or_update_player_pvp_info`;
CREATE PROCEDURE `sp_insert_or_update_player_pvp_info`(IN `in_charguid` bigint, IN `in_curcnt` int, IN `in_totalcnt` int, IN `in_wincnt` int,
IN `in_contwincnt` int, IN `in_flags` int, IN `in_crossscore3` int, IN `in_crosscnt3` int)
BEGIN
	INSERT INTO tb_player_crosspvp(charguid, curcnt, totalcnt, wincnt, contwincnt, flags, crossscore3, crosscnt3)
	VALUES (in_charguid, in_curcnt, in_totalcnt, in_wincnt, in_contwincnt, in_flags, in_crossscore3, in_crosscnt3) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid, curcnt=in_curcnt, totalcnt = in_totalcnt, 
	wincnt = in_wincnt, contwincnt = in_contwincnt, flags = in_flags, crossscore3 = in_crossscore3, crosscnt3 = in_crosscnt3;
END;;
#***************************************************************
##版本424修改完成
#***************************************************************
#***************************************************************
##版本425修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_star
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_star`;
CREATE PROCEDURE `sp_select_star`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_star WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_update_star
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_star`;
CREATE PROCEDURE `sp_update_star`(IN `in_charguid` bigint, IN `in_id` int, IN `in_point` int, IN `in_round` int)
BEGIN
	INSERT INTO tb_player_star(charguid, star, point, round)
	VALUES (in_charguid, in_id, in_point, in_round)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, star = in_id, point = in_point, round = in_round;
END ;;
#***************************************************************
##版本425修改完成
#***************************************************************
#***************************************************************
##版本426修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_secret_sweep_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_secret_sweep_select`;
CREATE PROCEDURE `sp_player_secret_sweep_select`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_secret_sweep WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_secret_sweep_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_secret_sweep_insert_update`;
CREATE PROCEDURE `sp_player_secret_sweep_insert_update`(IN `in_charguid` bigint, IN `in_id` int, IN `in_num` int, IN `in_time` bigint)
BEGIN
	INSERT INTO tb_player_secret_sweep(charguid, id, num, time)
	VALUES (in_charguid, in_id, in_num, in_time)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, id = in_id, num = in_num, time = in_time;
END ;;
#***************************************************************
##版本426修改完成
#***************************************************************
#***************************************************************
##版本427修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_equips_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_equips_insert_update`;
CREATE PROCEDURE `sp_player_equips_insert_update`(IN `in_charguid` bigint, IN `in_item_id` bigint, IN `in_item_tid` int, IN `in_slot_id` int,
	 IN `in_stack_num` int, IN `in_flags` bigint,IN `in_bag` int, IN `in_strenid` int, IN `in_strenval` int, IN `in_proval` int, IN `in_extralv` int,
	 IN `in_superholenum` int, IN `in_super1` varchar(64),IN `in_super2` varchar(64),IN `in_super3` varchar(64),IN `in_super4` varchar(64),
	 IN `in_super5` varchar(64), IN `in_super6` varchar(64), IN `in_super7` varchar(64), IN `in_newsuper` varchar(64), IN `in_time_stamp` bigint,
	 IN `in_newgroup` int, IN `in_newgroupbind` bigint, IN `in_wash` varchar(64), IN `in_NewGroupLevel` int, IN `in_jinglian` int, IN `in_godlevel` int)
BEGIN
	INSERT INTO tb_player_equips(charguid, item_id, item_tid, slot_id, stack_num, flags, bag, strenid, strenval, proval, extralv, superholenum,
	super1, super2, super3, super4, super5, super6, super7, newsuper, time_stamp, newgroup, newgroupbind, wash, NewGroupLevel, jinglian, godlevel)
	VALUES (in_charguid, in_item_id, in_item_tid, in_slot_id, in_stack_num, in_flags, in_bag, in_strenid, in_strenval, in_proval, in_extralv,
	in_superholenum, in_super1, in_super2, in_super3, in_super4, in_super5, in_super6, in_super7, in_newsuper, in_time_stamp, 
	in_newgroup, in_newgroupbind, in_wash, in_NewGroupLevel, in_jinglian, in_godlevel) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid, item_id=in_item_id, item_tid=in_item_tid, slot_id=in_slot_id, 
	stack_num=in_stack_num, flags=in_flags, bag=in_bag, strenid=in_strenid, strenval=in_strenval,proval=in_proval, extralv=in_extralv, 
	superholenum=in_superholenum, super1=in_super1, super2=in_super2, super3=in_super3, super4=in_super4, 
	super5=in_super5,super6=in_super6,super7=in_super7,newsuper=in_newsuper,time_stamp = in_time_stamp,newgroup=in_newgroup,newgroupbind = in_newgroupbind,
	wash = in_wash, NewGroupLevel=in_NewGroupLevel, jinglian=in_jinglian, godlevel=in_godlevel;
END;;
-- ----------------------------
-- Procedure structure for sp_change_role_name
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_change_role_name`;
CREATE PROCEDURE `sp_change_role_name`(IN `in_charguid` bigint, IN `in_name` varchar(64))
BEGIN
	UPDATE tb_player_info SET name = in_name WHERE charguid = in_charguid;
END;;
#***************************************************************
#***************************************************************
#***************************************************************
##版本428修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_update_new_babel
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_new_babel`;
CREATE PROCEDURE `sp_update_new_babel`(IN `in_charguid` bigint, IN `in_level` int, IN `in_time` int, IN `in_count` int )
BEGIN
	INSERT INTO tb_new_babel(charguid, level, time, count)
	VALUES (in_charguid, in_level, in_time, in_count) 
	ON DUPLICATE KEY UPDATE  level = in_level, time = in_time, count = in_count;
END;;
-- ----------------------------
-- Procedure structure for sp_select_new_babel
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_new_babel`;
CREATE PROCEDURE `sp_select_new_babel`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_new_babel WHERE charguid = in_charguid;
END;;
#***************************************************************
##版本428修改完成
#***************************************************************
##版本429修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_wingexit_active_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_wingexit_active_insert_update`;
CREATE PROCEDURE `sp_player_wingexit_active_insert_update`(IN `in_charguid` bigint, IN `in_id` int, IN `in_isactive` int)
BEGIN
	INSERT INTO tb_player_wingexit_active(charguid, id, isactive)
	VALUES (in_charguid, in_id, in_isactive) 
	ON DUPLICATE KEY UPDATE isactive=in_isactive;
END;;
-- ----------------------------
-- Procedure structure for sp_player_wingexit_active_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_wingexit_active_select`;
CREATE PROCEDURE `sp_player_wingexit_active_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_wingexit_active WHERE charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_player_wingexit_count_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_wingexit_count_insert_update`;
CREATE PROCEDURE `sp_player_wingexit_count_insert_update`(IN `in_charguid` bigint, IN `in_id` int, IN `in_type` int, IN `in_num` int, IN `in_time` bigint)
BEGIN
	INSERT INTO tb_player_wingexit_count(charguid, id, `type`, num, `time`)
	VALUES (in_charguid, in_id, in_type, in_num, in_time) 
	ON DUPLICATE KEY UPDATE num=in_num, `time`=in_time;
END;;
-- ----------------------------
-- Procedure structure for sp_player_wingexit_count_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_wingexit_count_select`;
CREATE PROCEDURE `sp_player_wingexit_count_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_wingexit_count WHERE charguid = in_charguid;
END;;
#***************************************************************
##版本429修改完成
#***************************************************************
#***************************************************************
##版本430修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_update_new_babel_rank
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_new_babel_rank`;
CREATE PROCEDURE `sp_update_new_babel_rank`(IN `in_rank` int, IN `in_guid` bigint, IN `in_val` int, IN `in_name` varchar(32), IN `in_level` int)
BEGIN
	INSERT INTO tb_new_babel_rank(rank, guid, value, name, level)
	VALUES (in_rank, in_guid, in_val, in_name, in_level) 
	ON DUPLICATE KEY UPDATE  guid = in_guid, value = in_val, name = in_name, level = in_level;
END;;
-- ----------------------------
-- Procedure structure for sp_select_new_babel_rank
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_new_babel_rank`;
CREATE PROCEDURE `sp_select_new_babel_rank`()
BEGIN
	SELECT * FROM tb_new_babel_rank;
END;;
#***************************************************************
##版本430修改完成
#***************************************************************
##版本431修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_player_zhannu_gem
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_zhannu_gem`;
CREATE PROCEDURE `sp_select_player_zhannu_gem`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_zhannu_gem WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_zhannu_gem_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhannu_gem_insert_update`;
CREATE PROCEDURE `sp_player_zhannu_gem_insert_update`(IN `in_charguid` bigint, IN `in_id` int)
BEGIN
	INSERT INTO tb_player_zhannu_gem(charguid, id)
	VALUES (in_charguid, in_id)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, id = in_id;
END ;;
-- ----------------------------
-- Procedure structure for sp_select_player_zhannu_gem_item
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_zhannu_gem_item`;
CREATE PROCEDURE `sp_select_player_zhannu_gem_item`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_zhannu_gem_item WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_zhannu_gem_item_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhannu_gem_item_insert_update`;
CREATE PROCEDURE `sp_player_zhannu_gem_item_insert_update`(IN `in_charguid` bigint, IN `in_itemgid` bigint, IN `in_itemtid` int, IN `in_pos` int, IN `in_type` int,
 IN `in_time_stamp` bigint)
BEGIN
	INSERT INTO tb_player_zhannu_gem_item(charguid, itemgid, itemtid, pos, type, time_stamp)
	VALUES (in_charguid, in_itemgid,in_itemtid,in_pos,in_type,in_time_stamp)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, itemgid = in_itemgid, itemtid = in_itemtid, pos = in_pos, type = in_type,
	 time_stamp = in_time_stamp;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_zhannu_gem_item_delete_by_id_and_timestamp
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhannu_gem_item_delete_by_id_and_timestamp`;
CREATE PROCEDURE `sp_player_zhannu_gem_item_delete_by_id_and_timestamp`(IN `in_charguid` bigint, IN `in_time_stamp` bigint)
BEGIN
  DELETE FROM tb_player_zhannu_gem_item WHERE charguid = in_charguid AND time_stamp <> in_time_stamp;
END;;
#**************************************************************
##版本431修改完成
#**************************************************************
#**************************************************************
##版本432修改开始
#**************************************************************
-- ----------------------------
-- Procedure structure for sp_select_player_app_info
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_app_info`;
CREATE PROCEDURE `sp_select_player_app_info`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_app_info WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_app_info_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_app_info_insert_update`;
CREATE PROCEDURE `sp_player_app_info_insert_update`(IN `in_charguid` bigint, IN `in_token` varchar(64), IN `in_param` varchar(256))
BEGIN
	INSERT INTO tb_player_app_info(charguid, token, param)
	VALUES (in_charguid, in_token, in_param)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, token = in_token, param = in_param;
END ;;

-- ----------------------------
-- Procedure structure for sp_select_rank_human_guild
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_human_guild`;
CREATE PROCEDURE `sp_select_rank_human_guild`(IN `in_charguid` bigint)
BEGIN
	SELECT IFNULL(tb_guild.name, '') AS name, IFNULL(tb_guild.gid, 0) AS gid FROM tb_guild_mem 
	LEFT JOIN tb_guild
	ON tb_guild.gid = tb_guild_mem.gid
	WHERE tb_guild_mem.charguid = in_charguid;
END;;

#**************************************************************
##版本432修改完成
#**************************************************************
#**************************************************************
##版本433修改开始
#**************************************************************
-- ----------------------------
-- Procedure structure for sp_select_player_app_info
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_vip_insert_update`;
CREATE PROCEDURE `sp_player_vip_insert_update`(IN `in_charguid` bigint, IN `in_vip_exp` bigint, IN `in_vip_lvlreward` int, IN `in_vip_weekrewardtime` bigint,
IN `in_vip_typelasttime1` bigint, IN `in_vip_typelasttime2` bigint, IN `in_vip_typelasttime3` bigint, IN `in_redpacketcnt` int, IN `in_vip_weekrewardlevel` int)
BEGIN
	INSERT INTO tb_player_vip(charguid,vip_exp,vip_lvlreward,vip_weekrewardtime,vip_typelasttime1,vip_typelasttime2,vip_typelasttime3,redpacketcnt,vip_weekrewardlevel)
	VALUES (in_charguid,in_vip_exp,in_vip_lvlreward,in_vip_weekrewardtime,in_vip_typelasttime1,in_vip_typelasttime2,in_vip_typelasttime3,in_redpacketcnt,in_vip_weekrewardlevel) 
	ON DUPLICATE KEY UPDATE vip_lvlreward=in_vip_lvlreward,vip_exp=in_vip_exp,vip_weekrewardtime=in_vip_weekrewardtime,vip_typelasttime1=in_vip_typelasttime1,
	vip_typelasttime2=in_vip_typelasttime2,vip_typelasttime3=in_vip_typelasttime3,redpacketcnt=in_redpacketcnt,vip_weekrewardlevel=in_vip_weekrewardlevel;
END;;
#**************************************************************
##版本433修改完成
#**************************************************************
#***************************************************************
##版本434修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_magickey_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_magickey_insert_update`;
CREATE PROCEDURE `sp_player_magickey_insert_update`(IN `in_charguid` bigint, IN `in_item_id` bigint, IN `in_item_tid` int, IN `in_slot_id` int,  IN `in_stack_num` int, 
IN `in_flags` bigint, IN `in_bag` int, IN `in_level` int, IN `in_wuxing` int, IN `in_totalexp` bigint, IN `in_passiveskill` varchar(256), 
IN `in_godid` bigint, IN `in_strenlv` int,IN `in_time_stamp` bigint,IN `in_strelevelVal` int,IN `in_awake` int)
BEGIN
	INSERT INTO tb_player_magickeys(charguid, item_id, item_tid, slot_id, stack_num, flags, bag,
		level, wuxing, totalexp, passiveskill, godid, strenlv, time_stamp,strelevelVal,awake)
	VALUES (in_charguid, in_item_id, in_item_tid, in_slot_id, in_stack_num, in_flags, in_bag,
		in_level, in_wuxing, in_totalexp, in_passiveskill, in_godid, in_strenlv, in_time_stamp, in_strelevelVal, in_awake) 
	ON DUPLICATE KEY UPDATE  item_id = in_item_id, item_tid = in_item_tid, slot_id = in_slot_id, stack_num = in_stack_num,
	flags = in_flags, bag = in_bag, level = in_level, wuxing = in_wuxing, totalexp = in_totalexp, passiveskill = in_passiveskill, 
	godid = in_godid, strenlv=in_strenlv, time_stamp = in_time_stamp,strelevelVal=in_strelevelVal,awake=in_awake;
END;;
#***************************************************************
##版本434修改完成
#***************************************************************
#***************************************************************
##版本435修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_ridewarext_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_ridewarext_insert_update`;
CREATE PROCEDURE `sp_player_ridewarext_insert_update`(IN `in_charguid` bigint, IN `in_id` int, IN `in_level` int)
BEGIN
	INSERT INTO tb_player_ridewarext(charguid, id, level)
	VALUES (in_charguid, in_id, in_level)
	ON DUPLICATE KEY UPDATE level = in_level;
END;;
-- ----------------------------
-- Procedure structure for sp_player_ridewarext_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_ridewarext_select`;
CREATE PROCEDURE `sp_player_ridewarext_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_ridewarext where charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_player_shortcuts_change_prof
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_shortcuts_change_prof`;
CREATE PROCEDURE `sp_player_shortcuts_change_prof`(IN `in_charguid` bigint, IN `in_shortcut_id` int, IN `in_shortcut_pos` int)
BEGIN
	UPDATE tb_player_shortcuts SET shortcut_id = in_shortcut_id WHERE charguid = in_charguid AND shortcut_pos = in_shortcut_pos;
END;;
-- ----------------------------
-- Procedure structure for sp_player_skills_update_prof
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_skills_update_prof`;
CREATE PROCEDURE `sp_player_skills_update_prof`(IN `in_charguid` bigint, IN `in_skill_id` int, IN `in_new_skill_id` int)
BEGIN
	UPDATE tb_player_skills SET skill_id = in_new_skill_id WHERE charguid = in_charguid AND skill_id = in_skill_id;
END;;
-- ----------------------------
-- Procedure structure for sp_update_player_info_by_changeprof
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_player_info_by_changeprof`;
CREATE PROCEDURE `sp_update_player_info_by_changeprof`(IN `in_charguid` bigint,IN `in_prof` int,IN `in_iconid` int,IN `in_sex` int,IN `in_changeproftag` int)
BEGIN
	update tb_player_info set prof = in_prof, iconid = in_iconid, sex = in_sex, changeproftag = in_changeproftag where charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_update_player_equip_wuqi
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_player_equip_wuqi`;
CREATE PROCEDURE `sp_update_player_equip_wuqi`(IN `in_charguid` bigint,IN `in_item_tid` int)
BEGIN
	update tb_player_equips set item_tid = in_item_tid where bag = 1 and slot_id = 1 and charguid = in_charguid;
END;;
#***************************************************************
##版本435修改完成
#***************************************************************
#***************************************************************
##版本436修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_info_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_info_insert_update`;
CREATE PROCEDURE `sp_player_info_insert_update`(IN `in_id` bigint,  IN `in_name` varchar(32), IN `in_level` int, IN `in_exp` bigint, IN `in_vip_level` int, IN `in_vip_exp` int,
			IN `in_power` bigint, IN `in_hp` int, IN `in_mp` int, IN `in_hunli` int, IN `in_tipo` int, IN `in_shenfa` int, IN `in_jingshen` int, 
			IN `in_leftpoint` int, IN `in_totalpoint` int, IN `in_sp` int, IN `in_max_sp` int, IN `in_sp_recover` int, IN `in_bindgold` bigint, 
			IN `in_unbindgold` bigint, IN `in_bindmoney` bigint, IN `in_unbindmoney` bigint, IN `in_zhenqi` bigint, IN `in_soul` int, IN `in_pk_mode` int, IN `in_pk_status` int,
			IN `in_pk_flags` int,IN `in_pk_evil` int,IN `in_redname_time` bigint, IN `in_grayname_time` bigint, IN `in_pk_count` int, IN `in_yao_hun` int,
			IN `in_arms` int, IN `in_dress` int, IN `in_online_time` int, IN `in_head` int, IN `in_suit` int, IN `in_weapon` int, IN `in_drop_val` int, IN `in_drop_lv` int, 
			IN `in_killtask_count` int, IN `in_onlinetime_day` int, IN `in_honor` int, IN `in_hearthstone_time` bigint, IN `in_lingzhi` int, IN `in_jingjie_exp` int, IN `in_vplan` int,
			IN `in_blesstime` bigint,IN `in_equipval` bigint, IN `in_wuhunid` int, IN `in_shenbingid` int,IN `in_extremityval` bigint, IN `in_wingid` int,
			IN `in_blesstime2` bigint,IN `in_blesstime3` bigint, IN `in_suitflag` int, IN `in_crossscore` int, IN `in_crossexploit` int, IN `in_crossseasonid` int, 
			IN `in_pvplevel` int, IN `in_sheild` bigint, IN `in_glorylevel` int, IN `in_gloryexp` int, IN `in_CuMoJiFen` int, IN `in_slayerQuestNum` int, 
			IN `in_magickey` int, IN `in_datangcnt` int, IN `in_luck_point` int, IN `in_txvipflag` int, IN `in_txbvipflag` int, IN `in_changeproftag` int)
BEGIN
	INSERT INTO tb_player_info(charguid, name, level, exp, vip_level, vip_exp,
		power, hp, mp, hunli, tipo, shenfa, jingshen, 
		leftpoint, totalpoint, sp, max_sp, sp_recover,bindgold,
		unbindgold, bindmoney, unbindmoney,zhenqi, soul, pk_mode, pk_status,
		pk_flags, pk_evil, redname_time, grayname_time, pk_count, yao_hun, 
		arms, dress, online_time, head, suit, weapon, drop_val, drop_lv, 
		killtask_count, onlinetime_day, honor,hearthstone_time,lingzhi,jingjie_exp,
		vplan, blesstime,equipval, wuhunid, shenbingid,extremityval, wingid,
		blesstime2, blesstime3, suitflag, crossscore, crossexploit, crossseasonid, pvplevel, sheild, glorylevel, gloryexp,
		CuMoJiFen, slayerQuestNum, magickey, datangcnt,luck_point, txvipflag, txbvipflag, changeproftag)
	VALUES (in_id, in_name, in_level, in_exp, in_vip_level, in_vip_exp,
		in_power, in_hp, in_mp, in_hunli, in_tipo, in_shenfa, in_jingshen, 
		in_leftpoint, in_totalpoint, in_sp, in_max_sp, in_sp_recover, in_bindgold, 
		in_unbindgold, in_bindmoney, in_unbindmoney, in_zhenqi, in_soul, in_pk_mode, in_pk_status,
		in_pk_flags,in_pk_evil, in_redname_time, in_grayname_time, in_pk_count, in_yao_hun, in_arms, 
		in_dress, in_online_time, in_head, in_suit, in_weapon, in_drop_val, in_drop_lv, in_killtask_count,
		in_onlinetime_day, in_honor,in_hearthstone_time,in_lingzhi,in_jingjie_exp,
		in_vplan, in_blesstime,in_equipval, in_wuhunid, in_shenbingid,in_extremityval, in_wingid, 
		in_blesstime2, in_blesstime3, in_suitflag, in_crossscore, in_crossexploit, in_crossseasonid, in_pvplevel, in_sheild, in_glorylevel, in_gloryexp, 
		in_CuMoJiFen, in_slayerQuestNum, in_magickey, in_datangcnt,in_luck_point, in_txvipflag, in_txbvipflag, in_changeproftag) 
	ON DUPLICATE KEY UPDATE name=in_name, level=in_level, exp = in_exp, vip_level = in_vip_level, vip_exp = in_vip_exp,
		power=in_power, hp=in_hp, mp=in_mp, hunli=in_hunli, tipo=in_tipo, shenfa=in_shenfa, jingshen=in_jingshen, 
		leftpoint=in_leftpoint, totalpoint=in_totalpoint, sp = in_sp, max_sp = in_max_sp, sp_recover = in_sp_recover, bindgold=in_bindgold, 
		unbindgold=in_unbindgold, bindmoney=in_bindmoney, unbindmoney=in_unbindmoney, zhenqi=in_zhenqi, soul = in_soul, pk_mode=in_pk_mode, pk_status = in_pk_status,
		pk_flags = in_pk_flags, pk_evil = in_pk_evil, redname_time = in_redname_time, grayname_time = in_grayname_time, pk_count = in_pk_count, yao_hun=in_yao_hun,
		arms = in_arms, dress = in_dress, online_time = in_online_time, head = in_head, suit = in_suit, weapon = in_weapon, drop_val = in_drop_val, drop_lv = in_drop_lv, 
		killtask_count = in_killtask_count, onlinetime_day=in_onlinetime_day, honor = in_honor,hearthstone_time=in_hearthstone_time,lingzhi=in_lingzhi,jingjie_exp=in_jingjie_exp,vplan=in_vplan,
		blesstime = in_blesstime,equipval = in_equipval, wuhunid = in_wuhunid, shenbingid = in_shenbingid, extremityval = in_extremityval, wingid = in_wingid,
		blesstime2 = in_blesstime2, blesstime3 = in_blesstime3, suitflag = in_suitflag, crossscore = in_crossscore, crossexploit = in_crossexploit,
		crossseasonid = in_crossseasonid, pvplevel = in_pvplevel, sheild = in_sheild, glorylevel = in_glorylevel, gloryexp = in_gloryexp, 
		CuMoJiFen = in_CuMoJiFen, slayerQuestNum = in_slayerQuestNum, magickey = in_magickey, datangcnt = in_datangcnt, luck_point = in_luck_point,
		txvipflag = in_txvipflag, txbvipflag = in_txbvipflag, changeproftag = in_changeproftag;
END;;
#***************************************************************
##版本436修改完成
#***************************************************************
#***************************************************************
##版本437修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_tiangangext_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_tiangangext_insert_update`;
CREATE PROCEDURE `sp_player_tiangangext_insert_update`(IN `in_charguid` bigint, IN `in_type` int, IN `in_level` int)
BEGIN
	INSERT INTO tb_player_tiangangext(charguid, type, level)
	VALUES (in_charguid, in_type, in_level)
	ON DUPLICATE KEY UPDATE level = in_level;
END;;
-- ----------------------------
-- Procedure structure for sp_player_tiangangext_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_tiangangext_select`;
CREATE PROCEDURE `sp_player_tiangangext_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_tiangangext where charguid = in_charguid;
END;;
#***************************************************************
##版本437修改完成
#***************************************************************
#***************************************************************
##版本438修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_app_res_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_app_res_insert_update`;
CREATE PROCEDURE `sp_player_app_res_insert_update`(IN `in_charguid` bigint, IN `in_id` int, IN `in_type` int, IN `in_cnt` int, IN `in_param` int)
BEGIN
	INSERT INTO tb_player_app_res(charguid, id, type, cnt, param)
	VALUES (in_charguid, in_id, in_type, in_cnt, in_param)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, id = in_id, type = in_type, cnt = in_cnt, param = in_param;
END;;
-- ----------------------------
-- Procedure structure for sp_player_app_res_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_app_res_select`;
CREATE PROCEDURE `sp_player_app_res_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_app_res where charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_player_app_res_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_app_res_delete`;
CREATE PROCEDURE `sp_player_app_res_delete`(IN `in_charguid` bigint)
BEGIN
	delete from tb_player_app_res where charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_player_app_op_res_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_app_op_res_insert_update`;
CREATE PROCEDURE `sp_player_app_op_res_insert_update`(IN `in_bid` bigint, IN `in_charguid` bigint, IN `in_id` int, IN `in_type` int, IN `in_time` int, IN `in_param` int)
BEGIN
	INSERT INTO tb_player_app_op_res(bid, charguid, id, type, time, param)
	VALUES (in_bid, in_charguid, in_id, in_type, in_time, in_param)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, id = in_id, type = in_type, time = in_time, param = in_param;
END;;
-- ----------------------------
-- Procedure structure for sp_player_app_op_res_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_app_op_res_select`;
CREATE PROCEDURE `sp_player_app_op_res_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_app_op_res where charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_player_app_op_res_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_app_op_res_delete`;
CREATE PROCEDURE `sp_player_app_op_res_delete`(IN `in_charguid` bigint, IN `in_time` int)
BEGIN
	delete from tb_player_app_op_res where charguid = in_charguid and time < in_time;
END;;
#***************************************************************
##版本438修改完成
#***************************************************************
#***************************************************************
##版本439修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_zhuanzhi_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhuanzhi_insert_update`;
CREATE PROCEDURE `sp_player_zhuanzhi_insert_update`(IN `in_charguid` bigint, IN `in_questid` int, IN `in_todayquestcnt` int, IN `in_questcnt` int, IN `in_step` int
, IN `in_progress` varchar(128), IN `in_zhuanzhi` int)
BEGIN
	INSERT INTO tb_player_zhuanzhi(charguid, questid,todayquestcnt, questcnt, step, progress, zhuanzhi)
	VALUES (in_charguid, in_questid,in_todayquestcnt, in_questcnt, in_step, in_progress, in_zhuanzhi)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, questid = in_questid, todayquestcnt = in_todayquestcnt, questcnt = in_questcnt
	, step = in_step, progress = in_progress, zhuanzhi = in_zhuanzhi;
END;;
-- ----------------------------
-- Procedure structure for sp_player_zhuanzhi_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhuanzhi_select_by_id`;
CREATE PROCEDURE `sp_player_zhuanzhi_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_zhuanzhi WHERE charguid=in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_player_zhuanzhi_num
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhuanzhi_num`;
CREATE PROCEDURE `sp_player_zhuanzhi_num`()
BEGIN
	SELECT IFNULL(sum(tb_player_zhuanzhi.questcnt),0) as questcnt,IFNULL(max(step),0) as step  FROM tb_player_zhuanzhi;
END;;
#***************************************************************
##版本439修改完成
#***************************************************************
#***************************************************************
##版本440修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_zhenfa_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhenfa_insert_update`;
CREATE PROCEDURE `sp_player_zhenfa_insert_update`(IN `in_charguid` bigint,IN `in_selecttype` int, IN `in_zhenfa` varchar(300), IN `in_attrdan` int)
BEGIN
	INSERT INTO tb_player_zhenfa(charguid,selecttype,zhenfa,attrdan)
	VALUES (in_charguid,in_selecttype,in_zhenfa,in_attrdan)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, selecttype = in_selecttype, zhenfa = in_zhenfa, attrdan = in_attrdan;
END;;
-- ----------------------------
-- Procedure structure for sp_player_zhenfa_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhenfa_select_by_id`;
CREATE PROCEDURE `sp_player_zhenfa_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_zhenfa WHERE charguid=in_charguid;
END;;
#***************************************************************
##版本440修改完成
#***************************************************************
#***************************************************************
##版本441修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_extra_insert_update`;
CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(256), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(1024), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(512),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int, IN `in_draw_cnt` int, IN `in_vitality_vip` int, IN `in_choujiang_num` int,
			IN `in_magickey_kl_num` int, IN `in_magickey_yl_num` int, IN `in_magickey_all_num` int, IN `in_monthcharge` int, IN `in_maxcharge` int, IN `in_hongyan_power` int, IN `in_hongyan_id` int, IN `in_hongyan_chuzhan_id` int, IN `in_HongYanHeTiTimes` int,
			IN `in_marrystren` int, IN `in_marrystrenwish` int, IN `in_expend_storage2` int, IN `in_storage2_online` int, 
			IN `in_expend_storage3` int, IN `in_storage3_online` int, IN `in_expend_storage4` int, IN `in_storage4_online` int)
BEGIN
	INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate,draw_cnt,vitality_vip, choujiang_num,magickey_kl_num,magickey_yl_num,magickey_all_num,
			monthcharge, maxcharge,hongyan_power,hongyan_id,hongyan_chuzhan_id,HongYanHeTiTimes,marrystren, marrystrenwish, expend_storage2, storage2_online,
			expend_storage3, storage3_online, expend_storage4, storage4_online)
	VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate, in_draw_cnt,in_vitality_vip,in_choujiang_num,in_magickey_kl_num,in_magickey_yl_num,in_magickey_all_num,
			in_monthcharge, in_maxcharge,in_hongyan_power,in_hongyan_id,in_hongyan_chuzhan_id,in_HongYanHeTiTimes,
			in_marrystren, in_marrystrenwish, in_expend_storage2, in_storage2_online, in_expend_storage3, in_storage3_online, in_expend_storage4, in_storage4_online)
	ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, 
			petstate = in_petstate,draw_cnt=in_draw_cnt, vitality_vip = in_vitality_vip,choujiang_num=in_choujiang_num,magickey_kl_num=in_magickey_kl_num,magickey_yl_num=in_magickey_yl_num,magickey_all_num=in_magickey_all_num,
			monthcharge = in_monthcharge, maxcharge = in_maxcharge,hongyan_power=in_hongyan_power,hongyan_id=in_hongyan_id,hongyan_chuzhan_id=in_hongyan_chuzhan_id,HongYanHeTiTimes=in_HongYanHeTiTimes,
			marrystren = in_marrystren, marrystrenwish = in_marrystrenwish, expend_storage2 = in_expend_storage2, storage2_online = in_storage2_online, 
			expend_storage3 = in_expend_storage3, storage3_online = in_storage3_online, expend_storage4 = in_expend_storage4, storage4_online = in_storage4_online;
END;;
#***************************************************************
##版本441修改完成
#***************************************************************
#***************************************************************
##版本442修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_zhenfa_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_zhenfa_insert_update`;
CREATE PROCEDURE `sp_player_zhenfa_insert_update`(IN `in_charguid` bigint,IN `in_selecttype` int, IN `in_zhenfa` varchar(300), IN `in_attrdan` int, IN `in_attrdanper` int)
BEGIN
	INSERT INTO tb_player_zhenfa(charguid,selecttype,zhenfa,attrdan,attrdanper)
	VALUES (in_charguid,in_selecttype,in_zhenfa,in_attrdan,in_attrdanper)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, selecttype = in_selecttype, zhenfa = in_zhenfa, attrdan = in_attrdan, attrdanper = in_attrdanper;
END;;
#***************************************************************
##版本442修改完成
#***************************************************************
#***************************************************************
##版本443修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_marryquests_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_marryquests_select_by_id`;
CREATE PROCEDURE `sp_player_marryquests_select_by_id`(IN `in_charguid` bigint)
BEGIN
  SELECT * FROM tb_player_marryquest WHERE charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_player_marryquests_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_marryquests_insert_update`;
CREATE PROCEDURE `sp_player_marryquests_insert_update`(IN `in_charguid` bigint,  IN `in_quest_id` int, 
IN `in_quest_star` int, IN `in_quest_counter` int, IN `in_quest_counter_id` varchar(256), 
IN `in_quest_reward_id` varchar(128), IN `in_quest_double` int, IN `in_quest_auto_star` int)
BEGIN
  INSERT INTO tb_player_marryquest(charguid, quest_id, quest_star,quest_counter,
  quest_counter_id,quest_reward_id,quest_double,quest_auto_star)
  VALUES (in_charguid, in_quest_id,in_quest_star,in_quest_counter,
  in_quest_counter_id,in_quest_reward_id,in_quest_double,in_quest_auto_star) 
  ON DUPLICATE KEY UPDATE charguid=in_charguid, quest_id=in_quest_id, quest_star=in_quest_star,
  quest_counter=in_quest_counter,quest_counter_id=in_quest_counter_id,quest_reward_id=in_quest_reward_id,
  quest_double=in_quest_double,quest_auto_star=in_quest_auto_star;
END;;
#***************************************************************
##版本443修改完成
#***************************************************************
#***************************************************************
##版本444修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_christmas_tree_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_christmas_tree_insert_update`;
CREATE PROCEDURE `sp_player_christmas_tree_insert_update`(IN `in_charguid` bigint,IN `in_id` int, IN `in_num` int, IN `in_openday` bigint)
BEGIN
	INSERT INTO tb_player_qiming_tree(charguid,`id`,num,openday) VALUES (in_charguid,in_id,in_num,in_openday)
	ON DUPLICATE KEY UPDATE num = in_num;
END;;
-- ----------------------------
-- Procedure structure for sp_player_christmas_tree_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_christmas_tree_select`;
CREATE PROCEDURE `sp_player_christmas_tree_select`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_qiming_tree where charguid=in_charguid;
END;;

#***************************************************************
##版本444修改完成
#***************************************************************
#***************************************************************
##版本445修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_talent
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_talent`;
CREATE PROCEDURE `sp_select_talent`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_talent WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_update_talent
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_talent`;
CREATE PROCEDURE `sp_update_talent`(IN `in_charguid` bigint, IN `in_talent_id` int, IN `in_talent_lvl` int)
BEGIN
	INSERT INTO tb_player_talent(charguid, talent_id, talent_lvl)
	VALUES (in_charguid, in_talent_id, in_talent_lvl)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, talent_id = in_talent_id, talent_lvl = in_talent_lvl;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_info_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_info_insert_update`;
CREATE PROCEDURE `sp_player_info_insert_update`(IN `in_id` bigint,  IN `in_name` varchar(32), IN `in_level` int, IN `in_exp` bigint, IN `in_vip_level` int, IN `in_vip_exp` int,
			IN `in_power` bigint, IN `in_hp` int, IN `in_mp` int, IN `in_hunli` int, IN `in_tipo` int, IN `in_shenfa` int, IN `in_jingshen` int, 
			IN `in_leftpoint` int, IN `in_totalpoint` int, IN `in_sp` int, IN `in_max_sp` int, IN `in_sp_recover` int, IN `in_bindgold` bigint, 
			IN `in_unbindgold` bigint, IN `in_bindmoney` bigint, IN `in_unbindmoney` bigint, IN `in_zhenqi` bigint, IN `in_soul` int, IN `in_pk_mode` int, IN `in_pk_status` int,
			IN `in_pk_flags` int,IN `in_pk_evil` int,IN `in_redname_time` bigint, IN `in_grayname_time` bigint, IN `in_pk_count` int, IN `in_yao_hun` int,
			IN `in_arms` int, IN `in_dress` int, IN `in_online_time` int, IN `in_head` int, IN `in_suit` int, IN `in_weapon` int, IN `in_drop_val` int, IN `in_drop_lv` int, 
			IN `in_killtask_count` int, IN `in_onlinetime_day` int, IN `in_honor` int, IN `in_hearthstone_time` bigint, IN `in_lingzhi` int, IN `in_jingjie_exp` int, IN `in_vplan` int,
			IN `in_blesstime` bigint,IN `in_equipval` bigint, IN `in_wuhunid` int, IN `in_shenbingid` int,IN `in_extremityval` bigint, IN `in_wingid` int,
			IN `in_blesstime2` bigint,IN `in_blesstime3` bigint, IN `in_suitflag` int, IN `in_crossscore` int, IN `in_crossexploit` int, IN `in_crossseasonid` int, 
			IN `in_pvplevel` int, IN `in_sheild` bigint, IN `in_glorylevel` int, IN `in_gloryexp` int, IN `in_CuMoJiFen` int, IN `in_slayerQuestNum` int, 
			IN `in_magickey` int, IN `in_datangcnt` int, IN `in_luck_point` int, IN `in_txvipflag` int, IN `in_txbvipflag` int, IN `in_changeproftag` int, IN `in_talent_point` int)
BEGIN
	INSERT INTO tb_player_info(charguid, name, level, exp, vip_level, vip_exp,
		power, hp, mp, hunli, tipo, shenfa, jingshen, 
		leftpoint, totalpoint, sp, max_sp, sp_recover,bindgold,
		unbindgold, bindmoney, unbindmoney,zhenqi, soul, pk_mode, pk_status,
		pk_flags, pk_evil, redname_time, grayname_time, pk_count, yao_hun, 
		arms, dress, online_time, head, suit, weapon, drop_val, drop_lv, 
		killtask_count, onlinetime_day, honor,hearthstone_time,lingzhi,jingjie_exp,
		vplan, blesstime,equipval, wuhunid, shenbingid,extremityval, wingid,
		blesstime2, blesstime3, suitflag, crossscore, crossexploit, crossseasonid, pvplevel, sheild, glorylevel, gloryexp,
		CuMoJiFen, slayerQuestNum, magickey, datangcnt,luck_point, txvipflag, txbvipflag, changeproftag, talent_point)
	VALUES (in_id, in_name, in_level, in_exp, in_vip_level, in_vip_exp,
		in_power, in_hp, in_mp, in_hunli, in_tipo, in_shenfa, in_jingshen, 
		in_leftpoint, in_totalpoint, in_sp, in_max_sp, in_sp_recover, in_bindgold, 
		in_unbindgold, in_bindmoney, in_unbindmoney, in_zhenqi, in_soul, in_pk_mode, in_pk_status,
		in_pk_flags,in_pk_evil, in_redname_time, in_grayname_time, in_pk_count, in_yao_hun, in_arms, 
		in_dress, in_online_time, in_head, in_suit, in_weapon, in_drop_val, in_drop_lv, in_killtask_count,
		in_onlinetime_day, in_honor,in_hearthstone_time,in_lingzhi,in_jingjie_exp,
		in_vplan, in_blesstime,in_equipval, in_wuhunid, in_shenbingid,in_extremityval, in_wingid, 
		in_blesstime2, in_blesstime3, in_suitflag, in_crossscore, in_crossexploit, in_crossseasonid, in_pvplevel, in_sheild, in_glorylevel, in_gloryexp, 
		in_CuMoJiFen, in_slayerQuestNum, in_magickey, in_datangcnt,in_luck_point, in_txvipflag, in_txbvipflag, in_changeproftag, in_talent_point) 
	ON DUPLICATE KEY UPDATE name=in_name, level=in_level, exp = in_exp, vip_level = in_vip_level, vip_exp = in_vip_exp,
		power=in_power, hp=in_hp, mp=in_mp, hunli=in_hunli, tipo=in_tipo, shenfa=in_shenfa, jingshen=in_jingshen, 
		leftpoint=in_leftpoint, totalpoint=in_totalpoint, sp = in_sp, max_sp = in_max_sp, sp_recover = in_sp_recover, bindgold=in_bindgold, 
		unbindgold=in_unbindgold, bindmoney=in_bindmoney, unbindmoney=in_unbindmoney, zhenqi=in_zhenqi, soul = in_soul, pk_mode=in_pk_mode, pk_status = in_pk_status,
		pk_flags = in_pk_flags, pk_evil = in_pk_evil, redname_time = in_redname_time, grayname_time = in_grayname_time, pk_count = in_pk_count, yao_hun=in_yao_hun,
		arms = in_arms, dress = in_dress, online_time = in_online_time, head = in_head, suit = in_suit, weapon = in_weapon, drop_val = in_drop_val, drop_lv = in_drop_lv, 
		killtask_count = in_killtask_count, onlinetime_day=in_onlinetime_day, honor = in_honor,hearthstone_time=in_hearthstone_time,lingzhi=in_lingzhi,jingjie_exp=in_jingjie_exp,vplan=in_vplan,
		blesstime = in_blesstime,equipval = in_equipval, wuhunid = in_wuhunid, shenbingid = in_shenbingid, extremityval = in_extremityval, wingid = in_wingid,
		blesstime2 = in_blesstime2, blesstime3 = in_blesstime3, suitflag = in_suitflag, crossscore = in_crossscore, crossexploit = in_crossexploit,
		crossseasonid = in_crossseasonid, pvplevel = in_pvplevel, sheild = in_sheild, glorylevel = in_glorylevel, gloryexp = in_gloryexp, 
		CuMoJiFen = in_CuMoJiFen, slayerQuestNum = in_slayerQuestNum, magickey = in_magickey, datangcnt = in_datangcnt, luck_point = in_luck_point,
		txvipflag = in_txvipflag, txbvipflag = in_txbvipflag, changeproftag = in_changeproftag, talent_point = in_talent_point;
END ;;
#***************************************************************
##版本445修改完成
#***************************************************************
#***************************************************************
#***************************************************************
##版本446修改开始
#***************************************************************
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_shenwu_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_shenwu_select_by_id`;
CREATE PROCEDURE `sp_player_shenwu_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT *  FROM tb_player_shenwu WHERE charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_player_shenwu_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_shenwu_insert_update`;
CREATE PROCEDURE `sp_player_shenwu_insert_update`(IN `in_charguid` bigint, IN `in_shenwu_level` int,
 IN `in_shenwu_star` int, IN `in_shenwu_stone` int, IN `in_shenwu_failnum` int)
BEGIN
	INSERT INTO tb_player_shenwu(charguid, shenwu_level, shenwu_star, shenwu_stone, shenwu_failnum)
	VALUES (in_charguid, in_shenwu_level, in_shenwu_star, in_shenwu_stone, in_shenwu_failnum) 
	ON DUPLICATE KEY UPDATE charguid = in_charguid, shenwu_level = in_shenwu_level,	shenwu_star = in_shenwu_star, 
	shenwu_stone = in_shenwu_stone, shenwu_failnum = in_shenwu_failnum;
END;;
-- ----------------------------
-- Procedure structure for sp_select_rank_shenwu()
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_shenwu`;
CREATE PROCEDURE `sp_select_rank_shenwu`()
BEGIN
	SELECT * FROM tb_rank_shenwu;
END;;
-- ----------------------------
-- Procedure structure for sp_update_rank_shenwu()
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_rank_shenwu`;
CREATE PROCEDURE `sp_update_rank_shenwu`(IN `in_rank` int, IN `in_charguid` bigint, IN `in_lastrank` int, IN `in_rankvalue` bigint)
BEGIN
	INSERT INTO tb_rank_shenwu(rank, charguid, lastrank, rankvalue)
	VALUES (in_rank, in_charguid, in_lastrank, in_rankvalue)
	ON DUPLICATE KEY UPDATE rank = in_rank, charguid = in_charguid, lastrank = in_lastrank, rankvalue = in_rankvalue;
END;;
-- ----------------------------
-- Procedure structure for sp_rank_shenwu()
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_rank_shenwu`;
CREATE PROCEDURE `sp_rank_shenwu`()
BEGIN
	SELECT tb_player_shenwu.charguid AS uid, tb_player_shenwu.shenwu_level AS rankvalue FROM tb_player_shenwu left join tb_player_info
	on tb_player_shenwu.charguid = tb_player_info.charguid
	WHERE tb_player_shenwu.shenwu_level > 0 ORDER BY tb_player_shenwu.shenwu_level DESC, shenwu_star DESC, tb_player_info.power DESC LIMIT 100;
END;;
#***************************************************************
##版本446修改完成
#***************************************************************
#***************************************************************
##版本447修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_xuetong_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_xuetong_insert_update`;
CREATE PROCEDURE `sp_player_xuetong_insert_update`(IN `in_charguid` bigint,IN `in_xuetong` varchar(300))
BEGIN
	INSERT INTO tb_player_xuetong(charguid,xuetong)
	VALUES (in_charguid,in_xuetong)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, xuetong = in_xuetong;
END;;
-- ----------------------------
-- Procedure structure for sp_player_xuetong_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_xuetong_select_by_id`;
CREATE PROCEDURE `sp_player_xuetong_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_xuetong WHERE charguid=in_charguid;
END;;

-- ----------------------------
-- Procedure structure for sp_check_user_playerinfo()
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_check_user_playerinfo`;
CREATE PROCEDURE `sp_check_user_playerinfo`(IN `in_charguid` bigint(20))
BEGIN
	SELECT name, online_time, prof, level, exp, exts, power  FROM tb_player_info
	WHERE charguid = in_charguid; 
END;;
#***************************************************************
##版本447修改完成
#***************************************************************
#***************************************************************
##版本448修改开始
#***************************************************************
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_sbjianyi
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_sbjianyi`;
CREATE PROCEDURE `sp_select_sbjianyi`(IN `in_charguid` bigint)
BEGIN
	SELECT *  FROM tb_player_sbjianyi WHERE charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_insert_update_sbjianyi
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_sbjianyi`;
CREATE PROCEDURE `sp_insert_update_sbjianyi`(IN `in_charguid` bigint, IN `in_id` int, IN `in_level` int, IN `in_star` int)
BEGIN
	INSERT INTO tb_player_sbjianyi(charguid, id, level, star)
	VALUES (in_charguid, in_id, in_level, in_star) 
	ON DUPLICATE KEY UPDATE charguid = in_charguid, level = in_level, star = in_star;
END;;
#***************************************************************
##版本448修改完成
#***************************************************************
#***************************************************************
##版本449修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_new_cross_boss_history
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_new_cross_boss_history`;
CREATE PROCEDURE `sp_select_new_cross_boss_history`()
BEGIN
	select * from tb_new_crossboss_history;
END;;

-- ----------------------------
-- Procedure structure for sp_update_new_cross_boss_history
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_new_cross_boss_history`;
CREATE PROCEDURE `sp_update_new_cross_boss_history`(IN `in_id` int, IN `in_avglv` int, 
	IN `in_firstname1` varchar(32), IN `in_killname1` varchar(32),
	IN `in_firstname2` varchar(32), IN `in_killname2` varchar(32),
	IN `in_firstname3` varchar(32), IN `in_killname3` varchar(32),
	IN `in_firstname4` varchar(32), IN `in_killname4` varchar(32),
	IN `in_firstname5` varchar(32), IN `in_killname5` varchar(32))
BEGIN
	INSERT INTO tb_new_crossboss_history(id, avglv, firstname1, killname1, firstname2, killname2, firstname3, killname3, firstname4, killname4, firstname5, killname5)
	VALUES (in_id, in_avglv, in_firstname1, in_killname1, in_firstname2, in_killname2, in_firstname3, in_killname3, in_firstname4, in_killname4, in_firstname5, in_killname5) 
	ON DUPLICATE KEY UPDATE id=in_id, avglv=in_avglv, firstname1=in_firstname1, killname1=in_killname1, firstname2=in_firstname2, killname2=in_killname2
	, firstname3=in_firstname3, killname3=in_killname3, firstname4=in_firstname4, killname4=in_killname4, firstname5=in_firstname5, killname5=in_killname5;
END;;
#***************************************************************
##版本449修改完成
#***************************************************************
#***************************************************************
##版本450修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_update_shenwu_fb
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_shenwu_fb`;
CREATE PROCEDURE `sp_update_shenwu_fb`(IN `in_charguid` bigint, IN `in_level` int, IN `in_time` int, IN `in_count` int )
BEGIN
	INSERT INTO tb_shenwufb(charguid, level, time, count)
	VALUES (in_charguid, in_level, in_time, in_count) 
	ON DUPLICATE KEY UPDATE  level = in_level, time = in_time, count = in_count;
END;;
-- ----------------------------
-- Procedure structure for sp_select_shenwu_fb
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_shenwu_fb`;
CREATE PROCEDURE `sp_select_shenwu_fb`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_shenwufb WHERE charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_update_shenwu_fb_rank
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_shenwu_fb_rank`;
CREATE PROCEDURE `sp_update_shenwu_fb_rank`(IN `in_rank` int, IN `in_guid` bigint, IN `in_val` int, IN `in_name` varchar(32), IN `in_level` int)
BEGIN
	INSERT INTO tb_shenwufb_rank(rank, guid, value, name, level)
	VALUES (in_rank, in_guid, in_val, in_name, in_level) 
	ON DUPLICATE KEY UPDATE  guid = in_guid, value = in_val, name = in_name, level = in_level;
END;;
-- ----------------------------
-- Procedure structure for sp_select_shenwu_fb_rank
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_shenwu_fb_rank`;
CREATE PROCEDURE `sp_select_shenwu_fb_rank`()
BEGIN
	SELECT * FROM tb_shenwufb_rank;
END;;
#***************************************************************
##版本450修改完成
#***************************************************************
#***************************************************************
##版本451修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_extra_insert_update`;
CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(256), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(1024), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(512),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int, IN `in_draw_cnt` int, IN `in_vitality_vip` int, IN `in_choujiang_num` int,
			IN `in_magickey_kl_num` int, IN `in_magickey_yl_num` int, IN `in_magickey_all_num` int, IN `in_monthcharge` int, IN `in_maxcharge` int, IN `in_hongyan_power` int, IN `in_hongyan_id` int, IN `in_hongyan_chuzhan_id` int, IN `in_HongYanHeTiTimes` int,
			IN `in_marrystren` int, IN `in_marrystrenwish` int, IN `in_expend_storage2` int, IN `in_storage2_online` int, 
			IN `in_expend_storage3` int, IN `in_storage3_online` int, IN `in_expend_storage4` int, IN `in_storage4_online` int, IN `in_shenwufb_num` int)
BEGIN
	INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate,draw_cnt,vitality_vip, choujiang_num,magickey_kl_num,magickey_yl_num,magickey_all_num,
			monthcharge, maxcharge,hongyan_power,hongyan_id,hongyan_chuzhan_id,HongYanHeTiTimes,marrystren, marrystrenwish, expend_storage2, storage2_online,
			expend_storage3, storage3_online, expend_storage4, storage4_online, shenwufb_num)
	VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate, in_draw_cnt,in_vitality_vip,in_choujiang_num,in_magickey_kl_num,in_magickey_yl_num,in_magickey_all_num,
			in_monthcharge, in_maxcharge,in_hongyan_power,in_hongyan_id,in_hongyan_chuzhan_id,in_HongYanHeTiTimes,
			in_marrystren, in_marrystrenwish, in_expend_storage2, in_storage2_online, in_expend_storage3, in_storage3_online, in_expend_storage4, in_storage4_online, in_shenwufb_num)
	ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, 
			petstate = in_petstate,draw_cnt=in_draw_cnt, vitality_vip = in_vitality_vip,choujiang_num=in_choujiang_num,magickey_kl_num=in_magickey_kl_num,magickey_yl_num=in_magickey_yl_num,magickey_all_num=in_magickey_all_num,
			monthcharge = in_monthcharge, maxcharge = in_maxcharge,hongyan_power=in_hongyan_power,hongyan_id=in_hongyan_id,hongyan_chuzhan_id=in_hongyan_chuzhan_id,HongYanHeTiTimes=in_HongYanHeTiTimes,
			marrystren = in_marrystren, marrystrenwish = in_marrystrenwish, expend_storage2 = in_expend_storage2, storage2_online = in_storage2_online, 
			expend_storage3 = in_expend_storage3, storage3_online = in_storage3_online, expend_storage4 = in_expend_storage4, storage4_online = in_storage4_online, shenwufb_num = in_shenwufb_num;
END;;
#***************************************************************
##版本451修改完成
#***************************************************************
#***************************************************************
##版本452修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_shenwuext
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_shenwuext`;
CREATE PROCEDURE `sp_select_shenwuext`(IN `in_charguid` bigint)
BEGIN
	SELECT *  FROM tb_player_shenwuext WHERE charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_insert_update_shenwuext
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_shenwuext`;
CREATE PROCEDURE `sp_insert_update_shenwuext`(IN `in_charguid` bigint, IN `in_level` int, IN `in_star` int)
BEGIN
	INSERT INTO tb_player_shenwuext(charguid, level, star)
	VALUES (in_charguid, in_level, in_star) 
	ON DUPLICATE KEY UPDATE level = in_level, star = in_star;
END;;
-- ----------------------------
-- Procedure structure for sp_player_shenwu_ext_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_shenwu_ext_by_id`;
CREATE PROCEDURE `sp_player_shenwu_ext_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT a.shenwu_level, a.shenwu_star, IFNULL((b.level),0) as shenwuext_level, IFNULL((b.star),0) as shenwuext_star FROM tb_player_shenwu as a left join tb_player_shenwuext as b on a.charguid = b.charguid WHERE a.charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_rank_shenwu()
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_rank_shenwu`;
CREATE PROCEDURE `sp_rank_shenwu`()
BEGIN
	SELECT tb_player_shenwu.charguid AS uid, tb_player_shenwu.shenwu_level AS rankvalue FROM tb_player_shenwu left join tb_player_info
	on tb_player_shenwu.charguid = tb_player_info.charguid left join tb_player_shenwuext on tb_player_shenwu.charguid = tb_player_shenwuext.charguid
	WHERE tb_player_shenwu.shenwu_level > 0 ORDER BY shenwu_level DESC, shenwu_star DESC, tb_player_shenwuext.level desc, tb_player_shenwuext.star desc, tb_player_info.power DESC LIMIT 100;
END;;
#***************************************************************
##版本452修改完成
#***************************************************************
#***************************************************************
##版本453修改开始
#***************************************************************
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_baojiaext
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_baojiaext`;
CREATE PROCEDURE `sp_select_baojiaext`(IN `in_charguid` bigint)
BEGIN
	SELECT *  FROM tb_player_baojiaext WHERE charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_insert_update_baojiaext
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_baojiaext`;
CREATE PROCEDURE `sp_insert_update_baojiaext`(IN `in_charguid` bigint, IN `in_id` int, IN `in_level` int, IN `in_star` int)
BEGIN
	INSERT INTO tb_player_baojiaext(charguid, id, level, star)
	VALUES (in_charguid, in_id, in_level, in_star) 
	ON DUPLICATE KEY UPDATE charguid = in_charguid, level = in_level, star = in_star;
END;;
#***************************************************************
##版本453修改完成
#***************************************************************
#***************************************************************
##版本454修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_extra_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_extra_insert_update`;
CREATE PROCEDURE `sp_player_extra_insert_update`(IN `in_uid` bigint,  IN `in_func_flags` varchar(256), IN `in_expend_bag` int, IN `in_bag_online` int, IN `in_expend_storage` int, 
			IN `in_storage_online` int, IN `in_babel_count` int, IN `in_timing_count` int,IN `in_offmin` int, IN `in_awardstatus` int, 
			IN `in_vitality` varchar(350), IN `in_actcode_flags` varchar(1024), IN `in_vitality_num` varchar(350), IN `in_daily_yesterday` varchar(350), IN `in_worshipstime` bigint,
			IN `in_zhanyinchip` int,IN `in_baojia_level` int,IN `in_baojia_wish` int,IN `in_baojia_procenum` int,IN `in_addicted_freetime` int, 
			IN `in_fatigue` int, IN `in_reward_bits` int, IN `in_huizhang_lvl` int, IN `in_huizhang_times` int, IN `in_huizhang_zhenqi` int, 
			IN `in_huizhang_progress` varchar(100),IN `in_vitality_getid` int, IN `in_achievement_flag` bigint, IN `in_lianti_pointid` varchar(100),IN `in_huizhang_dropzhenqi` int, 
			IN `in_zhuzairoad_energy` int, IN `in_equipcreate_unlockid` varchar(300),IN `in_sale_count` int, IN `in_freeshoe_count` int,
			IN `in_lingzhen_level` int,IN `in_lingzhen_wish` int,IN `in_lingzhen_procenum` int,IN `in_item_shortcut` int,IN `in_extremity_monster` int, IN `in_extremity_damage` bigint,
			IN `in_flyshoe_tick` int, IN `in_seven_day` int, IN `in_zhuan_id` int, IN `in_zhuan_step` int, IN `in_lastCheckTime` int, IN `in_daily_count` varchar(512),
			IN `in_lingzhen_attr_num` int, IN `in_footprints` int, IN `in_equipcreate_tick` int, IN `in_huizhang_tick` int, IN `in_personboss_count` int, IN `in_platform_info` varchar(350), IN `in_lastMonthCheckTime` int, IN `in_month_count` varchar(350),
			IN `in_magickey_tili` double, IN `in_crystal_minetask` int, IN `in_zhanyinlv` int, IN `in_advice` int, IN `in_vitality_total` int, IN `in_petstate` int, IN `in_draw_cnt` int, IN `in_vitality_vip` int, IN `in_choujiang_num` int,
			IN `in_magickey_kl_num` int, IN `in_magickey_yl_num` int, IN `in_magickey_all_num` int, IN `in_monthcharge` int, IN `in_maxcharge` int, IN `in_hongyan_power` int, IN `in_hongyan_id` int, IN `in_hongyan_chuzhan_id` int, IN `in_HongYanHeTiTimes` int,
			IN `in_marrystren` int, IN `in_marrystrenwish` int, IN `in_expend_storage2` int, IN `in_storage2_online` int, 
			IN `in_expend_storage3` int, IN `in_storage3_online` int, IN `in_expend_storage4` int, IN `in_storage4_online` int, IN `in_shenwufb_num` int, IN `in_max_timingid` int, IN `in_max_timinglevel` int)
BEGIN
	INSERT INTO tb_player_extra(charguid, func_flags, expend_bag, bag_online, expend_storage, 
			storage_online, babel_count, timing_count, offmin, awardstatus,
			vitality, actcode_flags,vitality_num,daily_yesterday, worshipstime,
			zhanyinchip,baojia_level, baojia_wish,baojia_procenum,addicted_freetime,
			fatigue, reward_bits,huizhang_lvl,huizhang_times,
			huizhang_zhenqi,huizhang_progress,vitality_getid, achievement_flag,lianti_pointid,huizhang_dropzhenqi,
			zhuzairoad_energy,equipcreate_unlockid,sale_count,freeshoe_count,lingzhen_level,
			lingzhen_wish,lingzhen_procenum,item_shortcut,extremity_monster,extremity_damage,
			flyshoe_tick,seven_day,zhuan_id,zhuan_step,lastCheckTime,daily_count,
			lingzhen_attr_num, footprints,equipcreate_tick,huizhang_tick,personboss_count,platform_info,lastMonthCheckTime,month_count,
			magickey_tili, crystal_minetask, zhanyinlv, advice, vitality_total, petstate,draw_cnt,vitality_vip, choujiang_num,magickey_kl_num,magickey_yl_num,magickey_all_num,
			monthcharge, maxcharge,hongyan_power,hongyan_id,hongyan_chuzhan_id,HongYanHeTiTimes,marrystren, marrystrenwish, expend_storage2, storage2_online,
			expend_storage3, storage3_online, expend_storage4, storage4_online, shenwufb_num, max_timingid, max_timinglevel)
	VALUES (in_uid, in_func_flags, in_expend_bag, in_bag_online, in_expend_storage, 
			in_storage_online, in_babel_count, in_timing_count, in_offmin, in_awardstatus,
			in_vitality, in_actcode_flags,in_vitality_num,in_daily_yesterday, in_worshipstime,
			in_zhanyinchip,in_baojia_level, in_baojia_wish,in_baojia_procenum,in_addicted_freetime,
			in_fatigue, in_reward_bits,in_huizhang_lvl,in_huizhang_times,
			in_huizhang_zhenqi,in_huizhang_progress,in_vitality_getid, in_achievement_flag,in_lianti_pointid,in_huizhang_dropzhenqi,
			in_zhuzairoad_energy,in_equipcreate_unlockid,in_sale_count,in_freeshoe_count,in_lingzhen_level,
			in_lingzhen_wish,in_lingzhen_procenum,in_item_shortcut,in_extremity_monster,in_extremity_damage,
			in_flyshoe_tick,in_seven_day,in_zhuan_id,in_zhuan_step,in_lastCheckTime,in_daily_count,
			in_lingzhen_attr_num, in_footprints,in_equipcreate_tick,in_huizhang_tick,in_personboss_count,in_platform_info,in_lastMonthCheckTime,in_month_count,
			in_magickey_tili, in_crystal_minetask, in_zhanyinlv, in_advice, in_vitality_total, in_petstate, in_draw_cnt,in_vitality_vip,in_choujiang_num,in_magickey_kl_num,in_magickey_yl_num,in_magickey_all_num,
			in_monthcharge, in_maxcharge,in_hongyan_power,in_hongyan_id,in_hongyan_chuzhan_id,in_HongYanHeTiTimes,
			in_marrystren, in_marrystrenwish, in_expend_storage2, in_storage2_online, in_expend_storage3, in_storage3_online, in_expend_storage4, in_storage4_online, in_shenwufb_num, in_max_timingid, in_max_timinglevel)
	ON DUPLICATE KEY UPDATE charguid=in_uid, func_flags=in_func_flags, expend_bag=in_expend_bag,
			bag_online=in_bag_online,expend_storage=in_expend_storage, storage_online=in_storage_online,
			babel_count=in_babel_count, timing_count=in_timing_count, offmin=in_offmin, 
			awardstatus = in_awardstatus, vitality = in_vitality, actcode_flags = in_actcode_flags, 
			vitality_num = in_vitality_num, daily_yesterday = in_daily_yesterday, worshipstime = in_worshipstime,zhanyinchip = in_zhanyinchip,
			baojia_level=in_baojia_level, baojia_wish=in_baojia_wish,baojia_procenum=in_baojia_procenum,addicted_freetime=in_addicted_freetime,
			fatigue = in_fatigue, reward_bits = in_reward_bits,huizhang_lvl=in_huizhang_lvl,huizhang_times=in_huizhang_times,huizhang_zhenqi=in_huizhang_zhenqi,
			huizhang_progress=in_huizhang_progress,vitality_getid=in_vitality_getid, achievement_flag = in_achievement_flag,lianti_pointid = in_lianti_pointid,
			huizhang_dropzhenqi = in_huizhang_dropzhenqi,zhuzairoad_energy=in_zhuzairoad_energy,equipcreate_unlockid = in_equipcreate_unlockid,
			sale_count=in_sale_count,freeshoe_count=in_freeshoe_count,lingzhen_level = in_lingzhen_level,lingzhen_wish=in_lingzhen_wish,lingzhen_procenum = in_lingzhen_procenum,
			item_shortcut = in_item_shortcut,extremity_monster = in_extremity_monster,extremity_damage = in_extremity_damage,
			flyshoe_tick = in_flyshoe_tick,seven_day=in_seven_day,zhuan_id = in_zhuan_id,zhuan_step=in_zhuan_step,lastCheckTime = in_lastCheckTime,daily_count=in_daily_count,
			lingzhen_attr_num=in_lingzhen_attr_num, footprints = in_footprints, equipcreate_tick = in_equipcreate_tick, huizhang_tick = in_huizhang_tick, personboss_count = in_personboss_count,
			platform_info = in_platform_info,lastMonthCheckTime = in_lastMonthCheckTime,month_count = in_month_count,
			magickey_tili = in_magickey_tili, crystal_minetask = in_crystal_minetask, zhanyinlv = in_zhanyinlv, advice = in_advice, vitality_total=in_vitality_total, 
			petstate = in_petstate,draw_cnt=in_draw_cnt, vitality_vip = in_vitality_vip,choujiang_num=in_choujiang_num,magickey_kl_num=in_magickey_kl_num,magickey_yl_num=in_magickey_yl_num,magickey_all_num=in_magickey_all_num,
			monthcharge = in_monthcharge, maxcharge = in_maxcharge,hongyan_power=in_hongyan_power,hongyan_id=in_hongyan_id,hongyan_chuzhan_id=in_hongyan_chuzhan_id,HongYanHeTiTimes=in_HongYanHeTiTimes,
			marrystren = in_marrystren, marrystrenwish = in_marrystrenwish, expend_storage2 = in_expend_storage2, storage2_online = in_storage2_online, 
			expend_storage3 = in_expend_storage3, storage3_online = in_storage3_online, expend_storage4 = in_expend_storage4, storage4_online = in_storage4_online, shenwufb_num = in_shenwufb_num, 
			max_timingid=in_max_timingid, max_timinglevel=in_max_timinglevel;
END;;
#***************************************************************
##版本454修改完成
#***************************************************************
#***************************************************************
##版本455修改开始
#***************************************************************
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_wuxingext
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_wuxingext`;
CREATE PROCEDURE `sp_select_wuxingext`(IN `in_charguid` bigint)
BEGIN
	SELECT *  FROM tb_player_wuxingext WHERE charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_insert_update_wuxingext
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_wuxingext`;
CREATE PROCEDURE `sp_insert_update_wuxingext`(IN `in_charguid` bigint, IN `in_id` int, IN `in_level` int, IN `in_star` int)
BEGIN
	INSERT INTO tb_player_wuxingext(charguid, id, level, star)
	VALUES (in_charguid, in_id, in_level, in_star) 
	ON DUPLICATE KEY UPDATE charguid = in_charguid, level = in_level, star = in_star;
END;;
#***************************************************************
##版本455修改完成
#***************************************************************
#***************************************************************
##版本456修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_magickey_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_magickey_insert_update`;
CREATE PROCEDURE `sp_player_magickey_insert_update`(IN `in_charguid` bigint, IN `in_item_id` bigint, IN `in_item_tid` int, IN `in_slot_id` int,  IN `in_stack_num` int, 
IN `in_flags` bigint, IN `in_bag` int, IN `in_level` int, IN `in_wuxing` int, IN `in_totalexp` bigint, IN `in_passiveskill` varchar(256), 
IN `in_godid` bigint, IN `in_strenlv` int,IN `in_time_stamp` bigint,IN `in_strelevelVal` int,IN `in_awake` int,IN `in_feishengid` int,IN `in_feishengext` int)
BEGIN
	INSERT INTO tb_player_magickeys(charguid, item_id, item_tid, slot_id, stack_num, flags, bag,
		level, wuxing, totalexp, passiveskill, godid, strenlv, time_stamp,strelevelVal,awake, feishengid, feishengext)
	VALUES (in_charguid, in_item_id, in_item_tid, in_slot_id, in_stack_num, in_flags, in_bag,
		in_level, in_wuxing, in_totalexp, in_passiveskill, in_godid, in_strenlv, in_time_stamp, in_strelevelVal, in_awake,in_feishengid,in_feishengext) 
	ON DUPLICATE KEY UPDATE  item_id = in_item_id, item_tid = in_item_tid, slot_id = in_slot_id, stack_num = in_stack_num,
	flags = in_flags, bag = in_bag, level = in_level, wuxing = in_wuxing, totalexp = in_totalexp, passiveskill = in_passiveskill, 
	godid = in_godid, strenlv=in_strenlv, time_stamp = in_time_stamp,strelevelVal=in_strelevelVal,awake=in_awake,feishengid=in_feishengid,feishengext=in_feishengext;
END;;
#***************************************************************
##版本456修改完成
#***************************************************************
#***************************************************************
##版本457修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_insert_or_update_player_pvp_info
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_or_update_player_pvp_info`;
CREATE PROCEDURE `sp_insert_or_update_player_pvp_info`(IN `in_charguid` bigint, IN `in_curcnt` int, IN `in_totalcnt` int, IN `in_wincnt` int,
IN `in_contwincnt` int, IN `in_flags` int, IN `in_crossscore3` int, IN `in_crosscnt3` int, IN `in_crossteamcnt` int)
BEGIN
	INSERT INTO tb_player_crosspvp(charguid, curcnt, totalcnt, wincnt, contwincnt, flags, crossscore3, crosscnt3, crossteamcnt)
	VALUES (in_charguid, in_curcnt, in_totalcnt, in_wincnt, in_contwincnt, in_flags, in_crossscore3, in_crosscnt3, in_crossteamcnt) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid, curcnt=in_curcnt, totalcnt = in_totalcnt, 
	wincnt = in_wincnt, contwincnt = in_contwincnt, flags = in_flags, crossscore3 = in_crossscore3, crosscnt3 = in_crosscnt3,
	crossteamcnt = in_crossteamcnt;
END;;
#***************************************************************
##版本457修改完成
#***************************************************************
#***************************************************************
##版本458修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_update_player_recharge
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_player_recharge`;
CREATE PROCEDURE `sp_update_player_recharge`(IN `in_order_id` VARCHAR(64))
BEGIN
	update tb_exchange_record set recharge = recharge + 1 where order_id = in_order_id;
END;;

-- ----------------------------
-- Procedure structure for sp_exchange_record_select
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_exchange_record_select`;
CREATE PROCEDURE `sp_exchange_record_select`(IN `in_order_id` varchar(64))
BEGIN
 	SELECT * FROM tb_exchange_record
 	WHERE order_id = in_order_id;
END;;
#***************************************************************
##版本458修改完成
#***************************************************************
#***************************************************************
##版本459修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_insert_or_update_player_pvp_info
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_qilinbi_select_by_id`;
CREATE PROCEDURE `sp_player_qilinbi_select_by_id`(in in_charguid bigint)
BEGIN
	select * from tb_player_qilinbi where charguid=in_charguid;
END;;
-- ----------------------------
-- Procedure structure for sp_player_qilinbi_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_qilinbi_insert_update`;
CREATE PROCEDURE `sp_player_qilinbi_insert_update`(IN `in_charguid` bigint, IN `in_level` int, IN `in_wish` int, IN `in_use_level` int, IN `in_attr_dan` int,IN `in_AllNum` int, IN `in_KeLingQuNum` int, IN `in_YiLingQuNum` int)
BEGIN
	INSERT INTO tb_player_qilinbi(charguid, level, wish, use_level, attr_dan, AllNum, KeLingQuNum, YiLingQuNum)
	VALUES (in_charguid, in_level, in_wish, in_use_level, in_attr_dan, in_AllNum, in_KeLingQuNum, in_YiLingQuNum)
	ON DUPLICATE KEY UPDATE level=in_level, wish=in_wish, use_level=in_use_level, attr_dan=in_attr_dan, AllNum=in_AllNum, KeLingQuNum=in_KeLingQuNum, YiLingQuNum=in_YiLingQuNum;
END;;
-- ----------------------------
-- Procedure structure for sp_select_rank_qilinbi
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_qilinbi`;
CREATE PROCEDURE `sp_select_rank_qilinbi`()
BEGIN
	SELECT * FROM tb_rank_qilinbi;
END;;
-- ----------------------------
-- Procedure structure for sp_update_rank_qilinbi
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_rank_qilinbi`;
CREATE PROCEDURE `sp_update_rank_qilinbi`(IN `in_rank` int, IN `in_charguid` bigint, IN `in_lastrank` int, IN `in_rankvalue` bigint)
BEGIN
	INSERT INTO tb_rank_qilinbi(rank, charguid, lastrank, rankvalue)
	VALUES (in_rank, in_charguid, in_lastrank, in_rankvalue)
	ON DUPLICATE KEY UPDATE rank = in_rank, charguid = in_charguid, lastrank = in_lastrank, rankvalue = in_rankvalue;
END;;
-- ----------------------------
-- Procedure structure for sp_rank_qilinbi
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_rank_qilinbi`;
CREATE PROCEDURE `sp_rank_qilinbi`()
BEGIN
SELECT a.charguid AS uid, a.level AS rankvalue FROM tb_player_qilinbi as a left join tb_player_info as b
on a.charguid = b.charguid WHERE a.level > 0 ORDER BY a.level DESC, a.wish DESC, b.power DESC LIMIT 100;
END;;
-- ----------------------------
-- Procedure structure for sp_select_rank_human_info_base
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_human_info_base`;
CREATE PROCEDURE `sp_select_rank_human_info_base`(IN `in_id` bigint)
BEGIN
	SELECT charguid, name, prof, level, hp, mp, power, vip_level, sex, dress, glorylevel,
arms, head, suit, weapon, hunli, tipo, shenfa, jingshen, vplan, wingid, shenbingid, suitflag,crossscore,txvipflag, txbvipflag,
    IFNULL((select (case when use_type=2 then use_id else 0 end) from tb_player_wing_skin where charguid=tb_player_info.charguid limit 1),0) as wing_skin,
    IFNULL((select use_level from tb_player_pifeng where charguid=tb_player_info.charguid limit 1),0) as piFengLevel,
    IFNULL((select curr_id from tb_player_guanzhi where charguid=tb_player_info.charguid limit 1),0) as guanzhi,
    IFNULL((select use_level from tb_player_baojia where charguid=tb_player_info.charguid limit 1),0) as BaoJiaLevel,
    IFNULL((select use_level from tb_player_tiangang where charguid=tb_player_info.charguid limit 1),0) as TianGangLevel,
	IFNULL((select hongyan_id from tb_player_extra where charguid=tb_player_info.charguid limit 1),0) as HongyanId,
	IFNULL((select use_level from tb_player_hunqi where charguid=tb_player_info.charguid limit 1),0) as HunQiLevel,
    IFNULL((select use_level from tb_player_qilinbi where charguid=tb_player_info.charguid limit 1),0) as QilinbiLevel
FROM tb_player_info WHERE charguid = in_id;
END;;
#***************************************************************
##版本459修改完成
#***************************************************************
#***************************************************************
##版本460修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_select_player_minglun_gem
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_minglun_gem`;
CREATE PROCEDURE `sp_select_player_minglun_gem`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_minglun_gem WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_minglun_gem_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_minglun_gem_insert_update`;
CREATE PROCEDURE `sp_player_minglun_gem_insert_update`(IN `in_charguid` bigint, IN `in_id` int)
BEGIN
	INSERT INTO tb_player_minglun_gem(charguid, id)
	VALUES (in_charguid, in_id)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, id = in_id;
END ;;
-- ----------------------------
-- Procedure structure for sp_select_player_minglun_gem_item
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_minglun_gem_item`;
CREATE PROCEDURE `sp_select_player_minglun_gem_item`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_minglun_gem_item WHERE charguid = in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_minglun_gem_item_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_minglun_gem_item_insert_update`;
CREATE PROCEDURE `sp_player_minglun_gem_item_insert_update`(IN `in_charguid` bigint, IN `in_itemgid` bigint, IN `in_itemtid` int, IN `in_pos` int, IN `in_type` int,
 IN `in_time_stamp` bigint)
BEGIN
	INSERT INTO tb_player_minglun_gem_item(charguid, itemgid, itemtid, pos, type, time_stamp)
	VALUES (in_charguid, in_itemgid,in_itemtid,in_pos,in_type,in_time_stamp)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, itemgid = in_itemgid, itemtid = in_itemtid, pos = in_pos, type = in_type,
	 time_stamp = in_time_stamp;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_minglun_gem_item_delete_by_id_and_timestamp
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_minglun_gem_item_delete_by_id_and_timestamp`;
CREATE PROCEDURE `sp_player_minglun_gem_item_delete_by_id_and_timestamp`(IN `in_charguid` bigint, IN `in_time_stamp` bigint)
BEGIN
  DELETE FROM tb_player_minglun_gem_item WHERE charguid = in_charguid AND time_stamp <> in_time_stamp;
END;;
#***************************************************************
##版本460修改完成
#***************************************************************
#***************************************************************
##版本461修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_insert_update_fabao_skillup
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_insert_update_fabao_skillup`;
CREATE PROCEDURE `sp_player_insert_update_fabao_skillup`(IN `in_charguid` bigint, IN `in_skillup_id` int,IN `in_level_id` int,IN `in_level_exp` int)
BEGIN
	INSERT INTO tb_player_fabao_skillup(charguid, skillup_id, level_id, level_exp)
	VALUES (in_charguid, in_skillup_id, in_level_id, in_level_exp)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, skillup_id=in_skillup_id, level_id=in_level_id, level_exp=in_level_exp;
END;;

-- ----------------------------
-- Procedure structure for sp_player_select_fabao_skillup
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_select_fabao_skillup`;
CREATE PROCEDURE `sp_player_select_fabao_skillup`(IN `in_charguid` bigint)
BEGIN
	select * from tb_player_fabao_skillup where charguid = in_charguid;
END;;
#***************************************************************
##版本461修改完成
#***************************************************************
#***************************************************************
##版本462修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_equips_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_equips_insert_update`;
CREATE PROCEDURE `sp_player_equips_insert_update`(IN `in_charguid` bigint, IN `in_item_id` bigint, IN `in_item_tid` int, IN `in_slot_id` int,
	 IN `in_stack_num` int, IN `in_flags` bigint,IN `in_bag` int, IN `in_strenid` int, IN `in_strenval` int, IN `in_proval` int, IN `in_extralv` int,
	 IN `in_superholenum` int, IN `in_super1` varchar(64),IN `in_super2` varchar(64),IN `in_super3` varchar(64),IN `in_super4` varchar(64),
	 IN `in_super5` varchar(64), IN `in_super6` varchar(64), IN `in_super7` varchar(64), IN `in_newsuper` varchar(64), IN `in_time_stamp` bigint,
	 IN `in_newgroup` int, IN `in_newgroupbind` bigint, IN `in_wash` varchar(64), IN `in_NewGroupLevel` int, IN `in_jinglian` int,
	 IN `in_godlevel` int, IN `in_blesslevel` int)
BEGIN
	INSERT INTO tb_player_equips(charguid, item_id, item_tid, slot_id, stack_num, flags, bag, strenid, strenval, proval, extralv, superholenum,
	super1, super2, super3, super4, super5, super6, super7, newsuper, time_stamp, newgroup, newgroupbind, wash, NewGroupLevel, jinglian, godlevel)
	VALUES (in_charguid, in_item_id, in_item_tid, in_slot_id, in_stack_num, in_flags, in_bag, in_strenid, in_strenval, in_proval, in_extralv,
	in_superholenum, in_super1, in_super2, in_super3, in_super4, in_super5, in_super6, in_super7, in_newsuper, in_time_stamp, 
	in_newgroup, in_newgroupbind, in_wash, in_NewGroupLevel, in_jinglian, in_godlevel) 
	ON DUPLICATE KEY UPDATE charguid=in_charguid, item_id=in_item_id, item_tid=in_item_tid, slot_id=in_slot_id, 
	stack_num=in_stack_num, flags=in_flags, bag=in_bag, strenid=in_strenid, strenval=in_strenval,proval=in_proval, extralv=in_extralv, 
	superholenum=in_superholenum, super1=in_super1, super2=in_super2, super3=in_super3, super4=in_super4, 
	super5=in_super5,super6=in_super6,super7=in_super7,newsuper=in_newsuper,time_stamp = in_time_stamp,newgroup=in_newgroup,newgroupbind = in_newgroupbind,
	wash = in_wash, NewGroupLevel=in_NewGroupLevel, jinglian=in_jinglian, godlevel=in_godlevel, blesslevel=in_blesslevel;
END;;
#***************************************************************
##版本462修改完成
#***************************************************************
#***************************************************************
##版本463修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_jianyu_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_jianyu_insert_update`;
CREATE PROCEDURE `sp_player_jianyu_insert_update`(IN `in_charguid` bigint, IN `in_lvl` int, IN `in_proce_num` int, IN `in_process` int, IN `in_sel` int, IN `in_attrperdan` int, IN `in_attrdan` int)
BEGIN
	INSERT INTO tb_player_jianyu(charguid, level, proce_num, process, sel, attrperdan, attrdan)
	VALUES (in_charguid, in_lvl, in_proce_num, in_process, in_sel, in_attrperdan, in_attrdan)
	ON DUPLICATE KEY UPDATE charguid = in_charguid, level = in_lvl, process = in_process, sel = in_sel, proce_num = in_proce_num, attrperdan = in_attrperdan, attrdan = in_attrdan;
END ;;
-- ----------------------------
-- Procedure structure for sp_player_jianyu_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_jianyu_select_by_id`;
CREATE PROCEDURE `sp_player_jianyu_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_jianyu WHERE charguid=in_charguid;
END ;;
-- ----------------------------
-- Procedure structure for sp_rank_jianyu
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_rank_jianyu`;
CREATE PROCEDURE `sp_rank_jianyu`()
BEGIN
	SELECT tb_player_jianyu.charguid AS uid, tb_player_jianyu.level AS rankvalue FROM tb_player_jianyu left join tb_player_info
	on tb_player_jianyu.charguid = tb_player_info.charguid
	WHERE tb_player_jianyu.level > 0 ORDER BY tb_player_jianyu.level DESC, proce_num DESC, tb_player_info.power DESC LIMIT 100;
END;;
-- ----------------------------
-- Procedure structure for sp_select_rank_jianyu
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_rank_jianyu`;
CREATE PROCEDURE `sp_select_rank_jianyu`()
BEGIN
	SELECT * FROM tb_rank_jianyu;
END;;
-- ----------------------------
-- Procedure structure for sp_update_rank_jianyu
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_rank_jianyu`;
CREATE PROCEDURE `sp_update_rank_jianyu`(IN `in_rank` int, IN `in_charguid` bigint, IN `in_lastrank` int, IN `in_rankvalue` bigint)
BEGIN
	INSERT INTO tb_rank_jianyu(rank, charguid, lastrank, rankvalue)
	VALUES (in_rank, in_charguid, in_lastrank, in_rankvalue)
	ON DUPLICATE KEY UPDATE rank = in_rank, charguid = in_charguid, lastrank = in_lastrank, rankvalue = in_rankvalue;
END;;
#***************************************************************
##版本463修改完成
#***************************************************************
#***************************************************************
##版本464修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for sp_player_pifengqixing_insert_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_pifengqixing_insert_update`;
CREATE PROCEDURE `sp_player_pifengqixing_insert_update`(IN `in_charguid` bigint, IN `in_id` int, IN `in_level` int, IN `in_progress` int)
BEGIN
	INSERT INTO tb_player_pifengqixing(charguid, id, level, progress)
	VALUES (in_charguid, in_id, in_level, in_progress)
	ON DUPLICATE KEY UPDATE level = in_level, progress=in_progress;
END;;
-- ----------------------------
-- Procedure structure for sp_player_pifengqixing_select_by_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_player_pifengqixing_select_by_id`;
CREATE PROCEDURE `sp_player_pifengqixing_select_by_id`(IN `in_charguid` bigint)
BEGIN
	SELECT * FROM tb_player_pifengqixing WHERE charguid=in_charguid;
END;;
#***************************************************************
##版本464修改完成
#***************************************************************
###############################过程修改完成####################################
###############################################################################
#↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
DELIMITER ;

DELIMITER ;;
-- ----------------------------
-- Procedure structure for sp_select_player_list_by_account_id
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_list_by_account_id`;
CREATE PROCEDURE `sp_select_player_list_by_account_id`(IN `in_account_id` bigint)
BEGIN
	SELECT * FROM tb_player_info WHERE account_id = in_account_id;
END;;

-- ----------------------------
-- Procedure structure for sp_update_forbidden_player_chat
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_forbidden_player_chat`;
CREATE PROCEDURE `sp_update_forbidden_player_chat`(IN `in_charguid` bigint)
BEGIN
	UPDATE tb_player_info SET  forb_chat_last = in_forb_chat_last, forb_chat_time = in_forb_chat_time
	WHERE charguid = in_charguid;
END ;;
DELIMITER;;


#***************************************************************
##版本465修改开始
#***************************************************************
-- ----------------------------
-- Procedure structure for `sp_select_player_change`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_player_change`;
CREATE PROCEDURE `sp_select_player_change`(IN `in_charguid` bigint)
BEGIN
  SELECT * FROM tb_player_change where charguid = in_charguid;
END;;
-- ----------------------------
-- Procedure structure for `sp_insert_update_player_change`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_update_player_change`;
CREATE PROCEDURE `sp_insert_update_player_change`(IN `in_charguid` bigint,IN `in_changeid` int, IN `in_begin_time` int, IN `in_end_time` int)
BEGIN
  INSERT INTO tb_player_change(charguid, changeid, begin_time, end_time)
  VALUES (in_charguid,in_changeid, in_begin_time, in_end_time) 
  ON DUPLICATE KEY UPDATE charguid=in_charguid, 
  changeid = in_changeid,
  begin_time  = in_begin_time,
  end_time    = in_end_time;
END;;
DELIMITER;;
#***************************************************************
##版本465修改结束
#***************************************************************
