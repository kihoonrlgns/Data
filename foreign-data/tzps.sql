--- Tzps Table ---

--DROP TABLE k_tzps_foreign_202006;

CREATE TABLE k_tzps_foreign_202101 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, regexp_replace(country, ",.*$", "") as country, row_number() over () as r_no
    FROM (
        SELECT wifi_id, shop_id, area, dwell_time, ts,
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time, 
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
        FROM wifi_sessions
        WHERE ((key >= '1:') and (key < '4:x'))
        AND shop_id in (1,2,3,4)
        AND deny is NULL
        AND area in ('in')
        AND country is not NULL
        AND dwell_time > 0
        AND local = false) A
    	WHERE date >= '2021-01-01'
	    AND date <= '2021-01-31';

SELECT shop_id, date, time, wifi_id, country, dwell_time
FROM k_tzps_foreign_202101
WHERE time BETWEEN '09:30:00' AND '17:00:00'
GROUP BY shop_id, date, time, wifi_id, country, dwell_time;

SELECT shop_id, date, country, count(distinct(wifi_id)) cnt
FROM k_tzps_foreign_202101
WHERE time BETWEEN '09:30:00' AND '17:00:00'
AND country not in ('ZM')
GROUP BY shop_id, date, country;
--ORDER BY shop_id ASC, date ASC, cnt DESC;

SELECT shop_id, date, country, count(distinct(wifi_id)) cnt
FROM k_tzps_foreign_202101
WHERE country not in ('ZM')
GROUP BY shop_id, date, country;