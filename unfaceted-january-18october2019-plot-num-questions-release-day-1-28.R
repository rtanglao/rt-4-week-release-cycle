library(tidyverse)
library(lubridate)
library(directlabels)
library(RColorBrewer)
add_release_day_number <-
  function(df_release,
           yyyy,
           mm,
           dd)
  {
    START_DATE <-
      make_datetime(yyyy, mm, dd, 0, 0, 0,
                    tz = "UTC")
    
    return (df_release %>%
              mutate(release_day_number =
                       (floor(interval(
                         START_DATE, created
                       ) / days(1))) + 1))
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
    # add day of release week i.e, 1, 2, 3, 4, 5,6, 7..28
    release_questions <-
      add_release_day_number(release_questions, yyyy, mm, dd)
    release_questions <- release_questions %>% 
      group_by(release_day_number) %>% 
      count()
    add_column(release_questions, release = release)
  }
jan_18oct_2019_questions <- 
  #read_csv("https://raw.githubusercontent.com/rtanglao/rt-kits-api2/master/sorted-all-desktop-en-us-2019-01-01-2019-10-18-firefox-desktop-all-locales.csv")
  read_csv("https://github.com/rtanglao/rt-kits-api2/blob/master/ARBITRARY_TIME_PERIOD/2019-01-01-2019-10-18-firefox-desktop-all-locales.csv?raw=true")
# change created unix time to r time UTC using as_datetime()
jan_18oct_2019_questions <- 
  jan_18oct_2019_questions %>%
  mutate(
    created = as_datetime(created, tz = "UTC")
    )

ff65_questions <- create_desktop_df_release_week_num_questions(
  jan_18oct_2019_questions, "65", 2019, 1, 29)
ff66_questions <- create_desktop_df_release_week_num_questions(
  jan_18oct_2019_questions, "66", 2019, 3, 19)
ff67_questions <- create_desktop_df_release_week_num_questions(
  jan_18oct_2019_questions, "67", 2019, 5, 21)
ff68_questions <- create_desktop_df_release_week_num_questions(
  jan_18oct_2019_questions, "68", 2019, 7, 9)
ff69_questions <- create_desktop_df_release_week_num_questions(
  jan_18oct_2019_questions, "69", 2019, 9, 3)
jan_18oct_2019_questions_by_release_week <- 
  bind_rows(ff65_questions, ff66_questions, ff67_questions, 
            ff68_questions, ff69_questions)

jan_18oct_2019_plot <- 
  ggplot(data=jan_18oct_2019_questions_by_release_week, 
         aes(x=release_day_number, y=n, group=release, 
             colour = factor(release)))
x_axis = sprintf("%d", seq(1:28))

jan_18oct_2019_plot = jan_18oct_2019_plot +
  geom_line(stat="identity") + 
  labs(color = 'Release Week 1-4') +
  scale_x_discrete(limits = x_axis) +
  labs(color = 'DesktopAAQ65-69') +
  geom_dl(aes(label = release), method = list(dl.trans(x = x + 0.2), "last.points", cex = 0.8)) +
  geom_dl(aes(label = release), method = list(dl.trans(x = x - 0.2), "first.points", cex = 0.8)) +
  scale_color_brewer(palette = "Dark2")
  #facet_wrap(~release_week_number)
