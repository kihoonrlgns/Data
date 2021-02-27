--- Isehara Table ---
DROP TABLE kevin_isehara_202012;

CREATE TABLE kevin_isehara_202102 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '3400:') and (key < '3409:x'))
		AND deny is NULL
		AND local = false
		AND shop_id in (3400,3401,3402,3403,3407,3408,3409)) A
	WHERE area in ('in')
	AND date >= '2020-12-26'
	AND date <= '2021-02-15';
	
SELECT wifi_id, shop_id, area, dwell_time, date, time, country
FROM kevin_isehara_202102
GROUP BY wifi_id, shop_id, area, dwell_time, date, time, country;

SELECT shop_id, date, count(DISTINCT wifi_id) cnt
FROM kevin_isehara_202102
GROUP BY shop_id, date