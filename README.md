# Cyclistic-Capstone-Project
Capstone project of Google Data Analytics course on Coursera

I have recently completed the Google Data Analytics course on Coursera as one of my first experiences with Data Analytics, and I will be showcasing what I have learnt in the form of a capstone project.
We will be working on a problem for Cyclistic, a fictional bike sharing company based in Chicago. 

## Background of Cyclistic
Cyclistic is a fictional bike sharing company based in Chicago. They have a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use the bikes to commute to work each day. \
[Note: The datasets used in this case study are made available by Motivate International Inc. under [this license](https://divvybikes.com/data-license-agreement).]

Cyclistic's current market strategy relies on building general awareness and appealing to broad customer segments. To do this, they have flexible pricing plans: single-ride passes, full-day passes, and annual memberships.
Customers who purchase single-ride or full-day passes are referred to as casual riders, while those who purchase annual memberships are Cyclistic members.

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers,
management believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, they believe there is a solid opportunity to convert casual riders into members. 


## Scenario
I play the role of a junior data analyst working on the marketing analyst team at Cyclistic. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, the team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, we will design a new marketing strategy to convert casual riders into annual members. My recommendations will be subject to approval by Cyclistic executives, so they must be backed up with compelling data insights and professional data visualizations.


### Ask
The question I will be working on is 'How do annual members and casual riders use Cyclistic bikes differently?' \
I will be analysing data from the past 12 months and identify trends and insights to find out how annual members and casual riders differ in their use of Cyclistic's bikes


### Prepare
Firstly I obtained the datasets of the latest 12 months (Jun 24 - May 25) from [this link](https://divvy-tripdata.s3.amazonaws.com/index.html). \


As Cyclistic is a fictional company, this data comes from a public dataset made available by Motivate International Inc. under [this license](https://divvybikes.com/data-license-agreement).] Due to data-privacy issues, we will not have access to riders' personally identifiable information, meaning we wil not be able to determine if the same individual has purchased multiple single passes, nor will we be able to identify whether the users live in the general servicable area of our Cyclistic bikes.

After downloading the 12 monthly datasets, I noticed that there were a total of more than 5 millions rows of data over the 12 datasets, and decided to combine them and analyse using Google Bigquery. 

> create or replace table cyclistic-dataset-work.cyclistic_data.overall_table as \
select *,'2024-06' as year_month from cyclistic-dataset-work.cyclistic_data.June24 \
union all \
select *,'2024-07' as year_month from cyclistic-dataset-work.cyclistic_data.July24 \
union all \
select *,'2024-08' as year_month from cyclistic-dataset-work.cyclistic_data.Aug24 \
union all \
select *,'2024-09' as year_month from cyclistic-dataset-work.cyclistic_data.Sep24 \
union all \
select *,'2024-10' as year_month from cyclistic-dataset-work.cyclistic_data.Oct24 \
union all \
select *,'2024-11' as year_month from cyclistic-dataset-work.cyclistic_data.Nov24 \
union all \
select *,'2024-12' as year_month from cyclistic-dataset-work.cyclistic_data.Dec24 \
union all \
select *,'2025-01' as year_month from cyclistic-dataset-work.cyclistic_data.Jan25 \
union all \
select *,'2025-02' as year_month from cyclistic-dataset-work.cyclistic_data.Feb25 \
union all \
select *,'2025-03' as year_month from cyclistic-dataset-work.cyclistic_data.Mar25 \
union all \
select *,'2025-04' as year_month from cyclistic-dataset-work.cyclistic_data.Apr25 \
union all \
> select *,'2025-05' as year_month from cyclistic-dataset-work.cyclistic_data.May25 \
order by started_at;

idea: add code in separate file (runable .sql file) and link it here?


