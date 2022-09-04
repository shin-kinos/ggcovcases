# ggcovcases 

A R package acquiring and visualising data of cases or deaths in COVID-19 in each country from WHO COVID-19 Global Data.  

## Description 

* A R package for COVID-19 data visualisation. 
* It automatically picks the cases or deaths data from WHO COVID-19 Global data (https://covid19.who.int/WHO-COVID-19-global-data.csv). 
* It creates line plot or connected scatter plot graph using ggplot2. 
* Enjoy. 

## Requirements 

### `ggplot2` (=> 3.3.0) 

* `ggplot2`: (https://ggplot2.tidyverse.org/) 

### `devtools` (=> 2.4.0) 

* `devtools`: (https://www.r-project.org/nosvn/pandoc/devtools.html) 

##Installation 

### Install `ggplot2` (if necessary) 

If necessary, you can install `ggplot2` package in your environment form **CRAN**.

[e.g.] 

```
install.packages("ggplot2")

``` 

### Install `devtools` (if necessary) 

If necessary, you can install `devtools` package in your environment from **CRAN**.

[e.g.] 

```
install.packages("devtools")

``` 

### Install `ggcovcases` 

You can install the package using `devtools::install_github()` 

[e.g] 

```
devtools::install_github("ggcovcases")
``` 

## Functions 

### `get_country_cases_data` 

Get specific country's COVID-19 cases and deaths from WHO COVID-19 Global Data (https://covid19.who.int/WHO-COVID-19-global-data.csv) as a data frame. 

### Arguments 

* `country_name`: Target country for data visualisation, default "The United Kingdom". ✅NOTE that a name of country must be exact the same as one registered in WHO COVID-19 Global data including capitalisation, and the argument must be integrated by *double quotation* (`""`) (e.g., "United States of America", "Russian Federation", "South Africa" and "Republic of Korea" etc.).
* `days`: date duration, default 90. 

[e.g] 

``` 
> covData_jp <- get_country_cases_data(country_name="Japan", days=120)
> str(covData_jp)
'data.frame':	120 obs. of  10 variables:
 $ Date_reported               : POSIXct, format: "2022-05-06" "2022-05-07" "2022-05-08" "2022-05-09" ...
 $ Country_code                : chr  "JP" "JP" "JP" "JP" ...
 $ Country                     : chr  "Japan" "Japan" "Japan" "Japan" ...
 $ WHO_region                  : chr  "WPRO" "WPRO" "WPRO" "WPRO" ...
 $ New_cases                   : int  21368 23615 34696 40942 33664 39041 45740 42378 38439 39416 ...
 $ Cumulative_cases            : int  8000280 8023895 8058591 8099533 8133197 8172238 8217978 8260356 8298795 8338211 ...
 $ New_deaths                  : int  18 35 24 28 30 51 41 39 31 34 ...
 $ Cumulative_deaths           : int  29726 29761 29785 29813 29843 29894 29935 29974 30005 30039 ...
 $ Sevendays_average_new_cases : int  NA NA NA 34152 37153 39271 39945 39074 38027 37269 ...
 $ Sevendays_average_new_deaths: int  NA NA NA 32 35 34 36 35 35 32 ...
``` 

### `plot_country_new_cases()` 

Visualise specific country's COVID-19 new cases from WHO COVID-19 Global Data by line plot. 

### Arguments 

* `country_name`: target country of data visualisation, default "The United Kingdom". ✅NOTE that a name of country must be exact the same as one registered in WHO COVID-19 Global data including capitalisation, and the argument must be integrated by *double quotation* (`""`) (e.g., "United States of America", "Russian Federation", "South Africa" and "Republic of Korea" etc.). 
* `days`: date duration, default 90.
* `axis_x_txt_size`: size of X axis text, default 8.
* `line_size_cases`: size of cases line, default 1.0.
* `line_size_average`: size of 7 days average line, default 2.0.
* `line_colour_cases`: colour of cases line, default "gray".
* `line_colour_average`: colour of 7 days average line, "#3EC70B". 

[e.g.] 

```
> plot_cases_us <- plot_country_new_cases(country_name="United States of America", days=365, axis_x_txt_size=5, line_colour_average="steelblue") 
> ggsave(plot=plot_case_us, units="px", width=2500, height=1000, filename="newCasesUSA_365.png") 
``` 

![newCasesUSA_365](https://user-images.githubusercontent.com/83740080/188315891-4e53af01-fcfe-4526-a8e2-8f0e20a8c202.png)

### `plot_country_cumulative_cases()` 

Visualise specific country's COVID-19 cumulative cases from WHO COVID-19 Global Data. 

### Arguments

* `country_name target`: country of data visualisation, default "The United Kingdom". ✅NOTE that a name of country must be exact the same as one registered in WHO COVID-19 Global data including capitalisation, and the argument must be integrated by *double quotation* (`""`) (e.g., "United States of America", "Russian Federation", "South Africa" and "Republic of Korea" etc.). 
* `days`: date duration, default 90.
* `axis_x_txt_size`: size of X axis text, default 8.
* `line_size`: size of line, default 2.0,
* `line_colour`: colour of line, default "#3EC70B". 

[e.g.]

```
> plot_cumuCases_ger <- plot_country_cumulative_cases(country_name="Germany", days=500, axis_x_txt_size=6, line_colour="forestgreen")
> ggsave(plot=plot_cumuCases_ger, units="px", width=2500, height=1000, filename="cumuCasesGer_500.png")
``` 

![cumuCasesGer_500](https://user-images.githubusercontent.com/83740080/188315999-5688f2f8-6bfe-4620-b77f-4e17d6f1e4c5.png)


### `plot_country_new_deaths()`

Visualise specific country's COVID-19 new deaths from WHO COVID-19 Global Data. 

### Arguments 

* `country_name`: target country of data visualisation, default "The United Kingdom". ✅NOTE that a name of country must be exact the same as one registered in WHO COVID-19 Global data including capitalisation, and the argument must be integrated by *double quotation* (`""`) (e.g., "United States of America", "Russian Federation", "South Africa" and "Republic of Korea" etc.). 
* `days`: date duration, default 90.
* `axis_x_txt_size`: size of X axis text, default 8.
* `line_size_deaths`: size of deaths line, default 1.0.
* `line_size_average`: size of 7 days average line, default 2.0.
* `line_colour_deaths`: colour of deaths line, default "gray".
* `line_colour_average`: colour of 7 days average line, "#3EC70B". 

```
> plot_new_southAf <- plot_country_new_deaths(country_name="South Africa", days=120, axis_x_txt_size=10)
> ggsave(plot=plot_new_southAf, units="px", width=2500, height=2000, filename="newDeaths_southAf_120.png")
``` 

![newDeaths_southAf_120](https://user-images.githubusercontent.com/83740080/188316049-138183b8-31b8-43ba-bd0d-646e6f0da65f.png) 

### `plot_country_cumulative_deaths()`

Visualise specific country's COVID-19 cumulative deaths from WHO COVID-19 Global Data.

### Arguments

* `country_name`: target country of data visualisation, default "The United Kingdom". ✅NOTE that a name of country must be exact the same as one registered in WHO COVID-19 Global data including capitalisation, and the argument must be integrated by *double quotation* (`""`) (e.g., "United States of America", "Russian Federation", "South Africa" and "Republic of Korea" etc.). 
* `days`: date duration, default 90.
* `axis_x_txt_size`: size of X axis text, default 8.
* `line_size`: size of line, default 2.0,
* `line_colour`: colour of line, default "#3EC70B". 

[e.g.]

```
> plot_cumuDeaths_jp <- plot_country_cumulative_deaths(country_name="Japan", days=150, line_colour="#E94560") 
> ggsave(plot=plot_cumuDeaths_jp, units="px", width=2500, height=1200, filename="cumuDeathJapan_150.png")
``` 

![cumuDeathJapan_150](https://user-images.githubusercontent.com/83740080/188316100-ecfeee7d-7bc1-4227-ac7f-c85a970a98f5.png) 

### `plot_country_new_cases_deaths()`

### Arguments 

* `country_name`: target country of data visualisation, default "The United Kingdom". ✅NOTE that a name of country must be exact the same as one registered in WHO COVID-19 Global data including capitalisation, and the argument must be integrated by *double quotation* (`""`) (e.g., "United States of America", "Russian Federation", "South Africa" and "Republic of Korea" etc.). 
* `days date`: duration, default 90.
* `axis_x_txt_size`: size of X axis text, default 8.
* `segment_size`: segment size of connected scatter plot, default 0.02.
* `segment_colour`: segment colour of connected scatter plot, default "gray".
* `point_size`: point size of connected scatter plot, default 2.0.
* `point_colour`: point colour of connected scatter plot, default "#3EC70B".
* `label_size`: label size of connected scatter plot, default 2.0.
* `label_colour`: label colour of connected scatter plot, default "#3EC70B". 

[e.g] 

```
> plot_cases_deaths <- plot_country_new_cases_deaths(point_colour="#FF5959", segment_colour="#676FA3", label_colour="#FF5959")
> ggsave(plot=plot_cases_deaths, units="px", width=2500, height=2000, filename="casesDeathsUk_90.png")
``` 

![casesDeathsUk_90](https://user-images.githubusercontent.com/83740080/188316138-2aaa5e06-6db9-4db2-a1c9-9a323a1dae42.png) 
