WITH
  sub AS (
  SELECT
    user_pseudo_id,
    subscription_start,
    subscription_end,
    DATE_DIFF(subscription_end, subscription_start, WEEK) AS Sub_lenght_weeks,
    DATE_TRUNC(subscription_start, WEEK) start_week_date
  FROM
    `tc-da-1.turing_data_analytics.subscriptions`)

SELECT
  sub.start_week_date,
  (SELECT COUNT(user_pseudo_id), FROM sub s WHERE sub.start_week_date = s.start_week_date) AS num_at_start,
  w1.week_1,
  w2.week_2,
  w3.week_3,
  w4.week_4,
  w5.week_5,
  w6.week_6
FROM
  sub
FULL JOIN
  (SELECT start_week_date, COUNT(user_pseudo_id) week_1
    FROM sub
    WHERE (Sub_lenght_weeks > 0 OR Sub_lenght_weeks IS NULL)
    GROUP BY start_week_date limit 13) as w1
ON w1.start_week_date = sub.start_week_date

FULL JOIN
  (SELECT start_week_date, COUNT(user_pseudo_id) week_2
    FROM sub
    WHERE (Sub_lenght_weeks > 1 OR Sub_lenght_weeks IS NULL)
    GROUP BY start_week_date limit 12) as w2
ON w2.start_week_date = sub.start_week_date

FULL JOIN
  (SELECT start_week_date, COUNT(user_pseudo_id) week_3
    FROM sub
    WHERE (Sub_lenght_weeks > 2 OR Sub_lenght_weeks IS NULL)
    GROUP BY start_week_date limit 11) as w3
ON w3.start_week_date = sub.start_week_date

FULL JOIN
  (SELECT start_week_date, COUNT(user_pseudo_id) week_4
    FROM sub
    WHERE (Sub_lenght_weeks > 3 OR Sub_lenght_weeks IS NULL)
    GROUP BY start_week_date limit 10) as w4
ON w4.start_week_date = sub.start_week_date

FULL JOIN
  (SELECT start_week_date, COUNT(user_pseudo_id) week_5
    FROM sub
    WHERE (Sub_lenght_weeks > 4 OR Sub_lenght_weeks IS NULL)
    GROUP BY start_week_date limit 9) as w5
ON w5.start_week_date = sub.start_week_date

FULL JOIN
  (SELECT start_week_date, COUNT(user_pseudo_id) week_6
    FROM sub
    WHERE (Sub_lenght_weeks > 5 OR Sub_lenght_weeks IS NULL)
    GROUP BY start_week_date limit 8) as w6
ON w6.start_week_date = sub.start_week_date

GROUP BY
  sub.start_week_date,w1.week_1, w2.week_2, w3.week_3, w4.week_4,w5.week_5, w6.week_6
ORDER BY sub.start_week_date