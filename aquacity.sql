CREATE TABLE kevin_aquacity202103_out AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '2421:') and (key < '2421:x'))
		AND deny is NULL
		AND local = false
		AND shop_id in (2421)) A
        WHERE area = 'out'
	AND date >= '2021-03-01'
	AND date <= '2021-03-31';
	
SELECT shop_id, date, time, wifi_id, area, country, dwell_time
FROM kevin_aquacity202103_out