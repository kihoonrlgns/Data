--- Zama Table ---
DROP TABLE kevin_zama_201912;

CREATE TABLE kevin_zama_201912 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '3148:') and (key < '3149:x'))
		AND deny is NULL
		AND local = false
		AND shop_id in (3148,3149)) A
	WHERE area not in 
	('out')
	AND date >= '2019-11-01'
	AND date <= '2019-11-30';
	
SELECT wifi_id, shop_id, area, dwell_time, date, time, country
FROM kevin_zama_201912