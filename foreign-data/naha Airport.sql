--- Naha Airport Foreign Table ---
DROP TABLE kevin_naha_country_201911;

CREATE TABLE kevin_naha_country_202002 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, regexp_replace(country, ",.*$", "") as country, row_number() over () as r_no
    FROM (
        SELECT wifi_id, shop_id, area, dwell_time, ts,
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time, 
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour,
        country
        FROM wifi_sessions
        WHERE ((key >= '30:') and (key < '30:x'))
        AND deny is NULL
        AND local = false
        AND shop_id in (3001)) A
        WHERE area not in ('in','out')
        AND dwell_time > 0
        AND date >= '2019-11-15'
        AND date <= '2020-02-14'; 
        --country is not NULL

SELECT wifi_id, shop_id, area, dwell_time, date, time, country
FROM kevin_naha_country_202002
