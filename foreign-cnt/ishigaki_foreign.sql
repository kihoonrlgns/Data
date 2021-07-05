-- Ishigaki Foreign Table ---

CREATE TABLE kevin_ishigaki_foreign_201812 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, regexp_replace(country, ",.*$", "") as country
, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time, country
		FROM wifi_sessions
		WHERE ((key >= '2535:') and (key < '2539:x'))
		AND deny is NULL
		AND local = false
		AND area = 'out'
		AND dwell_time > 0
		AND shop_id in (2535,2536,2537,2538,2539)
		AND country is not NULL) A
	WHERE area not in 
	('in', 'hidden')
	AND date >= '2018-10-15'
	AND date <= '2018-12-14';

SELECT shop_id, date, area, country, count(distinct(wifi_id)) cnt
FROM kevin_ishigaki_foreign_201812
GROUP BY shop_id, date, area, country;