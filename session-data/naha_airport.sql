--- Naha Airport Table ---
--DROP TABLE k_naha_201908;

CREATE TABLE k_naha_202002 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '3:') and (key < '3:x'))
		AND deny is NULL
		AND local = false
		AND shop_id in (3)) A
	WHERE area not in 
	('in','out')
	AND date >= '2019-11-15'
	AND date <= '2020-02-14';
	
SELECT wifi_id, shop_id, area, dwell_time, date, time
FROM k_naha_202002
WHERE r_no < 1000000

SELECT wifi_id, shop_id, area, dwell_time, date, time 
FROM k_naha_202002
WHERE r_no >= 1000000 AND r_no < 2000000

SELECT wifi_id, shop_id, area, dwell_time, date, time 
FROM k_naha_202002
WHERE r_no >= 2000000 AND r_no < 3000000

SELECT wifi_id, shop_id, area, dwell_time, date, time 
FROM k_naha_202002
WHERE r_no >= 3000000 AND r_no < 4000000
