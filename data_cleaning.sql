-- Remove NULL values
DELETE FROM marketing_logs
WHERE user_id IS NULL OR channel IS NULL;

-- Create cleaned data table
CREATE TABLE cleaned_logs AS
SELECT DISTINCT *
FROM marketing_logs;

-- Create customer journey table
CREATE TABLE journey_table AS
SELECT
    user_id,
    channel,
    touchpoint_date,
    conversion,
    revenue,
    ROW_NUMBER() OVER (
        PARTITION BY user_id
        ORDER BY touchpoint_date
    ) AS step_no
FROM cleaned_logs;
