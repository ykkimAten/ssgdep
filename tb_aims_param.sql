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
-- Table structure for table `tb_aims_param`
--

DROP TABLE IF EXISTS `tb_aims_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_aims_param` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '템플릿 ID',
  `PARAMETER` varchar(20) NOT NULL COMMENT '템플릿 변수',
  `MAPPING_ATTR` varchar(200) DEFAULT NULL COMMENT '매핑속성',
  `USE_YN` varchar(1) DEFAULT 'Y' COMMENT '사용여부',
  `REG_DATE` datetime DEFAULT current_timestamp() COMMENT '작성일',
  `MOD_DATE` datetime DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='전자명패 템플릿 변수관리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_aims_param`
--

LOCK TABLES `tb_aims_param` WRITE;
/*!40000 ALTER TABLE `tb_aims_param` DISABLE KEYS */;
INSERT INTO `tb_aims_param` VALUES (1,'TYPE','좌석명','Y','2022-06-16 16:05:25','2022-11-18 08:59:15'),(2,'ITEM_NAME','사용자명','Y','2022-06-16 16:05:25','2022-11-18 08:59:15'),(3,'SALE_PRICE','직급','N','2022-06-16 16:05:25','2022-11-18 08:59:15'),(4,'UNIT_PRICE','상위 부서명','Y','2022-06-16 16:05:25','2022-11-18 08:59:15'),(5,'LIST_PRICE','하위 부서명','Y','2022-06-16 16:05:25','2022-11-18 08:59:15'),(6,'DISPLAY_TYPE','복무정보','Y','2022-06-16 16:05:25','2022-11-18 08:59:15');
/*!40000 ALTER TABLE `tb_aims_param` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-03 14:55:21
