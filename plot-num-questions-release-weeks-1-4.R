library(tidyverse)
jan_aug_2019_questions <- read_csv("https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/01jan2019-31aug2019.csv")
# read in the release json file, argv(1)
# read in the file withi the releases argv(2)
# see https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/add-release-day-number.r
# see https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/add-release-week-number.r
# see plot-antivirus-mentions-by-3weeks.r which is:
# https://github.com/rtanglao/rt-kitsune-api/blob/master/VISUALIZATIONS/plot-antivirus-mentions-by-3weeks.r