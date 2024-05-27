library(dplyr)
library(tidyverse)
prison_pop <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")

avg_population_15to64_1990 <- prison_pop %>%
  filter(year == 1990) %>%
  summarize(avg_total_pop = round(mean(total_pop_15to64, na.rm=TRUE), 0))

avg_black_pop_15to64_1990 <- prison_pop %>%
  filter(year == 1990) %>%
  summarize(avg_black_pop = round(mean(black_pop_15to64, na.rm=TRUE), 0))

avg_white_pop_15to64_1990 <- prison_pop %>%
  filter(year == 1990) %>%
  summarize(avg_white_pop = round(mean(white_pop_15to64, na.rm=TRUE), 0))

avg_population_15to64_2018 <- prison_pop %>%
  filter(year == 2018) %>%
  summarize(avg_total_pop = round(mean(total_pop_15to64, na.rm=TRUE), 0))

avg_black_pop_15to64_2018 <- prison_pop %>%
  filter(year == 2018) %>%
  summarize(avg_black_pop = round(mean(black_pop_15to64, na.rm=TRUE), 0))

avg_white_pop_15to64_2018 <- prison_pop %>%
  filter(year == 2018) %>%
  summarize(avg_white_pop = round(mean(white_pop_15to64, na.rm=TRUE), 2))

avg_pop_increase_percent <- round((avg_population_15to64_2018 - avg_population_15to64_1990) / avg_population_15to64_1990 * 100, 2)

avg_black_pop_increase <- round((avg_black_pop_15to64_2018 - avg_black_pop_15to64_1990) / avg_black_pop_15to64_1990 * 100, 2)

avg_white_pop_increase <- round((avg_white_pop_15to64_2018 - avg_white_pop_15to64_1990) / avg_white_pop_15to64_1990 * 100, 2)
