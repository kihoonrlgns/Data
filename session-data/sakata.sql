-- Sakata Table --
CREATE TABLE kevin_sakata_201910 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '2650:') and (key < '2664:x'))
		AND deny is NULL
		AND local = false
		AND shop_id in (2650,2651,2652,2653,2654,2655,2656,2657,2658,2659,2660,2661,2662,2663,2664)) A
	WHERE area not in 
	('out')
	AND date >= '2019-02-01'
	AND date <= '2019-10-31';
	
SELECT wifi_id, shop_id, area, dwell_time, date, time, country
FROM kevin_sakata_201910