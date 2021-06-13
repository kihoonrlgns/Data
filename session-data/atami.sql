--- Atami Table ---
DROP TABLE kevin_atami_20200331;

CREATE TABLE kevin_atami_20200331 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '3287:') and (key < '3306:x'))
		AND deny is NULL
		AND local = false
		AND shop_id in (3287,3288,3289,3290,3291,3292,3293,3294,3295,3296,3297,3298,3299,3300,3301,3302,3303,3304,3306)) A
	WHERE area not in ('hidden')
	AND date >= '2020-02-22'
	AND date <= '2020-03-31';
	
SELECT wifi_id, shop_id, area, date, time, dwell_time
FROM kevin_atami_20200331