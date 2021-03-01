--- Isihnomaki Table ---
DROP TABLE kevin_ishinomaki_201908;

CREATE TABLE kevin_ishinomaki_20210228 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '6:') and (key < '10:x'))
		AND deny is NULL
		AND local = false
		AND shop_id in (6,7,8,9,10)) A
	WHERE area not in 
	('hidden')
	AND date >= '2020-09-01'
	AND date <= '2021-02-28';
	
SELECT wifi_id, shop_id, area, dwell_time, date, time, country
FROM kevin_ishinomaki_20210228
GROUP BY wifi_id, shop_id, area, dwell_time, date, time, country;

SELECT wifi_id, shop_id, area, dwell_time, date, time, country
FROM kevin_ishinomaki_201908
WHERE r_no < 1000000

SELECT wifi_id, shop_id, area, dwell_time, date, time, country 
FROM kevin_ishinomaki_201908
WHERE r_no >= 1000000 AND r_no < 2000000