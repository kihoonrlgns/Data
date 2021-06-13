--- Yomiuri Table 201907 (No Deny) ---
DROP TABLE kevin_yomiuri_201907_not_null;

CREATE TABLE kevin_yomiuri_202005 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '04:') and (key < '04:x'))
		AND local = false
		AND shop_id in (04)) A
	WHERE area in ('in')
	AND date >= '2020-01-01'
	AND date <= '2020-05-31';
	
 
SELECT wifi_id, shop_id, area, dwell_time, date, time, country
FROM kevin_yomiuri_202005



CREATE TABLE kevin_yomiuri_201907 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '04:') and (key < '04:x'))
		AND deny is NULL
		AND local = false
		AND shop_id in (04)) A
	WHERE area not in 
	('sky','out','aurora','east')
	AND date >= '2019-04-01'
	AND date <= '2019-06-30';
	
	
SELECT wifi_id, shop_id, area, dwell_time, date, time, country
FROM kevin_yomiuri_201907
WHERE r_no < 1000000