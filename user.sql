-- 팀장은 삭제 권한 있음
-- 사장님은 데이터베이스 생성 권한 없음
CREATE DATABASE sampleDB;
-- 데이버베이스 삭제 권한 있음
DROP DATABASE sampleDB;

USE shopdb;
-- 사장님 읽기 권한 있음;
SELECT * from memberTBL;
-- 사장님 쓰기 권한 없음;
-- 스탭은 쓰기, 삭제권한 있음
-- 모든 데이터베이스 읽기 가능 (shopDB에 대하여)
DELETE from memberTBL where memberId= 'Abc';


USE employees;
-- 스탭은 employees에 대해서는 읽기 권한만 존재
SELECT * from employees;
SELECT * From modelDB.buyTBL;

-- 유저 삭제 
DROP USER director;
DROP USER ceo;
DROP USER staff;

CREATE USER director@'%' IDENTIFIED by '1234';
GRANT ALL on *.* to director@'%' with GRANT OPTION;

CREATE USER ceo@'%' IDENTIFIED by '1234';
GRANT SELECT on *.* to ceo@'%';

CREATE user staff@'%' IDENTIFIED by'1234';
GRANT SELECT, INSERT, UPDATE, DELETE on shopdb.* to staff@'%';
GRANT SELECT on employees.* to staff@'%';

CREATE user alba@'%' IDENTIFIED by '1234';
GRANT select on shopdb.uv_membertbl to alba@'%';




