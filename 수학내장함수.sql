-- 수학 내장함수
-- ABS(숫자) : 절대값 
SELECT abs(-30);

-- CEILING(숫자) : 올림
SELECT ceiling(4.7);
SELECT ceiling(4.2);
-- FLOOR(숫자) : 내림
SELECT floor(4.7);
SELECT floor(4.2);
-- ROUND(숫자) : 반올림
SELECT round(4.7);
SELECT round(4.2);

-- CONV(숫자, 원래진수, 변환진수) : 진수 변환
SELECT conv('FE', 16, 10); 	-- 16진수를 10진수로
SELECT conv('FE', 16, 2); 	-- 16진수를 2진수로
SELECT conv('11111110', 2, 8); 	-- 2진수를 8진수로

-- PI() : 원주율 
SELECT PI();

-- MOD(숫자, 나눌 수) : 나머지 구하기
SELECT mod(127, 10), 157 % 10, 157 MOD 10;

-- POW(숫자, 제곱) : 제곱수 구하기
SELECT pow(2, 8); 	-- 2의 8승
-- SQRT(숫자) : 제곱근 구하기
SELECT sqrt(16); 	-- 16의 루트

-- RAND() : 랜덤한 숫자 구하기 0-1 미만의 실수
SELECT rand(), rand()*6, floor(rand()*6)+1;



-- 날짜 및 시간 함수

-- ADDDATE(날짜, 차이) : 더한 날짜 구하기
SELECT adddate('2023-12-20', interval 31 DAY);
SELECT adddate('2023-12-20', interval 2 month);
-- SUBDATE(날짜, 차이) : 뺀 날짜 구하기
SELECT subdate('2023-12-20', interval 31 DAY);
SELECT subdate('2023-12-20', interval 2 month);

-- ADDTIME(날짜/시간, 시간) : 더한 시간 구하기
SELECT addtime('2023-12-20 23:59:59', '1:1:1');
SELECT addtime('16:00:00', '5:15:30');

-- SUBTIME(날짜/시간, 시간) : 뺀 시간 구하기
SELECT subtime('2023-12-20 23:59:59', '1:1:1');
SELECT subtime('16:00:00', '5:15:30');

-- 현재 시각 구하기
SELECT now(), localtime(), localtimestamp(); 	-- 동일한 현재 날짜/시각 구하기
SELECT curdate(), current_date(), current_date;	-- 동일한 현재 날짜 구하기
SELECT curtime(), current_time(), current_time;	-- 동일한 현재 시각 구하기

-- 날짜에서 연, 월, 일, 시 구하기
SELECT year(now()), month(now()), day(now());
-- 분, 초, 마이크로초 
SELECT minute(now()), second(now()), microsecond(current_timestamp());

-- 날짜, 시간 추출하기
SELECT date(now()), time(now());

-- DATEDIFF(날짜1, 날짜2) : 날자 차이구하기
SELECT datediff('2024-03-18',NOW());
-- TIMEDIFF(시간1, 시간2) : 시간 차이구하기
SELECT timediff('16:30:00', CURTIME());

-- DAYOFWEEK(날짜) : 요일 구하기 (1:일요일 - 7:토요일) 반환
SELECT dayofweek(NOW());

-- LAST_DAY(날짜) : 마지막날 구하기
SELECT LAST_DAY('2024-02-01');

-- MAKETIME(시, 분, 초) : 시간 형식 만들기
SELECT maketime(16, 30, 00);

-- QUARTER(날짜) : 분기 구하기
SELECT quarter(now());