-- 변수 사용하기
-- SET @변수이름 = 변수의 값; 	변수 선언

-- 변수 확인
-- SELECT @변수이름; 			변수 확인 

set @myVar1 = 10;
set @myVar2 = 5;
set @myVar3 = 3.14;
set @myVar4 = '이름->';

SELECT @myVar1;
SELECT @myVar1 + @myVar2;

use sqldb;
SELECT @myVar4, name FROM usertbl;

SELECT concat(@myVar4, '안녕하세요');


-- 데이터 타입 변환 함수
use sqldb;

-- cast, convert
-- 평균 구매 개수 
SELECT avg(amount) as 평균구매개수 from buytbl;

-- 정수로 타입 변환
-- cast(표현식 as 데이터 타입)
-- convert (표현식, 데이터타입)
-- unsigned : 부호x, 0~255 / signed : 부호o, -128~127
SELECT cast(avg(amount) as SIGNED INTEGER) as 평균구매개수 FROM buytbl;
SELECT convert(avg(amount), SIGNED INTEGER) as 평균구매개수 FROM buytbl;

SELECT cast('2023-12-13' as date);
SELECT cast('2023.12.13' as date);
SELECT cast('2023@12@13' as date);
SELECT cast('2023$12$13' as date);

-- 숫자 데이터를 문자 데이터로 변환하여 연결한 예시 (명시적)
desc buytbl;
SELECT concat(cast(price as char(10)), "*", cast(amount as char(10)), "=") as '단가*수량', price * amount from buytbl;

-- 암시적인 타입 변환
SELECT '100' + '200';			-- 정수로 암시적 형변환되어 연산
SELECT concat('100', '200');	-- 문자열 연결
select concat(100, '200'); 		-- 정수가 문자열로 암시적 형변환되어 연결 
select 1 > '2mega'; 			-- 문자열이 정수 2로 변환되어 비교
SELECT 3 > '2mega';				-- 문자열이 정수 2로 변환되어 비교 
SELECT 0 = 'mega';				-- 문자열은 비교시 0으로 변환됨

-- 내장함수 
-- 제어흐름 함수 
-- if(수식, 참일때, 거짓일때)
SELECT if(100>200, '참', '거짓');
SELECT if(100<200, '참', '거짓');

-- ifnull(수식1, 수식2) : 수식1이 null이 아니면 수식1, null이면 수식2를 리턴.
SELECT ifnull(null, "널 임다");
SELECT ifnull("널 아입니다", "널 임다");

-- nullif(수식1, 수식2) : 두 수식이 같으면 null, 다르면 수식1을 리턴
SELECT nullif(100, 100);
SELECT nullif(100, 200);

-- CASE 문 ~ WHEN ~ THEN
SELECT CASE 5
	WHEN 1 THEN '일'
    WHEN 10 THEN '십'
    ELSE '모르는 수'
END AS "CASE";