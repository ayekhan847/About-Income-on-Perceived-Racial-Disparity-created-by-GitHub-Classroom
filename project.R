# load dplyr
library(dplyr)
library(stringr)

# load data set
sat_by_race <- read.csv("SAT_mean.csv")
income_by_race <- read.csv("Median_household_income.csv")

# rows and columns of original data set
sat_rows <- sat_by_race %>% nrow()
sat_columns <- sat_by_race %>% ncol()

income_rows <- income_by_race %>% nrow()
income_columns <- income_by_race %>% ncol()

# edit column names
colnames(sat_by_race) <- paste0("SAT_", colnames(sat_by_race))
colnames(income_by_race) <- paste0("Income_", colnames(income_by_race))

# join the dataframes by year
sat_income_df <- left_join(sat_by_race, income_by_race, by = c("SAT_Year" = "Income_Year")) %>% 
  rename(Year = SAT_Year)



