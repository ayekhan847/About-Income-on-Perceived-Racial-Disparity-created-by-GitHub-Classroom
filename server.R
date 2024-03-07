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
income_by_race <- read.csv("Median_household_income.csv")

# For Graph 1
SAT_colnames = colnames(sat_by_race)
sat_long <- sat_by_race %>% 
         select(all_of(SAT_colnames)) %>% 
         gather(key = "Race", value = "SAT_Score", -SAT_Year)

# For graph 2 
income_colnames <- colnames(income_by_race)
income_long <- income_by_race %>%
  select(all_of(income_colnames)) %>%
  gather(key = "Race", value = "Median_Income", -Year)

income_long$Median_Income <- as.numeric(gsub(",", "", income_long$Median_Income))

# For Graph 3
ratio_colnames = colnames(ratio_df)

ratio_long <- ratio_df %>%
  select(all_of(ratio_colnames)) %>% 
  gather(key = "Race", value = "Ratio", -Year)

length(ratio_long$Race)

server <- function(input, output){
  # Graph 1 Code
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
  
  
  # Graph 2 code
  selected_year_data <- reactive({
    income_long %>%
      filter(Year %in% input$year_to_display)
  })
  
  output$income_plot <- renderPlotly({
    
    income_plot <- ggplot(selected_year_data()) + 
      geom_col(mapping = aes(
        x = Race, 
        y = Median_Income, 
        fill = Race)) +
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
      labs(x = 'Race/Ethnicity', y = 'Income' , title = 'Median HouseHold Income by Race Across Years')
    
    return(ggplotly(income_plot))
  })
  
  
  # Graph 3 Code
  selected_race_data <- reactive({
    ratio_long %>%
      filter(Race %in% input$selected_race)
  })
  
  output$ratio_plot <- renderPlotly({
    sat_income_plot <- ggplot(selected_race_data()) +
      geom_line(mapping = aes(x = Year, 
                              y = Ratio, 
                              color = Race))+
      labs(title = "SAT Score and Household Income Ratios among Races over Years",
           x = "Year",
           y = "Ratio")
    
    return(ggplotly(sat_income_plot))
  })
  
  output$intro_image_1 <- renderImage({
    list(src = "image_201_1.jpg",
         contentType = "image/jpg",
         width = 600,
         height = 440,
         align = "left")
  }, deleteFile = FALSE)
  
  output$intro_image_2 <- renderImage({
    list(src = "image_201_2.jpg",
         contentType = "image/jpg",
         width = 600,
         height = 450,
         align = "left")
  }, deleteFile = FALSE)
}

