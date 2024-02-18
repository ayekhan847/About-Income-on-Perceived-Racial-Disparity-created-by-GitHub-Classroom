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

# creating a summarization dataframe
max_SAT_2017 <- sat_income_df %>% 
filter(Year == 2017) %>% 
summarize(
  max_sat_score= max(across(3:10)),
  ) %>% pull(max_sat_score)

max_SAT_2018 <- sat_income_df %>% 
  filter(Year == 2018) %>% 
  summarize(
    max_sat_score= max(across(3:10)),
  ) %>% pull(max_sat_score)

max_SAT_2019 <- sat_income_df %>% 
  filter(Year == 2019) %>% 
  summarize(
    max_sat_score= max(across(3:10)),
  )%>% pull(max_sat_score)

max_SAT_2020 <- sat_income_df %>% 
  filter(Year == 2020) %>% 
  summarize(
    max_sat_score= max(across(3:10)),
  )%>% pull(max_sat_score)

max_SAT_2021 <- sat_income_df %>% 
  filter(Year == 2021) %>% 
  summarize(
    max_sat_score= max(across(3:10)),
  )%>% pull(max_sat_score)

max_SAT_2022 <- sat_income_df %>% 
  filter(Year == 2022) %>% 
  summarize(
    max_sat_score= max(across(3:10)),
  )%>% pull(max_sat_score)

min_SAT_2017 <- sat_income_df %>% 
  filter(Year == 2017) %>% 
  summarize(
    min_sat_score= min(across(3:10)),
  ) %>% pull(min_sat_score)

min_SAT_2018 <- sat_income_df %>% 
  filter(Year == 2018) %>% 
  summarize(
    min_sat_score= min(across(3:10)),
  ) %>% pull(min_sat_score)

min_SAT_2019 <- sat_income_df %>% 
  filter(Year == 2019) %>% 
  summarize(
    min_sat_score= min(across(3:10)),
  )%>% pull(min_sat_score)

min_SAT_2020 <- sat_income_df %>% 
  filter(Year == 2020) %>% 
  summarize(
    min_sat_score= min(across(3:10)),
  )%>% pull(min_sat_score)

min_SAT_2021 <- sat_income_df %>% 
  filter(Year == 2021) %>% 
  summarize(
    min_sat_score= min(across(3:10)),
  )%>% pull(min_sat_score)

min_SAT_2022 <- sat_income_df %>% 
  filter(Year == 2022) %>% 
  summarize(
    min_sat_score= min(across(3:10)),
  )%>% pull(min_sat_score)

#creating dataframe:
min_and_max_SAT_Scores_Per_Year_df <- data.frame(
  Year = c(2017,2018,2019,2020,2021,2022),
  Max_Score = c(max_SAT_2017,max_SAT_2018,max_SAT_2019,max_SAT_2020,max_SAT_2021,max_SAT_2022),
  Min_Score = c(min_SAT_2017,min_SAT_2018,min_SAT_2019,min_SAT_2020,min_SAT_2021,min_SAT_2022),
)