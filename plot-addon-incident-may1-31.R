library(tidyverse)
library(lubridate)
library(directlabels)
library(RColorBrewer)
add_release_week_day_number <-
  function(df_release,
           yyyy,
           mm,
           dd)
  {
    START_DATE <-
      make_datetime(yyyy, mm, dd, 0, 0, 0,
                    tz = "UTC")
    
    return (df_release %>%
              mutate(release_week_day_number =
                       (floor(interval(
                         START_DATE, created
                       ) / days(1)))  + 1))
  }
add_release_week_number <-
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
create_desktop_df_release_week_num_questions <-
  function(df, release, yyyy, mm, dd)
  {
    # df is CSV with date time, release is "65"
    # yyyy, mm, dd are integers e.g. 2019, 1, 29
    # remove all questions before january 29, 2019
    ymd_str <- sprintf("%d-%d-%d", yyyy, mm, dd)
    release_start <- ymd(ymd_str, tz = "UTC")
    release_end <- release_start + weeks(4)
    release_questions <-
      df %>% 
      filter(created >= release_start & created < release_end)
    # add release week number i.e. 1, 2,3, or 4
    release_questions <- 
      add_release_week_number(release_questions, yyyy,mm, dd) 
    # add day of release week i.e, 1, 2, 3, 4, 5,6, 7
    release_questions <-
      add_release_week_day_number(release_questions, yyyy, mm, dd)
    release_questions <- release_questions %>% 
      group_by(release_week_number, release_week_day_number) %>% 
      count()
    add_column(release_questions, release = release)
  }
jan_18oct_2019_questions <- 
  read_csv("https://raw.githubusercontent.com/rtanglao/rt-kits-api2/master/sorted-all-desktop-en-us-2019-01-01-2019-10-18-firefox-desktop-all-locales.csv")
# change created unix time to r time UTC using as_datetime()
jan_18oct_2019_questions <- 
  jan_18oct_2019_questions %>%
  mutate(
    created = as_datetime(created, tz = "UTC")
    )

ymd_str <- "2019-5-1"
release_start <- ymd(ymd_str, tz = "UTC")
release_end <- release_start + days(31)
release_questions <-
  jan_18oct_2019_questions %>% 
  filter(created >= release_start & created < release_end)
release_questions <- add_release_week_day_number(
  release_questions, 2019, 5, 1)
release_questions <- release_questions %>% 
  group_by(release_week_day_number) %>% 
  count()
x_axis = sprintf("%d", seq(1:31))
release_plot <- 
  ggplot(data=release_questions, 
         aes(x=release_week_day_number, y=n, 
             ))
release_plot = release_plot +
  geom_line(stat="identity") + 
  labs(color = "incident") +
  scale_x_discrete(limits = x_axis)+
  labs(color = "incident1-31may2019") +
  scale_color_brewer(palette = "Dark2")

