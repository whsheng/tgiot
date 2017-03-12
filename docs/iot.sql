SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `t_objectinfo`;
DROP TABLE IF EXISTS `t_objecttype`;
DROP TABLE IF EXISTS `t_simcard`;
DROP TABLE IF EXISTS `t_devicetype`;
DROP TABLE IF EXISTS `t_role`;
DROP TABLE IF EXISTS `t_module`;
DROP TABLE IF EXISTS `t_rolepermission`;
DROP TABLE IF EXISTS `t_account`;
DROP TABLE IF EXISTS `t_oplog`;
DROP TABLE IF EXISTS `t_deviceconfig`;
DROP TABLE IF EXISTS `t_channel`;
DROP TABLE IF EXISTS `t_accountext`;
DROP TABLE IF EXISTS `t_accountobject`;
DROP TABLE IF EXISTS `t_vehicle`;
DROP TABLE IF EXISTS `t_channelobject`;
DROP TABLE IF EXISTS `t_historytrack`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `t_objectinfo` (
    `object_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '设备自编号，自增量、不允许为空',
    `object_type_id` INT NOT NULL COMMENT '目标类型ID',
    `imei` VARCHAR(16) COMMENT '设备IMEI号，不允许为空，不能重复',
    `sim` varchar(16) NOT NULL COMMENT '设备simkahaoi',
    `device_type_id` INT NOT NULL COMMENT '目标类型ID',
    `register_time` DATETIME NOT NULL COMMENT '设备注册时间',
    `active_time` DATETIME NOT NULL COMMENT '设备激活时间',
    `device_id` VARCHAR(32) NOT NULL COMMENT '设备ID',
    `device_key` VARCHAR(16) NOT NULL COMMENT '设备key',
    `device_secret` VARCHAR(32) NOT NULL COMMENT '设备密钥',
    `remark` VARCHAR(32) NOT NULL COMMENT '备注',
    `device_status` SMALLINT NOT NULL COMMENT '设备状态',
    `creator` BIGINT NOT NULL COMMENT '创建者',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `object_name` VARCHAR(16) NOT NULL COMMENT '设备名称',
    PRIMARY KEY (`object_id`),
    UNIQUE (`object_id`, `imei`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_objecttype` (
    `object_type_id` INT NOT NULL AUTO_INCREMENT COMMENT '目标类型ID',
    `object_type_name` VARCHAR(16) NOT NULL COMMENT '目标类型名称，如：汽车、轮船等',
    `object_type_icon` VARCHAR(64) NOT NULL COMMENT '目标类型对应的图标',
    `remark` VARCHAR(32) NOT NULL COMMENT '备注',
    PRIMARY KEY (`object_type_id`),
    UNIQUE (`object_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_simcard` (
    `iccid` VARCHAR(20) NOT NULL COMMENT '卡的唯一标识',
    `sim` VARCHAR(16) NOT NULL COMMENT '卡的唯一标识',
    `source` INT NOT NULL COMMENT '表示这张卡的来源，如：某个卡务服务商',
    `set_type` INT NOT NULL COMMENT '套餐类型',
    `register_time` DATETIME NOT NULL COMMENT '注册时间',
    `status` INT NOT NULL COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `t_devicetype` (
    `device_type_id` INT NOT NULL AUTO_INCREMENT COMMENT '设备类型ID',
    `device_type_name` VARCHAR(32) NOT NULL COMMENT '设备类型名称',
    `device_model` VARCHAR(16) NOT NULL COMMENT '设备类型名称',
    `manufacturer` VARCHAR(32) NOT NULL COMMENT '设备厂商',
    `remark` VARCHAR(64) NOT NULL COMMENT '备注',
    PRIMARY KEY (`device_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_role` (
    `role_id` INT NOT NULL AUTO_INCREMENT COMMENT '角色ID',
    `role_name` VARCHAR(16) NOT NULL COMMENT '角色名称',
    `remark` VARCHAR(64) NOT NULL COMMENT '备注',
    `creator` BIGINT NOT NULL COMMENT '创建者',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    PRIMARY KEY (`role_id`),
    UNIQUE (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_module` (
    `module_id` INT NOT NULL AUTO_INCREMENT COMMENT '模块ID',
    `module_name` VARCHAR(32) NOT NULL COMMENT '模块名称',
    `module_url` VARCHAR(128) NOT NULL COMMENT '模块URL',
    `parent_id` INT NOT NULL COMMENT '父模块ID',
    `remark` VARCHAR(64) NOT NULL COMMENT '备注',
    PRIMARY KEY (`module_id`),
    UNIQUE (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_rolepermission` (
    `permission_id` INT NOT NULL AUTO_INCREMENT COMMENT '角色权限ID',
    `role_id` INT NOT NULL COMMENT '角色ID',
    `module_id` INT NOT NULL COMMENT '模块ID',
    `is_enable` BIT NOT NULL COMMENT '是否可用',
    `remark` VARCHAR(64) NOT NULL COMMENT '备注',
    PRIMARY KEY (`permission_id`),
    UNIQUE (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_account` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '账号ID',
    `account` VARCHAR(32) NOT NULL COMMENT '账号名称',
    `passwd` VARCHAR(32) NOT NULL COMMENT '账号密码',
    `role_id` INT NOT NULL COMMENT '账号角色ID',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `is_enable` BIT NOT NULL COMMENT '是否可用',
    `nick_name` VARCHAR(32) NOT NULL COMMENT '昵称',
    `avatar_url` VARCHAR(128) NOT NULL COMMENT '账号头像URL',
    `channel_id` BIGINT COMMENT '渠道ID',
    PRIMARY KEY (`id`, `account`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_oplog` (
    `account_id` BIGINT NOT NULL COMMENT '账户ID',
    `op_time` DATETIME NOT NULL COMMENT '操作时间',
    `op_ip` VARCHAR(16) NOT NULL COMMENT '操作IP',
    `op_rule` INT NOT NULL COMMENT '操作规则'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `t_deviceconfig` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增ID',
    `object_id` BIGINT NOT NULL COMMENT '目标ID',
    `param_name` VARCHAR(16) NOT NULL COMMENT '参数名',
    `param_value` VARCHAR(32) NOT NULL COMMENT '参数值',
    `update_time` DATETIME NOT NULL COMMENT '更新时间',
    `remark` VARCHAR(64) NOT NULL COMMENT '备注',
    `set_flag` TINYINT NOT NULL COMMENT '设置标记',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_channel` (
    `channel_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '渠道ID',
    `channle_name` VARCHAR(16) NOT NULL COMMENT '渠道名称',
    `channel_alias` VARCHAR(16) NOT NULL COMMENT '别名',
    `comtact_no` VARCHAR(16) NOT NULL COMMENT '联系电话',
    `channel_type` INT NOT NULL COMMENT '渠道类型',
    `parent_id` BIGINT NOT NULL COMMENT '渠道类型',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `creator` BIGINT NOT NULL COMMENT '创建者',
    `remark` VARCHAR(64) NOT NULL COMMENT '备注',
    PRIMARY KEY (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_accountext` (
    `account_id` BIGINT NOT NULL COMMENT '账户ID',
    `alias` VARCHAR(32) NOT NULL COMMENT '别名',
    `email` VARCHAR(64) NOT NULL COMMENT '邮箱',
    `mobile` VARCHAR(16) NOT NULL COMMENT '手机'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `t_accountobject` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增ID',
    `account_id` BIGINT NOT NULL COMMENT '账号ID',
    `object_id` BIGINT NOT NULL COMMENT '目标ID',
    `create_time` DATETIME NOT NULL COMMENT '创建日期',
    `isbind` BIT NOT NULL COMMENT '绑定关系',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_vehicle` (
    `vehicle_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '车辆ID',
    `object_id` BIGINT NOT NULL,
    `vehicle_num` VARCHAR(12) NOT NULL COMMENT '车牌号',
    `engine_no` VARCHAR(8) NOT NULL COMMENT '发动机号',
    `buy_time` DATETIME NOT NULL COMMENT '购买时间',
    `brand` VARCHAR(16) NOT NULL COMMENT '车辆品牌',
    `create_time` DATETIME NOT NULL COMMENT '创建日期',
    `creator` BIGINT NOT NULL COMMENT '创建者',
    `remark` VARCHAR(64) NOT NULL COMMENT '备注',
    `vin` VARCHAR(18) NOT NULL COMMENT '车架号',
    PRIMARY KEY (`vehicle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_channelobject` (
    `channel_id` BIGINT NOT NULL COMMENT '渠道ID',
    `object_id` BIGINT NOT NULL COMMENT '目标ID',
    `create_time` DATETIME NOT NULL COMMENT '创建日期',
    `creator` BIGINT NOT NULL COMMENT '创建者',
    `remark` VARCHAR(64) NOT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `t_historytrack` (
    `object_id` BIGINT NOT NULL COMMENT '目标ID',
    `gps_time` DATETIME NOT NULL COMMENT 'GPS时间',
    `recv_time` DATETIME NOT NULL COMMENT '后台接收时间',
    `lat` BIGINT NOT NULL COMMENT '经度',
    `lon` BIGINT NOT NULL COMMENT '纬度',
    `speed` INT NOT NULL COMMENT '速度',
    `direct` smallint NOT NULL COMMENT '方向',
    `mileage` INT NOT NULL COMMENT '历程',
    `gps_flag` smallint NOT NULL COMMENT 'GPS定位标记',
    `gps_signal` int NOT NULL COMMENT 'GPS信号强度',
    `gsm_signal` int NOT NULL COMMENT 'GSM信号强度',
    `battery` TINYINT NOT NULL COMMENT '电量',
    `pos_desc` VARCHAR(64) NOT NULL COMMENT '位置描述',
    `raw_data` LONGTEXT NOT NULL COMMENT '原始数据包',
    `create_time` DATETIME NOT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
