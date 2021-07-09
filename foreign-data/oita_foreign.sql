-- Oita Foreign Table --

CREATE TABLE kevin_oita_foreign_201812 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, regexp_replace(country, ",.*$", "") as country
, row_number() over () as r_no
	FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
		substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time, country
		FROM wifi_sessions
		WHERE ((key >= '2561:') and (key < '2590:x'))
		AND deny is NULL
		AND local = false
		AND area = 'out'
		AND dwell_time > 0
		AND shop_id in (2561,2562,2563,2564,2565,2566,2567,2568,2569,2570,2571,2572,2573,2574,2575,2576,2577,2580,2590)
		AND country is not NULL) A
	WHERE area not in 
	('in')
	AND date >= '2018-11-01'
	AND date <= '2018-11-30';

SELECT shop_id, date, country, count(distinct(wifi_id)) cnt
FROM kevin_oita_foreign_201812
GROUP BY shop_id, date, country;