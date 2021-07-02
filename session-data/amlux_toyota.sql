--- Amlux Toyota Table ---
DROP TABLE kevin_toyota_201904;

CREATE TABLE kevin_toyota_201904_08 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '2021:') and (key < '2023:x'))
		AND deny is NULL
		AND local = false
		AND shop_id in (2021,2022,2023)) A
	WHERE area not in 
	('out', 'hidden', 'CAR_LINEUP', 'SPORT', 'WELL_CAB', 'ENT_ZEPP', 'GR', 'GLOBAL_DISCOV', 'ENT_MALL', 'HG_1F', 'HG_2F')
	AND date >= '2019-04-01'
	AND date <= '2019-08-31';
	
SELECT wifi_id, shop_id, area, dwell_time, date, time, country
FROM kevin_toyota_201904_08
WHERE r_no < 1000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_toyota_201904_08 
WHERE r_no >= 1000000 AND r_no < 2000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_toyota_201904_08 
WHERE r_no >= 2000000 AND r_no < 3000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_toyota_201904_08 
WHERE r_no >= 3000000 AND r_no < 4000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_toyota_201904_08 
WHERE r_no >= 4000000 AND r_no < 5000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_toyota_201904_08 
WHERE r_no >= 5000000 AND r_no < 6000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_toyota_201904_08 
WHERE r_no >= 6000000 AND r_no < 7000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_toyota_201904_08 
WHERE r_no >= 7000000 AND r_no < 8000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_toyota_201904_08 
WHERE r_no >= 8000000 AND r_no < 9000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_toyota_201904_08 
WHERE r_no >= 9000000 AND r_no < 10000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_toyota_201904_08 
WHERE r_no >= 10000000 AND r_no < 11000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_toyota_201904_08 
WHERE r_no >= 11000000 AND r_no < 12000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_toyota_201904_08 
WHERE r_no >= 12000000 AND r_no < 13000000


