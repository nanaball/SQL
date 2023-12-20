CREATE DATABASE tabledb;
use tabledb;

CREATE TABLE `usertbl` (
  `userID` char(8) NOT NULL,
  `name` varchar(10) NOT NULL,
  `emain` char(30) UNIQUE,
  `birthYEAR` int CHECK(birthYEAR >= 1900 AND birthYEAR <= 2024),
  `addr` char(2) NOT NULL DEFAULT '서울',
  `mobile` char(3) DEFAULT NULL,
  `mobile2` char(8) DEFAULT NULL,
  `height` smallint DEFAULT NULL,
  `mDATE` date DEFAULT NULL
);

-- 테이블 생성 후 수정으로 제약조건
ALTER TABLE usertbl
	ALTER COLUMN birthYEAR	SET DEFAULT -1;
    
-- 뷰 생성하기
CREATE VIEW v_usertable
	as SELECT userid, name, addr FROM usertbl;
    
SELECT * FROM v_usertable;