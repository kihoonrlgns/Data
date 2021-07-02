-- Okazaki Table --
DROP TABLE kevin_okazaki_201904;

CREATE TABLE kevin_okazaki_201904 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '2711:') and (key < '2716:x'))
		AND deny is NULL
		AND local = false
		AND shop_id in (2711,2712,2713,2714,2715,2716)) A
	WHERE area not in 
	('out')
	AND date >= '2019-02-01'
	AND date <= '2019-03-31';
	
SELECT wifi_id, shop_id, area, dwell_time, date, time, country
FROM kevin_okazaki_201904
WHERE r_no < 1000000
