-- Channel ROI Calculation
SELECT
    l.channel,
    l.linear_revenue,
    c.cost,
    (l.linear_revenue - c.cost) / c.cost AS ROI
FROM linear_touch l
JOIN channel_cost c
ON l.channel = c.channel;
