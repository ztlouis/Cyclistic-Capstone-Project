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
Firstly I obtained the datasets of the latest 12 months (Jun 24 - May 25) from [this link](https://divvy-tripdata.s3.amazonaws.com/index.html). 

Note: As Cyclistic is a fictional company, this data comes from a public dataset made available by Motivate International Inc. under [this license](https://divvybikes.com/data-license-agreement).

Due to data-privacy issues, we will not have access to riders' personally identifiable information, meaning we wil not be able to determine if the same individual has purchased multiple single passes, nor will we be able to identify whether the users live in the general servicable area of our Cyclistic bikes.

The data provided is ROCCC:

R – Reliable: comes from a reputable company \
O – Objective: it is objective data collected from users usage habits \
C – Comparable: we are able to compare the data over the different months \
C – Clear: each field in the dataset is well labeled and unambiguous \
C – Current: the datasets are the latest 12 months of available data

I analysed the data provided, the following are the fields and their data type, along with their function and what i found interesting about the data:

| Field Name | Data Type | Function | Observations (if applicable)|
| --- | :---:  |   ---  |    --- | 
| ride_id | string  |   assigns each ride with an id  |   each ride id is unique with 16 alphanumeric characters  | 
| rideable_type | string  |  3 options of bike: classic bike, electric bike, electric scooter  |  none   | 
| started_at |  timestamp |   start time of ride  | none   | 
| ended_at | timestamp  |   end time of ride  |   none | 
|start_station_name  |  string |  name of bike station that the trip started from   |   none | 
| start_station_id |  string |   id of start bike station  |  does not follow a fixed format, some are numeric while others are alphanumeric for example | 
| end_station_name | string  |  name of bike station that the trip ended at |  none   | 
| end_station_id |  string |   id of end bike station  | same observation as start_station_id    | 
| start_lat |  float |  latitude of start station   |  rounding of latitude is not standardised, some are to 2 decimal places while others go up to 7 decimal places  | 
| start_lng | float  |   longitude of start station  |  same issue as start_lat   | 
| end_lat | float  | latitude of end station    |  same issue as start_lat   | 
| end_lng |  float |   longitude of end station  |   same issue as start_lat  | 
| member_casual |  string |  differentiates members from casual riders   |  none   | 


### Process
I noticed that there were a total of more than 5 millions rows of data over the 12 datasets, and decided to combine and analyse them using Google Bigquery. 

I combined the 12 datasets into one and added a 'year-month' column to keep track of the origin of each data point.

```sql
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

```

I also added the columns ride_length and dayOfWeek, which lists ride length in seconds and day of week of the ride respectively. These are useful fields that are easy to derive and are not included in the given dataset.

```sql
create or replace table cyclistic-dataset-work.cyclistic_data.overall_table as
select *,
timestamp_diff(ended_at, started_at, second) as ride_length,
format_timestamp('%A',started_at) as dayOfWeek
from cyclistic-dataset-work.cyclistic_data.overall_table

```
Next, I checked for duplicate any duplicates in ride_id, which was supposed to be unique for each ride. I found that all entries in the ride_id column was indeed unique.
```sql
SELECT ride_id,
count(*)
FROM `cyclistic-dataset-work.cyclistic_data.overall_table`
group by ride_id
having count(*) > 1
```

I also ensured that ride length was positive, removing any rows with nonpositive ride length.
```sql
create or replace table cyclistic-dataset-work.cyclistic_data.overall_table as
SELECT *
FROM `cyclistic-dataset-work.cyclistic_data.overall_table`
where ride_length > 0

```



Although there was a substantial number of rows which was missing station data (such as start_station_id and start_station_name), I decided to keep the data as they were still able to serve as data points for our analysis of other aspects such as ride length and overall number of users.


### Analyse
To analyse our data, I used both SQL and Tableau.

First I checked for the total number of rides of botht casual riders and members, as well as their average ride times (in minutes).

```sql
SELECT 
member_casual, 
round(avg(ride_length)/60,2) as avg_ride_length_mins, 
count(*) as number_of_rides 
FROM cyclistic-dataset-work.cyclistic_data.overall_table 
group by member_casual
```


Result: 

<img width="507" height="80" alt="image" src="https://github.com/user-attachments/assets/d9d0198a-4a25-419e-ad63-9883efe658a8" />

From the table above, we see that members take more rides than casual riders, however the average length of each ride is significantly shorter than that of casual riders.

I plotted a histogram with bins of 2 minute intervals for ride length. 

<img width="1463" height="724" alt="image" src="https://github.com/user-attachments/assets/f68e76a2-9820-468a-9668-dbaeeca023b6" />
It is interesting that our histogram shows most of our rides are actually less than 10 minutes for both casual riders and members.

This suggests that our data is right-skewed, a small number of riders with long ride lengths are bringing up the average. In fact, from the slider below, you can see that it is very skewed, with ride lengths stretching all the way to multiple hours. 

One reason could be that members can start a ride anytime at no additional cost, but for casual riders, they might try to save on rental fees by purchasing a single-ride pass instead of a full-day pass, yet use the bike for a whole day, assuming that single-ride passes are cheaper than full-day passes. However, without information on the type of pass for each trip, we cannot be sure.

Next, we plotted the number of rides for each month, split into casual riders and members.


<img width="1454" height="715" alt="image" src="https://github.com/user-attachments/assets/a74129b0-595e-4044-8801-ed8983ba7686" />

We observe two things:
1) Members consistently take more rides than casual riders, which is expected since we already know that number of rides by members is higher from our previous query
2) The overall trend of rides is the same for both casual riders and members, suggesting a factor that effects all riders equally. One such factor might be the changing seasons. Rides peak around July to September where it is warm, and bottom out in December to February, which is during winter.

