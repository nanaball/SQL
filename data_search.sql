-- 특정한 조건의 데이터만 조회하기
-- where 절
-- SELECT 컬러명(필드명) from 테이블명 where 조건식;
use sqldb;

SELECT * FROM usertbl where name = '김경호';
SELECT * FROM usertbl where name = '이승기';
-- 주소가 서울인 사람 조회
SELECT * FROM usertbl where addr = '서울';
-- 키가 175 이상인 사람만 조회
SELECT * FROM usertbl where height >= 175;
-- 1970년 이후 출생한 사람 조회
SELECT * FROM usertbl where birthYEAR >= 1970;

-- 조건을 2개 이상 사용 (관계 연산자)
-- and
SELECT * FROM usertbl 
	where height >= 182 AND birthYEAR >= 1975;
-- or
SELECT * FROM usertbl 
	where height >= 182 OR birthYEAR >= 1975;
-- between .. and 
-- 연속적인 값(continious)을 가진 숫자 범위 조회
SELECT * FROM usertbl 
	where height >= 180 OR height <= 185;
SELECT * FROM usertbl 
	where height between 180 and 185;

-- in()
-- 이산적인 값(discrete)을 가진 문자열 조회
SELECT * FROM usertbl 
	where addr = '서울' OR addr='전남' or addr='경남';
SELECT * FROM usertbl 
	where addr in ('서울', '전남', '경남');
-- LIKE : 문자열의 내용을 검색
-- 와일드 카드 % (무엇이든 허용), _ (한글자와 매칭)
SELECT * FROM usertbl WHERE name LIKE '김%';
SELECT * FROM usertbl WHERE name LIKE '_범수';

-- 서브쿼리(SubQUERY) : 쿼이문 안에 쿼리문이 들어 있는 것 
-- 김경호(177)보다 키가 큰 사람을 질의하고 싶을 때
SELECT height FROM usertbl WHERE name = '김경호'; -- 177
SELECT name, height FROM usertbl WHERE height > 177;	-- 177자리에 쿼리문 대체

-- 단일행 (single row) 서브쿼리
-- 서브쿼리 177보다 키가 큰 사람 결과와 동일
-- SELECT 컬럼명 from 테이블명 WHERE 조건 연산자 (SELECT 컬럼명 from 테이블명 where 조건문);
SELECT name, height FROM usertbl WHERE height > (SELECT height FROM usertbl WHERE name = '김경호');

-- SELECT 컬럼명 from 테이블명 WHERE 조건 연산자 (SELECT 컬럼명 from 테이블명 where 조건문);

-- 다중 행(multi row) 서브쿼리
SELECT height from usertbl WHERE addr = '경남'; 	-- 2가지의 결과값 (170,173)
-- 행이 2개 이상이라 에러발생
SELECT name, height from usertbl WHERE height > (SELECT height from usertbl WHERE addr = '경남');
--  any 구문을 사용하면 170보다 크거나, 173보다 크거나= > 170보다 큰 사람
SELECT name, height from usertbl WHERE height > any (SELECT height from usertbl WHERE addr = '경남');
-- all 구문을 사용하면 170보다 크고, 173보다 큰 사람 => 173보다 큰 사람 
SELECT name, height from usertbl WHERE height > all (SELECT height from usertbl WHERE addr = '경남');




-- ORDER BY
-- 순서를 조절하는 구문, 쿼리 결과를 정렬
-- 기본값은 오름차순(ASC), 내림차순(DESC)

-- 가입일 기준 오름차순 
SELECT * FROM usertbl ORDER BY mDate;	-- 기본값 : 오름차순
SELECT * FROM usertbl ORDER BY mDate ASC;	-- 오름차순
SELECT * FROM usertbl ORDER BY mDate DESC;	-- 내림차순

-- 기분을 2가지 이상 사용하는 경우 
SELECT * FROM usertbl ORDER BY addr ASC, height desc; 

-- 주의사항 : 데이터베이스의 갯수가 많을 경우 성능을 떨어뜨릴 소지가 있음.

-- distinct : 종복 제거하기 
SELECT addr FROM usertbl order by addr; 
SELECT DISTINCT addr FROM usertbl; 
SELECT DISTINCT addr FROM usertbl order by addr; 

-- limit : 출력 개수를 제한하기
use employyes;
SELECT * FROM employees ORDER BY hire_date ASC;

-- 입사일이 최고 오래된 5명만 조회하고 싶다. 
SELECT * FROM employees ORDER BY hire_date ASC LIMIT 5;

-- LIMIT 시작인덱스, 개수 
-- 6-10까지 
SELECT * FROM employees ORDER BY hire_date ASC LIMIT 5,5;
-- 10-5까지 
SELECT * FROM employees ORDER BY hire_date ASC LIMIT 10,5;
-- LIMIT 개수 OFFSET 시작위치
SELECT * FROM employees ORDER BY hire_date ASC LIMIT 5 OFFSET 10;


-- 테이블 복사하기 
-- CREATE TABLE 새로운테이블명 (SELECT 복사할 열 FROM 복사할 테이블)
use sqldb;

-- 전제 열 복제하기
CREATE TABLE buytbl2 (SELECT * FROM buytbl);
SELECT * From buytbl2;

-- 테이블 복사한 경우 PK,FK 등의 제약조건은 복사되지 않는다. 
DESC buytbl;
DESC buytbl2;

-- 일부 컬럼만 복제하기
CREATE TABLE buytbl3 (SELECT prodNAME FROM buytbl);
SELECT * From buytbl3;

-- GROUP BY : 그룹으로 묶는 역할, 집계함수와 같이 사용 
SELECT userID, amount FROM buytbl ORDER BY userID;
SELECT userID, SUM(amount) FROM buytbl GROUP BY userID;

-- 집계함수 sum(), min(). max(), avg(), conut()
-- 평균
SELECT AVG(amount) FROM buytbl;
SELECT userID, AVG(amount) FROM buytbl GROUP BY userID;

-- 가장 키가 큰 사람과 가장 키가 작은 사람 키와 이름 구하기 
SELECT MAX(height) FROM usertbl;	-- 가장 큰 키 구하기 
SELECT name, MAX(height) FROM usertbl GROUP BY name;
-- 조건절에 서브쿼리를 추가하여 최대값과 사람이름을 구하기
SELECT name, height FROM usertbl WHERE height = (SELECT MAX(height) FROM usertbl);
SELECT name, height FROM usertbl WHERE height = (SELECT MIN(height) FROM usertbl);


-- count 숫자세기
SELECT * FROM usertbl;
-- 전체회원의 수 : 10
SELECT count(*) FROM usertbl;
-- 휴대폰 정보가 등록된 회원의 수 : 8 -> null은 count에서 제외 
SELECT count(mobile) FROM usertbl;

-- having : group by와 함께 사용하는 조건절
-- group by로 나온 집계함수에 조건절 필텨링이 가능핟. 
-- 사용자별 총구매액 (가격*구매양)
SELECT userID, sum(price*amount) from buytbl GROUP BY userID;
SELECT userID, sum(price*amount) from buytbl GROUP BY userID HAVING sum(price*amount) > 300;
-- 집계함수 기준 정렬 order by 사용가능
SELECT userID, sum(price*amount) from buytbl GROUP BY userID HAVING sum(price*amount) > 300 ORDER BY sum(price*amount) DESC;


