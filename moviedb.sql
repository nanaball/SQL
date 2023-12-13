CREATE DATABASE moviedb;

use moviedb;
CREATE table movietbl
	(movie_id		int, 
    movie_title		VARCHAR(30),
    movie_director 	VARCHAR(20),
    movie_star 		VARCHAR(20),
    movie_script 	LONGTEXT,
    movie_film		LONGBLOB) DEFAULT CHARSET=utf8mb4;
    
-- 영화 데이터 삽입 : longtext, longblob이 삽입되지 앖음    
INSERT into movietbl VALUES
(1, '쉰들러리스트', '스필버그', '리암 니슨', load_file('C:/Users/admin/Desktop/movies/Schindler.txt'), load_file('C:/Users/admin/Desktop/movies/Schindler.mp4'));

SELECT * FROM movietbl;

-- 시스템 변수 확인하기 
show VARIABLES;
SELECT @@max_allowed_packet; 	-- 최대 허용 패킷 크기 
SELECT @@secure_file_priv; 		-- 허용된 경로 위치

-- 허용된 경로에 파일을 위치시킨 후 삽입
INSERT INTO movietbl VALUES
(1, '쉰들러리스트', '스필버그', '리암 니슨',
 load_file('/var/lib/mysql-files/Schindler.txt'),
 load_file('/var/lib/mysql-files/Schindler.mp4')
 );
INSERT INTO movietbl VALUES
(2, '쇼생크탈출', '프랭크 다라본트', '팀 로빈스',
 load_file('/var/lib/mysql-files/Shawshank.txt'),
 load_file('/var/lib/mysql-files/Shawshank.mp4')
 );
 INSERT INTO movietbl VALUES
(3, '라스트모히칸', '마이클 만', '다니엘',
 load_file('/var/lib/mysql-files/Mohican.txt'),
 load_file('/var/lib/mysql-files/Mohican.mp4')
 );
 select * from movietbl;
 
 -- 파일 내보내기
 SELECT movie_script from movietbl where movie_id=2
	into OUTFILE '/var/lib/mysql-files/out.txt'
    LINES TERMINATED BY '\\n';
    
-- 영상 내보내기
 SELECT movie_film from movietbl where movie_id=3
	into DUMPFILE '/var/lib/mysql-files/out.mp4';