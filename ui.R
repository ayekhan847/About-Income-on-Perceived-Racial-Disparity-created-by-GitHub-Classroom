library(dplyr)
library(tidyr)
library(stringr)
library(shiny)
library(ggplot2)
library(plotly)

sat_by_race <- read.csv("sat_by_race.csv")
sat_income_df <- read.csv("sat_income_df.csv")
ratio_df <- read.csv("ratio_df.csv")
income_by_race <- read.csv("Median_household_income.csv")

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Introduction",
   p("Introduction",
      style = "font-size: 24px; font-weight: bold;"),
   p("In the following analysis, we dive into the intricate dynamic between income and educational outcomes across racial lines. Our examination illuminates two fundamental questions: We investigate the relationship between racial identities and academic performance, utilizing the lens of SAT scores. We then, using average household income, explore the profound impact of economic disparities on access to educational resources and opportunities among different racial groups. The crossroads between these datasets reveals the systemic inequalities deeply rooted within society and their factor in the perceived racial disparity in education.",
      style = "font-size: 18px;"),
   p("Information Regarding Data Used",
     style = "font-size: 24px; font-weight: bold;"),
   p("Median Household Income by Race (2017-2022):",
     style = "font-size: 18px; font-weight: bold;"),
   p("https://www.statista.com/statistics/1086359/median-household-income-race-us/ (website)
     https://www.census.gov/content/dam/Census/library/publications/2022/demo/p60-276.pdf (source)",
     style = "font-size: 14px;"),
   p("The dataset of median house income by race and ethnicity is downloaded from Statista, a platform with an extensive collection of statistics and reports. It is also a national dataset in the United States. The website provided us with the median household income in the United States, by race and ethnicity from 1967 to 2022 based on sources from the US Census Bureau, in particular, the Income in the United States: 2021- Current Population Reports published by the US Census Bureau. The US Census Bureau collected the data based on the Current Population Survey (CPS) and the Annual Social and Economic Supplements (ASEC).",
     style = "font-size: 18px;"),
   p("Mean SAT Scores by Race (2017-2022):",
     style = "font-size: 18px; font-weight: bold;"),
   p("https://reports.collegeboard.org/media/pdf/2017-total-group-sat-suite-assessments-annual-report.pdf (2017)
      https://reports.collegeboard.org/media/pdf/2018-total-group-sat-suite-assessments-annual-report.pdf (2018)
      https://reports.collegeboard.org/media/pdf/2019-total-group-sat-suite-assessments-annual-report.pdf (2019)
      https://reports.collegeboard.org/media/pdf/2020-total-group-sat-suite-assessments-annual-report.pdf (2020)
      https://reports.collegeboard.org/media/2022-04/2021-total-group-sat-suite-of-assessments-annual-report%20(1).pdf (2021)
      https://reports.collegeboard.org/media/pdf/2022-total-group-sat-suite-of-assessments-annual-report.pdf (2022)",
     style = "font-size: 14px;"),
   p("The dataset of mean SAT scores by race is generated from CollegeBoard’s SAT Suite of Assessment Annual Report from 2017 to 2022. It is a national dataset in the United States. Based on self-reported information test takers filled in during the SAT assessment, CollegeBoard was able to collect the data about their backgrounds and connect it with their SAT scores. Mean score, as explained by CollegeBoard, “is the arithmetic average of a defined set of test scores,” and will be calculated only if there are more than ten students in a group. Based on the annual reports from 2017 to 2022, we generated an Excel sheet by extracting the mean SAT total score (Total) by 8 categories of races (American Indian/Alaska Native, Asian, Black/African American, Hispanic/Latino, Native Hawaiian/Other Pacific Islander, White, Two or More Races, No Response) and All Races where we took the mean scores of all test takers in total.",
     style = "font-size: 18px;"),
   fluidRow(
     column(6,
            imageOutput("intro_image_2")
     ),
     column(6,
            imageOutput("intro_image_1")
     )
   )
)

## Mean SAT Score based on Year and Race TAB INFO
#Getting column names:
SAT_colnames <- colnames(sat_by_race)


viz_1_sidebar <- sidebarPanel(
  h2("Select Race to Display"),
  selectInput(
    inputId = "race_to_display",
    label = "Choose Race to Display",
    choices = SAT_colnames[2:10],
    selected = "All_Races",
    multiple = TRUE
  ),
  p("The chart depicts the range of SAT score distributions across various racial and ethnic categories over years. Median scores for each group are represented by the horizontal lines within the boxes. The dimensions of each box reflect the variability of scores around the median, with larger boxes signifying a more substantial dispersion of the middle 50% of scores.",
    style = "font-size: 16px;"),
  p("It's important to understand that the observed correlations between SAT scores and racial/ethnic categories do not exist in isolation but are caused by many factors, including but not limited to socioeconomic status, access to educational resources, and opportunities available to different groups.", 
    style = "font-size: 16px;"),
  p("An insightful inference from this data might suggest that individuals within the 'Mixed Race' category have SAT score ranges that are more comparable to those identified in the 'White' category. This observation could lead to the hypothesis that a significant proportion of test-takers in the 'Mixed Race' group are of partial White ancestry. This data also reveals that there is an unequal representation of test-takers among the different groups, pointing to a potential disparity in access to the SAT test itself.",
    style = "font-size: 16px;")
)

viz_1_main_panel <- mainPanel(
  h2("SAT Score Distribution Based on Year and Race"),
  plotlyOutput(outputId = "SAT_plot", width = "95%", height = "800px")
)

viz_1_tab <- tabPanel("SAT Scores",
  sidebarLayout(
    viz_1_sidebar,
    viz_1_main_panel
  )
)

## Median Household Incomes based on Year and Race TAB INFO

