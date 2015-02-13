Introduction
============

An R client for the EIA API. The API is currently in beta and can be subject to change.

Before you do anything head over to the [EIA registration page](http://www.eia.gov/beta/api/register.cfm) and get an API key.

Installation
============

    devtools::install_github("krose/eia")

Examples
========

Let's first load the library:

``` {.r}
library(eia)
```

Category
--------

The first function is the category function. If you don't supply any category\_id you will simply get data on the top level category returned as a list:

``` {.r}
eia_cat(api_key = api_key)
```

    ## $request
    ## $request$category_id
    ## [1] 371
    ## 
    ## $request$command
    ## [1] "category"
    ## 
    ## 
    ## $category
    ## $category$category_id
    ## [1] "371"
    ## 
    ## $category$parent_category_id
    ## NULL
    ## 
    ## $category$name
    ## [1] "EIA Data Sets"
    ## 
    ## $category$notes
    ## [1] ""
    ## 
    ## $category$childcategories
    ##   category_id                            name
    ## 1       40203 State Energy Data System (SEDS)
    ## 2           0                     Electricity
    ## 3      714804                     Natural Gas
    ## 4      714755                       Petroleum
    ## 5      717234                            Coal
    ## 6      829714       Short-Term Energy Outlook
    ## 7      964164           Annual Energy Outlook
    ## 8     1238399               Crude Oil Imports
    ## 
    ## $category$childseries
    ## list()

These categories are deep, so you might find yourself searching through these until you get to the data series that you are interested.

Here's the first level of the natural gas category:

``` {.r}
eia_cat(api_key = api_key, category_id = "714804")
```

    ## $request
    ## $request$category_id
    ## [1] 714804
    ## 
    ## $request$command
    ## [1] "category"
    ## 
    ## 
    ## $category
    ## $category$category_id
    ## [1] "714804"
    ## 
    ## $category$parent_category_id
    ## [1] "371"
    ## 
    ## $category$name
    ## [1] "Natural Gas"
    ## 
    ## $category$notes
    ## [1] ""
    ## 
    ## $category$childcategories
    ##   category_id                          name
    ## 1      714805                       Summary
    ## 2      714806                        Prices
    ## 3      714807      Exploration and Reserves
    ## 4      714814 Imports and Exports/Pipelines
    ## 5      714813                    Production
    ## 6      714816         Consumption / End Use
    ## 7      714815                       Storage
    ## 
    ## $category$childseries
    ## list()

When you get to the final level the result is often a long list of "childseries" which ids the data series you can request.

``` {.r}
eia_cat(api_key = api_key, category_id = 475136)
```

    ## $request
    ## $request$category_id
    ## [1] 475136
    ## 
    ## $request$command
    ## [1] "category"
    ## 
    ## 
    ## $category
    ## $category$category_id
    ## [1] "475136"
    ## 
    ## $category$parent_category_id
    ## [1] "714813"
    ## 
    ## $category$name
    ## [1] "Shale Gas Production"
    ## 
    ## $category$notes
    ## [1] ""
    ## 
    ## $category$childcategories
    ## list()
    ## 
    ## $category$childseries
    ##                          series_id
    ## 1      NG.RES_EPG0_R5302_SPA_BCF.A
    ## 2    NG.RES_EPG0_R5302_R1Z10_BCF.A
    ## 3  NG.RES_EPG0_R5302_RNMEAST_BCF.A
    ## 4    NG.RES_EPG0_R5302_RTX09_BCF.A
    ## 5    NG.RES_EPG0_R5302_RTX02_BCF.A
    ## 6   NG.RES_EPG0_R5302_RTX07B_BCF.A
    ## 7    NG.RES_EPG0_R5302_RTX03_BCF.A
    ## 8      NG.RES_EPG0_R5302_SAK_BCF.A
    ## 9     NG.RES_EPG0_R5302_RLAN_BCF.A
    ## 10   NG.RES_EPG0_R5302_R2X40_BCF.A
    ## 11   NG.RES_EPG0_R5302_RTX04_BCF.A
    ## 12     NG.RES_EPG0_R5302_SMT_BCF.A
    ## 13 NG.RES_EPG0_R5302_RNMWEST_BCF.A
    ## 14  NG.RES_EPG0_R5302_RTX07C_BCF.A
    ## 15     NG.RES_EPG0_R5302_SAL_BCF.A
    ## 16  NG.RES_EPG0_R5302_RTX08A_BCF.A
    ## 17   NG.RES_EPG0_R5302_RLASO_BCF.A
    ## 18     NG.RES_EPG0_R5302_SCA_BCF.A
    ## 19     NG.RES_EPG0_R5302_SMS_BCF.A
    ## 20     NG.RES_EPG0_R5302_SVA_BCF.A
    ## 21     NG.RES_EPG0_R5302_SKS_BCF.A
    ## 22     NG.RES_EPG0_R5302_NUS_BCF.A
    ## 23     NG.RES_EPG0_R5302_SWY_BCF.A
    ## 24     NG.RES_EPG0_R5302_SAR_BCF.A
    ## 25     NG.RES_EPG0_R5302_SCO_BCF.A
    ## 26     NG.RES_EPG0_R5302_SKY_BCF.A
    ## 27     NG.RES_EPG0_R5302_SND_BCF.A
    ## 28   NG.RES_EPG0_R5302_RTX10_BCF.A
    ## 29     NG.RES_EPG0_R5302_STX_BCF.A
    ## 30     NG.RES_EPG0_R5302_SOH_BCF.A
    ## 31     NG.RES_EPG0_R5302_SMI_BCF.A
    ## 32     NG.RES_EPG0_R5302_SOK_BCF.A
    ## 33   NG.RES_EPG0_R5302_RTX01_BCF.A
    ## 34     NG.RES_EPG0_R5302_SNM_BCF.A
    ## 35     NG.RES_EPG0_R5302_SWV_BCF.A
    ## 36   NG.RES_EPG0_R5302_RTX05_BCF.A
    ## 37   NG.RES_EPG0_R5302_RTX06_BCF.A
    ## 38   NG.RES_EPG0_R5302_RTX08_BCF.A
    ## 39     NG.RES_EPG0_R5302_SLA_BCF.A
    ##                                                        name f
    ## 1                     Pennsylvania Shale Production, Annual A
    ## 2                   Eastern States Shale Production, Annual A
    ## 3                 New Mexico--East Shale Production, Annual A
    ## 4            Texas--RRC District 9 Shale Production, Annual A
    ## 5       Texas--RRC District 2 onsh Shale Production, Annual A
    ## 6           Texas--RRC District 7B Shale Production, Annual A
    ## 7       Texas--RRC District 3 onsh Shale Production, Annual A
    ## 8     Alaska (with Total Offshore) Shale Production, Annual A
    ## 9                 Louisiana--North Shale Production, Annual A
    ## 10                  Western States Shale Production, Annual A
    ## 11      Texas--RRC District 4 onsh Shale Production, Annual A
    ## 12                         Montana Shale Production, Annual A
    ## 13                New Mexico--West Shale Production, Annual A
    ## 14          Texas--RRC District 7C Shale Production, Annual A
    ## 15   Alabama (with State Offshore) Shale Production, Annual A
    ## 16          Texas--RRC District 8A Shale Production, Annual A
    ## 17        Louisiana--South Onshore Shale Production, Annual A
    ## 18     California (with State off) Shale Production, Annual A
    ## 19    Mississippi (with State off) Shale Production, Annual A
    ## 20                        Virginia Shale Production, Annual A
    ## 21                          Kansas Shale Production, Annual A
    ## 22                            U.S. Shale Production, Annual A
    ## 23                         Wyoming Shale Production, Annual A
    ## 24                        Arkansas Shale Production, Annual A
    ## 25                        Colorado Shale Production, Annual A
    ## 26                        Kentucky Shale Production, Annual A
    ## 27                    North Dakota Shale Production, Annual A
    ## 28          Texas--RRC District 10 Shale Production, Annual A
    ## 29     Texas (with State Offshore) Shale Production, Annual A
    ## 30                            Ohio Shale Production, Annual A
    ## 31                        Michigan Shale Production, Annual A
    ## 32                        Oklahoma Shale Production, Annual A
    ## 33           Texas--RRC District 1 Shale Production, Annual A
    ## 34                      New Mexico Shale Production, Annual A
    ## 35                   West Virginia Shale Production, Annual A
    ## 36           Texas--RRC District 5 Shale Production, Annual A
    ## 37           Texas--RRC District 6 Shale Production, Annual A
    ## 38           Texas--RRC District 8 Shale Production, Annual A
    ## 39 Louisiana (with State Offshore) Shale Production, Annual A
    ##                 units               updated
    ## 1  Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 2  Billion Cubic Feet 13-AUG-13 11.49.51 AM
    ## 3  Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 4  Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 5  Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 6  Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 7  Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 8  Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 9  Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 10 Billion Cubic Feet 13-AUG-13 11.49.51 AM
    ## 11 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 12 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 13 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 14 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 15 Billion Cubic Feet 13-AUG-13 11.49.51 AM
    ## 16 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 17 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 18 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 19 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 20 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 21 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 22 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 23 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 24 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 25 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 26 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 27 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 28 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 29 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 30 Billion Cubic Feet 08-JAN-15 03.30.42 PM
    ## 31 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 32 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 33 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 34 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 35 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 36 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 37 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 38 Billion Cubic Feet 04-DEC-14 10.46.54 AM
    ## 39 Billion Cubic Feet 04-DEC-14 10.46.54 AM

Series
------

Let's take a look at the annual series from North Dakota and Montana where a part of the Bakken formation is.

``` {.r}
eia_series(api_key = api_key,
           series_id = c("NG.RES_EPG0_R5302_SND_BCF.A", "NG.RES_EPG0_R5302_SMT_BCF.A"))
```

    ## $request
    ## $request$command
    ## [1] "series"
    ## 
    ## $request$series_id
    ## [1] "NG.RES_EPG0_R5302_SND_BCF.A;NG.RES_EPG0_R5302_SMT_BCF.A"
    ## 
    ## 
    ## $series
    ##                     series_id                                  name
    ## 1 NG.RES_EPG0_R5302_SND_BCF.A North Dakota Shale Production, Annual
    ## 2 NG.RES_EPG0_R5302_SMT_BCF.A      Montana Shale Production, Annual
    ##                units f unitsshort                   description copyright
    ## 1 Billion Cubic Feet A        Bcf North Dakota Shale Production      None
    ## 2 Billion Cubic Feet A        Bcf      Montana Shale Production      None
    ##                                        source iso3166 geography start  end
    ## 1 EIA, U.S. Energy Information Administration  USA-ND    USA-ND  2007 2013
    ## 2 EIA, U.S. Energy Information Administration  USA-MT    USA-MT  2007 2013
    ##                    updated
    ## 1 2014-12-04T10:46:54-0500
    ## 2 2014-12-04T10:46:54-0500
    ## 
    ## $data
    ## $data$`list(date = c("2013", "2012", "2011", "2010", "2009", "2008", "2007"), value = c(268, 203, 95, 64, 25, 3, 3))`
    ##         date value
    ## 1 2013-01-01   268
    ## 2 2012-01-01   203
    ## 3 2011-01-01    95
    ## 4 2010-01-01    64
    ## 5 2009-01-01    25
    ## 6 2008-01-01     3
    ## 7 2007-01-01     3
    ## 
    ## $data$`list(date = c("2013", "2012", "2011", "2010", "2009", "2008", "2007"), value = c(19, 16, 13, 13, 7, 13, 12))`
    ##         date value
    ## 1 2013-01-01    19
    ## 2 2012-01-01    16
    ## 3 2011-01-01    13
    ## 4 2010-01-01    13
    ## 5 2009-01-01     7
    ## 6 2008-01-01    13
    ## 7 2007-01-01    12

That's a lot of information and I would rather have it in a more tidy format. When you select "tidy\_long" two additional columns are added, describing the series time frame and the series\_id.

``` {.r}
eia_series(api_key = api_key, 
           series_id = c("NG.RES_EPG0_R5302_SND_BCF.A", "NG.RES_EPG0_R5302_SMT_BCF.A"),
           tidy_data = "tidy_long", 
           only_data = TRUE)
```

    ##          date value series_time_frame                 series_name
    ## 1  2013-01-01   268                 A NG.RES_EPG0_R5302_SND_BCF.A
    ## 2  2012-01-01   203                 A NG.RES_EPG0_R5302_SND_BCF.A
    ## 3  2011-01-01    95                 A NG.RES_EPG0_R5302_SND_BCF.A
    ## 4  2010-01-01    64                 A NG.RES_EPG0_R5302_SND_BCF.A
    ## 5  2009-01-01    25                 A NG.RES_EPG0_R5302_SND_BCF.A
    ## 6  2008-01-01     3                 A NG.RES_EPG0_R5302_SND_BCF.A
    ## 7  2007-01-01     3                 A NG.RES_EPG0_R5302_SND_BCF.A
    ## 8  2013-01-01    19                 A NG.RES_EPG0_R5302_SMT_BCF.A
    ## 9  2012-01-01    16                 A NG.RES_EPG0_R5302_SMT_BCF.A
    ## 10 2011-01-01    13                 A NG.RES_EPG0_R5302_SMT_BCF.A
    ## 11 2010-01-01    13                 A NG.RES_EPG0_R5302_SMT_BCF.A
    ## 12 2009-01-01     7                 A NG.RES_EPG0_R5302_SMT_BCF.A
    ## 13 2008-01-01    13                 A NG.RES_EPG0_R5302_SMT_BCF.A
    ## 14 2007-01-01    12                 A NG.RES_EPG0_R5302_SMT_BCF.A
