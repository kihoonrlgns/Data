CREATE TABLE kevin_vr_foreign_201811 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, regexp_replace(country, ",.*$", "") as country
, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time, country
		FROM wifi_sessions
		WHERE ((key >= '2025:') and (key < '2482:x'))
		AND deny is NULL
		AND local = false
		AND area not in ('in', 'out', 'VR-in')
		AND dwell_time > 0
		AND shop_id in (2025,2482)
		AND country is not NULL) A
	WHERE date >= '2018-10-20'
	AND date <= '2018-10-31';

SELECT shop_id, date, area, country, count(distinct(wifi_id)) cnt
FROM kevin_vr_foreign_201811
GROUP BY shop_id, date, area, country;