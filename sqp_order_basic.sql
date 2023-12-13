-- 데이터베이스 선택
USE sqldb;

-- DDL 테이블 생성
CREATE TABLE testTbl(id int, userName CHAR(3), age int);

-- DML - INSERT 데이터 삽입
INSERT INTO testTbl (id, userName, age) VALUES(1, '홍길동', 30);
-- 생략한 열에는 NULL 값이 들어간다.
INSERT INTO testTbl (id, userName) VALUES(2, '홍길순');
-- 전체 컬럼 값을 순서대로 삽입할 경우 컬럼 생략 가능
INSERT INTO testTbl VALUES(3, '홍길서',32);
-- 순서를 변경할 경우, 입력한 열의 순서에 맞게 값을 입력
INSERT INTO testTbl (age, userName, id) VALUES(30, '홍길남', 4);

-- DQL : 데이터 조회
SELECT * FROM testTbl;

-- AUTO_INCREMENT 숫자 자동증가 
CREATE TABLE testTbl2
	(id INT AUTO_INCREMENT PRIMARY KEY, userName char(3), age int);
    
-- AUTO_INCREMENT 속성에 입력시 NULL 값이 자동 입력
INSERT INTO testTbl2 VALUES(NULL, '홍길서', 31);
INSERT INTO testTbl2 VALUES(NULL, '홍길동', 32);
INSERT INTO testTbl2 VALUES(NULL, '홍길북', 33);
INSERT INTO testTbl2 VALUES(NULL, '홍길남', 34);


-- DDL 테이블의 자동증가번호 변경
ALTER TAbLE testTbl2 auto_increment = 100;

insert into testTbl2 values (null, '홍길순', 35);

-- 자동증가 값을 변경하기(서버 변수 변경)
set @@auto_increment_increment=3;

insert into testTbl2 values (null, '홍길낄', 36);
insert into testTbl2 values (null, '홍길갈', 37);
insert into testTbl2 values (null, '홍길감', 38);

select * from testTbl2;

-- 증가값 복구 
set @@auto_increment_increment=1;

-- 샘플 데이터 생성하기 
CREATE table testTbl3 (id int, Fname varchar(50), Lname VARCHAR(50));

-- insert into ~ select 문 
INSERT into testTbl3
	select emp_no, first_name, last_name from employees.employees;
    
-- update : 데이터 수정하기 
UPDATE testTbl3
	SET Lname = '없음'
    WHERE Fname = 'Kyoichi';

SELECT * from  testTbl3 WHERE Fname = 'Kyoichi';
SELECT * from  testTbl3;


use sqldb;
select * FROM buytbl;
-- where 조건절을 생략하게 될 경우, 전체 행의 값이 변경된다. (주의)
UPDATE buytbl set price = price * 1.5;
select * FROM buytbl;


-- DELETE : 삭제
SELECT * FROM testTbl3;

-- 해당 조건에 부합하는 경우 모두 삭제 
DELETE FROM testTbl3 WHERE Fname = 'Georgi';

-- 상위 5건만 삭제하기 
SELECT * FROM testTbl3 WHERE Fname = 'Bezalel';
DELETE FROM testTbl3 WHERE Fname = 'Bezalel' LIMIT 5;

-- autocommit 설정 확인 및 변경
-- 명령문이 실행될 때 자동으로 COMMIT 수행 여부 
SELECT @@autocommit; 	-- 1 : true : 자동 커밋 설정 상태 

SET @@autocommit := 0; 	-- 0 : false : 자동 커밋 설정 해제
set @@autocommit := true;	-- 1
set @@autocommit := false;	-- 0

select * from testTbl3;
UPDATE testTbl3 set Fname = '없음';
SELECT * from testTbl3;

-- TCL : 현재 세션에서 실행된 작업 이전 COMMIT 시점으로 되돌림
ROLLBACK; 	
SELECT * FROM testTbl3;
UPDATE testTbl3 set Fname = '없음';
COMMIT;	-- 현재세션에서 실행된 작업을 적용;

-- 커밋을 수행한 시점으로 롤백 : 그 이전으로 롤백되지 않음;
ROLLBACK;
SELECT * FROM testTbl3;


-- 테이블 삭제하기 
CREATE TABLE testTbl4 (SELECT * FROM employees.employees);
CREATE TABLE testTbl5 (SELECT * FROM employees.employees);
CREATE TABLE testTbl6 (SELECT * FROM employees.employees);

SELECT * From testTbl4;

-- 모든 행을 삭제(데이터구조는 남아있음 DML, COMMIT하지 않았을 때 롤백가능)
DELETE FROM testTbl4;
ROLLBACK;

-- 모든 데이터를 삭제 (데이터 구조는 남아있음)
TRUNCATE TABLE testTbl5;	-- ddl은 커밋을 포함, 롤백되지 않음
SELECT * FROM testTbl5;
ROLLBACK;

-- 테이블 자체를 삭제 (데이터 구조가 남아있지 않음)
select * from test6;
drop TABLE testTbl6; 	-- ddl : 커밋을 포함;
ROLLBACK;

-- 오토 커밋 원상복구
SET @@autocommit = TRUE;