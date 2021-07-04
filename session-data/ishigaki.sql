-- Ishigaki Table 201903 ---
CREATE TABLE kevin_ishigaki_201903 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '2535:') and (key < '2539:x'))
		AND deny is NULL
		AND local = false
		AND shop_id in (2535,2536,2537,2538,2539)) A
	WHERE area not in 
	('hidden','in')
	AND date >= '2018-10-15'
	AND date <= '2019-02-14';
	
SELECT wifi_id, shop_id, area, dwell_time, date, time, country
FROM kevin_ishigaki_201903