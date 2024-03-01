#Loading libraries:
library(dplyr)
library(stringr)
library(shiny)
library(ggplot2)
library(plotly)

#Load data
sat_by_race <- read.csv("SAT_mean.csv")
income_by_race <- read.csv("Median_household_income.csv")


server <- function(input, output){
  
  # TODO Make outputs based on the UI inputs here
  
  # GRAPH 1 CODE
  output$SAT_boxplot <- renderPlotly({
   
    sat_long <- pivot_longer(
      sat_by_race, 
      cols = all_of(input$races),
      names_to = "Race",
      values_to = "SAT_Score"
    )
    
    SAT_plot <- ggplot(sat_long, aes(x = Race, y = SAT_Score)) +
      geom_boxplot() +
      scale_x_discrete(labels = c(
        "All Races", "Asian", "Black", "Hispanic", "No Response", 
        "Pacific Islander", "Mixed Race", "White", "American Indian or Alaska Native"
      )) +
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
      labs(x = 'Race/Ethnicity', y = 'SAT Score', title = 'SAT Scores by Race/Ethnicity Across Years')
    
    ggplotly(SAT_plot)
  })
}
  
  
  # GRAPH 2 CODE
  
  
  
  
  # GRAPH 3 CODE
  
  
  