-- Mylord Table 201901 ---
CREATE TABLE kevin_mylord_201901 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '2512:') and (key < '2512:x'))
		AND deny is NULL
		AND local = false
		AND shop_id in (2512)) A
	WHERE area not in 
	('hidden', 'in')
	AND date >= '2018-09-11'
	AND date <= '2019-01-14';
	
SELECT wifi_id, shop_id, area, dwell_time, date, time, country
FROM kevin_mylord_201901
WHERE r_no < 1000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_mylord_201901 
WHERE r_no >= 1000000 AND r_no < 2000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_mylord_201901 
WHERE r_no >= 2000000 AND r_no < 3000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_mylord_201901 
WHERE r_no >= 3000000 AND r_no < 4000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_mylord_201901 
WHERE r_no >= 4000000 AND r_no < 5000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_mylord_201901 
WHERE r_no >= 5000000 AND r_no < 6000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_mylord_201901 
WHERE r_no >= 6000000 AND r_no < 7000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_mylord_201901 
WHERE r_no >= 7000000 AND r_no < 8000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_mylord_201901 
WHERE r_no >= 8000000 AND r_no < 9000000
