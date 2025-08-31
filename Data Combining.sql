--combine the 12 monthly datasets into one, with an additional 'year_month' column to identify the original datasets that the data entries originated from

create or replace table cyclistic-dataset-work.cyclistic_data.overall_table as
select *,'2024-06' as year_month from cyclistic-dataset-work.cyclistic_data.June24
union all
select *,'2024-07' as year_month from cyclistic-dataset-work.cyclistic_data.July24
union all
select *,'2024-08' as year_month from cyclistic-dataset-work.cyclistic_data.Aug24
union all
select *,'2024-09' as year_month from cyclistic-dataset-work.cyclistic_data.Sep24
union all
select *,'2024-10' as year_month from cyclistic-dataset-work.cyclistic_data.Oct24
union all
select *,'2024-11' as year_month from cyclistic-dataset-work.cyclistic_data.Nov24
union all
select *,'2024-12' as year_month from cyclistic-dataset-work.cyclistic_data.Dec24
union all
select *,'2025-01' as year_month from cyclistic-dataset-work.cyclistic_data.Jan25
union all
select *,'2025-02' as year_month from cyclistic-dataset-work.cyclistic_data.Feb25
union all
select *,'2025-03' as year_month from cyclistic-dataset-work.cyclistic_data.Mar25
union all
select *,'2025-04' as year_month from cyclistic-dataset-work.cyclistic_data.Apr25
union all
select *,'2025-05' as year_month from cyclistic-dataset-work.cyclistic_data.May25
order by started_at;
