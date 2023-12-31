CREATE TABLE norm_joined AS
SELECT 
    title,
    year,
    month,
    genres,
    duration,
    countries,
    rating,
    votes,
    budget,
    boxoffice,
    currency,
    exchange_rate,
    budget * exchange_rate AS norm_budget,
    boxoffice * exchange_rate AS norm_boxoffice,
    CASE 
        WHEN (budget * exchange_rate) != 0 THEN (boxoffice * exchange_rate) / (budget * exchange_rate)
        ELSE NULL 
    END AS boxoffice_return
FROM 
    joined;

INSERT OVERWRITE DIRECTORY 'hdfs://nyu-dataproc-m/user/rz2123_nyu_edu/project/data/joined_data' 
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
SELECT * FROM norm_joined;
