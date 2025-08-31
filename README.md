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
| rideable_type | string  |  type of bike, classic or electric   |  none   | 
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

All the queries mentioned in this section can be found [here](https://github.com/ztlouis/Cyclistic-Capstone-Project/blob/main/Data%20Combining.sql)

I combined the 12 datasets into one and added a 'year-month' column to differentiate the entries from different datasets.

I also added the columns ride_length and dayOfWeek, which lists ride length in seconds and day of week of the ride respectively. These are useful fields that are easy to derive and are not included in the given dataset.

Next, I checked for duplicate any duplicates in ride_id, which was supposed to be unique for each ride. I found that all entries in the ride_id column was indeed unique.

MY next check for ride_id is that all 16 characters and no corruption(?)***************** of data

I also checked to ensure that ride length was positive, and more than 30 seconds. Unfortunately there were some rows with negative ride length so we had to remove those.

Although there was a substantial number of rows which was missing station data (such as start_station_id and start_station_name), I decided to keep the data as they were still able to serve as data point for our analysis of other aspects such as ride length and overall number of users.

# TODO: add the code for above

### Analyse



  
