+++
title = 'Boston Data Analysis'
date = 2022-05-24
draft = false
+++

![Travelling Image](../images/Money-for-Travel.jpg)

## Business Understanding

I love to travel and usually when I have time and money, I pack my bags and hit the road. One of the issues affecting my travel budget is the cost of accommodation (hotel...). Recently, when I joined the program on Udacity, I got data about housing prices in Boston. Let's study housing prices in Boston with me. There are 3 questions that I am interested in when looking at this data:

- Question 1: What are prices in cities in a specified timeframe?
- Question 2: What are the factors that impact prices?
- Question 3: How much the price for given house ?

### Prerequisites

Housing price data is downloaded from Kaggle at the following link [Boston data on Kaggle](https://www.kaggle.com/datasets/airbnb/boston)

## Data Understanding

In the Boston data, there are some files:

- `calendar.csv`: Calendar, including listing id and the price and availability for that day
- `listing.csv`: Listings, including full descriptions and average review score
- `reviews.csv`: Reviews, including a unique id for each reviewer and detailed comments

We take alook about Boston data.

### Gather data

We can display the data by looking at data frames the calendar, listing, and reviews

<br /><br />
_Calendar sample data_

| Index | listing_id |     date | available | price |
| ----- | ---------: | -------: | --------: | ----: |
| 0     |   12147973 | 9/5/2017 |         f |   NaN |
| 1     |   12147973 | 9/4/2017 |         f |   NaN |
| 2     |   12147973 | 9/3/2017 |         f |   NaN |
| 3     |   12147973 | 9/2/2017 |         f |   NaN |
| 4     |   12147973 | 9/1/2017 |         f |   NaN |

The prices will be `NaN` in the cases there is no available (value got `f`)

_Listing sample data_

| Index |       id |                           listing_url |   scrape_id | last_scraped |                                          name |                                           summary |                                             space |                                       description | experiences_offered |                             neighborhood_overview | ... | review_scores_value | requires_license | license | jurisdiction_names | instant_bookable | cancellation_policy | require_guest_profile_picture | require_guest_phone_verification | calculated_host_listings_count | reviews_per_month |
| ----- | -------: | ------------------------------------: | ----------: | -----------: | --------------------------------------------: | ------------------------------------------------: | ------------------------------------------------: | ------------------------------------------------: | ------------------: | ------------------------------------------------: | --: | ------------------: | ---------------: | ------: | -----------------: | ---------------: | ------------------: | ----------------------------: | -------------------------------: | -----------------------------: | ----------------: |
| 0     | 12147973 | https://www.airbnb.com/rooms/12147973 | 2.01609E+13 |     9/7/2016 |                    Sunny Bungalow in the City |  Cozy, sunny, family home. Master bedroom high... | The house has an open and cozy feel at the sam... |  Cozy, sunny, family home. Master bedroom high... |                none | Roslindale is quiet, convenient and friendly. ... | ... |                 NaN |                f |     NaN |                NaN |                f |            moderate |                             f |                                f |                              1 |               NaN |
| 1     |  3075044 |  https://www.airbnb.com/rooms/3075044 | 2.01609E+13 |     9/7/2016 |             Charming room in pet friendly apt | Charming and quiet room in a second floor 1910... | Small but cozy and quite room with a full size... | Charming and quiet room in a second floor 1910... |                none | The room is in Roslindale, a diverse and prima... | ... |                   9 |                f |     NaN |                NaN |                t |            moderate |                             f |                                f |                              1 |               1.3 |
| 2     |     6976 |     https://www.airbnb.com/rooms/6976 | 2.01609E+13 |     9/7/2016 |              Mexican Folk Art Haven in Boston | Come stay with a friendly, middle-aged guy in ... | Come stay with a friendly, middle-aged guy in ... | Come stay with a friendly, middle-aged guy in ... |                none | The LOCATION: Roslindale is a safe and diverse... | ... |                  10 |                f |     NaN |                NaN |                f |            moderate |                             t |                                f |                              1 |              0.47 |
| 3     |  1436513 |  https://www.airbnb.com/rooms/1436513 | 2.01609E+13 |     9/7/2016 | Spacious Sunny Bedroom Suite in Historic Home | Come experience the comforts of home away from... | Most places you find in Boston are small howev... | Come experience the comforts of home away from... |                none | Roslindale is a lovely little neighborhood loc... | ... |                  10 |                f |     NaN |                NaN |                f |            moderate |                             f |                                f |                              1 |                 1 |
| 4     |  7651065 |  https://www.airbnb.com/rooms/7651065 | 2.01609E+13 |     9/7/2016 |                           Come Home to Boston | My comfy, clean and relaxing home is one block... | Clean, attractive, private room, one block fro... | My comfy, clean and relaxing home is one block... |                none | I love the proximity to downtown, the neighbor... | ... |                  10 |                f |     NaN |                NaN |                f |            flexible |                             f |                                f |                              1 |              2.25 |

In the data, we can see there are mixed values of text, numeric and boolean values. The listing data include information about all listings such as how many bedrooms, bedroom types and prices in normal cases
<br />
_Reviews sample data_

| Index | listing_id |      id |      date | reviewer_id | reviewer_name |                                          comments |
| ----- | ---------: | ------: | --------: | ----------: | ------------: | ------------------------------------------------: |
| 0     |    1178162 | 4724140 | 5/21/2013 |     4298113 |       Olivier | My stay at islam's place was really cool! Good... |
| 1     |    1178162 | 4869189 | 5/29/2013 |     6452964 |     Charlotte | Great location for both airport and city - gre... |
| 2     |    1178162 | 5003196 |  6/6/2013 |     6449554 |     Sebastian | We really enjoyed our stay at Islams house. Fr... |
| 3     |    1178162 | 5150351 | 6/15/2013 |     2215611 |        Marine | The room was nice and clean and so were the co... |
| 4     |    1178162 | 5171140 | 6/16/2013 |     6848427 |        Andrew | Great location. Just 5 mins walk from the Airp... |

## Evaluation

After doing data manipulation, I use it to answer 3 questions

### Question 1: What are prices in cities in a specified timeframe?

I will do the calculation of the group by city and month (new added field) and calculate the mean value.
Since the listing prices are taken on a daily basis, for the convenience of monthly calculations, we will calculate the mean price by month.

#### Visualize the data

![df_listing](../images/chart_price_by_city_and_month.png)

- In the chart, we can see Charlestown city has the highest price (with a mean price 340$/day) and West Roxbury has the lowest price every month.
- Some cities are having a stable price in all months: Watertown, Milton
- Except for Boston (common location), some cities have a big difference in prices in day and month. Min price at Oct and Max price at Apr
  - Dorchester has a low price at 22$/day

We can see that:

- In the chart, we can see Charlestown city has the highest price (with a mean price 340$/day) and West Roxbury has the lowest price every month.
- Some cities are having a stable price in all months: Watertown, Milton
- Except for Boston (common location), some cities have a big difference in prices in day and month. Min price at Oct and Max price at Apr
  - Dorchester has a low price at 22$/day

> It's June now, if you want to go to Boston then I think you can consider West Roxbury as the place with the cheapest housing price

### Question 2: What are most factor impact to price ?

In the listing, we want to investigate how properties impact price.
We will visualize by their coefficients.

#### Visualize coefficients

We can see that some features mostly impact to price: `weekly_price`, `monthly_price`
, `accommodates`, `bedrooms`, `square_feet`.
There are features that lowest impact to price: `acceptance_rate`, `reviews_per_month`

![headmap](../images/headmap_cleaned_df_2.png)

> If we want to rent a house having large accommodates, bedrooms, square feets then the prices will be high.
> To save the housing price we can choose small accommodates, bedrooms, square feets

### Question 3: Predict price

As in question 1, West Roxbury is an attractive place for me. However, here, there are no houses that have accommodations = 10.
I am wondering if there are any houses with such accommodations, what will be the price?

Now let's try to get a record from West Roxbury city and add the accommodates information (value will be 10) and run it through the trained model.

As you can see, the result will be 55.3$. I think this is a good price for a trip here !

I hope you had a great time reading the article !

For the source code, you can refer on [Github](https://github.com/HoTrongHai/boston-data-analysis)
