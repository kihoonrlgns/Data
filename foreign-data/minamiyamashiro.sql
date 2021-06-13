--- Minamiyamashiro Foreign ---
CREATE TABLE kevin_minamiyamashiro_foreign_20210228 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, regexp_replace(country, ",.*$", "") as country, row_number() over () as r_no
    FROM (
        SELECT wifi_id, shop_id, area, dwell_time, ts,
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time, 
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
        FROM wifi_sessions
        WHERE ((key >= '3:') and (key < '3:x'))
        AND deny is NULL
        AND local = false
        AND country is not NULL
        AND dwell_time > 0
        AND shop_id in (3)) A
        WHERE area in ('in')
    	AND date >= '2020-12-01'
	    AND date <= '2021-02-28';


SELECT shop_id, date, time, wifi_id, area, country, dwell_time
FROM kevin_minamiyamashiro_foreign_20210228
WHERE country != 'ZM'

SELECT shop_id, date, count(DISTINCT(wifi_id)) cnt
FROM kevin_minamiyamashiro_foreign_20210228
WHERE country != 'ZM'
GROUP BY shop_id, date