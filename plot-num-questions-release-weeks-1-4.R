library(tidyverse)
library(lubridate)
library(anytime)
add_release_week_number
<-
  function(df_release,
           yyyy,
           mm,
           dd)
  {
    START_DATE <-
      make_datetime(yyyy, mm, dd, 0, 0, 0,
                    tz = "UTC")
    return (df_release %>%
              mutate(release_week_number =
                       floor(interval(
                         START_DATE, created
                       ) / days(7)) + 1))
  }
jan_aug_2019_questions <- read_csv("https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/01jan2019-31aug2019.csv")
# change created unix time to r time UTC using as_datetime()
jan_aug_2019_questions <- 
  jan_aug_2019_questions %>%
  mutate(
    created = as_datetime(created)
    )
# Firefox 65, January 29, 2019
# remove all questions before january 29, 2019
ff65_start <- ymd("2019-1-29", tz = "UTC")
ff65_end <- ff65_start + weeks(4)
ff65_questions <-
  jan_aug_2019_questions %>% 
  filter(created >= ff65_start & created < ff65_end)
  
# FF65W1D1, FF65W1D2, FF65W1D3, FF65W1D4, FF65W1D5,FF65W1D6,FF65W1D7
# FF65W2D1, FF65W2D2, FF65W2D3, FF65W2D4, FF65W2D5,FF65W2D6,FF65W2D7
# We want a column called "ReleaseWeekDay" with values 1-7
# read in the release json file, argv(1)
# read in the file with the releases argv(2)
# see https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/add-release-day-number.r
# see https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/add-release-week-number.r
# see plot-antivirus-mentions-by-3weeks.r which is:
# https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/plot-antivirus-mentions-by-3weeks.r