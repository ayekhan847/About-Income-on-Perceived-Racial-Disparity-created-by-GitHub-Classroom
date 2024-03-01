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

#For graph 1
SAT_colnames = colnames(sat_by_race)
sat_long <- sat_by_race %>% 
         select(all_of(SAT_colnames)) %>% 
         gather(key = "Race", value = "SAT_Score", -SAT_Year)


server <- function(input, output){
  #Graph 3 Code
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
  
  #Graph 1 Code
  selected_SAT_data <- reactive({
    sat_long %>%
      filter(Race %in% input$race_to_display)
  })
  
  output$SAT_plot <- renderPlotly({
    
    SAT_score_plot <- ggplot(selected_SAT_data()) +
      geom_boxplot(mapping = aes(x = Race, 
                                 y = SAT_Score,
                                 fill = Race))+
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
      labs(x = 'Race/Ethnicity', y = 'SAT Score', title = 'SAT Scores by Race/Ethnicity Across Years')
    
    return(ggplotly(SAT_score_plot))
    
  })
}

