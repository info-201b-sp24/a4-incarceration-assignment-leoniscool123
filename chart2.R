library(ggplot2)
library(dplyr)
library(tidyverse)

prison_pop <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")

black_percentages <- prison_pop %>%
  group_by(year) %>%
  summarize(black_percentage = sum(black_pop_15to64) / sum(total_pop_15to64) * 100)

white_percentages <- prison_pop %>%
  group_by(year) %>%
  summarize(white_percentage = sum(white_pop_15to64) / sum(total_pop_15to64) * 100)

combined_percentages <- inner_join(black_percentages, white_percentages, by = "year")

combined_percentages_long <- combined_percentages %>%
  pivot_longer(cols = c(black_percentage, white_percentage), names_to = "race", values_to = "percentage")

combined_percentages_long <- combined_percentages_long %>%
  filter(year >= 1990 & year <= 2018)

ggplot(combined_percentages_long, aes(x = year, y = percentage, color = race)) +
  geom_line() +
  labs(
    title = "Percentage of Black and White Population to Total Population (1990-2018)",
    x = "Year",
    y = "Percentage",
    color = "Race"
  ) +
  theme_minimal()

