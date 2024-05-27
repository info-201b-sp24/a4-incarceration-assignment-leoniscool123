library(dplyr)
library(ggplot2)
library(maps)

state_black_white_ratio <- prison_pop %>%
  select(state, black_prison_pop, white_prison_pop) %>%
  replace(is.na(.), 0) %>%
  group_by(state) %>%
  summarise(
    rate = sum(black_prison_pop) / sum(white_prison_pop)
  ) %>%
  arrange(desc(rate)) %>%
  slice(-1)

state_shape <- map_data("state") %>%
  rename(state = region)

state_shape <- state_shape %>%
  mutate(state = state.abb[match(state, state.name)]) # Assuming state2abbr is not available
state_shape <- state_shape %>%
  left_join(state_black_white_ratio, by = "state")

map <- ggplot(state_shape) +
  geom_polygon(mapping = aes(x = long, y = lat, group = group, fill = rate),
               color = "white", size = 0.1) +
  coord_map() +
  scale_fill_continuous(low = "#132B43", high = "Red") +
  labs(fill = "Ratio") +
  ggtitle("Black-to-White Incarceration Ratio") +
  theme_bw() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank()
  )
map
