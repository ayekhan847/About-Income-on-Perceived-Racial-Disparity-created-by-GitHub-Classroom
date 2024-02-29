# load packages
library(shiny)
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(plotly)

# read dataframe
sat_by_race <- read.csv("sat_by_race.csv")
sat_income_df <- read.csv("sat_income_df.csv")
ratio_df <- read.csv("ratio_df.csv")

ratio_colnames = colnames(ratio_df)

ratio_long <- ratio_df %>%
  select(all_of(ratio_colnames)) %>% 
  gather(key = "Race", value = "Ratio", -Year)

length(ratio_long$Race)

server <- function(input, output){
  selected_race_data <- reactive({
    ratio_long %>%
      filter(Race %in% input$selected_race)
  })
  
  output$ratio_plot <- renderPlotly({
    sat_income_plot <- ggplot(selected_race_data()) +
      geom_line(mapping = aes(x = Year, 
                              y = Ratio, 
                              color = Race))+
      labs(title = "SAT and Income Ratio over Years",
           x = "Year",
           y = "Ratio")
    
    return(ggplotly(sat_income_plot))
  })
}
