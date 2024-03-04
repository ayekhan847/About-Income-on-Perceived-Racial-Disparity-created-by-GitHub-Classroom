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
   h1("Introduction"),
   p("some explanation")
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
  )
)

viz_1_main_panel <- mainPanel(
  h2("SAT Score Distribution Based on Year and Race"),
  plotlyOutput(outputId = "SAT_plot", width = "95%", height = "900px")
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
  )
  
)

viz_2_main_panel <- mainPanel(
  h2("Median Household Incomes based on Year and Race"),
  plotlyOutput(outputId = "income_plot", width = "95%", height = "900px")
)

viz_2_tab <- tabPanel("Household Incomes",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)

## Ratio
# get column names from ratio_df
ratio_colnames = colnames(ratio_df)

viz_3_sidebar <- sidebarPanel(
  h2("Select Race with SAT and Income Ratio in Pair to See the Trend"),
  selectInput(inputId = "selected_race",
                label = "Select Race in Pair (eg. SAT_Black_Ratio, Income_Black_Ratio)",
                choices = ratio_colnames[2:11], 
                selected = "SAT_Black_Ratio", 
                multiple = TRUE)
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
 h1("Some title"),
 p("some conclusions")
)

## Overall UI Navbar

ui <- navbarPage("Impact of Income on the Perceived Racial Disparity in Education",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)
