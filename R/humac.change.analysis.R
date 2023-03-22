### Humac analysis
#
#
## Author: KL
#
#
## Project: ReLiEf
#
#
## Purpose: This script analyses isometric humac data from pre, mid and post
# test via change-score comparisons. The data is currently just randomly g
# enerated numbers from excel (humac.dummy.xlsx).
# Each sped (isometrick, 60, 120 and 240 d/s) will
# be filtered into data frames for separate analyses
#
#
## Associated scripts: humac.cleanup.R
#
#
## Packages
library(tidyverse);library(nlme);library(lme4);library(emmeans)

## Data

humac.dat <- readRDS("./data/data-gen/humac/humacd.clean.RDS") %>%
  select(subject, time = timep, test, leg, age, group, peak.torque)

isom.dat <- humac.dat %>%
  filter(test == "isom")

i60.dat <- humac.dat %>%
  filter(test == "isok.60")

i120.dat <- humac.dat %>%
  filter(test == "isok.120")

i240.dat <- humac.dat %>%
  filter(test == "isok.240")

## Change calculation

# Isometric

isom.change <- isom.dat %>%
  dplyr::select(subject, time, age, group, peak.torque) %>%
  group_by(subject, time, age, group) %>%
  summarise(peak.torque = mean(peak.torque, na.rm = TRUE)) %>%
  pivot_wider(names_from = time,
              values_from = peak.torque) %>%
  na.omit() %>%
  ungroup() %>%
  mutate(change.mid = mid - pre,
         change.post = post - pre,
         pre = pre - mean(pre, na.rm = TRUE)) %>%
  select(subject, age, group, pre, change.mid, change.post) %>%
  pivot_longer(names_to = "time",
               values_to = "change",
               cols = (change.mid:change.post)) %>%
    print()

saveRDS(isom.change, "./data/data-gen/humac/isomd.change.RDS")
