---

Next we will look at day of week

Number of Rides by Day of Week
<img width="1460" height="727" alt="image" src="https://github.com/user-attachments/assets/07683d03-62fe-485e-b060-30f2dd427827" />

Median Trip Length by Day of Week
<img width="1463" height="724" alt="image" src="https://github.com/user-attachments/assets/b44f72a5-8ab5-4da7-bf09-3146ccbac5d6" />

From the 2 graphs above, we can see that there are more rides by members during weekdays while rides by casual riders peak in the weekends. 
Additionally, ride length for casual riders peak during weekends while that of members remains stable throughout the week. To mitigate the problem


### Share
After analysing our data, I have compiled it into a tableau dashboard to explain our findings to our stakeholders. 

<img width="1434" height="803" alt="image" src="https://github.com/user-attachments/assets/a2718ea3-f565-44cf-9407-9cb933dacca9" />

To summarise our findings, the number of rides taken by both members and casual riders are heavily influenced by the changing season, with warmer months seeing more rides taken. 
Overall, most rides are under 30 minutes, with a relatively small number of riders with hours of ride time per trip.
Our target group, casual riders, tend to take more rides during weekends. These rides also tend to be longer than those taken during the weekdays.

### Act
Based on these findings, here are what I would recommend:
1) Introduce more types of Membership plans. Instead of only an annual membership, introduce weekend and seasonal memberships since that is when most casual riders use our bikes. This will encourage them to sign up for membership as our current annual membership may be too much of a commitment for them.
2) Benefits for new members. Improve sign up bonuses for new members, such as free single-ride passes. This will incentivise casual riders who frequently use our bikes to sign up for membership.
3) Set up a points system to reward long time members. They accumulate points based on how long they remain as a member, which can then be redeemed for rewards. This would encourage casual riders to sign up for membership and maintain it.


## Conclusion
To summarise, our datasets provided key insights on the usage patterns of our Cyclistic bikes. Although more insight could be derived should we have had more data to link users with the rides that they made, the current data is sufficient to analyse overall usage patterns of all users and we are able to come to a conclusion on how to best convert current casual riders into members.
