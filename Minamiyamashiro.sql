-- Minamiyamashiro Session Table --
CREATE TABLE kevin_minamiyamashiro_sess_20210228 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
    FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
        FROM wifi_sessions
        WHERE ((key >= '196:') and (key < '196:x'))
        AND deny is NULL
        AND local = false
        AND shop_id in (196)) A
    WHERE area in ('in')
    AND date >= '2020-12-01'
    AND date <= '2021-02-28';

SELECT wifi_id, shop_id, date, dwell_time
FROM kevin_minamiyamashiro_sess_20210228

SELECT date, count(DISTINCT(wifi_id)) cnt
FROM (
    SELECT shop_id, wifi_id, date, dwell_time
    FROM kevin_minamiyamashiro_sess_20210228
    WHERE dwell_time = 0
)t
GROUP BY shop_id, date