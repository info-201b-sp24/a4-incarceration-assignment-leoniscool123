library(ggplot2)
prison_pop <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")
black_pop_1990 <- prison_pop %>%
  filter(year == 1990) %>%
  summarize(avg_black_pop_1990 = mean(black_pop_15to64, na.rm = TRUE)) %>%
  pull(avg_black_pop_1990)

white_pop_1990 <- prison_pop %>%
  filter(year == 1990) %>%
  summarize(avg_white_pop_1990 = mean(white_pop_15to64, na.rm = TRUE)) %>%
  pull(avg_white_pop_1990)

percent_increase_black <- prison_pop %>%
  filter(year >= 1990 & year <= 2018) %>%
  group_by(year) %>%
  summarize(avg_black_pop = mean(black_pop_15to64, na.rm = TRUE)) %>%
  mutate(percent_increase = (avg_black_pop - black_pop_1990) / black_pop_1990 * 100)

percent_increase_white <- prison_pop %>%
  filter(year >= 1990 & year <= 2018) %>%
  group_by(year) %>%
  summarize(avg_white_pop = mean(white_pop_15to64, na.rm = TRUE)) %>%
  mutate(percent_increase = (avg_white_pop - white_pop_1990) / white_pop_1990 * 100)

combined_data <- percent_increase_black %>%
  select(year, percent_increase) %>%
  mutate(group = "Black") %>%
  bind_rows(
    percent_increase_white %>%
      select(year, percent_increase) %>%
      mutate(group = "White")
  )

ggplot(combined_data, aes(x = year, y = percent_increase, color = group)) +
  geom_line() +
  labs(title = "Percent Increase in Prison Population Aged 15 to 64 (1990-2018)",
       x = "Year",
       y = "Percent Increase",
       color = "Prisoner's Race") +
  theme_minimal()

