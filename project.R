# load dplyr
library(dplyr)
library(stringr)

# load data sets
sat_by_race <- read.csv("SAT_mean.csv")
income_by_race <- read.csv("Median_household_income.csv")

# rows and columns of original data set
sat_rows <- sat_by_race %>% nrow()
sat_columns <- sat_by_race %>% ncol()

income_rows <- income_by_race %>% nrow()
income_columns <- income_by_race %>% ncol()

# see description and structure of "sat_by_race"
str(sat_by_race)

# see description and structure of "income_by_race"
str(income_by_race)

# convert the character in "income_by_race" into numeric
income_by_race <- income_by_race %>% 
  mutate(across(2:7, ~as.numeric(gsub(",", "", .))))

# edit column names
colnames(sat_by_race) <- paste0("SAT_", colnames(sat_by_race))
colnames(income_by_race) <- paste0("Income_", colnames(income_by_race))

# join two data sets by year
sat_income_df <- left_join(sat_by_race, income_by_race, by = c("SAT_Year" = "Income_Year")) %>% 
  rename(Year = SAT_Year)

# in order to better compare the income and sat_score by race, 
# we delete the "Two or More races", "No response", and "Pacific.Islander" in sat_score
sat_income_df <- select(sat_income_df, -c(SAT_Pacific.Islander, SAT_No.response, SAT_Two.or.more.races))

# create new numerical columns comparing mean sat_score of each race to mean sat_score of all races
# by dividing the mean sat_score of each race by mean sat_score of all races
# and output as a Ratio
sat_income_df <- sat_income_df %>% 
  mutate(SAT_White_Ratio = SAT_White / SAT_All.races, 
         SAT_Black_Ratio = SAT_Black / SAT_All.races,
         SAT_Hispanic_Ratio = SAT_Hispanic / SAT_All.races,
         SAT_Asian_Ratio = SAT_Asian / SAT_All.races,
         SAT_American.Indian.And.Alaska.Native_Ratio = SAT_X..American.Indian.or.Alaska.Native. / SAT_All.races)

# create new categorical column to see if the sat_ratio of each race is larger than 1
sat_income_df <- sat_income_df %>% 
  mutate(SAT_White_Ratio_Above1 = ifelse(SAT_White_Ratio > 1, "Yes", "No"),
         SAT_Black_Ratio_Above1 = ifelse(SAT_Black_Ratio > 1, "Yes", "No"),
         SAT_Hispanic_Ratio_Above1 = ifelse(SAT_Hispanic_Ratio > 1, "Yes", "No"),
         SAT_Asian_Ratio_Above1 = ifelse(SAT_Asian_Ratio > 1, "Yes", "No"), 
         SAT_American.Indian.And.Alaska.Native_Ratio_Above1 = ifelse(SAT_American.Indian.And.Alaska.Native_Ratio > 1, "Yes", "No"))

# create new numerical columns comparing median household income of each race to median household income of all races
# by dividing the median household income of each race by median household income of all races
# and output as a Ratio
sat_income_df <- sat_income_df %>% 
  mutate(Income_White_Ratio = Income_White..non.Hispanic / Income_All.races, 
         Income_Black_Ratio = Income_Black / Income_All.races,
         Income_Hispanic_Ratio = Income_Hispanic..any.race. / Income_All.races,
         Income_Asian_Ratio = Income_Asian/ Income_All.races,
         Income_American.Indian.And.Alaska.Native_Ratio = Income_American.Indian.and.Alaska.Native / Income_All.races)

# create new categorical column to see if the income_ratio of each race is larger than 1
sat_income_df <- sat_income_df %>% 
  mutate(Income_White_Ratio_Above1 = ifelse(Income_White_Ratio > 1, "Yes", "No"),
         Income_Black_Ratio_Above1 = ifelse(Income_Black_Ratio > 1, "Yes", "No"),
         Income_Hispanic_Ratio_Above1 = ifelse(Income_Hispanic_Ratio > 1, "Yes", "No"),
         Income_Asian_Ratio_Above1 = ifelse(Income_Asian_Ratio > 1, "Yes", "No"), 
         Income_American.Indian.And.Alaska.Native_Ratio_Above1 = ifelse(Income_American.Indian.And.Alaska.Native_Ratio > 1, "Yes", "No"))

# creating a summarization dataframe of max and min of sat_score and max and min of income among all races
min_and_max_df <- sat_income_df %>% 
  group_by(Year) %>% 
  summarize(Max_SAT_Score = max(c(SAT_White, SAT_Black, SAT_Hispanic, SAT_Asian, SAT_X..American.Indian.or.Alaska.Native.)), 
            Min_SAT_Score = min(c(SAT_White, SAT_Black, SAT_Hispanic, SAT_Asian, SAT_X..American.Indian.or.Alaska.Native.)),
            Max_Income = max(c(Income_White..non.Hispanic, Income_Black, Income_Hispanic..any.race., Income_Asian, Income_American.Indian.and.Alaska.Native)),
            Min_Income = min(c(Income_White..non.Hispanic, Income_Black, Income_Hispanic..any.race., Income_Asian, Income_American.Indian.and.Alaska.Native)))

