--- Isehara Table ---
CREATE TABLE k_isehara_202102 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
		FROM wifi_sessions
		WHERE ((key >= '1:') and (key < '7:x'))
		AND deny is NULL
		AND local = false
		AND shop_id in (1,2,3,4,5,6,7)) A
	WHERE area in ('in')
	AND date >= '2020-12-26'
	AND date <= '2021-02-15';
	
SELECT wifi_id, shop_id, area, dwell_time, date, time, country
FROM k_isehara_202102
GROUP BY wifi_id, shop_id, area, dwell_time, date, time, country;

SELECT shop_id, date, count(DISTINCT wifi_id) cnt
FROM k_isehara_202102
GROUP BY shop_id, date