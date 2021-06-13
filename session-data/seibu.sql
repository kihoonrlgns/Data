--- Seibu session ---
CREATE TABLE k_seibu_session_201912 AS
SELECT wifi_id, shop_id, area, dwell_time, date, time, hour, country, row_number() over () as r_no
    FROM (SELECT wifi_id, shop_id, area, dwell_time, ts,
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),1,10) AS date,
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,8) AS time,
        substr(from_unixtime(CAST(ts / 1000 + 32400 as BIGINT), 'yyyy-MM-dd HH:mm:ss'),12,2) AS hour, country
        FROM wifi_sessions
        WHERE ((key >= '100:') and (key < '103:x'))
        AND shop_id in (100,101,102,103) 
        AND area in ('out')
        AND deny is NULL
        AND local = false) A
        WHERE date >= '2019-12-01'
        AND date <= '2019-12-31';
        
		
SELECT wifi_id, shop_id, dwell_time, date, time, country
FROM k_seibu_session_201912
GROUP BY wifi_id, shop_id, dwell_time, date, time, country;


CREATE TABLE k_seibu_session_201912 AS
SELECT *
FROM k_seibu_session_201912_1
UNION ALL
SELECT *
FROM k_seibu_session_201912_2
UNION ALL
SELECT *
FROM k_seibu_session_201912_3
UNION ALL
SELECT *
FROM k_seibu_session_201912_4
UNION ALL
SELECT *
FROM k_seibu_session_201912_5
UNION ALL
SELECT *
FROM k_seibu_session_201912_6
UNION ALL
SELECT *
FROM k_seibu_session_201912_7