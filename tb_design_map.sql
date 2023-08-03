-- MariaDB dump 10.19  Distrib 10.5.9-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: atensys
-- ------------------------------------------------------
-- Server version	10.5.9-MariaDB-1:10.5.9+maria~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'atensys'
--
/*!50003 DROP FUNCTION IF EXISTS `FN_CHOSEARCH` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`atensys`@`localhost` FUNCTION `FN_CHOSEARCH`(str varchar(100)) RETURNS varchar(100) CHARSET utf8
BEGIN
    declare returnStr varchar(100);
    declare cnt int;
    declare i int;
    declare j int;
    declare tmpStr varchar(10);
    declare tmp varchar(1024);
    if str is null then
        return '';
end if;
    set cnt = length(str)/3;
    set i = 1;
    set j = 1;
    while i <=cnt DO
            set tmpStr = substring(str,i,j);
case
                when tmpStr rlike '^(ㄱ|ㄲ)' OR ( tmpStr >= '가' AND tmpStr < '나' ) then  set tmp = 'ㄱ';
when tmpStr rlike '^ㄴ' OR ( tmpStr >= '나' AND tmpStr < '다' ) then set tmp = 'ㄴ';
when tmpStr rlike '^(ㄷ|ㄸ)' OR ( tmpStr >= '다' AND tmpStr < '라' ) then set tmp = 'ㄷ';
when tmpStr rlike '^ㄹ' OR ( tmpStr >= '라' AND tmpStr < '마' ) then set tmp = 'ㄹ';
when tmpStr rlike '^ㅁ' OR ( tmpStr >= '마' AND tmpStr < '바' ) then set tmp = 'ㅁ';
when tmpStr rlike '^ㅂ' OR ( tmpStr >= '바' AND tmpStr < '사' ) then set tmp = 'ㅂ';
when tmpStr rlike '^(ㅅ|ㅆ)' OR ( tmpStr >= '사' AND tmpStr < '아' ) then set tmp = 'ㅅ';
when tmpStr rlike '^ㅇ' OR ( tmpStr >= '아' AND tmpStr < '자' ) then set tmp = 'ㅇ';
when tmpStr rlike '^(ㅈ|ㅉ)' OR ( tmpStr >= '자' AND tmpStr < '차' ) then set tmp = 'ㅈ';
when tmpStr rlike '^ㅊ' OR ( tmpStr >= '차' AND tmpStr < '카' ) then set tmp = 'ㅊ';
when tmpStr rlike '^ㅋ' OR ( tmpStr >= '카' AND tmpStr < '타' ) then set tmp = 'ㅋ';
when tmpStr rlike 'ㅌ' OR ( tmpStr >= '타' AND tmpStr < '파' ) then set tmp = 'ㅌ';
when tmpStr rlike '^ㅍ' OR ( tmpStr >= '파' AND tmpStr < '하' ) then set tmp = 'ㅍ';
else set tmp = 'ㅎ';
end case;
            set returnStr = concat(ifnull(returnStr,''), tmp);
            set i=i+1;
end while;
RETURN returnStr;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_design_map`
--

DROP TABLE IF EXISTS `tb_design_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_design_map` (
  `DESIGN_DATA` text DEFAULT NULL COMMENT '맵 디자인 정보(JSON)',
  `CSS` text DEFAULT NULL COMMENT 'CSS (DESIGN_DATA를 기반으로 생성됨)',
  `MODIFY_DATETIME` datetime NOT NULL DEFAULT current_timestamp() COMMENT '수정일시',
  `svg_format` text DEFAULT NULL,
  `useable` varchar(10) DEFAULT NULL,
  `blocked` varchar(10) DEFAULT NULL,
  `used` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='디자인 도면';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_design_map`
--

LOCK TABLES `tb_design_map` WRITE;
/*!40000 ALTER TABLE `tb_design_map` DISABLE KEYS */;
INSERT INTO `tb_design_map` VALUES ('{\"statuses\":[{\"name\":\"useable\",\"desc\":\"예약가능\",\"backgroundColor\":\"#4bafdc\",\"color\":\"#ffffff\"},{\"name\":\"blocked\",\"desc\":\"예약불가\",\"backgroundColor\":\"#B1B3B9\",\"color\":\"#000000\"},{\"name\":\"used\",\"desc\":\"사용중\",\"backgroundColor\":\"#FBAA4D\",\"color\":\"#ffffff\"}],\"seats\":[{\"name\":\"full_time\",\"desc\":\"종일석\",\"boxStyle\":\"{\\n        \\\"width\\\": \\\"18px\\\",\\n        \\\"height\\\": \\\"18px\\\",\\n        \\\"boxSizing\\\": \\\"border-box\\\",\\n        \\\"borderRadius\\\": \\\"14px\\\",\\n        \\\"cursor\\\": \\\"pointer\\\",\\n        \\\"webkitBoxShadow\\\": \\\"-1px 1px 3px rgb(0 0 0 / 30%)\\\",\\n        \\\"mozBoxShadow\\\": \\\"-1px 1px 3px rgba(0, 0, 0, .3)\\\",\\n        \\\"boxShadow\\\": \\\"-1px 1px 3px rgb(0 0 0 / 30%)\\\",\\n        \\\"backgroundColor\\\": \\\"#2bb7b3\\\"\\n    }\",\"textStyle\":\"{\\n        \\\"display\\\": \\\"block\\\",\\n        \\\"width\\\": \\\"100%\\\",\\n        \\\"height\\\": \\\"100%\\\",\\n        \\\"color\\\": \\\"white\\\",\\n        \\\"fontSize\\\": \\\"0.3rem\\\",\\n        \\\"lineHeight\\\": \\\"18px\\\",\\n        \\\"textAlign\\\": \\\"center\\\",\\n        \\\"fontWeight\\\": \\\"500\\\",\\n        \\\"transform\\\" : \\\"scale(0.8)\\\"\\n    }\"},{\"name\":\"part_time\",\"desc\":\"시간석\",\"boxStyle\":\"{\\n            \\\"width\\\": \\\"34px\\\",\\n            \\\"height\\\": \\\"34px\\\",\\n            \\\"boxSizing\\\": \\\"border-box\\\",\\n            \\\"borderRadius\\\": \\\"5px\\\",\\n            \\\"cursor\\\": \\\"pointer\\\",\\n            \\\"margin\\\": \\\"-22 px 0 0 -13 px\\\",\\n            \\\"webkitBoxShadow\\\": \\\"-1px 1px 4px rgb(0 0 0 / 50%)\\\",\\n            \\\"mozBoxShadow\\\": \\\"-1px 1px 4px rgba(0, 0, 0, .5)\\\",\\n            \\\"boxShadow\\\": \\\"-1px 1px 4px rgb(0 0 0 / 50%)\\\",\\n            \\\"backgroundColor\\\": \\\"#2bb7b3\\\",\\n            \\\"transform\\\": \\\"rotate( -45deg)\\\"\\n        }\",\"textStyle\":\"{\\n        \\\"display\\\": \\\"block\\\",\\n        \\\"width\\\": \\\"100%\\\",\\n        \\\"height\\\": \\\"100%\\\",\\n        \\\"color\\\": \\\"white\\\",\\n        \\\"fontSize\\\": \\\"1.1rem\\\",\\n        \\\"lineHeight\\\": \\\"36px\\\",\\n        \\\"textAlign\\\": \\\"center\\\",\\n        \\\"fontWeight\\\": \\\"500\\\",    \\n        \\\"transform\\\": \\\"rotate( 45deg)\\\"\\n    }\"},{\"name\":\"period_range\",\"desc\":\"기간석\",\"boxStyle\":\"{\\n            \\\"width\\\": \\\"18px\\\",\\n            \\\"height\\\": \\\"18px\\\",\\n            \\\"boxSizing\\\": \\\"border-box\\\",\\n            \\\"borderRadius\\\": \\\"14px\\\", \\n            \\\"cursor\\\": \\\"pointer\\\",\\n            \\\"margin\\\": \\\"-22 px 0 0 -13 px\\\",\\n            \\\"webkitBoxShadow\\\": \\\"-1px 1px 3px rgb(0 0 0 / 50%)\\\",\\n            \\\"mozBoxShadow\\\": \\\"-1px 1px 3px rgba(0, 0, 0, .5)\\\",\\n            \\\"boxShadow\\\": \\\"-1px 1px 3px rgb(0 0 0 / 50%)\\\",\\n            \\\"backgroundColor\\\": \\\"#2bb7b3\\\"\\n        }\",\"textStyle\":\"{\\n        \\\"display\\\": \\\"block\\\",\\n        \\\"width\\\": \\\"100%\\\",\\n        \\\"height\\\": \\\"100%\\\",\\n        \\\"color\\\": \\\"white\\\",\\n        \\\"fontSize\\\": \\\"0.3rem\\\",\\n        \\\"lineHeight\\\": \\\"18px\\\",\\n        \\\"textAlign\\\": \\\"center\\\",\\n        \\\"fontWeight\\\": \\\"500\\\",\\n        \\\"transform\\\" : \\\"scale(0.8)\\\"\\n    }\"}],\"room\":{\"boxStyle\":\"{\\n    \\\"width\\\": \\\"37px\\\",\\n    \\\"height\\\": \\\"37px\\\",\\n    \\\"boxSizing\\\": \\\"border-box\\\",\\n    \\\"borderRadius\\\": \\\"8px\\\",\\n    \\\"cursor\\\": \\\"pointer\\\",\\n    \\\"backgroundColor\\\": \\\"#76ab76\\\",\\n    \\\"transform\\\": \\\"rotate(-45deg)\\\",\\n    \\\"padding\\\": \\\"0 3px 3px 0\\\",\\n    \\\"borderRadius\\\": \\\"50% 50% 50% 0\\\",\\n    \\\"margin\\\": \\\"-22px 0 0 -13px\\\",\\n    \\\"webkitBoxShadow\\\": \\\"-1px 1px 4px rgb(0 0 0 / 50%)\\\",\\n    \\\"mozBoxShadow\\\": \\\"-1px 1px 4px rgba(0, 0, 0, .5)\\\",\\n    \\\"boxShadow\\\": \\\"-1px 1px 4px rgb(0 0 0 / 50%)\\\"\\n}\",\"textStyle\":\"{\\n    \\\"display\\\": \\\"block\\\",\\n    \\\"width\\\": \\\"100%\\\",\\n    \\\"height\\\": \\\"100%\\\",\\n    \\\"color\\\": \\\"#76ab76\\\",\\n    \\\"fontSize\\\": \\\"0\\\",\\n    \\\"lineHeight\\\": \\\"36px\\\",\\n    \\\"textAlign\\\": \\\"center\\\",\\n    \\\"fontWeight\\\": \\\"500\\\",    \\n    \\\"transform\\\": \\\"rotate( 45deg)\\\"\\n}\"}}','/* 좌석 상태별 색상 */\r\n.seat_useable {\r\n    background-color: #4bafdc;\r\n    color: #ffffff;\r\n}\r\n.seat_blocked {\r\n    background-color: #B1B3B9;\r\n    color: #000000;\r\n}\r\n.seat_used {\r\n    background-color: #FBAA4D;\r\n    color: #ffffff;\r\n}\r\n\r\n/* 좌석 종일석 상자 */\r\n.seat_full_time_box { width: 18px;height: 18px;box-sizing: border-box;border-radius: 14px;cursor: pointer;webkit-box-shadow: -1px 1px 3px rgb(0 0 0 / 30%);moz-box-shadow: -1px 1px 3px rgba(0, 0, 0, .3);box-shadow: -1px 1px 3px rgb(0 0 0 / 30%);}\r\n\r\n/* 좌석 종일석 텍스트 */\r\n.seat_full_time_text { display: block;width: 100%;height: 100%;color: white;font-size: 0.3rem;line-height: 18px;text-align: center;font-weight: 500;transform: scale(0.8);}\r\n\r\n/* 좌석 시간석 상자 */\r\n.seat_part_time_box { width: 34px;height: 34px;box-sizing: border-box;border-radius: 5px;cursor: pointer;margin: -22 px 0 0 -13 px;webkit-box-shadow: -1px 1px 4px rgb(0 0 0 / 50%);moz-box-shadow: -1px 1px 4px rgba(0, 0, 0, .5);box-shadow: -1px 1px 4px rgb(0 0 0 / 50%);transform: rotate( -45deg);}\r\n\r\n/* 좌석 시간석 텍스트 */\r\n.seat_part_time_text { display: block;width: 100%;height: 100%;color: white;font-size: 1.1rem;line-height: 36px;text-align: center;font-weight: 500;transform: rotate( 45deg);}\r\n\r\n/* 좌석 기간석 상자 */\r\n.seat_period_range_box { width: 18px;height: 18px;box-sizing: border-box;border-radius: 14px;cursor: pointer;margin: -22 px 0 0 -13 px;webkit-box-shadow: -1px 1px 3px rgb(0 0 0 / 50%);moz-box-shadow: -1px 1px 3px rgba(0, 0, 0, .5);box-shadow: -1px 1px 3px rgb(0 0 0 / 50%);}\r\n\r\n/* 좌석 기간석 텍스트 */\r\n.seat_period_range_text { display: block;width: 100%;height: 100%;color: white;font-size: 0.3rem;line-height: 18px;text-align: center;font-weight: 500;transform: scale(0.8);}\r\n\r\n/* 회의실 상자 */\r\n.room_box { width: 37px; height: 37px; box-sizing: border-box; border-radius: 50% 50% 50% 0; cursor: pointer; background-color: #76ab76; transform: rotate(-45deg); padding: 0 3px 3px 0; margin: -22px 0 0 -13px; webkit-box-shadow: -1px 1px 4px rgb(0 0 0 / 50%); moz-box-shadow: -1px 1px 4px rgba(0, 0, 0, .5); box-shadow: -1px 1px 4px rgb(0 0 0 / 50%);  }\r\n\r\n/* 회의실 텍스트 */\r\n.room_text { display: block; width: 100%; height: 100%; color: #76ab76; font-size: 0; line-height: 36px; text-align: center; font-weight: 500; transform: rotate( 45deg);  }','2023-07-27 10:41:54','{\"seats\":[{\"id\":\"full_time\",\"name\":\"종일석\",\"width\":\"18\",\"height\":\"18\",\"format\":\"<svg xmlns=\\\"http://www.w3.org/2000/svg\\\">\\n    <rect width=\\\"18\\\" height=\\\"18\\\" fill=\\\"#3d87fb\\\" rx=\\\"100%\\\" ry=\\\"100%\\\"></rect>\\n    <g>\\n        <text text-anchor=\\\"middle\\\" alignment-baseline=\\\"middle\\\" transform=\\\"translate(9 10)\\\" fill=\\\"#fff\\\" font-size=\\\"0.65rem\\\"></text>\\n    </g>\\n</svg>\"},{\"id\":\"part_time\",\"name\":\"시간석\",\"width\":\"36\",\"height\":\"36\",\"format\":\"<svg xmlns=\\\"http://www.w3.org/2000/svg\\\">\\n    <path d=\\\"M15.8787 2.12132C17.0503 0.949746 18.9497 0.949748 20.1213 2.12132L33.8787 15.8787C35.0503 17.0503 35.0503 18.9497 33.8787 20.1213L20.1213 33.8787C18.9497 35.0503 17.0503 35.0503 15.8787 33.8787L2.12132 20.1213C0.949746 18.9497 0.949748 17.0503 2.12132 15.8787L15.8787 2.12132Z\\\" fill=\\\"#3d87fb\\\"></path>\\n    <g>\\n        <text text-anchor=\\\"middle\\\" alignment-baseline=\\\"middle\\\" transform=\\\"translate(18 18)\\\" fill=\\\"#fff\\\" font-size=\\\"14\\\"></text>\\n    </g>\\n</svg>\"},{\"id\":\"period_range\",\"name\":\"기간석\",\"width\":\"18\",\"height\":\"18\",\"format\":\"<svg xmlns=\\\"http://www.w3.org/2000/svg\\\">\\n    <rect width=\\\"18\\\" height=\\\"18\\\" fill=\\\"#3d87fb\\\" rx=\\\"100%\\\" ry=\\\"100%\\\"></rect>\\n    <g>\\n        <text text-anchor=\\\"middle\\\" alignment-baseline=\\\"middle\\\" transform=\\\"translate(9 10)\\\" fill=\\\"#fff\\\" font-size=\\\"0.65rem\\\"></text>\\n    </g>\\n</svg>\"}],\"room\":{\"width\":\"50\",\"height\":\"50\",\"format\":\"<svg xmlns=\\\"http://www.w3.org/2000/svg\\\">\\n    <rect width=\\\"50\\\" height=\\\"50\\\" rx=\\\"9\\\" fill=\\\"black\\\"></rect>\\n    <g>\\n        <path d=\\\"M35 13.75H33.75V11.25H31.25V13.75H18.75V11.25H16.25V13.75H15C13.625 13.75 12.5 14.875 12.5 16.25V36.25C12.5 37.625 13.625 38.75 15 38.75H35C36.375 38.75 37.5 37.625 37.5 36.25V16.25C37.5 14.875 36.375 13.75 35 13.75ZM35 36.25H15V20H35V36.25Z\\\" fill=\\\"white\\\"/>\\n    </g>\\n</svg>\"}}','#4bafdc','#adadad','#FBAA4D');
/*!40000 ALTER TABLE `tb_design_map` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-03 14:55:02
