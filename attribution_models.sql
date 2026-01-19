-- First Touch Attribution
SELECT
    channel,
    SUM(revenue) AS first_touch_revenue
FROM journey_table
WHERE step_no = 1 AND conversion = 1
GROUP BY channel;

-- Last Touch Attribution
SELECT
    channel,
    SUM(revenue) AS last_touch_revenue
FROM journey_table jt
WHERE step_no = (
    SELECT MAX(step_no)
    FROM journey_table
    WHERE user_id = jt.user_id
)
AND conversion = 1
GROUP BY channel;

-- Linear Attribution
CREATE TABLE linear_touch AS
SELECT
    channel,
    SUM(revenue / total_steps) AS linear_revenue
FROM (
    SELECT
        user_id,
        channel,
        revenue,
        COUNT(*) OVER (PARTITION BY user_id) AS total_steps
    FROM journey_table
    WHERE conversion = 1
) t
GROUP BY channel;
