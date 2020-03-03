library(tidyverse)
library(lubridate)
library(directlabels)
library(RColorBrewer)

december2018_03mar_2020_questions <- 
  read_csv("https://raw.githubusercontent.com/rtanglao/rt-kits-api2/master/PRODUCT_INTEGRITY_4WEEK_RELEASE_CYCLE/2018-11-01-2020-03-02-num-ff-desktop-aaq-questions-created-2020-03-02.csv")

calendar_week_ff_desktop_plot <- 
  ggplot(
    data = december2018_03mar_2020_questions, 
         aes(x=product_integrity_week_start, y=num_ff_desktop_en_us_questions, 
             ))
calendar_week_ff_desktop_plot = 
  calendar_week_ff_desktop_plot +
  geom_bar(stat="identity") +
  xlab("Calendar Week") + 
  ylab("# FF Desktop SUMO Forum Questions")
calendar_week_ff_desktop_plot =
  calendar_week_ff_desktop_plot +
  geom_vline(data = december2018_03mar_2020_questions,
             aes(xintercept = as.numeric(as.Date("2019-01-27")), 
                 colour = "FF65"),
             show.legend = TRUE) +
  geom_text(data=december2018_03mar_2020_questions, 
            x=as.numeric(as.Date("2019-01-27")), 
            y=0, label="FF65", size=3, angle=90, 
            vjust=-0.4, hjust=-1, colour = "hotpink") +
  geom_vline(data = december2018_03mar_2020_questions,
             aes(xintercept = as.numeric(as.Date("2019-03-19")), 
                 colour = "FF66"),
             show.legend = TRUE) +
  geom_text(data=december2018_03mar_2020_questions, 
            x=as.numeric(as.Date("2019-03-19")), 
            y=0, label="FF66", size=3, angle=90, 
            vjust=-0.4, hjust=-1, colour = "hotpink") +
  geom_vline(data = december2018_03mar_2020_questions,
             aes(xintercept = as.numeric(as.Date("2019-05-21")), 
                 colour = "FF67"),
             show.legend = TRUE) +
  geom_text(data=december2018_03mar_2020_questions, 
            x=as.numeric(as.Date("2019-05-21")), 
                        y=0, label="FF67", size=3, angle=90, 
            vjust=-0.4, hjust=-1, colour = "hotpink") +
  geom_vline(data = december2018_03mar_2020_questions,
             aes(xintercept = as.numeric(as.Date("2019-07-07")), 
                 colour = "FF68"),
             show.legend = TRUE) +
  geom_text(data=december2018_03mar_2020_questions, 
            x=as.numeric(as.Date("2019-07-07")), 
            y=0, label="FF68", size=3, angle=90, 
            vjust=-0.4, hjust=-1, colour = "hotpink") +
  geom_vline(data = december2018_03mar_2020_questions,
             aes(xintercept = as.numeric(as.Date("2019-09-01")), 
                 colour = "FF69"),
             show.legend = TRUE) +
  geom_text(data=december2018_03mar_2020_questions, 
            x=as.numeric(as.Date("2019-09-01")), 
            y=0, label="FF69", size=3, angle=90, 
            vjust=-0.4, hjust=-1, colour = "hotpink") +
  geom_vline(data = december2018_03mar_2020_questions,
             aes(xintercept = as.numeric(as.Date("2019-10-20")), 
                 colour = "FF70"),
             show.legend = TRUE) +
  geom_text(data=december2018_03mar_2020_questions, 
            x=as.numeric(as.Date("2019-10-20")), 
            y=0, label="FF70", size=3, angle=90, 
            vjust=-0.4, hjust=-1, colour = "hotpink") +
  geom_vline(data = december2018_03mar_2020_questions,
             aes(xintercept = as.numeric(as.Date("2019-12-01")), 
                 colour = "FF71"),
             show.legend = TRUE) +
  geom_text(data=december2018_03mar_2020_questions, 
            x=as.numeric(as.Date("2019-12-01")), 
            y=0, label="FF71", size=3, angle=90, 
            vjust=-0.4, hjust=-1, colour = "hotpink") +
  geom_vline(data = december2018_03mar_2020_questions,
             aes(xintercept = as.numeric(as.Date("2020-01-05")), 
                 colour = "FF72"),
             show.legend = TRUE) +
  geom_text(data=december2018_03mar_2020_questions, 
            x=as.numeric(as.Date("2020-01-05")), 
            y=0, label="FF72", size=3, angle=90, 
            vjust=-0.4, hjust=-1, colour = "hotpink") +
  geom_vline(data = december2018_03mar_2020_questions,
             aes(xintercept = as.numeric(as.Date("2020-02-09")), 
                 colour = "FF73"),
             show.legend = TRUE) +
  geom_text(data=december2018_03mar_2020_questions, 
            x=as.numeric(as.Date("2020-02-09")), 
            y=0, label="FF73", size=3, angle=90, 
            vjust=-0.4, hjust=-1, colour = "hotpink") +
  labs(x = "Calendar Week", color = "Firefox Release Week") 
  #opts(title="geom_vline", plot.title=theme_text(size=40, vjust=1.5))
  