viz_2_sidebar <- sidebarPanel(
  h2("Select Year to Display"),
  selectInput(
    inputId = "year_to_display",
    label = "Choose Year to Display",
    choices = income_by_race$Year,
    selected = "2017"
  ),
  p("This graph depicts the median household income for different races across 5 years. Our graph depicts data from 2017 to 2022 for various races and when selecting a particular year we can see the income vary. Based on our graph we can draw conclusions that Asian households have the highest household income and over the years and continue to have the highest while black households have the lowest household income. This conclusion emphasizes race isn’t the only factor that correlates to higher academic performance but instead there is the underlying factor of household income which helps contribute to higher academic performance for many students.",
    style = "font-size: 16px;")
  
)

viz_2_main_panel <- mainPanel(
  h2("Median Household Incomes based on Year and Race"),
  plotlyOutput(outputId = "income_plot", width = "95%", height = "900px")
)

viz_2_tab <- tabPanel("Household Incomes",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel,
    
  )
)

## Ratio
# get column names from ratio_df
ratio_colnames = colnames(ratio_df)

viz_3_sidebar <- sidebarPanel(
  h2("Select Race with SAT and Income Ratio in Pair to See the Trend"),
  selectInput(inputId = "selected_race",
                label = "Choose Ratio by Race in Pair (eg. SAT_Black_Ratio, Income_Black_Ratio)",
                choices = ratio_colnames[2:11], 
                selected = "SAT_Black_Ratio", 
                multiple = TRUE),
  p("The adjacent line graph represents a complex comparison of SAT score trends alongside average yearly income trends in the US, abstracted into 5 race categories. There are 10 lines present in total, a line for the score trend and income trend for the following 5 categories: American Indian/Alaskan Native, Asian, Black, Hispanic, White. Rather than their numerical values, the scores and incomes are depicted as ratio-deviations from their respective means in hopes to highlight general correlative tendencies over the years.",
    style = "font-size: 16px;"),
  p("Analyzing this dataframe has proved to be quite insightful, as there is a significant correlation depicted between income and educational results. Such a correlation fights against the commonly abused narrative of racial factors as a causation of academic intelligence and success. This narrative is one that pushes intensely harmful stereotypes such as the Model-Minority picture, immigrants for the labor force, non-white accents as “unintelligent”, and the dehumanization of Black people. What can be taken away from the presented data, is that lower academic performance is most likely a result of lesser access to resources and opportunity, rather than a genetic disposition or correlation with race.",
    style = "font-size: 16px;")
)

viz_3_main_panel <- mainPanel(
  h2("SAT Score and Household Income Ratios based on Year and Race"),
  plotlyOutput(outputId = "ratio_plot", width = "95%", height = "600px")
)

viz_3_tab <- tabPanel("Correlation between SAT Scores and Household Incomes",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  )
)

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Conclusion",
 p("Conclusion",
    style = "font-size: 24px; font-weight: bold;"),
 p("Our first takeaway underscores the profound impact of economic disparities on educational opportunities across racial lines. Highlighting the stark differences in average yearly income among racial groups, the analysis unveils systemic inequalities entrenched within society. These disparities not only reflect broader economic divides but also directly influence access to educational resources and opportunities. The intersectionality of race and class further complicates the landscape, with policy interventions needed to address the root causes of educational inequality. Cultural attitudes, societal perceptions, and long-term implications underscore the urgency of promoting economic equity to foster greater educational access, social mobility, and societal well-being for all students, irrespective of their racial or socioeconomic backgrounds.", 
   style = "font-size: 18px;"),
 p("The second takeaway we derive from our analysis of the SAT score box-plot graph highlights the intricate interplay between racial/ethnic groups and academic performance. Notably, we observe a discernible variation in scores across different racial categories, shedding light on systemic disparities within our educational system. The distribution of scores reveals that the 'Asian, White, and Mixed Race' groups exert a significant influence, with median SAT ranges of 1223, 1113, and 1101 respectively, surpassing the median score for 'All Races' at 1059. This data suggests that students from these racial categories tend to perform above the average. By scrutinizing their backgrounds, we can initiate a nuanced exploration into the socioeconomic factors that confer advantages to certain student populations. This analysis enriches our understanding of the complexities shaping educational outcomes and emphasizes the systemic inequalities in our education system.",
   style = "font-size: 18px;"),
 p("Our third takeaway is that lower academic performance is most likely a result of lesser access to resources and opportunity, rather than a genetic disposition or correlation with race. Critical considerations to address are that income and education are likely to have a cyclic correlation – lower wages leads to less educational opportunity, leading back to lower wages. This cyclic relationship is depicted as most of the 10 lines can be described as roughly plateau. Identifying a cyclic correlation between income and education is vital to bridging the presented gap. It alerts us that to address this issue we must start by increasing access to education and resources in poor areas. Additionally public schools in such areas must be allocated resources, and provided better government funding to help end the cycle of race or community-based poverty. When we strip away the false narrative of certain races being “naturally” more proficient or capable, we are able to open our eyes to the reality of the situation and the “trap” like nature of poverty masked by complex racist theory.",
   style = "font-size: 18px;"),
 p("In summary, our analysis illuminates the intricate relationship of race, socioeconomic status, and academic performance. By recognizing the profound impact of economic disparities and systemic inequalities, we hope to highlight the urgency of transformative action. It is imperative that we prioritize policies and initiatives aimed at promoting economic equity, fostering greater access to educational opportunities, and dismantling barriers to success for all students, regardless of their background. By doing so, we can strive towards a more just and equitable education system that empowers every individual to fulfill their potential and contribute meaningfully to society no matter their cards dealt at birth.",
   style = "font-size: 18px;")
)

## Overall UI Navbar

ui <- navbarPage("Impact of Income on the Perceived Racial Disparity in Education",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)
