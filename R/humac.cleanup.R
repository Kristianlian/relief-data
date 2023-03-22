### Humac cleanup
#
#
## Author: KL
#
#
## Project: ReLiEf
#
#
## Purpose: This script cleans up humac peak torque data
#
#
## Packages
library(readxl); library(tidyverse)


## Data
humac <- read_excel("./data/humac.dummy.xlsx", na = "NA")

humac.clean <- humac %>%
  mutate(timep = if_else(time %in% c("T0", "T1"),
                         "pre",
                         if_else(time %in% c("T2", "T3"),
                                 "mid",
                                 if_else(time %in% c("T4", "T5"),
                                         "post", time)))) %>%
  mutate(timep = factor(timep, levels = c("pre", "mid", "post")),
         group = factor(group, levels = c("1s", "3s", "con"))) %>%
  select(subject, timep, test, leg, age, group, peak.torque) %>%
  print()

saveRDS(humac.clean, "./data/data-gen/humac/humacd.clean.RDS")


