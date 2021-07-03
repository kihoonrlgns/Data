--- Toyosu Table 201907 ---
DROP TABLE kevin_toyosu_201907;

CREATE TABLE kevin_toyosu_20190724 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '2961:') and (key < '2961:x'))
		AND deny is NULL
		AND local = false
		AND shop_id in (2961)) A
	WHERE area not in 
	('out')
	AND date >= '2019-07-24'
	AND date <= '2019-07-24';
	
	
SELECT wifi_id, shop_id, area, dwell_time, date, time, country
FROM kevin_toyosu_20190724
WHERE r_no < 1000000