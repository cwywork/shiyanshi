/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : qhdxlab

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-04-08 09:29:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for authority
-- ----------------------------
DROP TABLE IF EXISTS `authority`;
CREATE TABLE `authority` (
  `Id` varchar(32) NOT NULL DEFAULT '' COMMENT 'Id',
  `roleId` char(32) DEFAULT NULL COMMENT '角色Id',
  `stepId` char(32) DEFAULT NULL COMMENT '流程Id',
  `menuId` char(255) DEFAULT NULL COMMENT '菜单Id',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `extend` varchar(255) DEFAULT NULL COMMENT '扩展',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authority
-- ----------------------------
INSERT INTO `authority` VALUES ('1', '0', '1d27e859622511e7b62fbbd90eb76f07', '0', '项目填写人', '专项ID为以1开头，加step');
INSERT INTO `authority` VALUES ('102', '9065f9cb85ce4ec2a56f114ca5a217f1', '231caa66622511e7b62fbbd90eb76f07', '[06, 0601, 060102, 060103, 060104, 0602,  060202, 060203, 060204, 0603,060302, 060303, 060304, 0604, 060402, 060403, 060404]', '专项项目负责人', null);
INSERT INTO `authority` VALUES ('103', 'ea525af119734394b4fa6cba4b0f2763', '561e34c4a2e44ffcb09780936d1f1c0f', '[06, 0601, 060102, 060103, 060104, 0602,  060202, 060203, 060204, 0603,060302, 060303, 060304, 0604, 060402, 060403, 060404]', '专项初审人', null);
INSERT INTO `authority` VALUES ('104', '9429f619a17a48e4955658b7a54f7438', '28abbe2c622511e7b62fbbd90eb76f07', '[06, 0601,060102, 060103, 060104, 0602,060202, 060203, 060204, 0603, 060302, 060303, 060304, 0604, 060402, 060403, 060404, 09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304]', '专家专家评审', null);
INSERT INTO `authority` VALUES ('105', '0bdf4459868e47f28ee788254fd53d56', '4b9d362b622b11e7b62fbbd90eb76f07', '[06, 0601, 060102, 060103, 060104, 0602,  060202, 060203, 060204, 0603,060302, 060303, 060304, 0604, 060402, 060403, 060404]', '专项设备处处长', null);
INSERT INTO `authority` VALUES ('106', '410722f444044a22be3109caaf04c752', '6680feeb2ef84d17be3d77b0e829800c', '[06, 0601, 060102, 060103, 060104, 0602,  060202, 060203, 060204, 0603,060302, 060303, 060304, 0604, 060402, 060403, 060404]', null, null);
INSERT INTO `authority` VALUES ('107', '8a4f12c55e4f495c9c18042142ccd60d', '270f86fd6c87440fa1bec24f6e140609', '[06, 0601, 060102, 060103, 060104, 0602,  060202, 060203, 060204, 0603,060302, 060303, 060304, 0604, 060402, 060403, 060404]', '专项执行', null);
INSERT INTO `authority` VALUES ('202', 'ca7f19f891c345da826167a5ee5ef0b8', '0de615f92bf44e9a842afd143eb5e580', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304]', '校内采购主管领导', '校内采购ID为以2开头，加step');
INSERT INTO `authority` VALUES ('203', '7b92a23329eb478f87bb547753041527', '341105a502994a22ad1b9406f41a1e37', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304]', '校内采购预审人', null);
INSERT INTO `authority` VALUES ('204', '277c0b660b2a47858c6b3e954c262794', '27c96bbe3af14b388aaed8878df5ab51', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304]', '校内采购初审', null);
INSERT INTO `authority` VALUES ('205', '0bdf4459868e47f28ee788254fd53d56', '38ddd9b08f0f48c58651aa1b33f3ccb3', '[06, 0601,060102, 060103, 060104, 0602,060202, 060203, 060204, 0603, 060302, 060303, 060304, 0604, 060402, 060403, 060404, 09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304]', '校内采购专家评审', null);
INSERT INTO `authority` VALUES ('206', 'acb787148df34214a6af9a2722fdad2c', '00bffc83becd4863a2730f5664dbf607', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304]', '校内采购归口部门', null);
INSERT INTO `authority` VALUES ('207', '7011e58494fa4ffa82cd5cebf1dcb72d', '4f7b88e5d08947668e50a8b1641b5b83', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304]', '校内采购计财', null);
INSERT INTO `authority` VALUES ('208', 'eed17487be88437cb50c76cab282b68e', 'c56b4b489bf348a49483777e1fa124de', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304]', '校内采购小组办公室', null);
INSERT INTO `authority` VALUES ('209', '802f16504b034ce1826bdd3950ab375f', '91f9d082f46c408ca47f4fa338bddfdc', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304]', '校内采购招标小组领导', null);
INSERT INTO `authority` VALUES ('210', '6da5f6393ad9483fbab13461fb29fa0d', '0d994867676f48a1804e9157d392f803', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304]', '校内采购执行', null);

-- ----------------------------
-- Table structure for classes
-- ----------------------------
DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes` (
  `classId` char(32) NOT NULL DEFAULT '' COMMENT '班级Id',
  `classCode` char(32) DEFAULT '' COMMENT '班级编号',
  `className` varchar(50) DEFAULT NULL COMMENT '班级名称',
  `gradeName` varchar(50) DEFAULT NULL COMMENT '年级名称',
  `headmasterName` varchar(50) DEFAULT NULL COMMENT '班主任名称',
  `headmasterTel` varchar(11) DEFAULT NULL COMMENT '班主任电话',
  `headmasterEmail` varchar(50) DEFAULT NULL COMMENT '班主任邮箱',
  `operateDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `operateMan` varchar(50) DEFAULT NULL COMMENT '操作人',
  `isShow` char(2) DEFAULT '01' COMMENT '''01''显示，''02''不显示',
  PRIMARY KEY (`classId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classes
-- ----------------------------
INSERT INTO `classes` VALUES ('088268ecec4e41a8a0595c1f7f113296', '1', '2班', '1年级', '1', '18811708007', '1@qq.com', '2017-11-08 03:49:40', '2017001', '01');
INSERT INTO `classes` VALUES ('09b52af65bf64b2090cd27164adeb1d4', '3戚戚然', '2年级', '3', '李占萍', '3', '3', '2017-11-07 09:05:14', '2017001', '02');
INSERT INTO `classes` VALUES ('52785449e9624887b92f0e432b6414da', '1213', '1212', '1212', '1212', '18811708007', '1212@qq.com', '2018-01-11 13:29:07', '2017001', '01');
INSERT INTO `classes` VALUES ('dc6dc4ca8fe2484e87d26e66c4f6bbe5', '1', '11', '1', '1', '18811708007', '2@qq.com', '2017-11-08 03:51:17', null, '01');
INSERT INTO `classes` VALUES ('e2c27ab7bafd4c7eb0872b1cba7c24e4', '1213', '1212', '1212', '1212', '18811708007', '1212@qq.com', '2018-01-11 13:28:10', '2017001', '01');
INSERT INTO `classes` VALUES ('f46b6b33690b45e082493d239ff28f41', '1', '1', '1', '1', '1', '1', '2017-11-08 02:13:16', null, '02');

-- ----------------------------
-- Table structure for dgoods
-- ----------------------------
DROP TABLE IF EXISTS `dgoods`;
CREATE TABLE `dgoods` (
  `dGoodsId` char(32) NOT NULL COMMENT '危险品Id',
  `dGoodsCode` char(32) DEFAULT NULL COMMENT '危险品编号',
  `dGoodsName` varchar(40) DEFAULT NULL COMMENT '危险品名称',
  `dGoodsClassify` varchar(255) DEFAULT NULL COMMENT '分类',
  `dGoodsFeatures` varchar(255) DEFAULT NULL COMMENT '危险品特性',
  `dGoodsTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `dGoodSafety` varchar(255) DEFAULT NULL COMMENT '安全防护措施',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `isShow` char(2) DEFAULT '01' COMMENT '''01''显示，''02''不显示',
  `operateMan` varchar(11) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`dGoodsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dgoods
-- ----------------------------
INSERT INTO `dgoods` VALUES ('137d5ed5bee04a3583f7e6eb6bd8cab4', 'qhdx2017J001S840454', '12121', '01', '01', '2018-03-12 11:08:49', '1212', '1212', '01', '2017001');
INSERT INTO `dgoods` VALUES ('4f05f5e0ad7744b08ec3e200b6e6b9dd', 'qhdx2017J001S5125638', '1212', '02', '01', '2018-03-12 10:51:36', '1212', '1212', '01', '2017001');
INSERT INTO `dgoods` VALUES ('9d1b41ff040949c0b10034882e6d934a', 'qhdx2017J001S412541', '12', '01', '01', '2018-03-12 10:41:31', '12', '12', '01', '2017001');

-- ----------------------------
-- Table structure for dict
-- ----------------------------
DROP TABLE IF EXISTS `dict`;
CREATE TABLE `dict` (
  `dictId` varchar(64) NOT NULL DEFAULT '' COMMENT '字典主键',
  `dictCode` varchar(50) DEFAULT NULL COMMENT '字典名称',
  `dictName` varchar(50) DEFAULT NULL COMMENT '字典值',
  `dictUnit` varchar(10) DEFAULT NULL COMMENT '字典单位',
  `dictExtend` varchar(20) DEFAULT NULL COMMENT '字典预留字段',
  PRIMARY KEY (`dictId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dict
-- ----------------------------
INSERT INTO `dict` VALUES ('84823cd1622411e7b62fbbd90eb76f07', 'projectType', '项目类型', '专项与合同管理', '项目类型');
INSERT INTO `dict` VALUES ('89877aee622411e7b62fbbd90eb76f07', 'capitalSource', '资金来源', '专项与合同管理', '资金来源');
INSERT INTO `dict` VALUES ('e9d90f2457684f10bf0718c98f33f763', 'schoolsAndDepartments', '院系设置', '专项与合同管理', '院系设置');
INSERT INTO `dict` VALUES ('2b6423f1c6c947a58c52d0a8ea6d1bd3', 'scientificResearch', '科学研究', '专项与合同管理', '科学研究');
INSERT INTO `dict` VALUES ('559bfcbe622b11e7b62fbbd90eb76f07', 'projectState', '项目状态', '专项与合同管理', '项目状态');
INSERT INTO `dict` VALUES ('99da96ccc5a44a69b3aa2b6f9947f5bb', 'AuditState', '审核状态', '专项与合同管理', null);
INSERT INTO `dict` VALUES ('2596c950f88647f49a1943863547bf6b', 'purchase', '资金来源', '校内采购', null);
INSERT INTO `dict` VALUES ('39da575519c044788c2afe374a4232e2', 'expertType', '专家类型', '专家库', null);
INSERT INTO `dict` VALUES ('955c2619537a4af09e4195b5f685ea13', 'ApplicationProcurement', '申请采购方式', '校内采购', null);
INSERT INTO `dict` VALUES ('f5ce696dd4d54dfbb1a835307ea597eb', 'expert_audit_style', '专家审核类型', '专家审核类型', null);
INSERT INTO `dict` VALUES ('fa0b0ac4c3bd46628ecd91f61df1d3c0', 'receive_goods', '收货状态', '收货状态', null);
INSERT INTO `dict` VALUES ('ebc24a99d5104ee486f631dc213f7965', 'training', '培训状态', '培训状态', null);
INSERT INTO `dict` VALUES ('662ed66026914f689d47f42dc54130ec', 'acceptance', '验收状态', '验收状态', null);
INSERT INTO `dict` VALUES ('ee98408fa695484180dccc205a1dbd9d', 'alternate', '支付状态', '支付状态', null);
INSERT INTO `dict` VALUES ('6d8a7ace0e614af98b581874b94bfa3a', 'goodStyle', '清单类型', '物品清单管理', null);
INSERT INTO `dict` VALUES ('f67eafa37be94bf9b301a064ba061322', 'isSubmit', '是否提交', '物品清单管理', null);
INSERT INTO `dict` VALUES ('d30982fbbc7d42e0acc819a7541729ba', 'goodBrand', '商品品牌', '物品清单管理', null);
INSERT INTO `dict` VALUES ('2c2e34541fc7470b970631032fdc5be9', 'category', '商品类目', '物品清单管理', null);
INSERT INTO `dict` VALUES ('cdbce3e748af41298a9f15655b3a6213', 'isaudit', '是否审核', '物品清单管理', null);
INSERT INTO `dict` VALUES ('6fbe463e28bb4e0dbbd1f9ba2dfc5e37', 'goodUnit', '商品单位', '物品清单管理', null);
INSERT INTO `dict` VALUES ('1466eb47fde443d1aba3c68c04efe52b', 'lab_style', '实验室类型', '实验室管理', null);
INSERT INTO `dict` VALUES ('3482ef2b1ae540fc992b681e938332db', 'lab_state', '使用状态', '实验室管理', null);
INSERT INTO `dict` VALUES ('db3f0599234e48b7b731f3bef8053b68', 'lab_isuse', '是否可用', '实验室管理', null);
INSERT INTO `dict` VALUES ('6680feeb2ef84d17be3d77b0e829800c', 'campuspurchasing', '项目状态', '校内采购', null);
INSERT INTO `dict` VALUES ('073fa7cef19548009cc795201799d5fe', 'tender', '招标状态', '招标状态', null);
INSERT INTO `dict` VALUES ('1e0943e41e7e435eb55026b3b3c5bb07', 'contract', '合同状态', '合同状态', null);
INSERT INTO `dict` VALUES ('cd6085afd1b34a90b8f26af3680a8fad', 'country', '国别', '国别', null);
INSERT INTO `dict` VALUES ('457348a3f0a24459b13591a8ccb1ac03', 'nation', '民族', '民族', null);
INSERT INTO `dict` VALUES ('50f7fc08b1e246bf937a305ae619b64b', 'major', '专业类型', '专业类型', null);
INSERT INTO `dict` VALUES ('77be3732f265412c9393a5f49f6a49fd', 'sex', '性别', '性别', null);
INSERT INTO `dict` VALUES ('41c5495af424462abea66ae10760b23e', 'NativePlace', '出生地', '出生地', null);
INSERT INTO `dict` VALUES ('6ed0f1336218425e97b1cb5623a699dc', 'schoolingLenth', '学制', '学制', null);
INSERT INTO `dict` VALUES ('b3dd6fbbb95a439497acdc9cf85d3fb7', 'isHeadmaster', '是否班主任', '是否班主任', null);
INSERT INTO `dict` VALUES ('10e1254109524898a04d5d59797856f8', 'teacherFormation', '教师编制', '教师编制', null);
INSERT INTO `dict` VALUES ('0dd5fbd96cde4d5a89e3002185b7db9f', 'centralized_department', '归口部门类型', '归口部门', null);
INSERT INTO `dict` VALUES ('8112ecbab696436591e71e4bcf166803', 'confirmation', '合同确认', '合同确认状态', null);
INSERT INTO `dict` VALUES ('c2ed4b28cb8a46598e2643c125352be9', 'dGoodsClassify', '危险品归类', '危险品归类', null);
INSERT INTO `dict` VALUES ('60592e6b13ed45e39e895c8269885cfd', 'dGoodsFeatures', '危险品特性', '危险品特性', null);

-- ----------------------------
-- Table structure for dictinfo
-- ----------------------------
DROP TABLE IF EXISTS `dictinfo`;
CREATE TABLE `dictinfo` (
  `dictId` varchar(64) NOT NULL DEFAULT '' COMMENT '字典主键',
  `dictName` varchar(50) DEFAULT NULL COMMENT '字典名称',
  `dictValue` varchar(50) DEFAULT NULL COMMENT '字典值',
  `dictTypeId` varchar(32) DEFAULT NULL COMMENT '字典类型',
  `dictUnit` varchar(10) DEFAULT NULL COMMENT '字典单位',
  `dictExtend` varchar(20) DEFAULT NULL COMMENT '字典预留字段',
  PRIMARY KEY (`dictId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of dictinfo
-- ----------------------------
INSERT INTO `dictinfo` VALUES ('84823cd1622411e7b62fbbd90eb76f07', '学科建设', '01', '84823cd1622411e7b62fbbd90eb76f07', '', '项目类型');
INSERT INTO `dictinfo` VALUES ('89877aee622411e7b62fbbd90eb76f07', '教育教学建设', '02', '84823cd1622411e7b62fbbd90eb76f07', '', '项目类型');
INSERT INTO `dictinfo` VALUES ('e9f75e04622411e7b62fbbd90eb76f07', '科研平台及基地', '03', '84823cd1622411e7b62fbbd90eb76f07', '', '项目类型');
INSERT INTO `dictinfo` VALUES ('ef26fd0c622411e7b62fbbd90eb76f07', '实验室改造', '04', '84823cd1622411e7b62fbbd90eb76f07', '', '项目类型');
INSERT INTO `dictinfo` VALUES ('f40745f3622411e7b62fbbd90eb76f07', '基建及维修', '05', '84823cd1622411e7b62fbbd90eb76f07', '', '项目类型');
INSERT INTO `dictinfo` VALUES ('e54c37fc9cb64c1d9da58a13b0ac9d32', '随机专家', '01', 'f5ce696dd4d54dfbb1a835307ea597eb', '专家审核类型', '专家审核类型');
INSERT INTO `dictinfo` VALUES ('1d27e859622511e7b62fbbd90eb76f07', '未立项', '01', '559bfcbe622b11e7b62fbbd90eb76f07', '项目状态', '项目状态');
INSERT INTO `dictinfo` VALUES ('231caa66622511e7b62fbbd90eb76f07', '申报中', '02', '559bfcbe622b11e7b62fbbd90eb76f07', '项目状态', '项目状态');
INSERT INTO `dictinfo` VALUES ('28abbe2c622511e7b62fbbd90eb76f07', '初审中', '04', '559bfcbe622b11e7b62fbbd90eb76f07', '项目状态', '项目状态');
INSERT INTO `dictinfo` VALUES ('4b9d362b622b11e7b62fbbd90eb76f07', '专家审核中', '05', '559bfcbe622b11e7b62fbbd90eb76f07', '项目状态', '项目状态');
INSERT INTO `dictinfo` VALUES ('a8bcfb0310b54186a13fafd6aea02168', '指定专家', '02', 'f5ce696dd4d54dfbb1a835307ea597eb', '专家审核类型', '专家审核类型');
INSERT INTO `dictinfo` VALUES ('6680feeb2ef84d17be3d77b0e829800c', '项目待确认', '06  ', '559bfcbe622b11e7b62fbbd90eb76f07', '项目状态', '项目状态');
INSERT INTO `dictinfo` VALUES ('559bfcbe622b11e7b62fbbd91eb76f07', '后勤', '06', '84823cd1622411e7b62fbbd90eb76f07', null, '项目类型');
INSERT INTO `dictinfo` VALUES ('559bfcbe622b11e7b62fbbd92eb76f07', '公共服务体系', '07', '84823cd1622411e7b62fbbd90eb76f07', null, '项目类型');
INSERT INTO `dictinfo` VALUES ('559bfcbe622b11e7b62fbbd93eb76f07', '其它', '08', '84823cd1622411e7b62fbbd90eb76f07', null, '项目类型');
INSERT INTO `dictinfo` VALUES ('bbe5d60072444f79830b5af48e4dfb2d', '中央财政', '01', '89877aee622411e7b62fbbd90eb76f07', '', '资金来源');
INSERT INTO `dictinfo` VALUES ('0d0270283745424a9fb0a5887445e1e9', '省级财政', '02', '89877aee622411e7b62fbbd90eb76f07', '', '资金来源');
INSERT INTO `dictinfo` VALUES ('9fbadbdd0e3a458d9c2c4ab44673eec0', '办公室', '18', 'e9d90f2457684f10bf0718c98f33f763', '李占萍', '18691822573');
INSERT INTO `dictinfo` VALUES ('1274cc5c43e44af5b8aa1d1da865eb56', '纪委', '36', 'e9d90f2457684f10bf0718c98f33f763', 'lzp', '18691822573');
INSERT INTO `dictinfo` VALUES ('1b895940a58446e4be553ad9dde839f1', '组织人事部', '19', 'e9d90f2457684f10bf0718c98f33f763', '小天儿', '18691822573');
INSERT INTO `dictinfo` VALUES ('3a197459339a4f8a96dce5feed2d34aa', '宣传部', '20', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('b9c39918faf148d7be885b02c2a05315', '工会', '21', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('cab48a857137411eace6a5fcca93e872', '发展规划处', '22', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('b99401143be84a33aaf71c1aa27fb93a', '计划财务处', '23', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('145d6d3834d645d29cdb34bfead2ef3e', '科技处', '24', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('c217772b088b48e1b3c08ce6e7b79d19', '教务处', '25', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('bea32e0f454c4ecf93e2cfa81dd37032', '学生工作处', '26', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('8ac51cce788c4ac98f474fb044e2fb5d', '团委', '27', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('15b96cc56ae9487c82aca40514c391d8', '研究生院', '28', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('f7aceb14e7214df587582b038fa5084f', '基础教育处', '29', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('386fb1a7e39846beb17598c01133ff71', '实验室管理处', '30', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('191694e021354dec9de2221c99e76e2c', '基建处', '31', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('4f02872ffeb74afc8813443ea0d3acf4', '保卫处', '32', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('be28bb1b8bf740a7a522776f9cd7ac7c', '督导室', '33', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('a4dad056fbda4a0e9fec24c5a66d1745', '教育教学评估中心', '34', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('77efecb83aa4429e864676ea676637c1', '外事办', '35', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('c01092c53f4f48288ec8c8b162d01001', '图书馆', '38', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('c13669f6139f49e1a94595bdfa4d2855', '学报编辑部', '40', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('63d34c80981a4fec895b2049dcc84912', '信息化技术中心', '37', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('65249a3a1f794f928ac559417f2c2a18', '后勤管理处', '41', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('25bbd7673a5a41ee906562aa5c782418', '国有资产管理中心', '39', 'e9d90f2457684f10bf0718c98f33f763', '', '党政系统');
INSERT INTO `dictinfo` VALUES ('9f1051ef65f948f5ac8ee217b44f3719', '附属医院', '01', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('9093a00db4e147b89d1e4cd07defcaef', '医学院', '02', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('23b46fd18d9c44dca4f66bfa9851a81e', '农牧学院', '03', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('02aeb717b82b4ed2929818517145ae16', '化工学院', '04', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('fbc2b5e8e0fc4be4bfff5eb913755cbd', '财经学院', '05', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('596a2775ae504b298509a51c59648c46', '机械工程学院', '06', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('bc458d1165824121b8a4c89f423cc55c', '水利水电学院', '07', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('7938aee81c724affacf2e61a7e616735', '土木工程学院', '08', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('7caa421edef9430fb8984b66771bc5a5', '生态环境工程学院', '09', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('8f19a56ae1684cf8ab60e71101f09af0', '昆仑学院', '10', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('67a1b3baac1f409db2239d078c0c4edb', '继续教育学院', '11', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('1cf607595afb402293012c350e078d85', '藏医学院', '12', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('5843206590864153a8de28ec4c086ff5', '马克思主义学院', '13', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('a948f5d77dce4e2da94fdd772e65cc3d', '地质工程系', '14', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('4659c1e925d3412281493e67406fcfb1', '计算机技术与应用系', '15', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('f230d5fec16843469b376df750a317fe', '基础部', '16', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('69b18febd0b9462c91b0fe49cafdda5c', '体育部', '17', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('c9a12d945a334a5aad7853e27c6c958d', '农林科学院', '01', '2b6423f1c6c947a58c52d0a8ea6d1bd3', '', '科学研究');
INSERT INTO `dictinfo` VALUES ('e1bbc4755c7e441db4880efd6f074561', '畜牧兽医科学院', '02', '2b6423f1c6c947a58c52d0a8ea6d1bd3', '', '科学研究');
INSERT INTO `dictinfo` VALUES ('bb14d1d8dcf94cb486e23f0eb425cd80', '省部共建三江源生态与高原农牧业国家发展重点实验室', '03', '2b6423f1c6c947a58c52d0a8ea6d1bd3', '', '科学研究');
INSERT INTO `dictinfo` VALUES ('935a6a5a30e741888f3cc45b4493381f', '青海大学-清华大学三江源研究院', '04', '2b6423f1c6c947a58c52d0a8ea6d1bd3', '', '科学研究');
INSERT INTO `dictinfo` VALUES ('171f8e1250c24799af230790a47053e6', '柴达木经济循环研究院', '05', '2b6423f1c6c947a58c52d0a8ea6d1bd3', '', '科学研究');
INSERT INTO `dictinfo` VALUES ('527ba285d17a4a3089f7b298909ace59', '产业发展研究院', '06', '2b6423f1c6c947a58c52d0a8ea6d1bd3', '', '科学研究');
INSERT INTO `dictinfo` VALUES ('f4c897d77bed45718f3d9bcc5295b2e1', '新农村发展研究院', '07', '2b6423f1c6c947a58c52d0a8ea6d1bd3', '', '科学研究');
INSERT INTO `dictinfo` VALUES ('bbafea0601ce4a8a9e2c28fcd970782c', '青海省情研究中心', '08', '2b6423f1c6c947a58c52d0a8ea6d1bd3', '', '科学研究');
INSERT INTO `dictinfo` VALUES ('8111b841184c4252b76e57b80f9b683b', '新能源光伏产业研究中心', '09', '2b6423f1c6c947a58c52d0a8ea6d1bd3', '', '科学研究');
INSERT INTO `dictinfo` VALUES ('00fb19f162364fe1afa7b76ed9564594', '青藏高原天然气水合物研究院', '10', '2b6423f1c6c947a58c52d0a8ea6d1bd3', '', '科学研究');
INSERT INTO `dictinfo` VALUES ('abbd52e46bf84954b1b03e9743074c10', '中国地质大学地调院青海大学分院', '11', '2b6423f1c6c947a58c52d0a8ea6d1bd3', '', '科学研究');
INSERT INTO `dictinfo` VALUES ('4cdc95d7c078432e9d3272ec18107c03', '青海湖地学实习基地', '12', '2b6423f1c6c947a58c52d0a8ea6d1bd3', '', '科学研究');
INSERT INTO `dictinfo` VALUES ('d7b8904c20784b85bd749b7ef84233e1', '同意', '02', '99da96ccc5a44a69b3aa2b6f9947f5bb', '专项与合同管理', '审核状态');
INSERT INTO `dictinfo` VALUES ('cd178926e17a46e78cd1e0ab25e7b05f', '退回修改', '03', '99da96ccc5a44a69b3aa2b6f9947f5bb', '专项与合同管理', '审核状态');
INSERT INTO `dictinfo` VALUES ('d7ec217742434ea38136557613764457', '科研项目', '03', '2596c950f88647f49a1943863547bf6b', '', '校内采购系统');
INSERT INTO `dictinfo` VALUES ('f25ee69ad5694249b6404a77cde18372', '其他专项', '04', '89877aee622411e7b62fbbd90eb76f07', '资金来源', '资金来源');
INSERT INTO `dictinfo` VALUES ('dc9535de7dd142d18564093b430207ef', '校级财政专项', '03', '89877aee622411e7b62fbbd90eb76f07', '资金来源', '资金来源');
INSERT INTO `dictinfo` VALUES ('e0685357c1934ae8b507638c5a3a9f6a', '水利工程', '01', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('5276877b36004bb5ab7e5402fcf67ddf', '建筑工程', '02', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('b04092a369f94a76895fb6ebe18183a8', '资源勘查', '03', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('2853c2af7c614fb091ec01b4ee0f2f7f', '测绘', '04', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('fc458508413a45f0a6815be34769f972', '岩土工程', '05', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('cdaf6e134f064bcbabcb0bb16db2b09f', '土木工程', '06', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('3299d628cbff4bef8ab34ae242fa02e2', '建筑', '07', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('4242b2e7ff8c490899abefe752407eec', '工程力学', '08', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('bcdb6d97b3464b799db37f44673abd85', '给排水', '11', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('488e1e174db845f7bc9886901e1ea8cf', '工程管理', '09', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('8306dbf439d2479a9c864d3634f9a107', '工民建', '10', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('201caebb81ed4ef98c9d1d9854c355b8', '水电', '12', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('905e73ec780f48bca25b10a82eb17dc7', '电气工程', '13', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('2de09e81ad2848f4bb4278351d50fe66', '农学', '14', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('c42d8d8e4fd040cdbac7c250eb247378', '新能源材料', '15', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('61e7254f898a4c3ba8a899be5d5fb6d2', '园艺', '16', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('3d673b59a2bf45a8b0eea0ad846a81cd', '植物营养', '17', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('8ffd6829109540ecaf42d34a1bf6afc9', '分子生态', '18', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('5eb61f481e5b4707bf6c076f7ac1b0f2', '基础医学', '19', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('9b1eb234b8a04e12afdcb5be90576322', '药学', '20', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('d31c2fd78551453f9b2d36c68e874752', '医学', '21', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('07996c74b6b244f8a4ba477729b56a3c', '公共卫生', '22', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('a3e18fe4fc1f4909bd1d98ed67965b8a', '医药学', '23', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('a62eeb6ab4114b1082d8a8cef9d75ae5', '分析仪器', '24', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('2dc869de2ea24609909f1dc09f97ac4d', '化学', '25', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('8c06088144034875931cee4c9e77aba0', '自动化', '26', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('07927e564540469b8efb7f70438440d2', '生物学', '27', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('895a24c4d82649c897438003cdd94b62', '畜牧业', '28', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('e354c35ddde647409624cebb072c4243', '兽医学', '29', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('dc7bd0aab2be42d99478e951715b004a', '草业', '30', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('81c580df9a9d4958bdc1f41ec87aa1e4', '草地生态', '31', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('3986642036b649bcaa69ce3e8aade7a5', '饲草生产', '32', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('17c643801232497e90aed7b3dc1906fd', '草业工程', '33', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('eb7229136c254012878ad1e84b51e6e9', '电力自动化', '34', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('88816cde813c4bc693a708319507e298', '机械工程', '35', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('6e44cb111d1448f79ecc2c66567fce53', '材料学', '36', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('4939f24734154ca7b0bd5b538325df80', '机械电子', '37', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('dda34a8a8b7e400589e0487fd20fcd52', '冶金工程', '38', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('2775bd1203374d0ca2df8c1b7feb0cc4', '草原', '39', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('578db75757174ee7a52e93eed7ce571e', '材料加工', '40', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('23b647ddb07344339951dc7a68fa38f2', '微生物代谢调控', '41', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('e1308d4eaa55469d90b0b6f2b48bd239', '动物资源保护', '42', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('30e988dd510743648935d28a481771ee', '高原冷水鱼', '43', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('f282e0976ded4aadb2f340b8b990cdd8', '遥感', '44', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('ab2e48f50b5648d1847d85b08926eca3', '水文水资源', '45', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('0103f3eeb65d44359f2d13217d3e0535', '植物抗逆机制', '46', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('6105f52a1a97494e95baf25f15bc891b', '生物信息学', '47', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('acf2eb12dc5a4b9ab61d53b7f669b8a6', '根际微生物', '48', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('ddc756059d1f4bf2a6851b5d5d50d58d', '植物生态学', '50', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('3b1a9a1aeaf3467593c19d25e1762cc8', '植物分子生物学', '51', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('0bacd67d9e11468089da65a47f958aff', '公开招标', '01', '955c2619537a4af09e4195b5f685ea13', '校内采购', '申请采购方式');
INSERT INTO `dictinfo` VALUES ('b4229c85ee5b43e7a8f33ff0bd1f9593', '本部门经费', '02', '2596c950f88647f49a1943863547bf6b', '', '校内采购系统');
INSERT INTO `dictinfo` VALUES ('29a2e9fcb98747b0a15f39ac63032660', '财政专项', '01', '2596c950f88647f49a1943863547bf6b', '', '校内采购系统');
INSERT INTO `dictinfo` VALUES ('270f86fd6c87440fa1bec24f6e140609', '执行中', '07', '559bfcbe622b11e7b62fbbd90eb76f07', '项目状态', '项目状态');
INSERT INTO `dictinfo` VALUES ('c82b99586df24a8588d947f37ce26d85', '培训中', '11', '559bfcbe622b11e7b62fbbd90eb76f07', '项目状态', '项目状态');
INSERT INTO `dictinfo` VALUES ('1b323af2e12e40b993743433d232e044', '验收中', '12', '559bfcbe622b11e7b62fbbd90eb76f07', '项目状态', '项目状态');
INSERT INTO `dictinfo` VALUES ('6ad269a1605345abb77b9aa75649f364', '支付中', '13', '559bfcbe622b11e7b62fbbd90eb76f07', '项目状态', '项目状态');
INSERT INTO `dictinfo` VALUES ('b9d3645fba4d4bffae8da5b66f493fed', '已完成', '14', '559bfcbe622b11e7b62fbbd90eb76f07', '项目状态', '项目状态');
INSERT INTO `dictinfo` VALUES ('624949db63f243cb9812189b4fccf267', '办公用品', '01', '6d8a7ace0e614af98b581874b94bfa3a', '物品清单管理', '商品类型');
INSERT INTO `dictinfo` VALUES ('41bd78da6147411ea42181b38322610a', '收货中', '10', '559bfcbe622b11e7b62fbbd90eb76f07', '项目状态', '项目状态');
INSERT INTO `dictinfo` VALUES ('6fd6a183ff0445c9bd35792f6c608aa7', '直接通过', '03', 'f5ce696dd4d54dfbb1a835307ea597eb', '专家审核类型', '专家审核类型');
INSERT INTO `dictinfo` VALUES ('05e2fc0565a94c208798618ba676ddd3', '未收货', '01', 'fa0b0ac4c3bd46628ecd91f61df1d3c0', '收货状态', '收货状态');
INSERT INTO `dictinfo` VALUES ('a064f069eea44ce89fbacc01dc9ec989', '已收货', '02', 'fa0b0ac4c3bd46628ecd91f61df1d3c0', '收货状态', '收货状态');
INSERT INTO `dictinfo` VALUES ('a13afa7d552c4539a18c3f00b42da591', '未培训', '01', 'ebc24a99d5104ee486f631dc213f7965', '培训状态', '培训状态');
INSERT INTO `dictinfo` VALUES ('1274d3432f6d472eb6293ea492961eab', '已培训', '02', 'ebc24a99d5104ee486f631dc213f7965', '培训状态', '培训状态');
INSERT INTO `dictinfo` VALUES ('3ec33639a5af4fa18280cf074299bb6e', '未验收', '01', '662ed66026914f689d47f42dc54130ec', '验收状态', '验收状态');
INSERT INTO `dictinfo` VALUES ('4565cd8d22624f9eadf9ed62af9bb519', '已验收', '02', '662ed66026914f689d47f42dc54130ec', '验收状态', '验收状态');
INSERT INTO `dictinfo` VALUES ('7f587ccae66e4af2855bf902f795b95f', '未支付', '01', 'ee98408fa695484180dccc205a1dbd9d', '支付状态', '支付状态');
INSERT INTO `dictinfo` VALUES ('eb86750aa2544c9ea87c6d4636041749', '已支付', '02', 'ee98408fa695484180dccc205a1dbd9d', '支付状态', '支付状态');
INSERT INTO `dictinfo` VALUES ('e1aad38f8a704303b6559ec73a0cb8ae', '仪器设备', '02', '6d8a7ace0e614af98b581874b94bfa3a', '物品清单管理', '商品类型');
INSERT INTO `dictinfo` VALUES ('6faf91fcd6114ec38d9418c3bb17491b', '低值消耗品', '03', '6d8a7ace0e614af98b581874b94bfa3a', '物品清单管理', '商品类型');
INSERT INTO `dictinfo` VALUES ('038917c049da401a90e98879fe9218b8', '已复核', '01', 'f67eafa37be94bf9b301a064ba061322', '物品清单管理', '是否提交');
INSERT INTO `dictinfo` VALUES ('2017443a144045bda2eb9bf72ccf6907', '未复核', '02', 'f67eafa37be94bf9b301a064ba061322', '物品清单管理', '是否提交');
INSERT INTO `dictinfo` VALUES ('8d3de93b5a45472ca42507a14e26b230', '华为', '01', 'd30982fbbc7d42e0acc819a7541729ba', '物品清单管理', '商品品牌');
INSERT INTO `dictinfo` VALUES ('c67e69748aa64513a33d716d88436386', '苹果', '02', 'd30982fbbc7d42e0acc819a7541729ba', '物品清单管理', '商品品牌');
INSERT INTO `dictinfo` VALUES ('224c07f905cc47a88a05cc21c7e6066b', '中信', '03', 'd30982fbbc7d42e0acc819a7541729ba', '物品清单管理', '商品品牌');
INSERT INTO `dictinfo` VALUES ('290266243270483b8d73172327bef1f8', '牧马人', '04', 'd30982fbbc7d42e0acc819a7541729ba', '物品清单管理', '商品品牌');
INSERT INTO `dictinfo` VALUES ('ecdfa482bc8a4c68b565a5cf4897d1f7', '电泳', '01', '2c2e34541fc7470b970631032fdc5be9', '物品清单管理', '商品类目');
INSERT INTO `dictinfo` VALUES ('e806a351e84a4be884c5835b463c5003', '仪器试验台', '02', '2c2e34541fc7470b970631032fdc5be9', '物品清单管理', '商品类目');
INSERT INTO `dictinfo` VALUES ('af66a1e02a764e3485ad77079f734aaa', '通风柜', '03', '2c2e34541fc7470b970631032fdc5be9', '物品清单管理', '商品类目');
INSERT INTO `dictinfo` VALUES ('69bd930580aa41a8ba0a4fafd224ec59', '是', '01', 'cdbce3e748af41298a9f15655b3a6213', '物品清单管理', '是否审核');
INSERT INTO `dictinfo` VALUES ('adc77f0b5f594d29a000186c4f678235', '否', '02', 'cdbce3e748af41298a9f15655b3a6213', '物品清单管理', '是否审核');
INSERT INTO `dictinfo` VALUES ('e70bddba6d1547f5a980f38f480a613d', '台', '01', '6fbe463e28bb4e0dbbd1f9ba2dfc5e37', '物品清单管理', '商品单位');
INSERT INTO `dictinfo` VALUES ('fc4d2f7dfceb46ba8648c3237bb354c7', '件', '02', '6fbe463e28bb4e0dbbd1f9ba2dfc5e37', '物品清单管理', '商品单位');
INSERT INTO `dictinfo` VALUES ('c80c0a50ef9a4259bcee0139e3d8ffcb', '座', '03', '6fbe463e28bb4e0dbbd1f9ba2dfc5e37', '物品清单管理', '商品单位');
INSERT INTO `dictinfo` VALUES ('a71e0fbc43ca4f3398364cea7d1c325d', '个', '04', '6fbe463e28bb4e0dbbd1f9ba2dfc5e37', '物品清单管理', '商品单位');
INSERT INTO `dictinfo` VALUES ('bc64fe48d4744f5fb4d979b5335e41fa', '仪器转角台', '04', '2c2e34541fc7470b970631032fdc5be9', '物品清单管理', '商品类目');
INSERT INTO `dictinfo` VALUES ('79cfcf81979147a88f9c56ed8b6b434d', '工位', '01', '1466eb47fde443d1aba3c68c04efe52b', '实验室管理', '实验室类型');
INSERT INTO `dictinfo` VALUES ('407bb5237d0d4bfc8211ca5505126e3f', '大型仪器存放处', '02', '1466eb47fde443d1aba3c68c04efe52b', '实验室管理', '实验室类型');
INSERT INTO `dictinfo` VALUES ('82b19a23c17c47d8937d841f4f3709bb', '正在使用中', '01', '3482ef2b1ae540fc992b681e938332db', '实验室管理', '使用状态');
INSERT INTO `dictinfo` VALUES ('df46747c59954ed7a4adcb8eca0da972', '可用', '02', '3482ef2b1ae540fc992b681e938332db', '实验室管理', '使用状态');
INSERT INTO `dictinfo` VALUES ('f783fa60db23486284cf975730b990f5', '禁用', '03', '3482ef2b1ae540fc992b681e938332db', '实验室管理', '使用状态');
INSERT INTO `dictinfo` VALUES ('5fb3a753ed6749ffb2f7e946a18c2eee', '可用', '01', 'db3f0599234e48b7b731f3bef8053b68', '实验室管理', '是否可用');
INSERT INTO `dictinfo` VALUES ('eb5ed984617d4fa981026964cf219c6c', '不可用', '02', 'db3f0599234e48b7b731f3bef8053b68', '实验室管理', '是否可用');
INSERT INTO `dictinfo` VALUES ('8b0f25f597cf47f4bc4aca1c1a3d0dfa', '化学危险品', '04', '6d8a7ace0e614af98b581874b94bfa3a', '物品清单管理', '商品类型');
INSERT INTO `dictinfo` VALUES ('f2a0ad670f504afea25c91310546e12a', '试剂柜', '05', '2c2e34541fc7470b970631032fdc5be9', '物品清单管理', '商品类目');
INSERT INTO `dictinfo` VALUES ('0f39fdc8aeeb4c72968ba653bbf00ea3', '水槽', '06', '2c2e34541fc7470b970631032fdc5be9', '物品清单管理', '商品类目');
INSERT INTO `dictinfo` VALUES ('c5d2ae6d9d904494913829cd4dd63502', '龙头', '07', '2c2e34541fc7470b970631032fdc5be9', '物品清单管理', '商品类目');
INSERT INTO `dictinfo` VALUES ('4a9c764f2c6f4ed98ca10615b2d2340b', '洗眼器', '08', '2c2e34541fc7470b970631032fdc5be9', '物品清单管理', '商品类目');
INSERT INTO `dictinfo` VALUES ('3f96dfbb084f4cc38c4276b0735db567', '只', '05', '6fbe463e28bb4e0dbbd1f9ba2dfc5e37', '物品清单管理', '商品单位');
INSERT INTO `dictinfo` VALUES ('1ed54a94c9334cf2b1f9962ad2352add', '本', '06', '6fbe463e28bb4e0dbbd1f9ba2dfc5e37', '物品清单管理', '商品单位');
INSERT INTO `dictinfo` VALUES ('07e29a5b8ad042de8fade9b308d73555', '清华同方', '05', 'd30982fbbc7d42e0acc819a7541729ba', '物品清单管理', '商品品牌');
INSERT INTO `dictinfo` VALUES ('e94513a395fb48329f222d8abea9126b', '代尔', '06', 'd30982fbbc7d42e0acc819a7541729ba', '物品清单管理', '商品品牌');
INSERT INTO `dictinfo` VALUES ('4feb65b5bd2d44fda8274b36137d3a6f', '未立项', '01', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('0de615f92bf44e9a842afd143eb5e580', '主管领导审核', '02', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('341105a502994a22ad1b9406f41a1e37', '项目预审', '03', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('27c96bbe3af14b388aaed8878df5ab51', '项目初审', '04', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('38ddd9b08f0f48c58651aa1b33f3ccb3', '专家审核', '05', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('00bffc83becd4863a2730f5664dbf607', '项目归口部', '06', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('4f7b88e5d08947668e50a8b1641b5b83', '计财处审核', '07', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('c56b4b489bf348a49483777e1fa124de', '小组办公室', '08', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('91f9d082f46c408ca47f4fa338bddfdc', '校招标领导小组', '09', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('0d994867676f48a1804e9157d392f803', '执行中', '10', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('84dab1000d0e481c89cf85d4d3419be0', '收货中', '13', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('a114c99a2fdb4def9782e7a34266698e', '招标中', '11', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('70c99905c8d5454da34e36e2d21e7925', '验收中', '14', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('cdb199b8b6a345ea800fab9b3e755619', '支付中', '15', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('d2364c762f4241ba86aaa99b84956ff1', '已完成', '16', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('ab18b05d641248ef8868cf47bc501b0a', '邀请招标', '02', '955c2619537a4af09e4195b5f685ea13', '校内采购', '申请采购方式');
INSERT INTO `dictinfo` VALUES ('07b52d66715b42b2a254a64c608093da', '竞争性谈判', '03', '955c2619537a4af09e4195b5f685ea13', '校内采购', '申请采购方式');
INSERT INTO `dictinfo` VALUES ('04182a8ff8224f7c9101c29f33b105df', '单一来源', '04', '955c2619537a4af09e4195b5f685ea13', '校内采购', '申请采购方式');
INSERT INTO `dictinfo` VALUES ('b401baeb06ff4303ad5c8ab791c6f464', '自行询价', '05', '955c2619537a4af09e4195b5f685ea13', '校内采购', '申请采购方式');
INSERT INTO `dictinfo` VALUES ('755a7082fa91451e86b044afc515e843', '挂网询价', '06', '955c2619537a4af09e4195b5f685ea13', '校内采购', '申请采购方式');
INSERT INTO `dictinfo` VALUES ('b57f2ec05f5c42f3a792d5538a7b9c31', '自行采购', '07', '955c2619537a4af09e4195b5f685ea13', '校内采购', '申请采购方式');
INSERT INTO `dictinfo` VALUES ('9e054dd8c704484d9af9e8293d80407c', '竞争性磋商', '08', '955c2619537a4af09e4195b5f685ea13', '校内采购', '申请采购方式');
INSERT INTO `dictinfo` VALUES ('e1c64992cc054e1e810a2194745b3bbc', '未招标', '01', '073fa7cef19548009cc795201799d5fe', '招标状态', '招标状态');
INSERT INTO `dictinfo` VALUES ('cb1d2a56e64a44608d73b48c4d8aedcc', '已招标', '02', '073fa7cef19548009cc795201799d5fe', '招标状态', '招标状态');
INSERT INTO `dictinfo` VALUES ('858713a893764c8a877232db5dff984d', '未签合同', '01', '1e0943e41e7e435eb55026b3b3c5bb07', '合同状态', '合同状态');
INSERT INTO `dictinfo` VALUES ('ae14304b4f2c4e5193a7f59cb58a9b4a', '已签合同', '02', '1e0943e41e7e435eb55026b3b3c5bb07', '合同状态', '合同状态');
INSERT INTO `dictinfo` VALUES ('760d5b24ab814ffc995340c5d4c24ee1', '农林科学院', '50', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('c8d8867ff0cb44f0b945ea61ba77a659', '畜牧兽医科学院', '51', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('a07dada4411d49aa903ea90712bcd7ef', '国家重点实验室', '52', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('921f13acff0f4cc9981add2169e8c0e7', '三江源研究员', '53', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('25042c911d8442fe921dffc28d538dfa', '产业发展研究员', '54', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('63dee2b1f1a4458089c389c5310d7f9c', '新农村发展研究员', '55', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('6fb8011dbbf8444f96f2fb38cce752c1', '省情研究中心', '56', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('79fa84a4b41f463e8a419593c44d62f2', '新能源光伏中心', '57', 'e9d90f2457684f10bf0718c98f33f763', '', '院系设置');
INSERT INTO `dictinfo` VALUES ('1b7e0c2304d5453bbcca22fdc3c2612c', '招标中', '08', '559bfcbe622b11e7b62fbbd90eb76f07', '项目状态', '项目状态');
INSERT INTO `dictinfo` VALUES ('d6261e62d60f4ebe907bd5cf1e4781d7', '签合同中', '09', '559bfcbe622b11e7b62fbbd90eb76f07', '项目状态', '项目状态');
INSERT INTO `dictinfo` VALUES ('9b3de2d919ed4801b34ba3dec577ff2a', '中国', '01', 'cd6085afd1b34a90b8f26af3680a8fad', '国别', '国别');
INSERT INTO `dictinfo` VALUES ('d9351ed51280485d80e26746b4697dc5', '美国', '02', 'cd6085afd1b34a90b8f26af3680a8fad', '国别', '国别');
INSERT INTO `dictinfo` VALUES ('90a571f648ca40b08389b36da6e22c1a', '汉族', '01', '457348a3f0a24459b13591a8ccb1ac03', '民族', '民族');
INSERT INTO `dictinfo` VALUES ('09357b69f6f7411b8765c7a3e47ac11f', '藏族', '02', '457348a3f0a24459b13591a8ccb1ac03', '民族', '民族');
INSERT INTO `dictinfo` VALUES ('c653e39f6a274238803ed332466df395', '回族', '03', '457348a3f0a24459b13591a8ccb1ac03', '民族', '民族');
INSERT INTO `dictinfo` VALUES ('5716ebbb130c441cb2109c0ada0ce689', '计算机科学与技术', '01', '50f7fc08b1e246bf937a305ae619b64b', '专业类型', '专业类型');
INSERT INTO `dictinfo` VALUES ('b2415fab6f1d48f483aa6cacbc9a3875', '软件工程', '02', '50f7fc08b1e246bf937a305ae619b64b', '专业类型', '专业类型');
INSERT INTO `dictinfo` VALUES ('c0a64af53a7a46c7b3c8ff5f11dcd997', '男', '01', '77be3732f265412c9393a5f49f6a49fd', '性别', '性别');
INSERT INTO `dictinfo` VALUES ('6bb47755e5b249fabe49f93193b8b2ed', '女', '02', '77be3732f265412c9393a5f49f6a49fd', '性别', '性别');
INSERT INTO `dictinfo` VALUES ('8ad657b5875d433b854d384eb17585e7', '青海', '01', '41c5495af424462abea66ae10760b23e', '出生地', '出生地');
INSERT INTO `dictinfo` VALUES ('8117cb70fdf747b3a003cf245f052abb', '北京', '02', '41c5495af424462abea66ae10760b23e', '出生地', '出生地');
INSERT INTO `dictinfo` VALUES ('62179fe4b7df41d5ac2fd89847840e53', '3年', '01', '6ed0f1336218425e97b1cb5623a699dc', '学制', '学制');
INSERT INTO `dictinfo` VALUES ('f195c1d7eb21453a9b602d34a4c0c3d8', '4年', '02', '6ed0f1336218425e97b1cb5623a699dc', '学制', '学制');
INSERT INTO `dictinfo` VALUES ('4fbfbc02f6d64b2590725cf513e682e2', '5年', '03', '6ed0f1336218425e97b1cb5623a699dc', '学制', '学制');
INSERT INTO `dictinfo` VALUES ('767f368e610743b5833e34b83cbda4a0', '是', '02', 'b3dd6fbbb95a439497acdc9cf85d3fb7', '是否班主任', '是否班主任');
INSERT INTO `dictinfo` VALUES ('3aeb7512a7b44fd8aac50d49b7241494', '否', '01', 'b3dd6fbbb95a439497acdc9cf85d3fb7', '是否班主任', '是否班主任');
INSERT INTO `dictinfo` VALUES ('e36f01e76baa4aa38094049438537d9f', '有编制', '01', '10e1254109524898a04d5d59797856f8', '教师编制', '教师编制');
INSERT INTO `dictinfo` VALUES ('5f85bdf1adea40fb9ab3ec2298ae8a0c', '无编制', '02', '10e1254109524898a04d5d59797856f8', '教师编制', '教师编制');
INSERT INTO `dictinfo` VALUES ('d1139e7c537c457ba475de779bc72856', '实验室管理处', '201711061', '0dd5fbd96cde4d5a89e3002185b7db9f', '归口部门', '归口部门类型');
INSERT INTO `dictinfo` VALUES ('04e02140a5234c6eb45ea161bcc62459', '国有资产管理中心', '201711062', '0dd5fbd96cde4d5a89e3002185b7db9f', '归口部门', '归口部门类型');
INSERT INTO `dictinfo` VALUES ('88d2068428ee4f6d98b3f7c553d65663', '科技处', '201711063', '0dd5fbd96cde4d5a89e3002185b7db9f', '归口部门', '归口部门类型');
INSERT INTO `dictinfo` VALUES ('ee936c42427b43528d7b682ce574afd3', '签合同中', '12', '6680feeb2ef84d17be3d77b0e829800c', '校内采购', '项目状态');
INSERT INTO `dictinfo` VALUES ('eeb9d5d6fd65458283cc9c232f88a5bf', '荒漠化防治', '52', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('c0af0e536b784af69b0a1bbd3769395b', '植物生理生态', '53', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('a8aec2d00ef14479a936ba0ff3cebbc5', '有机化学', '54', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('d79e28fb6f34476e86fbb9294f3513d9', '中藏药', '55', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('7a90c66a1080402baeba3617c6a1469e', '纳米材料', '56', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('b442860a13a64536b47802b541598b6c', '全球变化生态学', '58', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('85c752424cb44d2cae2467e2c2d07982', '鸟类保护与利用', '59', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('76f9eff5f6ff4d6fb0c40edf94f8c65f', '湖泊生态学', '60', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('6beda4561eeb40dc92f997022a781509', '土壤学', '61', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('8d6d3c0d833843188ebbca2a4085eeb4', '计算机', '62', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('79ad195857344afe855357d0661a0deb', '办公自动化', '63', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('edb0f36450784b2691b08537c497ad1e', '智能信息系统', '64', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('0fa56eef761341968d071bf375b1793e', '计算机网络', '65', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('794e78b0fbb44325890e8c8576d0d307', '计算机应用', '66', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('82545dae9730439dbee7bc61d67ba7cd', '教务管理', '67', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('da7d9794087342cbafc257eb23ac5550', '中文', '68', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('b5add163f25349469fbb026afe504789', '图书馆学', '69', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('70faade9c2d943a39791547c88ce0b97', '图书情报', '70', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('95645514b1f74e4486c13fac57e2aea0', '地质工程系', '71', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('d773693d7f64483db9dafedd47c0fddd', '政教', '72', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('051b56bf297944ccb14bb3003a7dd9db', '林学', '73', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('adf6401bbd464c21a292ad404bf4b0bc', '预防兽医学', '74', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('8c06db6b1f4c4227b39b45789fac3714', '生物技术', '76', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('1b28a44f0efb48a78fd0246297b44b9f', '分子生药学', '77', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('624411713eef4e029d8bf04bd36aca7b', '政治学', '78', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('6232c7187df540099f5cc0f1620535cb', '化学工程', '79', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('3fdf18dd06dc4f83bf0e5021689aa45f', '经济学', '80', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('8702f435fab042f4a6da9fe48da3a580', '病理生理学', '81', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('a52d707e76424975bae084a5d3d84c43', '中医', '82', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('0da627d79e6d4c6db39c690c87e18bb7', '藏医学', '83', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('76993c6a6a0d4aa2aed269895559cd8a', '数学', '84', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('b3bb717dc5104d03a7df15d64e90225f', '经济管理', '85', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('b1c0d738c957407282f9fa39ccda5ae5', '畜牧业经济', '86', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('f5b4a83523ef4793b309bbdf5b88a608', '档案类', '87', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('a7de1b24b3814721a14859a9577a9a2d', '工商管理', '88', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('97b6904d54fd4c838bfa2a039daada7d', '财会', '89', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('5b1f5e89dc1347e79703e74259cf7de7', '经济', '90', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('ff3d1e26e21343cd8bdd2b80bf4aae61', '财政', '91', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('96171f76948a4373b60307e903362d0c', '后勤管理', '92', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('fbc89b34f3fa4443bd57b95d21ad0f66', '后勤餐饮', '93', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('d3fe95717a3f4dfaacedfe5cdcceb784', '音乐艺术', '94', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('83f93cfcf2244b87923683d79d1cb6ee', '思政', '95', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('894c0e07aaaa4c228439beaa718ab0c7', '临床医学', '96', '39da575519c044788c2afe374a4232e2', '专家库', '专家类型');
INSERT INTO `dictinfo` VALUES ('561e34c4a2e44ffcb09780936d1f1c0f', '合同确认', '03', '559bfcbe622b11e7b62fbbd90eb76f07', '项目状态', '项目状态');
INSERT INTO `dictinfo` VALUES ('b2779c967b59466aa8158f49d3759d54', '是', '01', '8112ecbab696436591e71e4bcf166803', '合同确认状态', '合同确认');
INSERT INTO `dictinfo` VALUES ('9185bc764ad842ecb7d449e0533dcfed', '否', '02', '8112ecbab696436591e71e4bcf166803', '合同确认状态', '合同确认');
INSERT INTO `dictinfo` VALUES ('4c68c736cc4444f480205dad00b8bbd4', '教务处', '201711064', '0dd5fbd96cde4d5a89e3002185b7db9f', '归口部门', '归口部门类型');
INSERT INTO `dictinfo` VALUES ('deb9d3552ed046ba99f3c87bf4e67eb5', '组织人事部', '201711065', '0dd5fbd96cde4d5a89e3002185b7db9f', '归口部门', '归口部门类型');
INSERT INTO `dictinfo` VALUES ('41d5f256b9ca43d2b8e1dcf0ebea5a2f', '爆炸品', '01', 'c2ed4b28cb8a46598e2643c125352be9', '危险品', '危险品归类');
INSERT INTO `dictinfo` VALUES ('c1cdd11722b44d2ba1d50a62dcfb6a26', '压缩气体和液化气体', '02', 'c2ed4b28cb8a46598e2643c125352be9', '危险品', '危险品归类');
INSERT INTO `dictinfo` VALUES ('8a4f4b7013f3485f85c78cf88d9bf77d', '易燃液体', '03', 'c2ed4b28cb8a46598e2643c125352be9', '危险品', '危险品归类');
INSERT INTO `dictinfo` VALUES ('d48e46b209764172a95118ff2adead18', '易燃固体、自然物品和遇湿易燃物品', '04', 'c2ed4b28cb8a46598e2643c125352be9', '危险品', '危险品归类');
INSERT INTO `dictinfo` VALUES ('167407708e9b45f1bfbb71e90ab21b6b', '氧化剂和有机过氧化物', '05', 'c2ed4b28cb8a46598e2643c125352be9', '危险品', '危险品归类');
INSERT INTO `dictinfo` VALUES ('7b5c96f2e54642aeaaaf5c28de3301a9', '腐蚀品', '08', 'c2ed4b28cb8a46598e2643c125352be9', '危险品', '危险品归类');
INSERT INTO `dictinfo` VALUES ('fb20e68b4bd0478a9eb20d2478ae5628', '毒害品和感染性物品', '06', 'c2ed4b28cb8a46598e2643c125352be9', '危险品', '危险品归类');
INSERT INTO `dictinfo` VALUES ('4dd3fa1186464f34a3cb2e843b3e4bb5', '放射性物品', '07', 'c2ed4b28cb8a46598e2643c125352be9', '危险品', '危险品归类');
INSERT INTO `dictinfo` VALUES ('bbdbd1bab8884f3c9d5c303ef8d75c8f', '杂类', '09', 'c2ed4b28cb8a46598e2643c125352be9', '危险品', '危险品归类');
INSERT INTO `dictinfo` VALUES ('2f09ac97bb1243df963138889373fd7b', '特性1', '01', '60592e6b13ed45e39e895c8269885cfd', '危险品特性', '危险品特性');

-- ----------------------------
-- Table structure for entering_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `entering_warehouse`;
CREATE TABLE `entering_warehouse` (
  `entering_warehouse_code` varchar(32) NOT NULL DEFAULT '' COMMENT '入库编号',
  `warehouse_code` varchar(32) DEFAULT NULL COMMENT '仓库编号',
  `goods_code` varchar(50) DEFAULT NULL COMMENT '货物编号',
  `entering_warehouse_date` varchar(32) DEFAULT NULL COMMENT '入库日期',
  `entering_warehouse_num` varchar(10) DEFAULT NULL COMMENT '入库数量',
  `consignee` varchar(20) DEFAULT NULL COMMENT '收货人',
  PRIMARY KEY (`entering_warehouse_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='入库表';

-- ----------------------------
-- Records of entering_warehouse
-- ----------------------------
INSERT INTO `entering_warehouse` VALUES ('2815bd91f97e40d488c1c2505f83d515', '00c01db1b58d411a9e10489b05bb86ef', '9d234249ec7c407598c6c0811cd425b7', '2017-10-24 19:44:51', '123', 'lvxing2');
INSERT INTO `entering_warehouse` VALUES ('107f44b6554d4743bbd1e58958f7ec13', '00c01db1b58d411a9e10489b05bb86ef', '46e4db4938804c6cba6498cea78b8f0f', '2017-10-28 19:56:39', '12', 'zhangs');

-- ----------------------------
-- Table structure for ex_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `ex_warehouse`;
CREATE TABLE `ex_warehouse` (
  `ex_warehouse_code` varchar(32) NOT NULL DEFAULT '' COMMENT '出库编号',
  `warehouse_code` varchar(50) DEFAULT NULL COMMENT '仓库编号',
  `goods_code` varchar(50) DEFAULT NULL COMMENT '货物编号',
  `ex_warehouse_date` varchar(32) DEFAULT NULL COMMENT '出库日期',
  `ex_warehouse_num` varchar(10) DEFAULT NULL COMMENT '出库数量',
  `recipient` varchar(20) DEFAULT NULL COMMENT '领用人',
  PRIMARY KEY (`ex_warehouse_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='出库表';

-- ----------------------------
-- Records of ex_warehouse
-- ----------------------------
INSERT INTO `ex_warehouse` VALUES ('7910d64120c64517b1a1352645dd0567', '你好', '111111111111', '13256268658', '111', '1');

-- ----------------------------
-- Table structure for instrument
-- ----------------------------
DROP TABLE IF EXISTS `instrument`;
CREATE TABLE `instrument` (
  `instrument_id` varchar(32) NOT NULL,
  `lab_id` varchar(32) DEFAULT NULL,
  `instrument_name` varchar(50) DEFAULT NULL,
  `instrument_num` varchar(50) DEFAULT NULL,
  `instrument_use` varchar(50) DEFAULT NULL,
  `instrument_state` varchar(50) DEFAULT NULL,
  `lab_style` char(50) DEFAULT NULL,
  PRIMARY KEY (`instrument_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of instrument
-- ----------------------------

-- ----------------------------
-- Table structure for laboratory
-- ----------------------------
DROP TABLE IF EXISTS `laboratory`;
CREATE TABLE `laboratory` (
  `lab_id` varchar(32) NOT NULL COMMENT '实验室编号',
  `lab_name` varchar(50) DEFAULT NULL COMMENT '实验室名称',
  `lab_address` varchar(100) DEFAULT NULL COMMENT '实验室具体方位',
  `lab_use` varchar(50) DEFAULT NULL COMMENT '实验室用途',
  `lab_style` char(50) DEFAULT '01' COMMENT '实验室类型',
  `lab_urange` varchar(50) DEFAULT NULL COMMENT '实验室使用范围',
  `lab_admin` varchar(20) DEFAULT NULL COMMENT '管理员',
  `admin_tel` varchar(20) DEFAULT NULL COMMENT '管理员电话',
  `admin_email` varchar(20) DEFAULT NULL COMMENT '管理员邮箱',
  `lab_state` char(50) DEFAULT '01' COMMENT '实验室使用状态',
  `lab_isuse` char(50) DEFAULT '01' COMMENT '是否可用',
  PRIMARY KEY (`lab_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of laboratory
-- ----------------------------
INSERT INTO `laboratory` VALUES ('8e03047cebec4bf49b127c2aa1857ae1', '111', '333', '222', '02', '444', '2017003', '18691822573', '823533851@qq.com', '02', '02');

-- ----------------------------
-- Table structure for logbook
-- ----------------------------
DROP TABLE IF EXISTS `logbook`;
CREATE TABLE `logbook` (
  `LogBookId` char(32) NOT NULL DEFAULT '' COMMENT '日志Id',
  `ModifyField` varchar(255) DEFAULT NULL COMMENT '修改字段',
  `ModifyTableName` varchar(50) DEFAULT NULL COMMENT '修改表名',
  `ExecuteSql` varchar(255) DEFAULT NULL COMMENT '执行Sql',
  `CreateDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  `Operator` varchar(50) DEFAULT NULL COMMENT '操作人',
  `ModuleNum` varchar(20) DEFAULT NULL COMMENT '模块编号',
  `LogBookInfomation` varchar(255) DEFAULT '登录成功' COMMENT '日志信息',
  PRIMARY KEY (`LogBookId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of logbook
-- ----------------------------

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus` (
  `pid` varchar(32) DEFAULT NULL,
  `id` char(32) NOT NULL COMMENT '菜单编号',
  `text` varchar(200) DEFAULT NULL,
  `iconcls` varchar(200) DEFAULT NULL,
  `src` varchar(200) DEFAULT NULL,
  `seq` int(1) DEFAULT NULL,
  `state` char(1) DEFAULT NULL COMMENT '是否显示',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menus
-- ----------------------------
INSERT INTO `menus` VALUES ('0', '01', '信息管理', 'index_icon1.png', '', '1', null);
INSERT INTO `menus` VALUES ('0', '02', '预约管理', 'index_icon2.png', null, '1', null);
INSERT INTO `menus` VALUES ('0', '03', '仪器共享服务', 'index_icon3.png', null, '1', null);
INSERT INTO `menus` VALUES ('0', '05', '招标采购系统', 'index_icon5.png', null, '1', null);
INSERT INTO `menus` VALUES ('0', '04', '危险品及耗材', 'index_icon4.png', null, '1', null);
INSERT INTO `menus` VALUES ('0', '06', '专项与合同管理', 'index_icon6.png', null, '1', null);
INSERT INTO `menus` VALUES ('02', '0201', '实验室预约', 'icon-ht', null, '1', null);
INSERT INTO `menus` VALUES ('0201', '020101', '进出入记录', 'icon-htqc', '/demo.jsp', '1', null);
INSERT INTO `menus` VALUES ('0201', '020102', '实验室预约', 'icon-htgl', '/demo.jsp', '2', null);
INSERT INTO `menus` VALUES ('0202', '020201', '进出入记录', 'icon-zjin', '/demo.jsp', '1', null);
INSERT INTO `menus` VALUES ('0202', '020202', '工位预约', 'icon-htgl', '/demo.jsp', '2', null);
INSERT INTO `menus` VALUES ('03', '0301', '大型仪器信息管理', 'icon-ht', null, '1', null);
INSERT INTO `menus` VALUES ('0301', '030101', '大型仪器信息', 'icon-htqc', '/demo.jsp', '1', null);
INSERT INTO `menus` VALUES ('03', '0302', '大型仪器预约', 'icon-zj', null, '2', null);
INSERT INTO `menus` VALUES ('0302', '030201', '大型仪器预约', 'icon-zjin', '/demo.jsp', '1', null);
INSERT INTO `menus` VALUES ('0302', '030202', '预约记录', 'icon-zjout', '/demo.jsp', '2', null);
INSERT INTO `menus` VALUES ('0302', '030203', '使用记录', 'icon-set', '/demo.jsp', '3', null);
INSERT INTO `menus` VALUES ('04', '0401', '仓库管理', 'icon-ht', null, '1', null);
INSERT INTO `menus` VALUES ('0401', '040101', '仓库信息', 'icon-htqc', '/warehouse/show.action', '1', null);
INSERT INTO `menus` VALUES ('04', '0402', '入库管理', 'icon-ht', null, '2', null);
INSERT INTO `menus` VALUES ('0402', '040201', '出库', 'icon-zjin', '/ex_warehouse/show.action', '1', null);
INSERT INTO `menus` VALUES ('04', '0403', '危险品以及耗材盘点管理', 'icon-hz', null, '3', null);
INSERT INTO `menus` VALUES ('0403', '040301', '危险品以及耗材盘点', 'icon-nav', '/demo.jsp', '1', null);
INSERT INTO `menus` VALUES ('04', '0404', '危险品管理办法', 'icon-hz', null, '4', null);
INSERT INTO `menus` VALUES ('0404', '040401', '危险品管理', 'icon-nav', '/rolesOfDangerous.jsp', '1', null);
INSERT INTO `menus` VALUES ('04', '0405', '危险品及耗材清单', 'icon-hz', null, '5', null);
INSERT INTO `menus` VALUES ('0405', '040501', '危险品及耗材清单', 'icon-nav', '/dGoods/show.action', '1', null);
INSERT INTO `menus` VALUES ('05', '0501', '低耗材采购申请', 'icon-ht', null, '1', null);
INSERT INTO `menus` VALUES ('0', '07', '数据统计分析', 'index_icon7.png', null, '1', null);
INSERT INTO `menus` VALUES ('0', '08', '系统管理', 'index_icon8.png', null, '1', null);
INSERT INTO `menus` VALUES ('0', '09', '校内采购流程', 'index_icon5.png', null, '1', null);
INSERT INTO `menus` VALUES ('01', '0101', '实验室管理', 'icon-ht', '', '1', null);
INSERT INTO `menus` VALUES ('0103', '010301', '班级信息', 'icon-nav', '/classes/show.action', '1', null);
INSERT INTO `menus` VALUES ('0101', '010101', '实验室管理', 'icon-htqc', '/laboratory/show.action?dictName=01', '1', null);
INSERT INTO `menus` VALUES ('01', '0102', '人员管理', 'icon-zj', null, '2', null);
INSERT INTO `menus` VALUES ('0102', '010201', '管理员', 'icon-zjin', '/projecteExamine.jsp', '1', null);
INSERT INTO `menus` VALUES ('0102', '010202', '教师', 'icon-zjout', '/teacher/show.action', '2', null);
INSERT INTO `menus` VALUES ('0102', '010203', '学生', 'icon-set', '/student/show.action', '3', null);
INSERT INTO `menus` VALUES ('01', '0103', '班级信息管理', 'icon-hz', null, '3', null);
INSERT INTO `menus` VALUES ('02', '0202', '工位预约', 'icon-zj', null, '2', null);
INSERT INTO `menus` VALUES ('0501', '050101', '审批', 'icon-htqc', '/demo.jsp', '1', null);
INSERT INTO `menus` VALUES ('0501', '050102', '结果发布', 'icon-set', '/demo.jsp', '2', null);
INSERT INTO `menus` VALUES ('05', '0502', '大型仪器招标采购管理', 'icon-zj', null, '2', null);
INSERT INTO `menus` VALUES ('0502', '050201', '招标计划', 'icon-zjin', '/demo.jsp', '1', null);
INSERT INTO `menus` VALUES ('0502', '050202', '审批', 'icon-zjout', '/demo.jsp', '2', null);
INSERT INTO `menus` VALUES ('0502', '050203', '结果发布', 'icon-set', '/demo.jsp', '3', null);
INSERT INTO `menus` VALUES ('05', '0503', '企业意标', 'icon-hz', null, '3', null);
INSERT INTO `menus` VALUES ('0503', '050301', '上传标书', 'icon-nav', '/demo.jsp', '1', null);
INSERT INTO `menus` VALUES ('0503', '050302', '专家评审', 'icon-nav', '/demo.jsp', '2', null);
INSERT INTO `menus` VALUES ('0503', '050303', '批示结果', 'icon-nav', '/demo.jsp', '3', null);
INSERT INTO `menus` VALUES ('06', '0601', '中央财政专项', 'icon-sys', null, '1', null);
INSERT INTO `menus` VALUES ('0601', '060101', '项目填写', 'icon-pgin', '/project/projectMasterInfo.action?purchase=01&dictName=01', '1', null);
INSERT INTO `menus` VALUES ('0601', '060102', '项目立项', 'icon-pgin', '/project/projectDetailInfo.action?purchase=01&dictName=01', '2', null);
INSERT INTO `menus` VALUES ('0601', '060103', '项目执行', 'icon-pgset', '/project/projectEquipCheck.action?purchase=01&dictName=01', '3', null);
INSERT INTO `menus` VALUES ('0601', '060104', '项目完成', 'icon-pgin', '/project/projectCheckInfo.action?purchase=01&dictName=01', '4', null);
INSERT INTO `menus` VALUES ('06', '0602', '省级财政专项', 'icon-ht', null, '2', null);
INSERT INTO `menus` VALUES ('0602', '060201', '项目填写', 'icon-htqc', '/project/projectMasterInfo.action?purchase=01&dictName=02', '1', null);
INSERT INTO `menus` VALUES ('0602', '060202', '项目立项', 'icon-pgin', '/project/projectDetailInfo.action?purchase=01&dictName=02', '2', null);
INSERT INTO `menus` VALUES ('0602', '060203', '项目执行', 'icon-pgset', '/project/projectEquipCheck.action?purchase=01&dictName=02', '3', null);
INSERT INTO `menus` VALUES ('0602', '060204', '项目完成', 'icon-pgin', '/project/projectCheckInfo.action?purchase=01&dictName=02', '4', null);
INSERT INTO `menus` VALUES ('06', '0603', '校级财政专项', 'icon-zj', null, '3', null);
INSERT INTO `menus` VALUES ('0603', '060301', '项目填写', 'icon-zjin', '/project/projectMasterInfo.action?purchase=01&dictName=03', '1', null);
INSERT INTO `menus` VALUES ('0603', '060302', '项目立项', 'icon-pgin', '/project/projectDetailInfo.action?purchase=01&dictName=03', '2', null);
INSERT INTO `menus` VALUES ('0603', '060303', '项目执行', 'icon-pgset', '/project/projectEquipCheck.action?purchase=01&dictName=03', '3', null);
INSERT INTO `menus` VALUES ('0603', '060304', '项目完成', 'icon-pgin', '/project/projectCheckInfo.action?purchase=01&dictName=03', '4', null);
INSERT INTO `menus` VALUES ('06', '0604', '其他专项', 'icon-hz', null, '4', null);
INSERT INTO `menus` VALUES ('0604', '060401', '项目填写', 'icon-nav', '/project/projectMasterInfo.action?purchase=01&dictName=04', '1', null);
INSERT INTO `menus` VALUES ('0604', '060402', '项目立项', 'icon-pgin', '/project/projectDetailInfo.action?purchase=01&dictName=04', '2', null);
INSERT INTO `menus` VALUES ('0604', '060403', '项目执行', 'icon-pgset', '/project/projectEquipCheck.action?purchase=01&dictName=04', '3', null);
INSERT INTO `menus` VALUES ('0604', '060404', '项目完成', 'icon-pgin', '/project/projectCheckInfo.action?purchase=01&dictName=04', '4', null);
INSERT INTO `menus` VALUES ('07', '0701', '数据统计', 'icon-ht', null, '1', null);
INSERT INTO `menus` VALUES ('0701', '070101', '数据统计', 'icon-htqc', '/dataAnalysis/dataStatistics.action', '1', null);
INSERT INTO `menus` VALUES ('0701', '070102', '项目年度报表', 'icon-htgl', '/dataAnalysis/educationSpecial.action', '2', null);
INSERT INTO `menus` VALUES ('0701', '070103', '数据查询', 'icon-htcx', '/demo.jsp', '3', null);
INSERT INTO `menus` VALUES ('07', '0702', '数据信息汇总', 'icon-hz', null, '2', null);
INSERT INTO `menus` VALUES ('0702', '070201', '汇总信息', 'icon-nav', '/demo.jsp', '1', null);
INSERT INTO `menus` VALUES ('08', '0801', '系统设置', 'icon-ht', null, '1', null);
INSERT INTO `menus` VALUES ('0801', '080101', '用户管理', 'icon-htqc', '/user/userman.action', '1', null);
INSERT INTO `menus` VALUES ('0801', '080102', '专家管理', 'icon-htqc', '/user/expert.action', '2', null);
INSERT INTO `menus` VALUES ('0801', '080103', '供应商管理', 'icon-htqc', '/provider/enterprovider.action', '3', null);
INSERT INTO `menus` VALUES ('0801', '080104', '物品清单管理', 'icon-htqc', '/purchase_list/show.action', '4', null);
INSERT INTO `menus` VALUES ('0801', '080105', '数据字典', 'icon-htqc', '/dict/dictionary.action', '5', null);
INSERT INTO `menus` VALUES ('0801', '080106', '菜单管理', 'icon-htqc', '/menus/menu.action', '6', null);
INSERT INTO `menus` VALUES ('0801', '080107', '角色管理', 'icon-htqc', '/role/role.action', '7', null);
INSERT INTO `menus` VALUES ('0801', '080108', '修改密码', 'icon-htgl', '/user/enterUpdatePwd.action', '8', null);
INSERT INTO `menus` VALUES ('09', '0901', '财政专项', 'icon-sys', null, '1', null);
INSERT INTO `menus` VALUES ('0901', '090101', '填写项目', 'icon-pgin', '/project/campusPurchasing.action?purchase=02&dictName=01', '1', null);
INSERT INTO `menus` VALUES ('0901', '090102', '项目审批', 'icon-pgin', '/project/cumpusProject.action?purchase=02&dictName=01', '2', null);
INSERT INTO `menus` VALUES ('0901', '090103', '项目执行', 'icon-pgset', '/project/campusApproval.action?purchase=02&dictName=01', '3', null);
INSERT INTO `menus` VALUES ('0901', '090104', '项目完成', 'icon-pgin', '/project/campusImplementation.action?purchase=02&dictName=01', '4', null);
INSERT INTO `menus` VALUES ('09', '0902', '本部门经费', 'icon-ht', null, '2', null);
INSERT INTO `menus` VALUES ('0902', '090201', '填写项目', 'icon-pgin', '/project/campusPurchasing.action?purchase=02&dictName=02', '1', null);
INSERT INTO `menus` VALUES ('0902', '090202', '项目审批', 'icon-pgin', '/project/cumpusProject.action?purchase=02&dictName=02', '2', null);
INSERT INTO `menus` VALUES ('0902', '090203', '项目执行', 'icon-pgset', '/project/campusApproval.action?purchase=02&dictName=02', '3', null);
INSERT INTO `menus` VALUES ('0902', '090204', '项目完成', 'icon-htqc', '/project/campusImplementation.action?purchase=02&dictName=02', '4', null);
INSERT INTO `menus` VALUES ('09', '0903', '科研项目', 'icon-zj', null, '3', null);
INSERT INTO `menus` VALUES ('0903', '090301', '填写项目', 'icon-pgin', '/project/campusPurchasing.action?purchase=02&dictName=03', '1', null);
INSERT INTO `menus` VALUES ('0903', '090302', '项目审批', 'icon-pgin', '/project/cumpusProject.action?purchase=02&dictName=03', '2', null);
INSERT INTO `menus` VALUES ('0903', '090303', '项目执行', 'icon-pgset', '/project/campusApproval.action?purchase=02&dictName=03', '3', null);
INSERT INTO `menus` VALUES ('0903', '090304', '项目完成', 'icon-zjin', '/project/campusImplementation.action?purchase=02&dictName=03', '4', null);
INSERT INTO `menus` VALUES ('0701', '70104', '校内数据统计', 'icon-htqc', '/InschoolDataAnalysis/inschoolDataStation.action', '4', null);
INSERT INTO `menus` VALUES ('0701', '70105', '校内项目年度报表', 'icon-htgl', '/InschoolDataAnalysis/inschoolEducation.action', '5', null);

-- ----------------------------
-- Table structure for project_check
-- ----------------------------
DROP TABLE IF EXISTS `project_check`;
CREATE TABLE `project_check` (
  `PROJECT_CHECK_CODE` char(64) DEFAULT NULL COMMENT '项目日志编号',
  `PROJECT_MASTER_CODE` varchar(32) NOT NULL COMMENT '项目编号',
  `AUDITOR_CODE` varchar(30) DEFAULT NULL COMMENT '审核人',
  `AUDITOR_DATE` datetime DEFAULT NULL COMMENT '审核时间',
  `AUDITOR_OPINION` varchar(100) DEFAULT NULL COMMENT '审核意见',
  `IS_AGREED` char(2) DEFAULT NULL COMMENT '是否同意',
  `STEP` char(4) DEFAULT NULL COMMENT '流程环节'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project_check
-- ----------------------------
INSERT INTO `project_check` VALUES ('5f929e720dd4408aace38e16f05e5d1a', 'qhdx2017J001S342093', 'null', '2018-03-13 15:34:46', 'null', '', '01');
INSERT INTO `project_check` VALUES ('386eb33b87c54e2fa170bd228618e9ee', 'qhdx2017J002S1712964', 'null', '2018-03-14 09:17:31', 'null', '', '01');
INSERT INTO `project_check` VALUES ('723b0517f7b74e689422240f37a237b3', 'qhdx2017J003S3955115', '2017001', '2018-03-26 15:44:14', 'null', '01', '02');
INSERT INTO `project_check` VALUES ('487b25c2b0164343bf85e6e3570d9fb2', 'qhdx2017J004S4057707', '2017001', '2018-03-26 15:43:50', 'null', '01', '02');
INSERT INTO `project_check` VALUES ('a880b4d551314e08b2033070c90084af', 'qhdx2017J005S3646892', 'null', '2018-03-26 15:37:07', 'null', '', '01');
INSERT INTO `project_check` VALUES ('1e7eb472b4a2404aa271f16c8c432cc4', 'qhdx2017J006S4752712', 'null', '2018-03-26 15:48:12', 'null', '', '01');
INSERT INTO `project_check` VALUES ('bf4c392d572d4aa691dcc2b738c2ae41', 'qhdx2017J007S4953148', 'null', '2018-03-26 15:50:11', 'null', '', '01');
INSERT INTO `project_check` VALUES ('26bc93ad5bfc4214874daccebb00b4e3', 'qhdx2017J007S5450514', '2017002', '2018-04-02 13:37:18', '', '01', '03');

-- ----------------------------
-- Table structure for project_expert
-- ----------------------------
DROP TABLE IF EXISTS `project_expert`;
CREATE TABLE `project_expert` (
  `PROJECT_MASTER_CODE` char(32) DEFAULT NULL COMMENT '项目编号',
  `EXPERT_STYLE` char(16) DEFAULT NULL COMMENT '专家类型',
  `EXPERT_ACCOUNT` varchar(50) DEFAULT NULL COMMENT '专家编号',
  `EXPERT_TEL` varchar(11) DEFAULT NULL COMMENT '专家电话',
  `EXPERT_EMAIL` varchar(255) DEFAULT NULL COMMENT '专家邮箱',
  `ISPOSITION` varchar(2) DEFAULT NULL COMMENT '是否到岗',
  `EXPERT_SUGGESSTION` varchar(100) DEFAULT NULL COMMENT '专家建议',
  `ISHEADMAN` varchar(2) DEFAULT '02' COMMENT '是否专家组组长(02：否，01：是)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project_expert
-- ----------------------------
INSERT INTO `project_expert` VALUES ('qhdx2017J001S342093', '01', '100000000000', '15982115756', '2568831318@qq.com', '01', null, '01');
INSERT INTO `project_expert` VALUES ('qhdx2017J001S342093', '01', '200000000000', '18691822573', '2568831318@qq.com', '01', null, '02');
INSERT INTO `project_expert` VALUES ('qhdx2017J001S342093', '01', '300000000000', '18691822573', '2568831318@qq.com', '01', null, '02');
INSERT INTO `project_expert` VALUES ('qhdx2017J004S4057707', '01', '100000000000', '15982115756', '2568831318@qq.com', '01', null, '01');
INSERT INTO `project_expert` VALUES ('qhdx2017J004S4057707', '01', '200000000000', '18691822573', '2568831318@qq.com', '01', null, '02');
INSERT INTO `project_expert` VALUES ('qhdx2017J004S4057707', '01', '300000000000', '18691822573', '2568831318@qq.com', '01', null, '02');

-- ----------------------------
-- Table structure for project_information
-- ----------------------------
DROP TABLE IF EXISTS `project_information`;
CREATE TABLE `project_information` (
  `PROJECT_INFORMATION_ID` char(32) DEFAULT NULL COMMENT '项目行信息编号',
  `PROJECT_MASTER_CODE` varchar(32) DEFAULT NULL COMMENT '项目编号',
  `PROJECT_INFORMATION_CODE` varchar(32) DEFAULT NULL COMMENT '子项目编号',
  `PROJECT_INFORMATION_NAME` varchar(50) DEFAULT NULL COMMENT '子项目名称',
  `PROJECT_UNIT` varchar(20) DEFAULT NULL COMMENT '项目单位',
  `PROJECT_BUDGET_AMOUNT` decimal(20,0) DEFAULT NULL COMMENT '预算金额',
  `PROJECT_ACTUAL_AMOUNT` decimal(20,0) DEFAULT NULL COMMENT '实际金额',
  `PROJECT_STATUS` char(2) DEFAULT '02' COMMENT '项目状态',
  `PROJECT_NUM` varchar(10) CHARACTER SET armscii8 DEFAULT '' COMMENT '采购数量',
  `PROJECT_INFORMATION_petitioner` varchar(20) DEFAULT NULL COMMENT '子项目负责人',
  `PROJECT_PARAMS` varchar(500) DEFAULT NULL COMMENT '参数',
  `REMARK` varchar(200) DEFAULT NULL,
  `tender` varchar(4) DEFAULT '01' COMMENT '招标状态',
  `contract` varchar(4) DEFAULT '01' COMMENT '合同状态',
  `receive_goods` varchar(4) DEFAULT '01' COMMENT '收货状态',
  `training` varchar(4) DEFAULT '01' COMMENT '培训状态',
  `acceptance` varchar(4) DEFAULT '01' COMMENT '验收状态',
  `alternate` varchar(4) DEFAULT '01' COMMENT '支付状态'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='项目信息行项目表';

-- ----------------------------
-- Records of project_information
-- ----------------------------
INSERT INTO `project_information` VALUES ('fe3f1b654aa84144b39d1fdd7df12ffb', 'qhdx2017J004S4057707', 'qhdx2017J004S4057707001', '1212', 'null', '102', null, '02', 'null', '2017004', '1212', null, '01', '01', '01', '01', '01', '01');
INSERT INTO `project_information` VALUES ('c959a4446d9344608b78254d8d2496f4', 'qhdx2017J004S4057707', 'qhdx2017J004S4057707701', '121212', 'null', null, null, '02', 'null', '2017002', '1112', null, '01', '01', '01', '01', '01', '01');
INSERT INTO `project_information` VALUES ('2e6cabbd4f594c908493fcea9dc9eac1', 'qhdx2017J003S3955115', 'qhdx2017J003S3955115001', '青海大学实验室改造', 'null', null, null, '02', 'null', '2017002', '1212', null, '01', '01', '01', '01', '01', '01');
INSERT INTO `project_information` VALUES ('d71660b8beb24e9e916d8bf64b628117', 'qhdx2017J007S5450514', 'qhdx2017J007S5450514001', '青海大学实验室改造', 'null', null, null, '03', 'null', '2017002', '222', null, '01', '01', '01', '01', '01', '01');

-- ----------------------------
-- Table structure for project_information_log
-- ----------------------------
DROP TABLE IF EXISTS `project_information_log`;
CREATE TABLE `project_information_log` (
  `PROJECT_INFORMATION_ID` char(32) DEFAULT NULL COMMENT '项目行信息编号',
  `PROJECT_MASTER_CODE` varchar(32) DEFAULT NULL COMMENT '项目编号',
  `project_information_name` varchar(50) DEFAULT NULL COMMENT '项目名称',
  `PROJECT_UNIT` varchar(20) DEFAULT NULL COMMENT '项目单位',
  `PROJECT_BUDGET_AMOUNT` decimal(20,0) DEFAULT NULL COMMENT '预算金额',
  `PROJECT_ACTUAL_AMOUNT` decimal(20,0) DEFAULT NULL COMMENT '实际金额',
  `PROJECT_STATUS` char(2) DEFAULT '02' COMMENT '项目状态',
  `PROJECT_NUM` varchar(10) CHARACTER SET armscii8 DEFAULT '' COMMENT '采购数量',
  `PROJECT_PARAMS` varchar(500) DEFAULT NULL COMMENT '参数',
  `REMARK` varchar(200) DEFAULT NULL,
  `tender` varchar(4) DEFAULT '01' COMMENT '招标状态',
  `contract` varchar(4) DEFAULT '01' COMMENT '签合同状态',
  `receive_goods` varchar(4) DEFAULT '01' COMMENT '收货状态',
  `training` varchar(4) DEFAULT '01' COMMENT '培训状态',
  `acceptance` varchar(4) DEFAULT '01' COMMENT '验收状态',
  `alternate` varchar(4) DEFAULT '01' COMMENT '支付状态',
  `ModifyTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '系统当前时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='项目信息行项目表';

-- ----------------------------
-- Records of project_information_log
-- ----------------------------
INSERT INTO `project_information_log` VALUES ('fe3f1b654aa84144b39d1fdd7df12ffb', 'qhdx2017J004S4057707', '1212', null, null, null, '02', '', '1212', null, '01', '01', '01', '01', '01', '01', '2018-03-15 09:12:08');
INSERT INTO `project_information_log` VALUES ('c959a4446d9344608b78254d8d2496f4', 'qhdx2017J004S4057707', '121212', null, null, null, '02', '', '1112', null, '01', '01', '01', '01', '01', '01', '2018-03-26 15:43:35');
INSERT INTO `project_information_log` VALUES ('2e6cabbd4f594c908493fcea9dc9eac1', 'qhdx2017J003S3955115', '青海大学实验室改造', null, null, null, '02', '', '1212', null, '01', '01', '01', '01', '01', '01', '2018-03-26 15:44:11');
INSERT INTO `project_information_log` VALUES ('d71660b8beb24e9e916d8bf64b628117', 'qhdx2017J007S5450514', '青海大学实验室改造', null, null, null, '02', '', '222', null, '01', '01', '01', '01', '01', '01', '2018-04-02 13:37:14');

-- ----------------------------
-- Table structure for project_info_param
-- ----------------------------
DROP TABLE IF EXISTS `project_info_param`;
CREATE TABLE `project_info_param` (
  `PROJECT_PARAM_ID` varchar(32) DEFAULT NULL COMMENT '项目详细参数',
  `PROJECT_INFORMATION_ID` char(32) DEFAULT NULL COMMENT '项目行信息编号',
  `PROJECT_MASTER_CODE` varchar(32) DEFAULT NULL COMMENT '项目编号',
  `NAME` varchar(100) DEFAULT NULL COMMENT '产品名称',
  `TYPE` varchar(200) DEFAULT NULL COMMENT '规格型号',
  `PRICE` varchar(50) DEFAULT NULL COMMENT '单价',
  `UNIT` varchar(80) DEFAULT NULL COMMENT '单位',
  `NUM` varchar(8) DEFAULT NULL COMMENT '数量',
  `MONEY` varchar(100) DEFAULT NULL COMMENT '金额(元)',
  `room_name` varchar(100) DEFAULT NULL COMMENT '房间名称',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注',
  `manufacturer` varchar(100) DEFAULT NULL COMMENT '生产制造商',
  `country_origin` varchar(20) DEFAULT NULL COMMENT '产地国别',
  `distribution_manufacturer` varchar(100) DEFAULT NULL COMMENT '经销厂家',
  `state` varchar(10) DEFAULT NULL COMMENT '类型 01：实验室改造；02：仪器设备；03：其它'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project_info_param
-- ----------------------------
INSERT INTO `project_info_param` VALUES ('b93ea8f696ec4b2c82dbb49315f44a22', 'fe3f1b654aa84144b39d1fdd7df12ffb', 'qhdx2017J004S4057707', '产品名称', '三星', '10.0', '个', '10', '100.0', '实验室名称', '备注', null, null, null, '01');
INSERT INTO `project_info_param` VALUES ('4c065fd807664e68b4882ca424501128', 'fe3f1b654aa84144b39d1fdd7df12ffb', 'qhdx2017J004S4057707', '1.0', '1', '1.0', '111', '11', '1.0', 'hello', '1.0', null, '美国', '1.0', '02');
INSERT INTO `project_info_param` VALUES ('6affb8d8bc2c496199dd217f495f1acd', 'fe3f1b654aa84144b39d1fdd7df12ffb', 'qhdx2017J004S4057707', '1.0', '1.0', '1.0', '1.0', '1', '1.0', '1.0', '1.0', null, '1.0', '1.0', '02');

-- ----------------------------
-- Table structure for project_info_param_log
-- ----------------------------
DROP TABLE IF EXISTS `project_info_param_log`;
CREATE TABLE `project_info_param_log` (
  `PROJECT_PARAM_ID` varchar(32) DEFAULT NULL COMMENT '项目详细参数',
  `PROJECT_INFORMATION_ID` char(32) DEFAULT NULL COMMENT '项目行信息编号',
  `PROJECT_MASTER_CODE` varchar(32) DEFAULT NULL COMMENT '项目编号',
  `NAME` varchar(100) DEFAULT NULL COMMENT '产品名称',
  `TYPE` varchar(200) DEFAULT NULL COMMENT '规格型号',
  `PRICE` varchar(50) DEFAULT NULL COMMENT '单价',
  `UNIT` varchar(80) DEFAULT NULL COMMENT '单位',
  `NUM` varchar(8) DEFAULT NULL COMMENT '数量',
  `MONEY` varchar(100) DEFAULT NULL COMMENT '金额(元)',
  `RoomName` varchar(100) DEFAULT NULL COMMENT '房间编号',
  `Remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `ModifyTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '系统当前时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project_info_param_log
-- ----------------------------

-- ----------------------------
-- Table structure for project_instrument
-- ----------------------------
DROP TABLE IF EXISTS `project_instrument`;
CREATE TABLE `project_instrument` (
  `Id` varchar(32) DEFAULT NULL COMMENT '设备ID',
  `PROJECT_MASTER_CODE` varchar(32) DEFAULT NULL,
  `Instrument_Name` varchar(255) DEFAULT NULL COMMENT '设备名称',
  `Number` int(11) DEFAULT NULL COMMENT '数量',
  `Unit` varchar(10) DEFAULT NULL COMMENT '单位',
  `Detailed_Information` text COMMENT '设备详细信息',
  `PROJECT_INFORMATION_ID` varchar(255) DEFAULT NULL,
  `Creator` varchar(20) DEFAULT NULL COMMENT '创建者',
  `DateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project_instrument
-- ----------------------------
INSERT INTO `project_instrument` VALUES ('0a74d2ede4c44d64bf00411e7c348f6d', 'qhdx2017J443435001', '111', '222', '333', '4444', '36727183091548fe9b487b7d3496f6a1', '2017002', '2017-10-31 09:00:28');
INSERT INTO `project_instrument` VALUES ('ae13acac5bf54316a1242d65e3f5c826', 'qhdx2017J410177444', '1111', '12', '55', 'v', '1189dce3869a493ba3b3ed34aa4e41c5', '2017002', '2017-10-31 09:07:13');
INSERT INTO `project_instrument` VALUES ('2acbe595d2754ea5b0d72224838ac3a7', 'qhdx2017J4933281518', '111', '11', '1', '111', '6363a29ae51f4c2e88b513238d8726d2', '2017002', '2017-11-01 07:29:54');
INSERT INTO `project_instrument` VALUES ('d1ccb292979b46608b86a8d4b8a954f5', 'qhdx2017J5925758518', '1111', '12', '55', '5', 'd8ad67d8217c4594a979a4ad83b8b231', 'lzp1', '2017-11-02 03:03:50');
INSERT INTO `project_instrument` VALUES ('2a821ca9aae846a983d7004498327a3e', 'qhdx2017J240218594', '1111', '12', '12', '222', '913d8c0ac9fe4f8795c04f55d1c19ebd', '2017002', '2017-11-02 08:59:25');
INSERT INTO `project_instrument` VALUES ('455e2b4fd004483790f32a576d9e2727', 'qhdx2017J1925154594', '111', '12', '请问', '驱蚊器', 'f9d75aac91d044589ee2ecdfe69e325c', 'laa', '2017-11-03 02:25:44');
INSERT INTO `project_instrument` VALUES ('9cafb8bbf2a3407083d6861e659759d1', 'qhdx2017J01174505', '1111', '12', '12', '好', 'c16b2359701a4a5d8db189933baa8dc9', '2017002', '2017-11-03 06:08:36');
INSERT INTO `project_instrument` VALUES ('75e9f0fa1b024df58a636f0b0307632c', 'qhdx2017J001S1510725', '1111', '12', '额', '12334', 'b1494e223e634d74b34ddd812eed2845', '2017002', '2017-11-03 07:20:52');
INSERT INTO `project_instrument` VALUES ('fb56e164241747efaa5ad64a69d066eb', 'qhdx2017J003S3815620', '大型仪器', '12', '台', '大型仪器12台', '61add3600c4c46afa1e3cafb9c20c080', 'lzp', '2017-11-03 07:41:54');
INSERT INTO `project_instrument` VALUES ('57c14a83136e48d2970f7eb671f66f51', 'qhdx2017J004S5627741', '电脑', '10', '台', '电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装电脑组装', '1ae1137ec7d24c999e64aa51b86a436a', '2017002', '2017-11-03 07:43:52');
INSERT INTO `project_instrument` VALUES ('e2a6f53da7f544f28ddc4af617188050', 'qhdx2017J002S1534759', '1111', '12', '12', '1213', '2acbae8bfead410a92cd12bd785ff87a', '2017002', '2017-11-03 07:53:49');
INSERT INTO `project_instrument` VALUES ('a140821b8f3e41169c2fe7d8e2cac679', 'qhdx2017J016S365405', '222', '12', '12', '233', 'fad7f9877cfd4177900244d49188660e', '2017002', '2017-11-07 01:54:58');

-- ----------------------------
-- Table structure for project_instrument_log
-- ----------------------------
DROP TABLE IF EXISTS `project_instrument_log`;
CREATE TABLE `project_instrument_log` (
  `Id` char(32) DEFAULT NULL COMMENT '设备ID',
  `PROJECT_MASTER_CODE` varchar(32) DEFAULT NULL,
  `Instrument_Name` varchar(255) DEFAULT NULL COMMENT '设备名称',
  `Number` int(11) DEFAULT NULL COMMENT '数量',
  `Unit` varchar(10) DEFAULT NULL COMMENT '单位',
  `Detailed_Information` text COMMENT '设备详细信息',
  `PROJECT_INFORMATION_ID` char(32) DEFAULT NULL,
  `Creator` varchar(20) DEFAULT NULL COMMENT '创建者',
  `DateTime` datetime DEFAULT NULL COMMENT '创建时间',
  `ModifyTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '系统当前时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project_instrument_log
-- ----------------------------

-- ----------------------------
-- Table structure for project_log
-- ----------------------------
DROP TABLE IF EXISTS `project_log`;
CREATE TABLE `project_log` (
  `PROJECT_LOG_CODE` char(64) DEFAULT NULL COMMENT '项目日志编号',
  `PROJECT_MASTER_CODE` varchar(32) NOT NULL COMMENT '项目编号',
  `AUDITOR_CODE` varchar(30) DEFAULT NULL COMMENT '审核人',
  `AUDITOR_DATE` datetime DEFAULT NULL COMMENT '审核时间',
  `AUDITOR_OPINION` varchar(100) DEFAULT NULL COMMENT '审核意见',
  `IS_AGREED` char(2) DEFAULT NULL COMMENT '是否同意',
  `STEP` char(4) DEFAULT NULL COMMENT '流程环节',
  `HISTORY_STEP` char(4) DEFAULT NULL COMMENT '历史状态'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='项目信息日志表';

-- ----------------------------
-- Records of project_log
-- ----------------------------
INSERT INTO `project_log` VALUES ('f921fca91beb4ff4a804d50e4a10c284', 'qhdx2017J004S4057707', '2017001', '2018-03-26 15:43:50', 'null', '02', '02', null);
INSERT INTO `project_log` VALUES ('f50372a2d2874839b8ff5799e7acd8ea', 'qhdx2017J003S3955115', '2017001', '2018-03-26 15:44:14', 'null', '02', '02', null);
INSERT INTO `project_log` VALUES ('fedb076ccb8f491faf93d7d4bfc46f46', 'qhdx2017J007S5450514', '2017001', '2018-04-02 13:36:55', 'null', '02', '02', null);
INSERT INTO `project_log` VALUES ('40b225acb3504689be6b7683ebc31aa0', 'qhdx2017J007S5450514', '2017002', '2018-04-02 13:37:18', '', '02', '03', null);

-- ----------------------------
-- Table structure for project_master
-- ----------------------------
DROP TABLE IF EXISTS `project_master`;
CREATE TABLE `project_master` (
  `PROJECT_MASTER_ID` char(32) CHARACTER SET utf8 COLLATE utf8_icelandic_ci NOT NULL COMMENT '项目ID',
  `PROJECT_MASTER_CODE` varchar(32) DEFAULT NULL COMMENT '项目编码',
  `PROJECT_TYPE` char(2) DEFAULT '' COMMENT '项目类型',
  `PROJECT_NAME` varchar(100) DEFAULT NULL COMMENT '项目名称',
  `PROJECT_BUDGET_AMOUNT` decimal(20,0) NOT NULL COMMENT '项目预算总金额',
  `PROJECT_ACTUAL_AMOUNT` decimal(20,0) NOT NULL DEFAULT '0' COMMENT '项目实际总金额',
  `APPLICANT_UNIT` varchar(50) DEFAULT NULL COMMENT '申请单位',
  `WRITTER` char(100) DEFAULT NULL COMMENT '填写人',
  `PETITIONER` varchar(32) DEFAULT NULL COMMENT '项目负责人编号',
  `APPLICANT_DATE` char(19) DEFAULT '' COMMENT '申请时间',
  `PROJECT_STATUS` varchar(100) DEFAULT NULL COMMENT '项目状态',
  `PLAN_YEAR` char(4) DEFAULT '' COMMENT '计划年份',
  `PLAN_QUARTERLY` varchar(20) DEFAULT NULL COMMENT '计划季度',
  `PROJECT_BEGINTIME` date DEFAULT NULL COMMENT '项目开始时间',
  `PROJECT_ENDTIME` date DEFAULT NULL COMMENT '项目结束时间',
  `STEP` char(4) DEFAULT NULL COMMENT '流程环节',
  `EQUIPCHECKMAN` varchar(100) DEFAULT NULL COMMENT '设备处初审人(专项预审人)',
  `EXPERTS` varchar(100) DEFAULT NULL COMMENT '专家组',
  `EQUIPCHIEF` varchar(100) DEFAULT NULL COMMENT '设备处领导',
  `REMARK` varchar(200) DEFAULT NULL COMMENT '备注',
  `PROJECT_FUNDS_SOURCES` varchar(100) DEFAULT NULL COMMENT '资金来源',
  `PROJECT_ISSUED_CAPITAL` varchar(10) DEFAULT NULL COMMENT '投资资金',
  `INVESTMENT_QUOTA` varchar(20) DEFAULT NULL COMMENT '投资额度',
  `HISTORY_STEP` char(4) DEFAULT NULL COMMENT '历史状态',
  `expert_audit_style` varchar(4) DEFAULT '01' COMMENT '专家审核类型 01:随机三位02:指定三位03:直接通过',
  `receive_goods` varchar(4) DEFAULT '01' COMMENT '收货状态',
  `training` varchar(4) DEFAULT '01' COMMENT '培训状态',
  `acceptance` varchar(4) DEFAULT '01' COMMENT '验收状态',
  `alternate` varchar(4) DEFAULT '01' COMMENT '支付状态',
  `tender` varchar(4) DEFAULT '01' COMMENT '招标状态',
  `contract` varchar(4) DEFAULT '01' COMMENT '合同状态',
  `CREATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  `PROJECT_TYPE_PURCHASE` varchar(2) DEFAULT NULL COMMENT '''"02"表示校内采购，"01"表示专项采购''',
  `TELEPHONE` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `APPLY_PURCHASE` varchar(32) DEFAULT NULL COMMENT '申请采购方式',
  `IS_SIGN_CONTRACT` char(2) DEFAULT NULL COMMENT '是否签合同',
  `IS_INVITATION_TENDER` char(2) DEFAULT NULL COMMENT '是否招标',
  `WINNING_AMOUNT` varchar(20) DEFAULT NULL COMMENT '中标金额',
  `Declaration_unit` varchar(255) DEFAULT NULL COMMENT '申报单位',
  `Competent_leader` varchar(255) DEFAULT NULL COMMENT '主管领导',
  `contract_confirmation` char(4) DEFAULT NULL,
  PRIMARY KEY (`PROJECT_MASTER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='项目主信息';

-- ----------------------------
-- Records of project_master
-- ----------------------------
INSERT INTO `project_master` VALUES ('f061a00d43a14a489b43fc817040e876', 'qhdx2017J002S1712964', '01', '青海大学实验室建设', '0', '1', '36', '2017001', '2017002', null, '201711009', '2018', '201711007', '2018-03-07', '2018-03-30', '02', null, '201711008', null, null, '01', '2017003', null, null, null, '01', '01', '01', '01', '01', '01', '2018-03-26 15:48:37', '01', null, null, null, null, null, null, null, null);
INSERT INTO `project_master` VALUES ('f06fa504f8df4f0ca80c188a65b81480', 'qhdx2017J003S3955115', null, '1213', '100000', '0', null, '2017001', '李占萍', null, '201711009', '2018', '201711007', '2017-08-01', '2018-03-09', '02', null, '201711008', null, '1121', '01', '201711004', null, null, '03', '01', '01', '01', '01', '01', '01', '2018-03-26 15:48:39', '02', null, null, null, null, null, '18', null, null);
INSERT INTO `project_master` VALUES ('bc8490d41a64441eac76d0f2dbc92fb6', 'qhdx2017J004S4057707', null, '12123', '100000', '0', null, '2017001', '李占萍', null, '201711009', '2018', '201711007', '2018-03-08', '2018-03-22', '02', null, '201711008', null, ' 12123', '01', '201711004', null, null, '02', '01', '01', '01', '01', '01', '01', '2018-03-26 15:48:41', '02', null, null, null, null, null, '18', null, null);
INSERT INTO `project_master` VALUES ('0835e0e964d94c8ab984aad25ca8646b', 'qhdx2017J001S342093', null, '1213', '1', '0', null, '2017001', '李占萍', null, '201711009', '2018', '201711007', '2018-03-01', '2018-03-30', '02', null, '201711008', null, '1212', '01', '201711004', null, null, '02', '01', '01', '01', '01', '01', '01', '2018-03-26 15:48:43', '02', null, null, null, null, null, '18', null, null);
INSERT INTO `project_master` VALUES ('9815f9d957724c2ab735d1aebe926ba4', 'qhdx2017J005S3646892', '01', '青海大学实验室建设', '11', '11', '18', '2017001', '2017002', null, '201711009', '2018', '201711007', '2018-03-26', '2018-03-07', '02', null, '201711008', null, null, '01', '2017003', null, null, null, '01', '01', '01', '01', '01', '01', '2018-03-26 15:48:45', '01', null, null, null, null, null, null, null, null);
INSERT INTO `project_master` VALUES ('353b4b5186c94725bf18a5e97a49bfe7', 'qhdx2017J006S4752712', '01', '青海大学实验室建设', '1213111', '12', '36', '2017001', '2017002', null, '201711009', '2018', '201711007', '2018-03-07', '2018-03-08', '01', null, '201711008', null, null, '01', '2017003', null, null, null, '01', '01', '01', '01', '01', '01', '2018-03-26 15:48:12', '01', null, null, null, null, null, null, null, null);
INSERT INTO `project_master` VALUES ('6ba57eeadfaf45d6adaf1bd93949c426', 'qhdx2017J007S5450514', '02', '青海大学实验室建设', '1', '1', '18', '2017001', '2017002', null, '201711009', '2018', '201711007', '2018-03-01', '2018-03-08', '03', '2017004', '201711008', '2017006', null, '01', '2017003', null, null, null, '01', '01', '01', '01', '01', '01', '2018-04-02 13:37:18', '01', null, 'null', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for project_master_log
-- ----------------------------
DROP TABLE IF EXISTS `project_master_log`;
CREATE TABLE `project_master_log` (
  `PROJECT_MASTER_ID` char(32) CHARACTER SET utf8 COLLATE utf8_icelandic_ci DEFAULT NULL COMMENT '项目ID',
  `PROJECT_MASTER_CODE` varchar(32) DEFAULT NULL COMMENT '项目编码',
  `PROJECT_TYPE` char(2) DEFAULT NULL COMMENT '项目类型',
  `PROJECT_NAME` varchar(100) DEFAULT NULL COMMENT '项目名称',
  `PROJECT_BUDGET_AMOUNT` decimal(20,0) DEFAULT NULL COMMENT '项目预算总金额',
  `PROJECT_ACTUAL_AMOUNT` decimal(20,0) DEFAULT NULL COMMENT '项目实际总金额',
  `APPLICANT_UNIT` varchar(50) DEFAULT NULL COMMENT '申请单位',
  `WRITTER` char(12) DEFAULT NULL COMMENT '填写人',
  `PETITIONER` varchar(32) DEFAULT NULL COMMENT '项目负责人编号',
  `APPLICANT_DATE` char(19) DEFAULT '' COMMENT '申请时间',
  `PROJECT_STATUS` varchar(100) DEFAULT NULL COMMENT '项目状态',
  `PLAN_YEAR` char(4) DEFAULT '' COMMENT '计划年份',
  `PLAN_QUARTERLY` varchar(20) DEFAULT NULL COMMENT '计划季度',
  `PROJECT_BEGINTIME` date DEFAULT NULL COMMENT '项目开始时间',
  `PROJECT_ENDTIME` date DEFAULT NULL COMMENT '项目结束时间',
  `STEP` char(4) DEFAULT NULL COMMENT '流程环节',
  `EQUIPCHECKMAN` varchar(100) DEFAULT NULL COMMENT '设备处初审人',
  `EXPERTS` varchar(100) DEFAULT NULL COMMENT '专家组',
  `EQUIPCHIEF` varchar(100) DEFAULT NULL COMMENT '设备处领导',
  `REMARK` varchar(200) DEFAULT NULL COMMENT '备注',
  `PROJECT_FUNDS_SOURCES` varchar(100) DEFAULT NULL COMMENT '资金来源',
  `PROJECT_ISSUED_CAPITAL` varchar(100) DEFAULT NULL COMMENT '下达资金',
  `HISTORY_STEP` char(4) DEFAULT NULL COMMENT '历史状态',
  `expert_audit_style` varchar(4) DEFAULT '01' COMMENT '专家审核类型 01:随机三位02:指定三位03:直接通过',
  `tender` varchar(4) DEFAULT '01' COMMENT '招标状态',
  `contract` varchar(4) DEFAULT '01' COMMENT '合同状态',
  `receive_goods` varchar(4) DEFAULT '01' COMMENT '收货状态',
  `training` varchar(4) DEFAULT '01' COMMENT '培训状态',
  `acceptance` varchar(4) DEFAULT '01' COMMENT '验收状态',
  `alternate` varchar(4) DEFAULT '01' COMMENT '支付状态',
  `CREATE_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  `PROJECT_TYPE_PURCHASE` varchar(2) DEFAULT NULL COMMENT '''"02"表示校内采购，"01"表示专项采购''',
  `TELEPHONE` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `APPLY_PURCHASE` varchar(2) DEFAULT NULL COMMENT '申请采购方式'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='项目主信息';

-- ----------------------------
-- Records of project_master_log
-- ----------------------------
INSERT INTO `project_master_log` VALUES ('0835e0e964d94c8ab984aad25ca8646b', 'qhdx2017J001S342093', null, null, null, null, null, '2017001', '李占萍', '', '201711009', '2018', '201711007', '2018-03-01', '2018-03-30', '01', null, '201711008', null, '1212', null, '201711004', null, '02', '01', '01', '01', '01', '01', '01', '2018-03-13 15:34:49', '02', null, null);
INSERT INTO `project_master_log` VALUES ('f061a00d43a14a489b43fc817040e876', 'qhdx2017J002S1712964', '01', '青海大学实验室建设', '0', '1', '36', '2017001', '2017002', '', '201711009', '2018', '201711007', '2018-03-07', '2018-03-30', '01', null, '201711008', null, null, '01', '2017003', null, '01', '01', '01', '01', '01', '01', '01', '2018-03-14 09:17:31', '01', null, null);
INSERT INTO `project_master_log` VALUES ('f06fa504f8df4f0ca80c188a65b81480', 'qhdx2017J003S3955115', null, null, null, null, null, '2017001', '李占萍', '', '201711009', '2018', '201711007', '2017-08-01', '2018-03-09', '01', null, '201711008', null, '1121', null, '201711004', null, '03', '01', '01', '01', '01', '01', '01', '2018-03-14 13:40:09', '02', null, null);
INSERT INTO `project_master_log` VALUES ('bc8490d41a64441eac76d0f2dbc92fb6', 'qhdx2017J004S4057707', null, null, null, null, null, '2017001', '李占萍', '', '201711009', '2018', '201711007', '2018-03-08', '2018-03-22', '01', null, '201711008', null, ' 12123', null, '201711004', null, '02', '01', '01', '01', '01', '01', '01', '2018-03-14 13:41:31', '02', null, null);
INSERT INTO `project_master_log` VALUES ('9815f9d957724c2ab735d1aebe926ba4', 'qhdx2017J005S3646892', '01', '青海大学实验室建设', '11', '11', '18', '2017001', '2017002', '', '201711009', '2018', '201711007', '2018-03-26', '2018-03-07', '01', null, '201711008', null, null, '01', '2017003', null, '01', '01', '01', '01', '01', '01', '01', '2018-03-26 15:37:07', '01', null, null);
INSERT INTO `project_master_log` VALUES ('353b4b5186c94725bf18a5e97a49bfe7', 'qhdx2017J006S4752712', '01', '青海大学实验室建设', '1213111', '12', '36', '2017001', '2017002', '', '201711009', '2018', '201711007', '2018-03-07', '2018-03-08', '01', null, '201711008', null, null, '01', '2017003', null, '01', '01', '01', '01', '01', '01', '01', '2018-03-26 15:48:12', '01', null, null);
INSERT INTO `project_master_log` VALUES ('181247f931fe4248a9c0998a36bfe101', 'qhdx2017J007S4953148', '01', '青海大学实验室建设', '5', '5', '19', '2017001', '123456', '', '201711009', '2018', '201711007', '2018-03-12', '2018-03-31', '01', null, '201711008', null, null, '01', '2017003', null, '01', '01', '01', '01', '01', '01', '01', '2018-03-26 15:50:11', '01', null, null);
INSERT INTO `project_master_log` VALUES ('6ba57eeadfaf45d6adaf1bd93949c426', 'qhdx2017J007S5450514', '02', '青海大学实验室建设', '1', '1', '18', '2017001', '2017002', '', '201711009', '2018', '201711007', '2018-03-01', '2018-03-08', '01', null, '201711008', null, null, '01', '2017003', null, '01', '01', '01', '01', '01', '01', '01', '2018-03-26 15:55:14', '01', null, null);

-- ----------------------------
-- Table structure for provider
-- ----------------------------
DROP TABLE IF EXISTS `provider`;
CREATE TABLE `provider` (
  `provider_id` char(32) NOT NULL COMMENT '供应商编号',
  `provider_code` char(32) DEFAULT NULL COMMENT '供应商代码',
  `provider_name` varchar(50) DEFAULT NULL COMMENT '供应商名称',
  `contacts_name` varchar(50) DEFAULT NULL COMMENT '联系人名称',
  `contacts_tel` varchar(11) DEFAULT NULL COMMENT '联系人电话',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `contacts_email` varchar(50) DEFAULT NULL COMMENT '联系人邮箱',
  `lawyer` varchar(50) DEFAULT NULL COMMENT '法人代表',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`provider_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of provider
-- ----------------------------
INSERT INTO `provider` VALUES ('d29d421c1ef24fbb8e001e3bbe27c0c7', '12ff111', '你好', '成昆', '13698745632', '青海大学', '1510291176@qq.com', '李四二', '就是干');
INSERT INTO `provider` VALUES ('c8ee37ed911f4104a50c67907fb50cf6', 'qhdx1213', '贺函', '旺仔', '13897311411', '青海大学', '1510291176@qq.com', '李四', '就是干');

-- ----------------------------
-- Table structure for purchase_list
-- ----------------------------
DROP TABLE IF EXISTS `purchase_list`;
CREATE TABLE `purchase_list` (
  `goods_code` char(32) NOT NULL COMMENT '商品编号',
  `provider_id` char(32) NOT NULL COMMENT '供应商编号',
  `style` varchar(50) DEFAULT NULL COMMENT '商品类型',
  `category` varchar(50) DEFAULT NULL COMMENT '商品类目',
  `brand` varchar(50) DEFAULT NULL COMMENT '商品品牌',
  `size` varchar(50) DEFAULT NULL COMMENT '商品规格',
  `unit` varchar(80) DEFAULT NULL COMMENT '商品单位',
  `price` varchar(50) DEFAULT NULL COMMENT '单价',
  `original_price` varchar(50) DEFAULT NULL COMMENT '原价',
  `discount_price` varchar(50) DEFAULT NULL COMMENT '特惠价',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `datatime` varchar(20) DEFAULT NULL COMMENT '当前系统时间',
  `editmen` varchar(12) DEFAULT NULL COMMENT '添加人账号',
  `auditdata` varchar(20) DEFAULT NULL COMMENT '审核时间',
  `auditmen` varchar(12) DEFAULT NULL COMMENT '审核人',
  `issubmit` varchar(2) NOT NULL DEFAULT '02',
  `goods_name` varchar(50) DEFAULT NULL COMMENT '商品名称',
  PRIMARY KEY (`goods_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of purchase_list
-- ----------------------------
INSERT INTO `purchase_list` VALUES ('d3e4e19cf4f744bbb71963f9c0c12aaa', 'c8ee37ed911f4104a50c67907fb50cf6', '03', '01', '04', '10mah，100pcc', '02', '1', '3', '2', '电泳', '2017-10-12 14:34:12', '', '2017-10-13 15:34:25', '2017001', '01', '电泳');
INSERT INTO `purchase_list` VALUES ('9d234249ec7c407598c6c0811cd425b7', 'c8ee37ed911f4104a50c67907fb50cf6', '01', '03', '04', '10mah，100pcc', '02', '10000', '20000', '8000', '通风柜', '2017-10-09 13:42:19', '', '2017-10-13 15:34:38', '2017001', '01', '通风柜');
INSERT INTO `purchase_list` VALUES ('46e4db4938804c6cba6498cea78b8f0f', 'd29d421c1ef24fbb8e001e3bbe27c0c7', '01', '02', '04', '10mah，100pcc', '01', '10000', '20000', '8000', '仪器试验台', null, '', '2017-10-13 15:34:48', '2017001', '01', '仪器试验台');
INSERT INTO `purchase_list` VALUES ('1e9b44b7e1da4f17ba65d322ab2b4962', 'd29d421c1ef24fbb8e001e3bbe27c0c7', '01', '01', '02', '10mah，100pcc', '02', '10000', '5000', '8000', '电泳', '2017-10-12 17:16:06', '', '2017-10-13 15:35:00', '2017001', '01', '电泳');
INSERT INTO `purchase_list` VALUES ('4a6f266cacc44068a3c3f256fe96d427', 'd29d421c1ef24fbb8e001e3bbe27c0c7', '03', '02', '01', '10mah，100pcc', '02', '5000', '5000', '4000', '仪器试验台', '2017-10-12 16:58:28', '', '2017-10-13 15:35:10', '2017001', '01', '仪器试验台');
INSERT INTO `purchase_list` VALUES ('2c745cb5463346c9b486db6eb5f91bbb', 'd29d421c1ef24fbb8e001e3bbe27c0c7', '03', '02', '01', '10mah，100pcc', '02', '5000', '5000', '4000', '仪器试验台', '2017-10-12 16:58:58', '', '2017-10-13 15:35:19', '2017001', '01', '仪器试验台');
INSERT INTO `purchase_list` VALUES ('634348aef0bc4905ad0d24db304ba620', 'd29d421c1ef24fbb8e001e3bbe27c0c7', '01', '03', '04', '1000mAh', '01', '10000', '5000', '8000', '通风柜', '2017-10-12 18:19:06', '', '2017-10-13 15:35:32', '2017001', '01', '通风柜');
INSERT INTO `purchase_list` VALUES ('7a3f4a8d5503485f95d89ebad6ff0a34', 'd29d421c1ef24fbb8e001e3bbe27c0c7', '01', '03', '04', '10mah，100pcc', '02', '4000', '5000', '4000', '通风柜', '2017-10-12 18:20:03', '', '2017-10-13 15:35:46', '2017001', '01', '通风柜');
INSERT INTO `purchase_list` VALUES ('a95a4d603cb1413fb3069b2679f2b367', 'd29d421c1ef24fbb8e001e3bbe27c0c7', '01', '03', '04', '10mah，100pcc', '02', '4000', '5000', '4000', '通风柜', '2017-10-12 18:12:02', '', '2017-10-13 15:35:58', '2017001', '01', '通风柜');
INSERT INTO `purchase_list` VALUES ('f9dcc5cfcabb4940ae61d3a2d3ad1910', 'd29d421c1ef24fbb8e001e3bbe27c0c7', '01', '03', '04', '10mah，100pcc', '02', '5000', '5000', '4000', '通风柜', '2017-10-12 18:10:02', '2017001', '2017-10-13 15:36:08', '2017001', '01', '通风柜');
INSERT INTO `purchase_list` VALUES ('1a5c2521546b484cad2fa8f676839c96', 'd29d421c1ef24fbb8e001e3bbe27c0c7', '01', '01', '01', '10', '01', '10000', '20000', '8000', '电泳', '2017-10-12 22:48:39', '', '2017-10-13 15:36:22', '2017001', '01', '电泳');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` varchar(32) NOT NULL,
  `pid` varchar(32) DEFAULT NULL,
  `text` varchar(20) DEFAULT NULL,
  `seq` decimal(20,0) DEFAULT NULL,
  `roleDescribe` varchar(20) DEFAULT NULL,
  `resourcesId` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('0', '', '超级管理员', '0', '超级管理员角色', '0');
INSERT INTO `roles` VALUES ('0bdf4459868e47f28ee788254fd53d56', '0', '专家评审人', '6', '专家评审人', '[06, 0601,060102, 060103, 060104, 0602,060202, 060203, 060204, 0603, 060302, 060303, 060304, 0604, 060402, 060403, 060404, 09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304,07,0701,070101,070102,70104,70105]');
INSERT INTO `roles` VALUES ('277c0b660b2a47858c6b3e954c262794', '0', '校内采购初审人', '2', '校内采购初审人', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304,07,0701,70104,70105]');
INSERT INTO `roles` VALUES ('410722f444044a22be3109caaf04c752', '0', '专项项目确认人(处长)', '1', '专项项目确认人(处长)', '[06, 0601, 060102, 060103, 060104, 0602,  060202, 060203, 060204, 0603,060302, 060303, 060304, 0604, 060402, 060403, 060404,07,0701,070101,070102]');
INSERT INTO `roles` VALUES ('5abd66e69fef4fd88ce4be994a78f3e0', '0', '专项项目填报人', '1', '专项项目填报人', '[06, 0601, 060101, 060102, 060103, 060104, 0602, 060201, 060202, 060203, 060204, 0603, 060301, 060302, 060303, 060304, 0604, 060401, 060402, 060403, 060404,07,0701,070101,070102]');
INSERT INTO `roles` VALUES ('60578e26c0c147a68cf6ce05756f911e', '0', '校内采购申报人', '2', '校内采购申报人', '[09, 0901, 090101, 090102, 090103, 090104, 0902, 090201, 090202, 090203, 090204, 0903, 090301, 090302, 090303, 090304,07,0701,70104,70105]');
INSERT INTO `roles` VALUES ('6da5f6393ad9483fbab13461fb29fa0d', '0', '校内采购执行人', '2', '校内采购执行人', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304,07,0701,70104,70105]');
INSERT INTO `roles` VALUES ('7011e58494fa4ffa82cd5cebf1dcb72d', '0', '校内采购计财', '2', '校内采购计财', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304,07,0701,70104,70105]');
INSERT INTO `roles` VALUES ('7b92a23329eb478f87bb547753041527', '0', '校内采购预审人', '2', '校内采购预审人', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304,07,0701,70104,70105]');
INSERT INTO `roles` VALUES ('802f16504b034ce1826bdd3950ab375f', '0', '校内采购招投标小组领导', '2', '校内采购招投标小组领导', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304,07,0701,70104,70105]');
INSERT INTO `roles` VALUES ('8a4f12c55e4f495c9c18042142ccd60d', '0', '项目执行  操作人', '1', '项目执行  操作人', '[06, 0601, 060102, 060103, 060104, 0602,  060202, 060203, 060204, 0603,060302, 060303, 060304, 0604, 060402, 060403, 060404,07,0701,070101,070102]');
INSERT INTO `roles` VALUES ('9065f9cb85ce4ec2a56f114ca5a217f1', '0', '专项负责人', '1', '专项负责人', '[06, 0601, 060102, 060103, 060104, 0602,  060202, 060203, 060204, 0603,060302, 060303, 060304, 0604, 060402, 060403, 060404,07,0701,070101,070102]');
INSERT INTO `roles` VALUES ('9429f619a17a48e4955658b7a54f7438', '0', '专项初审人', '1', '专项初审人', '[06, 0601, 060102, 060103, 060104, 0602,  060202, 060203, 060204, 0603,060302, 060303, 060304, 0604, 060402, 060403, 060404,07,0701,070101,070102]');
INSERT INTO `roles` VALUES ('acb787148df34214a6af9a2722fdad2c', '0', '校内采购归口部', '2', '校内采购归口部', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304,07,0701,70104,70105]');
INSERT INTO `roles` VALUES ('ca7f19f891c345da826167a5ee5ef0b8', '0', '校内采购主管领导', '2', '校内采购主管领导', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304,07,0701,70104,70105]');
INSERT INTO `roles` VALUES ('ea525af119734394b4fa6cba4b0f2763', '0', '设备处项目合同确认人', '1', '设备处项目合同确认人', '[06, 0601, 060102, 060103, 060104, 0602,  060202, 060203, 060204, 0603,060302, 060303, 060304, 0604, 060402, 060403, 060404,07,0701,070101,070102]');
INSERT INTO `roles` VALUES ('eed17487be88437cb50c76cab282b68e', '0', '校内采购小组办公室', '2', '校内采购小组办公室', '[09, 0901, 090102, 090103, 090104, 0902, 090202, 090203, 090204, 0903, 090302, 090303, 090304,07,0701,70104,70105]');

-- ----------------------------
-- Table structure for role_resources
-- ----------------------------
DROP TABLE IF EXISTS `role_resources`;
CREATE TABLE `role_resources` (
  `ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  `RESOURCES_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_resources
-- ----------------------------

-- ----------------------------
-- Table structure for station
-- ----------------------------
DROP TABLE IF EXISTS `station`;
CREATE TABLE `station` (
  `station_id` varchar(50) NOT NULL,
  `lab_id` varchar(32) DEFAULT NULL COMMENT '实验室编号',
  `station_use` varchar(100) DEFAULT NULL,
  `station_name` varchar(50) DEFAULT NULL,
  `station_state` varchar(50) DEFAULT NULL,
  `purchaselist` varchar(50) DEFAULT NULL,
  `lab_style` char(50) DEFAULT NULL,
  PRIMARY KEY (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of station
-- ----------------------------
INSERT INTO `station` VALUES ('168c57da1ae745aa84eeeec5bc89e5d8', null, '物理实验', '工位1', '01', '9d234249ec7c407598c6c0811cd425b7', '01');
INSERT INTO `station` VALUES ('70672a8ed4484e15978ff9ea3736db98', null, '物理实验', '工位1', '01', '9d234249ec7c407598c6c0811cd425b7', '01');
INSERT INTO `station` VALUES ('77708881d9534f4c9fd95011b84852e0', null, '1111', '1111', '02', 'd3e4e19cf4f744bbb71963f9c0c12aaa', '01');
INSERT INTO `station` VALUES ('d215ee24d27b403d86b96cc5de923037', null, '电竞', '工位1', '02', '46e4db4938804c6cba6498cea78b8f0f', '01');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `studentId` char(32) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '学生Id',
  `studentCode` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '学生学号',
  `studentName` varchar(12) CHARACTER SET utf8 DEFAULT NULL COMMENT '学生姓名',
  `studentTel` varchar(11) CHARACTER SET utf8 DEFAULT NULL COMMENT '学生电话',
  `studentEmail` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '学生邮箱',
  `studentsex` char(2) CHARACTER SET utf8 DEFAULT '01' COMMENT '“01”表示男生，“02”表示女生',
  `studentNation` varchar(12) CHARACTER SET utf8 DEFAULT NULL COMMENT '民族',
  `studentNativePlace` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '学生籍贯',
  `studentMajor` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '学生专业',
  `studentDepartment` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '学生院系',
  `birthDate` date DEFAULT NULL COMMENT '出生时间',
  `entranceDate` date DEFAULT NULL COMMENT '入学时间',
  `schoolingLenth` varchar(4) CHARACTER SET utf8 DEFAULT NULL COMMENT '学制',
  `operateMan` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '操作人',
  `isShow` char(2) CHARACTER SET utf8 DEFAULT '01' COMMENT '''01''显示，''02''不显示',
  PRIMARY KEY (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('7ee15f09897a4b0c84727df9c89541f1', '1', '1', '18811708007', '2568831318@qq.com', '01', '02', '02', '01', '19', '2017-11-08', '2017-11-16', '02', '2017001', '01');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `teacherId` char(32) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '教师Id',
  `teacherCode` char(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '教师编号',
  `teacherName` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '教师名称',
  `teacherSex` char(2) CHARACTER SET utf8 DEFAULT NULL COMMENT '教师性别',
  `teacherTel` varchar(11) CHARACTER SET utf8 DEFAULT NULL COMMENT '教师电话号码',
  `teacherEmail` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '教师邮箱',
  `teacherFormation` char(4) CHARACTER SET utf8 DEFAULT NULL COMMENT '教师编制',
  `birthDate` date DEFAULT NULL COMMENT '出生日期',
  `nativePlace` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '出生地（籍贯）',
  `teacherMajor` char(4) CHARACTER SET utf8 DEFAULT NULL COMMENT '教师专业',
  `entranceDate` date DEFAULT NULL COMMENT '入教时间',
  `isHeadmaster` char(2) CHARACTER SET utf8 DEFAULT '02' COMMENT '''01''表示是班主任,''02''表示不是班主任',
  `operateMan` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '操作人',
  `isShow` char(2) CHARACTER SET utf8 DEFAULT '01' COMMENT '''01''显示，''02''不显示',
  `nation` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '民族',
  PRIMARY KEY (`teacherId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('7c884492013e4e9692567e049a696ae0', '2', '2', '01', '18811708007', '2568831318@qq.com', '01', '2017-11-08', '01', '01', '2017-11-16', '02', '2017001', '01', '01');
INSERT INTO `teacher` VALUES ('f57eda264a044daa842f4dadccc9c664', '33', '33', '01', '18811708007', '2568831318@qq.com', '01', '1993-11-03', '01', '02', '2017-11-30', '01', '2017001', '01', '01');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userid` char(32) NOT NULL COMMENT '用户编号',
  `username` varchar(50) DEFAULT NULL COMMENT '用户姓名',
  `account` varchar(30) DEFAULT NULL COMMENT '登录账号（学号）',
  `password` varchar(32) DEFAULT '' COMMENT '登录密码',
  `telephone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `isvalidity` char(1) DEFAULT '1' COMMENT '是否有效 1:有效；0：无效',
  `roleId` varchar(32) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `expert_style` varchar(32) DEFAULT NULL COMMENT '专家类型',
  `num` int(30) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('701ebbf8b6314f8a8a3b11818f358830', '发展规划处项目填报人', '2017001', '2017001', '18691822573', '1', '0', '823533851@qq.com', null, null);
INSERT INTO `user` VALUES ('701ebbf8b6314f8a8a3b11818f358831', '设备处项目申报人', '2017002', '2017002', '18691822573', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', '2568831318@qq.com', null, null);
INSERT INTO `user` VALUES ('701ebbf8b6314f8a8a3b11818f358832', '设备处项目初审人', '2017004', '2017004', '18691822573', '1', '9429f619a17a48e4955658b7a54f7438', '823533853@qq.com', null, null);
INSERT INTO `user` VALUES ('701ebbf8b6314f8a8a3b11818f358833', '专家评审人', '2017005', '2017005', '18691822573', '1', '0bdf4459868e47f28ee788254fd53d56', '823533854@qq.com', null, null);
INSERT INTO `user` VALUES ('701ebbf8b6314f8a8a3b11818f358834', '设备处   处长', '2017006', '2017006', '18691822573', '1', '410722f444044a22be3109caaf04c752', '823533855@qq.com', null, null);
INSERT INTO `user` VALUES ('701ebbf8b6314f8a8a3b11818f358835', '项目执行  操作人', '2017007', '2017007', '18691822573', '1', '8a4f12c55e4f495c9c18042142ccd60d', '823533856@qq.com', null, null);
INSERT INTO `user` VALUES ('161e48fb24834dcc8da24fbe1da5f350', '张小璐', '123456', 'admin123', '15982115756', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', '1484356385@qq.com', null, null);
INSERT INTO `user` VALUES ('5745adc5d16a423b9ece895502565af7', '陈倩', '陈倩', '陈倩', '18909710194', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', '95862583@qq.com', null, null);
INSERT INTO `user` VALUES ('1899969577bc4ad4ab8f520705fe1e16', '李长忠', '李长忠', '李长忠', '18909710194', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', '95862583@qq.com', null, null);
INSERT INTO `user` VALUES ('bca38b5523e148f6911305ac92df5675', '张伟', '张伟', '张伟', '18909710194', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', '95862583@qq.com', null, null);
INSERT INTO `user` VALUES ('df6486384f24494281523927bddab984', '王晓', '王晓', '王晓', '18909710194', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', '95862583@qq.com', null, null);
INSERT INTO `user` VALUES ('ff172f5336494ffeb89be09d40377e9d', '段瑞君', '段瑞君', '段瑞君', '18809710809', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', 'suzhanhai@qq.com', null, null);
INSERT INTO `user` VALUES ('2bda3a727a314170b4a3bbc35c28a5a6', '李积兰', '李积兰', '李积兰', '18809710809', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', 'suzhanhai@qq.com', null, null);
INSERT INTO `user` VALUES ('ce92f52cf60d40ff8fb372eaaf58933e', '马如龙', '马如龙', '马如龙', '18809710809', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', 'suzhanhai@qq.com', null, null);
INSERT INTO `user` VALUES ('924f9c87180d4266a57cffd7c3da7edb', '校内采购主管领导', '201711002', '201711002', '18811708007', '1', 'ca7f19f891c345da826167a5ee5ef0b8', '2568831318@qq.com', null, null);
INSERT INTO `user` VALUES ('e37b7d628121439f983b041257aa4d0e', '王舰', '王舰', '王舰', '18809710809', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', 'suzhanhai@qq.com', null, null);
INSERT INTO `user` VALUES ('3d6ddfefdc654193828577d912806e9e', '格日力', '格日力', '格日力', '18809710809', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', 'suzhanhai@qq.com', null, null);
INSERT INTO `user` VALUES ('4d33db16356c46c2bf273e09bb2f35d2', '司杨', '司杨', '司杨', '18809710809', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', 'suzhanhai@qq.com', null, null);
INSERT INTO `user` VALUES ('10ce74abbd2740c2b600fbb743c1adfd', '李双元', '李双元', '李双元', '18809710809', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', 'suzhanhai@qq.com', null, null);
INSERT INTO `user` VALUES ('539a474e4e0943f6852c788d022aeae2', '网校', '123456', '123admin', '15982115756', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', '1484356385@qq.com', null, null);
INSERT INTO `user` VALUES ('8ce344b7dffd446fbf00752487a83b7c', '李丽', '100000000000', '100000000000', '15982115756', '1', '0bdf4459868e47f28ee788254fd53d56', '2568831318@qq.com', '01', '3');
INSERT INTO `user` VALUES ('9a422bf7d740455b9b28ab7073b996d0', '鱼鱼', '200000000000', '200000000000', '18691822573', '1', '0bdf4459868e47f28ee788254fd53d56', '2568831318@qq.com', '01', '4');
INSERT INTO `user` VALUES ('f53769392cd04fbd95e0fcae3d257b21', '李莉莉', '300000000000', '300000000000', '18691822573', '1', '0bdf4459868e47f28ee788254fd53d56', '2568831318@qq.com', '01', '5');
INSERT INTO `user` VALUES ('16781b5b7fd04488b8383cd0b046aba9', '丽丽', '400000000000', '400000000000', '18691822573', '1', '0bdf4459868e47f28ee788254fd53d56', '2568831318@qq.com', '01', '6');
INSERT INTO `user` VALUES ('ce4f7ccf1abd43208aae2a78cabc6230', '俞灏明', '500000000000', '500000000000', '18691822573', '1', '0bdf4459868e47f28ee788254fd53d56', '2568831318@qq.com', '01', '7');
INSERT INTO `user` VALUES ('d9a9d59012ae46e98e9639ece30c56de', '俞灏', '600000000000', '600000000000', '18691822573', '1', '0bdf4459868e47f28ee788254fd53d56', '2568831318@qq.com', '01', '8');
INSERT INTO `user` VALUES ('93f967bcfdca4869a49066a2a6de1298', '谢娜', '700000000000', '700000000000', '18691822573', '1', '0bdf4459868e47f28ee788254fd53d56', '2568831318@qq.com', '01', '9');
INSERT INTO `user` VALUES ('fa944a4546684e8e98671209cdc346c3', '李丽', '100000000001', '100000000001', '18691822573', '1', '0bdf4459868e47f28ee788254fd53d56', '2568831318@qq.com', '01', '10');
INSERT INTO `user` VALUES ('f1358dd20d4e4e48baffd96bdb758576', '电竞', '100000000012', '100000000012', '18691822573', '1', '0bdf4459868e47f28ee788254fd53d56', '2568831318@qq.com', '01', '11');
INSERT INTO `user` VALUES ('5e80388a408444f598fee17f83a6286c', '高启', '100000000013', '100000000013', '18691822573', '1', '0bdf4459868e47f28ee788254fd53d56', '2568831318@qq.com', '01', '12');
INSERT INTO `user` VALUES ('02c74f60c10147b6bc5cdcdc23d0a357', '卢腾', '100000000014', '100000000014', '18691822573', '1', '0bdf4459868e47f28ee788254fd53d56', '2568831318@qq.com', '01', '13');
INSERT INTO `user` VALUES ('5d4dbffd030c404f91808037e8d0a1d1', '陈宇', '100000000015', '100000000015', '18691822573', '1', '0bdf4459868e47f28ee788254fd53d56', '2568831318@qq.com', '01', '14');
INSERT INTO `user` VALUES ('5d4dbffd030c404f91808037e8d0a1d2', '陈宇2', '100000000016', '100000000016', '18691822573', '1', '0bdf4459868e47f28ee788254fd53d56', '2568831318@qq.com', '01', '15');
INSERT INTO `user` VALUES ('b70282424d0942f2a59f614752c25d45', '苏占海', '苏占海', '苏占海', '18809710809', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', 'suzhanhai@qq.com', null, null);
INSERT INTO `user` VALUES ('a963dec8588c46fb9b2c013531a0a933', '马茹', '马茹', '马茹', '18809710909', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', 'suzhanhai@qq.com', null, null);
INSERT INTO `user` VALUES ('af7c9f41141b4d1e92ba9e6441479660', '贺君', '贺君', '贺君', '18809710809', '1', '9065f9cb85ce4ec2a56f114ca5a217f1', 'suzhanhai@qq.com', null, null);
INSERT INTO `user` VALUES ('1a2479c1c9bc415f8afe50e32f373723', '周印利', '周印利', '周印利', '18809710809', '1', '0', 'suzhanhai@qq.com', null, null);
INSERT INTO `user` VALUES ('e7f70310342642aebdbbba656deb2f60', '王晓英', '王晓英', '王晓英', '18809710809', '1', '0', 'suzhanhai@qq.com', null, null);
INSERT INTO `user` VALUES ('473f31c6c09c414297f8efff3c0930c1', '吴桂玲', '吴桂玲', '吴桂玲', '18809710809', '1', '0', 'suzhanhai@qq.com', null, null);
INSERT INTO `user` VALUES ('04ebe8473d3a4281855ad7192d17dc53', '李永刚', '李永刚', '李永刚', '18809710809', '1', '0', 'suzhanhai@qq.com', null, null);
INSERT INTO `user` VALUES ('ab3aa346d58e11e7a1d938d547015a55', '张伟', '2017120191', '123abc', '13997127085', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '21', '1');
INSERT INTO `user` VALUES ('676a78a0c004475fb6ac0fc18befc0d5', '校内采购预审人', '201711003', '201711003', '18811708007', '1', '7b92a23329eb478f87bb547753041527', '2568831318@qq.com', null, null);
INSERT INTO `user` VALUES ('a8da4a089d1441558b45f0a6fd75457f', '校内采购初审人', '201711004', '201711004', '18811708007', '1', '277c0b660b2a47858c6b3e954c262794', '2568831318@qq.com', null, null);
INSERT INTO `user` VALUES ('a8420c3914694558aca084b42cb3d3d5', '校内采购归口', '201711006', '201711006', '18811708007', '1', 'acb787148df34214a6af9a2722fdad2c', '2568831318@qq.com', null, null);
INSERT INTO `user` VALUES ('314987ed702f4b6d9f22efd72fdb6dd4', '校内采购计财', '201711007', '201711007', '18811708007', '1', '7011e58494fa4ffa82cd5cebf1dcb72d', '2568831318@qq.com', null, null);
INSERT INTO `user` VALUES ('2ed8fcf6300642b88fa052504858c092', '校内采购小组办公室', '201711008', '201711008', '18811708007', '1', 'eed17487be88437cb50c76cab282b68e', '2568831318@qq.com', null, null);
INSERT INTO `user` VALUES ('ff78a631335645c686841f89b667fc9a', '校内采购招投标小组领导', '201711009', '201711009', '18811708007', '1', '802f16504b034ce1826bdd3950ab375f', '2568831318@qq.com', null, null);
INSERT INTO `user` VALUES ('4f0ce322071e4dee98f0d7c205aa1d04', '李占萍', '李占萍', '李占萍', '18691822573', '1', 'ca7f19f891c345da826167a5ee5ef0b8', '2568831318@qq.com', null, null);
INSERT INTO `user` VALUES ('c8405d308c894ebe9ee46af571d69e01', 'lzp', 'lzp', 'lzp', '18691822573', '1', 'ca7f19f891c345da826167a5ee5ef0b8', '18691822573@139.com', null, null);
INSERT INTO `user` VALUES ('c7126a4499614e75861a7c6bbc3444ab', '小天儿', '小天儿', '小天儿', '18691822573', '1', 'ca7f19f891c345da826167a5ee5ef0b8', '18691822573@139.com', null, null);
INSERT INTO `user` VALUES ('a13fe29ccadd4816a6ba7ea3198dd2f2', '实验室管理处', '201711061', '201711061', '18811708007', '1', 'acb787148df34214a6af9a2722fdad2c', '2568831318@qq.com', null, null);
INSERT INTO `user` VALUES ('2155017d95964b88871f83dc0d4ef4b1', '国有资产管理中心', '201711062', '201711062', '18811708007', '1', 'acb787148df34214a6af9a2722fdad2c', '2568831318@qq.com', null, null);
INSERT INTO `user` VALUES ('36c4532d07744797b5306f91d33d9588', '科技处', '201711063', '201711063', '18811708007', '1', 'acb787148df34214a6af9a2722fdad2c', '2568831318@qq.com', null, null);
INSERT INTO `user` VALUES ('90d1ec515e8d4550b3ae22a6bbe37440', '教务处', '201711064', '201711064', '18811708007', '1', 'acb787148df34214a6af9a2722fdad2c', '2568831318@qq.com', null, null);
INSERT INTO `user` VALUES ('ebc5aedcd90e4466aca324b32c183afd', '组织人事部', '201711065', '201711065', '18691822573', '1', 'acb787148df34214a6af9a2722fdad2c', '18691822573@139.com', null, null);
INSERT INTO `user` VALUES ('23ad1916633641c8970fc9ea1470e62f', '校内采购执行人', '201711010', '201711010', '18811708007', '1', '6da5f6393ad9483fbab13461fb29fa0d', '2568831318@qq.com', null, null);
INSERT INTO `user` VALUES ('e1b209c9d63c11e7b4b338d547015a55', '	仉国栋', '2017120001', '123abc', '13709727296', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '06', '3');
INSERT INTO `user` VALUES ('e1b501c1d63c11e7b4b338d547015a55', '	杨亚萍', '2017120002', '123abc', '13897258950', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '06', '4');
INSERT INTO `user` VALUES ('94a65456d63b11e7b4b338d547015a55', '刘连新', '2017120003', '123abc', '13519700012', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '01', '1');
INSERT INTO `user` VALUES ('94a8c59fd63b11e7b4b338d547015a55', '解宏伟', '2017120004', '123abc', '13997481103', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '01', '2');
INSERT INTO `user` VALUES ('cd694752d63b11e7b4b338d547015a55', '任岗', '2017120005', '123abc', '18609710198', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '02', '1');
INSERT INTO `user` VALUES ('cd6c53e3d63b11e7b4b338d547015a55', '张庆平', '2017120006', '123abc', '13997082393', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '02', '2');
INSERT INTO `user` VALUES ('f3f4f530d63b11e7b4b338d547015a55', '任二峰', '2017120007', '123abc', '13897262769', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '03', '1');
INSERT INTO `user` VALUES ('1594c305d63c11e7b4b338d547015a55', '	宁黎平', '2017120008', '123abc', '13897432839', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '04', '1');
INSERT INTO `user` VALUES ('4422f792d63c11e7b4b338d547015a55', '	张吾渝', '2017120009', '123abc', '13997231954', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '05', '1');
INSERT INTO `user` VALUES ('e1a8f7c5d63c11e7b4b338d547015a55', '	陈柏昆', '2017120010', '123abc', '13519769262', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '06', '1');
INSERT INTO `user` VALUES ('e1acb5ced63c11e7b4b338d547015a55', '	杨立峰', '2017120011', '123abc', '13709733116', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '06', '2');
INSERT INTO `user` VALUES ('e1b74856d63c11e7b4b338d547015a55', '	陈柏昆', '2017120012', '123abc', '13519769262', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '06', '5');
INSERT INTO `user` VALUES ('1a117412d63d11e7b4b338d547015a55', '邵楠', '2017120013', '123abc', '13897187688', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '07', '1');
INSERT INTO `user` VALUES ('77641db4d63d11e7b4b338d547015a55', '李秀莲', '2017120014', '123abc', '18997180001', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '08', '1');
INSERT INTO `user` VALUES ('776761ecd63d11e7b4b338d547015a55', '赵伟东', '2017120015', '123abc', '13086259531', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '08', '2');
INSERT INTO `user` VALUES ('bcd67fc1d63d11e7b4b338d547015a55', '佟勇', '2017120016', '123abc', '13997198465', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '09', '1');
INSERT INTO `user` VALUES ('bcd94389d63d11e7b4b338d547015a55', '邢艳红', '2017120017', '123abc', '13997193080', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '09', '2');
INSERT INTO `user` VALUES ('f515ac70d63d11e7b4b338d547015a55', '阎淑君', '2017120018', '123abc', '13709728321', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '10', '1');
INSERT INTO `user` VALUES ('f517fd0ed63d11e7b4b338d547015a55', '龚志起', '2017120019', '123abc', '18209784765', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '10', '2');
INSERT INTO `user` VALUES ('3e2d8ce7d63e11e7b4b338d547015a55', '孙军强	', '2017120020', '123abc', '13997144180', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '11', '1');
INSERT INTO `user` VALUES ('3e301e23d63e11e7b4b338d547015a55', '李建林', '2017120021', '123abc', '15897086065', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '11', '2');
INSERT INTO `user` VALUES ('3e32fba3d63e11e7b4b338d547015a55', '陈从兴', '2017120022', '123abc', '13389757678', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '11', '3');
INSERT INTO `user` VALUES ('8622750ed63e11e7b4b338d547015a55', '魏虎奎	', '2017120023', '123abc', '15897085951', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '12', '1');
INSERT INTO `user` VALUES ('86256aecd63e11e7b4b338d547015a55', '王云鹤', '2017120024', '123abc', '15897085980', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '12', '2');
INSERT INTO `user` VALUES ('a6e07370d63f11e7b4b338d547015a55', '司杨', '2017120025', '123abc', '13519745628', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '13', '1');
INSERT INTO `user` VALUES ('a6e3dbd6d63f11e7b4b338d547015a55', '李钊年', '2017120026', '123abc', '13519764320', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '13', '2');
INSERT INTO `user` VALUES ('a6e54ea3d63f11e7b4b338d547015a55', '张金霞', '2017120027', '123abc', '13997282086', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '13', '3');
INSERT INTO `user` VALUES ('7606f96cd64011e7b4b338d547015a55', '陈卫华', '2017120028', '123abc', '13519784946', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '14', '1');
INSERT INTO `user` VALUES ('76085352d64011e7b4b338d547015a55', '魏有海', '2017120029', '123abc', '13519732739', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '14', '2');
INSERT INTO `user` VALUES ('7609d996d64011e7b4b338d547015a55', '马晓岗', '2017120030', '123abc', '13997135357', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '14', '3');
INSERT INTO `user` VALUES ('760c0638d64011e7b4b338d547015a55', '肖明', '2017120031', '123abc', '13519718389', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '14', '4');
INSERT INTO `user` VALUES ('760e78dfd64011e7b4b338d547015a55', '耿贵工', '2017120032', '123abc', '13897627006', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '14', '5');
INSERT INTO `user` VALUES ('76109bfdd64011e7b4b338d547015a55', '田东蓉', '2017120033', '123abc', '13997167352', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '14', '6');
INSERT INTO `user` VALUES ('76127ffdd64011e7b4b338d547015a55', '魏登邦', '2017120034', '123abc', '13997052590', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '14', '7');
INSERT INTO `user` VALUES ('76142d0ed64011e7b4b338d547015a55', '李宗仁', '2017120035', '123abc', '13519702226', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '14', '8');
INSERT INTO `user` VALUES ('d0b95cb0d64011e7b4b338d547015a55', '铁生年', '2017120036', '123abc', '13897279838', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '15', '1');
INSERT INTO `user` VALUES ('d0badcb8d64011e7b4b338d547015a55', '韩红静', '2017120037', '123abc', '17725296362', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '15', '2');
INSERT INTO `user` VALUES ('2b684285d64111e7b4b338d547015a55', '薛寒青', '2017120038', '123abc', '13997070707', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '16', '1');
INSERT INTO `user` VALUES ('2b6b4156d64111e7b4b338d547015a55', '祁银燕', '2017120039', '123abc', '13639784628', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '16', '2');
INSERT INTO `user` VALUES ('2b6ca0ced64111e7b4b338d547015a55', '侯志强', '2017120040', '123abc', '13897491997', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '16', '3');
INSERT INTO `user` VALUES ('51f1fcd6d64111e7b4b338d547015a55', '韩燕', '2017120041', '123abc', '13709718399', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '17', '1');
INSERT INTO `user` VALUES ('7037a601d64111e7b4b338d547015a55', '张得芳', '2017120042', '123abc', '18709711495', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '18', '1');
INSERT INTO `user` VALUES ('d2bdd4dfd64111e7b4b338d547015a55', '李建华', '2017120043', '123abc', '13519709410', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '19', '1');
INSERT INTO `user` VALUES ('d2c0ff85d64111e7b4b338d547015a55', '杨应忠', '2017120044', '123abc', '13997052122', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '19', '2');
INSERT INTO `user` VALUES ('c93b37e8d58e11e7a1d938d547015a55', '马祁生', '2017120045', '123abc', '13519760368', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '21', '2');
INSERT INTO `user` VALUES ('a7740b7dd59011e7a1d938d547015a55', '陈芃', '2017120046', '123abc', '18997176727', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '21', '3');
INSERT INTO `user` VALUES ('0a819945d67311e7b4b338d547015a55', '陈湘宏', '2017120047', '123abc', '13519743069', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '20', '1');
INSERT INTO `user` VALUES ('3eb104b0d67311e7b4b338d547015a55', '苏效东', '2017120048', '123abc', '18909786157', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '22', '1');
INSERT INTO `user` VALUES ('9d9b0d5bd67311e7b4b338d547015a55', '张发斌', '2017120049', '123abc', '13519703916', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '23', '1');
INSERT INTO `user` VALUES ('9d9c655fd67311e7b4b338d547015a55', '黄明玉', '2017120050', '123abc', '13086298156', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '23', '2');
INSERT INTO `user` VALUES ('9d9dabfdd67311e7b4b338d547015a55', '苏占海', '2017120051', '123abc', '18109710809', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '23', '3');
INSERT INTO `user` VALUES ('bbed2d56d67311e7b4b338d547015a55', '裴海昆', '2017120052', '123abc', '13997147001', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '24', '1');
INSERT INTO `user` VALUES ('009d47e3d67411e7b4b338d547015a55', '叶飞安', '2017120053', '123abc', '13997133831', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '25', '1');
INSERT INTO `user` VALUES ('009f4292d67411e7b4b338d547015a55', '邢英', '2017120054', '123abc', '15297139636', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '25', '2');
INSERT INTO `user` VALUES ('868908a3d67411e7b4b338d547015a55', '薛志斌', '2017120055', '123abc', '13997004208', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '26', '1');
INSERT INTO `user` VALUES ('ac3a939fd67411e7b4b338d547015a55', '段瑞君', '2017120056', '123abc', '15897081509', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '27', '1');
INSERT INTO `user` VALUES ('a1660463d67511e7b4b338d547015a55', '杜银忠', '2017120057', '123abc', '13997208256', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '28', '1');
INSERT INTO `user` VALUES ('a16734b8d67511e7b4b338d547015a55', '冯宇哲', '2017120058', '123abc', '13997276253', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '28', '2');
INSERT INTO `user` VALUES ('a16890b0d67511e7b4b338d547015a55', '冶成君', '2017120059', '123abc', '13897650790', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '28', '3');
INSERT INTO `user` VALUES ('a16b0ab4d67511e7b4b338d547015a55', '余忠祥', '2017120060', '123abc', '13519789082', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '28', '4');
INSERT INTO `user` VALUES ('a16cda49d67511e7b4b338d547015a55', '周继平', '2017120061', '123abc', '13997276202', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '28', '5');
INSERT INTO `user` VALUES ('a16ecc56d67511e7b4b338d547015a55', '郝力壮', '2017120062', '123abc', '13897401028', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '28', '6');
INSERT INTO `user` VALUES ('a1714be3d67511e7b4b338d547015a55', '张雁平', '2017120063', '123abc', '13639715206', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '28', '7');
INSERT INTO `user` VALUES ('a172cca3d67511e7b4b338d547015a55', '徐惊涛', '2017120064', '123abc', '13997185693', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '28', '8');
INSERT INTO `user` VALUES ('a174ab30d67511e7b4b338d547015a55', '吴克选', '2017120065', '123abc', '13997090050', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '28', '9');
INSERT INTO `user` VALUES ('a176f7f8d67511e7b4b338d547015a55', '阎明毅', '2017120066', '123abc', '13709765660', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '28', '10');
INSERT INTO `user` VALUES ('a1791523d67511e7b4b338d547015a55', '史绍俊', '2017120067', '123abc', '13997149992', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '28', '11');
INSERT INTO `user` VALUES ('704ca101d67611e7b4b338d547015a55', '李伟', '2017120068', '123abc', '13709747279', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '29', '1');
INSERT INTO `user` VALUES ('704e5789d67611e7b4b338d547015a55', '郭志宏', '2017120069', '123abc', '13109799699', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '29', '2');
INSERT INTO `user` VALUES ('704fe2b0d67611e7b4b338d547015a55', '朵红', '2017120070', '123abc', '13639716578', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '29', '3');
INSERT INTO `user` VALUES ('70520cc9d67611e7b4b338d547015a55', '李生庆', '2017120071', '123abc', '13897212259', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '29', '4');
INSERT INTO `user` VALUES ('7053c56cd67611e7b4b338d547015a55', '徐尚荣', '2017120072', '123abc', '13709735760', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '29', '5');
INSERT INTO `user` VALUES ('70551b78d67611e7b4b338d547015a55', '陆艳', '2017120073', '123abc', '13639758996', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '29', '6');
INSERT INTO `user` VALUES ('705708acd67611e7b4b338d547015a55', '胡国元', '2017120074', '123abc', '13997182395', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '29', '7');
INSERT INTO `user` VALUES ('7058af78d67611e7b4b338d547015a55', '许延刚', '2017120075', '123abc', '13997137626', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '29', '8');
INSERT INTO `user` VALUES ('ba323dfdd67611e7b4b338d547015a55', '徐成体', '2017120076', '123abc', '13997125757', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '30', '1');
INSERT INTO `user` VALUES ('76048b5bd67711e7b4b338d547015a55', '董全民', '2017120077', '123abc', '13897473651', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '31', '1');
INSERT INTO `user` VALUES ('7605c2bdd67711e7b4b338d547015a55', '李世雄', '2017120078', '123abc', '13897421217', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '31', '2');
INSERT INTO `user` VALUES ('7607321fd67711e7b4b338d547015a55', '李玉玲', '2017120079', '123abc', '13897288737', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '31', '3');
INSERT INTO `user` VALUES ('7609299bd67711e7b4b338d547015a55', '刘文辉', '2017120080', '123abc', '13997032802', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '31', '4');
INSERT INTO `user` VALUES ('760aa7c5d67711e7b4b338d547015a55', '施建军', '2017120081', '123abc', '13997094054', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '31', '5');
INSERT INTO `user` VALUES ('760c6192d67711e7b4b338d547015a55', '王宏生', '2017120082', '123abc', '13897288823', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '31', '6');
INSERT INTO `user` VALUES ('760e3409d67711e7b4b338d547015a55', '李春丽', '2017120083', '123abc', '15003663195', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '31', '7');
INSERT INTO `user` VALUES ('76101a56d67711e7b4b338d547015a55', '全小龙', '2017120084', '123abc', '13327695680', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '31', '8');
INSERT INTO `user` VALUES ('05006f92d67811e7b4b338d547015a55', '德科加', '2017120085', '123abc', '13897403257', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '32', '1');
INSERT INTO `user` VALUES ('0501f934d67811e7b4b338d547015a55', '徐成体', '2017120086', '123abc', '13997125757', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '32', '2');
INSERT INTO `user` VALUES ('2927e88ed67811e7b4b338d547015a55', '盛丽', '2017120087', '123abc', '13709716562', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '33', '1');
INSERT INTO `user` VALUES ('9e855fc0d89011e7b17c38d547015a55', '李文秀', '2017120088', '123abc', '13519704470', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '34', '1');
INSERT INTO `user` VALUES ('9e896888d89011e7b17c38d547015a55', '张海峰', '2017120089', '123abc', '13897633721', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '34', '2');
INSERT INTO `user` VALUES ('9e8e3259d89011e7b17c38d547015a55', '唐岩', '2017120090', '123abc', '18797168882', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '34', '3');
INSERT INTO `user` VALUES ('f4022c74d89011e7b17c38d547015a55', '叶军', '2017120091', '123abc', '13897260731', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '35', '1');
INSERT INTO `user` VALUES ('f4057656d89011e7b17c38d547015a55', '王晓珺', '2017120092', '123abc', '13997063324', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '35', '2');
INSERT INTO `user` VALUES ('f406fa74d89011e7b17c38d547015a55', '王小红', '2017120093', '123abc', '13897240463', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '35', '3');
INSERT INTO `user` VALUES ('964f4efed89111e7b17c38d547015a55', '王金辉', '2017120094', '123abc', '13709742114', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '36', '1');
INSERT INTO `user` VALUES ('96514cadd89111e7b17c38d547015a55', '雷富军', '2017120095', '123abc', '13897235844', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '36', '2');
INSERT INTO `user` VALUES ('965396d8d89111e7b17c38d547015a55', '吴磊', '2017120096', '123abc', '18797327018', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '36', '3');
INSERT INTO `user` VALUES ('9655618bd89111e7b17c38d547015a55', '朱闯', '2017120097', '123abc', '13897236080', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '36', '4');
INSERT INTO `user` VALUES ('96573935d89111e7b17c38d547015a55', '金培鹏', '2017120098', '123abc', '13997295263', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '36', '5');
INSERT INTO `user` VALUES ('03e1cdcdd89211e7b17c38d547015a55', '高德东', '2017120099', '123abc', '13519764535', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '37', '1');
INSERT INTO `user` VALUES ('36b7171bd89211e7b17c38d547015a55', '严军', '2017120100', '123abc', '13519754616', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '38', '1');
INSERT INTO `user` VALUES ('53bbf9dad89211e7b17c38d547015a55', '王永杰', '2017120101', '123abc', '13309788872', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '39', '1');
INSERT INTO `user` VALUES ('8fe7fb51d89211e7b17c38d547015a55', '高莉', '2017120102', '123abc', '13519768200', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '40', '1');
INSERT INTO `user` VALUES ('8fea86b3d89211e7b17c38d547015a55', '李灼华', '2017120103', '123abc', '13897474694', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '40', '2');
INSERT INTO `user` VALUES ('babb6d4ed89211e7b17c38d547015a55', '高强', '2017120104', '123abc', '13997128906', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '41', '1');
INSERT INTO `user` VALUES ('efafe5a9d89211e7b17c38d547015a55', '夏明哲', '2017120105', '123abc', '13086265454', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '42', '1');
INSERT INTO `user` VALUES ('394eb93fd89311e7b17c38d547015a55', '马睿', '2017120106', '123abc', '15297087971', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '43', '1');
INSERT INTO `user` VALUES ('556557d7d89311e7b17c38d547015a55', '孟庆凯', '2017120107', '123abc', '18209719909', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '44', '1');
INSERT INTO `user` VALUES ('92c390cbd89311e7b17c38d547015a55', '李琼', '2017120108', '123abc', '18393910101', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '45', '1');
INSERT INTO `user` VALUES ('b36dc0a6d89311e7b17c38d547015a55', '殷恒霞', '2017120109', '123abc', '15597396618', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '46', '1');
INSERT INTO `user` VALUES ('d718bb23d89311e7b17c38d547015a55', '封烁', '2017120110', '123abc', '18609718894', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '47', '1');
INSERT INTO `user` VALUES ('ff792f76d89311e7b17c38d547015a55', '尚千涵', '2017120111', '123abc', '13997131282', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '48', '1');
INSERT INTO `user` VALUES ('8118f20cd89411e7b17c38d547015a55', '任飞', '2017120112', '123abc', '18697238706', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '50', '1');
INSERT INTO `user` VALUES ('811b629dd89411e7b17c38d547015a55', '李兰平', '2017120113', '123abc', '13997136351', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '50', '2');
INSERT INTO `user` VALUES ('811d3865d89411e7b17c38d547015a55', '梁德飞', '2017120114', '123abc', '15109785097', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '50', '3');
INSERT INTO `user` VALUES ('d65f0594d89411e7b17c38d547015a55', '武学霞', '2017120115', '123abc', '15297185367', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '51', '1');
INSERT INTO `user` VALUES ('f3301288d89411e7b17c38d547015a55', '田丽慧', '2017120116', '123abc', '15117932056', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '52', '1');
INSERT INTO `user` VALUES ('10299c47d89511e7b17c38d547015a55', '李宏林', '2017120117', '123abc', '13993163795', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '53', '1');
INSERT INTO `user` VALUES ('2ea991d7d89511e7b17c38d547015a55', '徐德芳', '2017120118', '123abc', '18297195676', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '54', '1');
INSERT INTO `user` VALUES ('4440dbefd89511e7b17c38d547015a55', '张寿德', '2017120119', '123abc', '13997060026', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '55', '1');
INSERT INTO `user` VALUES ('5af2e632d89511e7b17c38d547015a55', '谢克锋', '2017120120', '123abc', '13919254001', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '56', '1');
INSERT INTO `user` VALUES ('9c1641e7d89511e7b17c38d547015a55', '张春辉', '2017120121', '123abc', '13519789218', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '58', '1');
INSERT INTO `user` VALUES ('b58e4e21d89511e7b17c38d547015a55', '王稳', '2017120122', '123abc', '13086262836', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '59', '1');
INSERT INTO `user` VALUES ('ddfeabc9d89511e7b17c38d547015a55', '贾军梅', '2017120123', '123abc', '15201182431', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '60', '1');
INSERT INTO `user` VALUES ('fc111e09d89511e7b17c38d547015a55', '王军强', '2017120124', '123abc', '13993555390', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '61', '1');
INSERT INTO `user` VALUES ('f6fc1bc5d89611e7b17c38d547015a55', '王晓英', '2017120125', '123abc', '13734603501', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '62', '1');
INSERT INTO `user` VALUES ('f6fef8c1d89611e7b17c38d547015a55', '祁俊', '2017120126', '123abc', '13897488125', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '62', '2');
INSERT INTO `user` VALUES ('f701cba7d89611e7b17c38d547015a55', '王晓青', '2017120127', '123abc', '13519732208', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '62', '3');
INSERT INTO `user` VALUES ('f7037a41d89611e7b17c38d547015a55', '张玉安', '2017120128', '123abc', '18209719643', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '62', '4');
INSERT INTO `user` VALUES ('f704dfdad89611e7b17c38d547015a55', '刘海雄', '2017120129', '123abc', '13519709619', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '36', '5');
INSERT INTO `user` VALUES ('f7068145d89611e7b17c38d547015a55', '任继涛', '2017120130', '123abc', '13709711617', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '62', '6');
INSERT INTO `user` VALUES ('f707fe38d89611e7b17c38d547015a55', '李智勇', '2017120131', '123abc', '13897233655', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '62', '7');
INSERT INTO `user` VALUES ('f7099a40d89611e7b17c38d547015a55', '丁蓉', '2017120132', '123abc', '18609788232', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '62', '8');
INSERT INTO `user` VALUES ('f70bc3bcd89611e7b17c38d547015a55', '冯文熠', '2017120133', '123abc', '13309710916', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '62', '9');
INSERT INTO `user` VALUES ('2b4a45c3d89711e7b17c38d547015a55', '白英卿', '2017120134', '123abc', '13519703600', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '63', '1');
INSERT INTO `user` VALUES ('56ca8959d89711e7b17c38d547015a55', '田芳', '2017120135', '123abc', '13897234181', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '64', '1');
INSERT INTO `user` VALUES ('8798f81ed89711e7b17c38d547015a55', '余海芸', '2017120136', '123abc', '13997276265', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '65', '1');
INSERT INTO `user` VALUES ('879b5604d89711e7b17c38d547015a55', '杨新存', '2017120137', '123abc', '18697243399', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '65', '2');
INSERT INTO `user` VALUES ('afff9179d89711e7b17c38d547015a55', '周钧', '2017120138', '123abc', '15500576855', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '66', '1');
INSERT INTO `user` VALUES ('b0033102d89711e7b17c38d547015a55', '朱  琳', '2017120139', '123abc', '18697243300', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '66', '2');
INSERT INTO `user` VALUES ('e6b1ea04d89711e7b17c38d547015a55', '赵常丽', '2017120140', '123abc', '13997167365', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '67', '1');
INSERT INTO `user` VALUES ('e6b3562ad89711e7b17c38d547015a55', '周印利', '2017120141', '123abc', '15897185303', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '67', '2');
INSERT INTO `user` VALUES ('31f7ad57d89811e7b17c38d547015a55', '周宜', '2017120142', '123abc', '13709782533', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '68', '1');
INSERT INTO `user` VALUES ('31f9c08ed89811e7b17c38d547015a55', '边良志', '2017120143', '123abc', '13519705396', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '68', '2');
INSERT INTO `user` VALUES ('991033bdd89811e7b17c38d547015a55', '陈伟', '2017120144', '123abc', '13519705890', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '69', '1');
INSERT INTO `user` VALUES ('9913b08ad89811e7b17c38d547015a55', '孔繁青', '2017120145', '123abc', '13007785969', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '69', '2');
INSERT INTO `user` VALUES ('991708e8d89811e7b17c38d547015a55', '文建军', '2017120146', '123abc', '13897180929', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '69', '3');
INSERT INTO `user` VALUES ('991a5130d89811e7b17c38d547015a55', '满世忠', '2017120147', '123abc', '13709764198', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '69', '4');
INSERT INTO `user` VALUES ('c481637ad89811e7b17c38d547015a55', '蔡洪涛', '2017120148', '123abc', '13709766805', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '70', '1');
INSERT INTO `user` VALUES ('da907d3ed89811e7b17c38d547015a55', '胡夏嵩', '2017120149', '123abc', '13997234726', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '71', '1');
INSERT INTO `user` VALUES ('f5358bf4d89811e7b17c38d547015a55', '丁玉珍', '2017120150', '123abc', '13997227268', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '72', '1');
INSERT INTO `user` VALUES ('12f8ca0ad89911e7b17c38d547015a55', '陈松', '2017120151', '123abc', '15110991151', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '73', '1');
INSERT INTO `user` VALUES ('2bd2e72fd89911e7b17c38d547015a55', '赵静', '2017120152', '123abc', '13897519588', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '74', '1');
INSERT INTO `user` VALUES ('706676a2d89911e7b17c38d547015a55', '李长忠', '2017120152', '123abc', '15897186983', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '76', '1');
INSERT INTO `user` VALUES ('85d5d844d89911e7b17c38d547015a55', '张得钧', '2017120154', '123abc', '13997166221', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '77', '1');
INSERT INTO `user` VALUES ('9d27a3a1d89911e7b17c38d547015a55', '武永亮', '2017120155', '123abc', '13519703091', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '78', '1');
INSERT INTO `user` VALUES ('b91a91bbd89911e7b17c38d547015a55', '张宏', '2017120156', '123abc', '13997182397', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '79', '1');
INSERT INTO `user` VALUES ('25630d7ed89a11e7b17c38d547015a55', '张宏岩', '2017120157', '123abc', '13309718766', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '80', '1');
INSERT INTO `user` VALUES ('256526add89a11e7b17c38d547015a55', '余敬德', '2017120158', '123abc', '18909786939', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '80', '2');
INSERT INTO `user` VALUES ('2567b406d89a11e7b17c38d547015a55', '曲波', '2017120159', '123abc', '13997191364', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '80', '3');
INSERT INTO `user` VALUES ('256a1efed89a11e7b17c38d547015a55', '丁生喜', '2017120160', '123abc', '13007795222', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '80', '4');
INSERT INTO `user` VALUES ('256d1142d89a11e7b17c38d547015a55', '田巧玲', '2017120161', '123abc', '13997191301', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '80', '5');
INSERT INTO `user` VALUES ('733b0664d89a11e7b17c38d547015a55', '刘永年', '2017120162', '123abc', '13639758808', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '81', '1');
INSERT INTO `user` VALUES ('861a1fb8d89a11e7b17c38d547015a55', '李杰', '2017120163', '123abc', '13519730586', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '82', '1');
INSERT INTO `user` VALUES ('9f505ef5d89a11e7b17c38d547015a55', '李先加', '2017120164', '123abc', '13519704078', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '83', '1');
INSERT INTO `user` VALUES ('b97c7dc3d89a11e7b17c38d547015a55', '郭翀琦', '2017120165', '123abc', '13519759518', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '84', '1');
INSERT INTO `user` VALUES ('00620376d89b11e7b17c38d547015a55', '刘德成', '2017120166', '123abc', '13519703966', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '85', '1');
INSERT INTO `user` VALUES ('0063c521d89b11e7b17c38d547015a55', '姚红义', '2017120167', '123abc', '15897188197', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '85', '2');
INSERT INTO `user` VALUES ('00657221d89b11e7b17c38d547015a55', '费胜章', '2017120168', '123abc', '13997132575', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '85', '3');
INSERT INTO `user` VALUES ('1db5143dd89b11e7b17c38d547015a55', '陈诚', '2017120169', '123abc', '13897284591', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '86', '1');
INSERT INTO `user` VALUES ('37511ba4d89b11e7b17c38d547015a55', '卜亚男', '2017120170', '123abc', '13709739177', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '87', '1');
INSERT INTO `user` VALUES ('514d2338d89b11e7b17c38d547015a55', '颜明', '2017120171', '123abc', '13997143697', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '88', '1');
INSERT INTO `user` VALUES ('a501c839d89b11e7b17c38d547015a55', '窦元名', '2017120172', '123abc', '13119769895', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '89', '1');
INSERT INTO `user` VALUES ('a503f8f5d89b11e7b17c38d547015a55', '白东升', '2017120173', '123abc', '18997151855', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '89', '2');
INSERT INTO `user` VALUES ('c2a8a63bd89b11e7b17c38d547015a55', '王建军', '2017120174', '123abc', '13997236708', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '90', '1');
INSERT INTO `user` VALUES ('d72b30cdd89b11e7b17c38d547015a55', '李凌云', '2017120175', '123abc', '13997230698', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '91', '1');
INSERT INTO `user` VALUES ('293240ccd8a211e7b17c38d547015a55', '刘革庆', '2017120176', '123abc', '15897086513', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '92', '1');
INSERT INTO `user` VALUES ('29349495d8a211e7b17c38d547015a55', '陈世彪', '2017120177', '123abc', '13519702286', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '92', '2');
INSERT INTO `user` VALUES ('2936af6ad8a211e7b17c38d547015a55', '钞海峰', '2017120178', '123abc', '13709749652', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '92', '3');
INSERT INTO `user` VALUES ('2938e56ed8a211e7b17c38d547015a55', '余国庆', '2017120179', '123abc', '13997290074', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '92', '4');
INSERT INTO `user` VALUES ('293a96d8d8a211e7b17c38d547015a55', '宋荣宁', '2017120180', '123abc', '13519708269', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '92', '5');
INSERT INTO `user` VALUES ('293c2865d8a211e7b17c38d547015a55', '王秋明', '2017120181', '123abc', '13897405886', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '92', '6');
INSERT INTO `user` VALUES ('293d93d4d8a211e7b17c38d547015a55', '赵成云', '2017120182', '123abc', '18897112513', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '92', '7');
INSERT INTO `user` VALUES ('293f74a5d8a211e7b17c38d547015a55', '黄江萍', '2017120183', '123abc', '15897086085', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '92', '8');
INSERT INTO `user` VALUES ('294128f6d8a211e7b17c38d547015a55', '侯生章', '2017120184', '123abc', '15897086003', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '92', '9');
INSERT INTO `user` VALUES ('2942baedd8a211e7b17c38d547015a55', '赵云', '2017120185', '123abc', '13897409118', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '92', '10');
INSERT INTO `user` VALUES ('2944500fd8a211e7b17c38d547015a55', '付江宁', '2017120186', '123abc', '13709784963', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '92', '11');
INSERT INTO `user` VALUES ('56b65ff8d8a211e7b17c38d547015a55', '霍小景', '2017120187', '123abc', '13909787574', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '93', '1');
INSERT INTO `user` VALUES ('6db6700dd8a211e7b17c38d547015a55', '谈美琴', '2017120188', '123abc', '13897587346', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '94', '1');
INSERT INTO `user` VALUES ('822aa6a3d8a211e7b17c38d547015a55', '周全厚', '2017120189', '123abc', '13709745308', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '95', '1');
INSERT INTO `user` VALUES ('a2f916e3d8a211e7b17c38d547015a55', '王万生', '2017120190', '123abc', '13519711000', '1', '0bdf4459868e47f28ee788254fd53d56', '123@qq.com', '96', '1');
INSERT INTO `user` VALUES ('d7aa74660c3247fb90a8eaa13d5f1348', '设备处项目合同确认人', '2017003', '2017003', '18691822573', '1', 'ea525af119734394b4fa6cba4b0f2763', '823533851@qq.com', null, null);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------

-- ----------------------------
-- Table structure for warehouse
-- ----------------------------
DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE `warehouse` (
  `warehouse_code` varchar(32) NOT NULL COMMENT '仓库编号',
  `warehouse_name` varchar(100) DEFAULT NULL COMMENT '仓库名称',
  `warehouse_address` varchar(100) DEFAULT NULL COMMENT '仓库所在地',
  `warehouse_keeper` varchar(100) DEFAULT NULL COMMENT '仓库管理员',
  `warehouse_size` varchar(10) DEFAULT NULL COMMENT '仓库大小',
  `subordinate_unit` varchar(3) DEFAULT NULL COMMENT '所属单位',
  PRIMARY KEY (`warehouse_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='仓库表';

-- ----------------------------
-- Records of warehouse
-- ----------------------------
INSERT INTO `warehouse` VALUES ('79113342f6eb4879b2c4c28c1777b8cb', '青海大学实验室仓库2', '青海大学3号', '张三', '111', '19');
INSERT INTO `warehouse` VALUES ('d187aff64a3b4b7cae2bb40f12c71534', '111', '22', '33', '44', '36');
INSERT INTO `warehouse` VALUES ('4d1d99a476b844e99722d6f524d41761', '22', '3', '4', '5', '36');
INSERT INTO `warehouse` VALUES ('6fad4b639e4c4df980069e846627f5a1', '222', '333', '44', '5', '36');
INSERT INTO `warehouse` VALUES ('cdadadd9440a464bb82f5f65586dea6e', '6', '66', '6', '6', '36');
INSERT INTO `warehouse` VALUES ('43ef3da625a041a79f8582a217ba84ca', '7', '7', '7', '7', '18');
INSERT INTO `warehouse` VALUES ('9f5fae86b67e44a8bc4cca9215333257', '8', '8', '8', '8', '18');
INSERT INTO `warehouse` VALUES ('46e18340402f4dbf8bbb57d6394d258a', '9', '9', '9', '9', '36');
INSERT INTO `warehouse` VALUES ('ba14d9610757475c86e0f0bf0b9c1744', '12', '12', '12', '12', '36');
INSERT INTO `warehouse` VALUES ('97565d1ef2064a3a97fee51d15190d4f', '13', '13', '13', '13', '36');
INSERT INTO `warehouse` VALUES ('dd3b2a03089d41e29b94aaa53025fb90', '14', '14', '14', '14', '19');
INSERT INTO `warehouse` VALUES ('c281d584c88f413da5a39b44cc074e0c', '15', '15', '15', '15', '36');
INSERT INTO `warehouse` VALUES ('79a9e66734db49409d66160ca7015eb9', '2342', '234', '2342', '234', '36');
INSERT INTO `warehouse` VALUES ('dbef0c9501b24a5abb5a20594adc1929', '2342', '23432', '2343', '234', '36');

-- ----------------------------
-- View structure for projectmasterview
-- ----------------------------
DROP VIEW IF EXISTS `projectmasterview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `projectmasterview` AS select `project_master`.`PROJECT_MASTER_ID` AS `PROJECT_MASTER_ID`,`project_master`.`PROJECT_MASTER_CODE` AS `PROJECT_MASTER_CODE`,`project_master`.`PROJECT_TYPE` AS `PROJECT_TYPE`,`project_master`.`PROJECT_NAME` AS `PROJECT_NAME`,`project_master`.`PROJECT_BUDGET_AMOUNT` AS `PROJECT_BUDGET_AMOUNT`,`project_master`.`PROJECT_ACTUAL_AMOUNT` AS `PROJECT_ACTUAL_AMOUNT`,`project_master`.`APPLICANT_UNIT` AS `APPLICANT_UNIT`,`project_master`.`WRITTER` AS `WRITTER`,`project_master`.`PETITIONER` AS `PETITIONER`,`project_master`.`APPLICANT_DATE` AS `APPLICANT_DATE`,`project_master`.`PROJECT_STATUS` AS `PROJECT_STATUS`,`project_master`.`PLAN_YEAR` AS `PLAN_YEAR`,`project_master`.`PLAN_QUARTERLY` AS `PLAN_QUARTERLY`,`project_master`.`PROJECT_BEGINTIME` AS `PROJECT_BEGINTIME`,`project_master`.`PROJECT_ENDTIME` AS `PROJECT_ENDTIME`,`project_master`.`STEP` AS `STEP`,`project_master`.`EQUIPCHECKMAN` AS `EQUIPCHECKMAN`,`project_master`.`EXPERTS` AS `EXPERTS`,`project_master`.`EQUIPCHIEF` AS `EQUIPCHIEF`,`project_master`.`REMARK` AS `REMARK`,`project_master`.`PROJECT_FUNDS_SOURCES` AS `PROJECT_FUNDS_SOURCES`,`project_master`.`PROJECT_ISSUED_CAPITAL` AS `PROJECT_ISSUED_CAPITAL`,`project_master`.`INVESTMENT_QUOTA` AS `INVESTMENT_QUOTA`,`project_master`.`HISTORY_STEP` AS `HISTORY_STEP`,`project_master`.`expert_audit_style` AS `expert_audit_style`,`project_master`.`receive_goods` AS `receive_goods`,`project_master`.`training` AS `training`,`project_master`.`acceptance` AS `acceptance`,`project_master`.`alternate` AS `alternate`,`project_master`.`tender` AS `tender`,`project_master`.`contract` AS `contract`,`project_master`.`CREATE_DATE` AS `CREATE_DATE`,`project_master`.`PROJECT_TYPE_PURCHASE` AS `PROJECT_TYPE_PURCHASE`,`project_master`.`TELEPHONE` AS `TELEPHONE`,`project_master`.`APPLY_PURCHASE` AS `APPLY_PURCHASE`,`project_master`.`IS_SIGN_CONTRACT` AS `IS_SIGN_CONTRACT`,`project_master`.`IS_INVITATION_TENDER` AS `IS_INVITATION_TENDER`,`project_master`.`WINNING_AMOUNT` AS `WINNING_AMOUNT`,`project_master`.`Declaration_unit` AS `Declaration_unit`,`project_master`.`Competent_leader` AS `Competent_leader`,`project_master`.`contract_confirmation` AS `contract_confirmation`,`FunDictName`('89877aee622411e7b62fbbd90eb76f07',`project_master`.`PROJECT_FUNDS_SOURCES`) AS `FUNDS_SOURCES`,`FunDictName`('559bfcbe622b11e7b62fbbd90eb76f07',`project_master`.`STEP`) AS `stepName`,`FunDictName`('fa0b0ac4c3bd46628ecd91f61df1d3c0',`project_master`.`receive_goods`) AS `receive_goods_name`,`FunDictName`('662ed66026914f689d47f42dc54130ec',`project_master`.`acceptance`) AS `acceptanceName`,`FunDictName`('ee98408fa695484180dccc205a1dbd9d',`project_master`.`alternate`) AS `alternateName`,`FunDictName`('e9d90f2457684f10bf0718c98f33f763',`project_master`.`APPLICANT_UNIT`) AS `applicant_unit_name`,`FunDictName`('e9d90f2457684f10bf0718c98f33f763',`project_master`.`Declaration_unit`) AS `Declaration_unit_name` from `project_master` ;

-- ----------------------------
-- Function structure for FunDictName
-- ----------------------------
DROP FUNCTION IF EXISTS `FunDictName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `FunDictName`(s_dictYypeId    VARCHAR(32),s_dictValue      VARCHAR(32)) RETURNS varchar(255) CHARSET utf8
BEGIN
       RETURN(select dictName from dictinfo where dictTypeId=s_dictYypeId  and dictValue=s_dictValue);
     END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for FunUserName
-- ----------------------------
DROP FUNCTION IF EXISTS `FunUserName`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `FunUserName`(s_account    VARCHAR(32)) RETURNS varchar(255) CHARSET utf8
BEGIN
  RETURN (select username from user where account=s_account);  
END
;;
DELIMITER ;
