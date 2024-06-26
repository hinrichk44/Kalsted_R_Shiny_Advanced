# BUSINESS SCIENCE ----
# DS4B 202-R ----
# DYNAMIC UI TRAINING -----
# Version 1

# APPLICATION DESCRIPTION ----
# - Render UI a single UI component
# - Render Multiple UI Components
# - Store user information & react to adding and deleting

# LIBRARIES ----
# Shiny
library(shiny)
library(shinyWidgets)
library(shinythemes)

# Core
library(tidyverse)

# CUSTOM FUNCTIONS ----
info_card <- function(title, value, sub_value,
                      main_icon = "chart-line", sub_icon = "arrow-up",
                      bg_color = "default", text_color = "default", sub_text_color = "success") {
    
    div(
        class = "panel panel-default",
        div(
            class = str_glue("panel-body bg-{bg_color} text-{text_color}"),
            p(class = "pull-right", icon(class = "fa-3x", main_icon)),
            h4(title),
            h5(value),
            p(
                class = str_glue("text-{sub_text_color}"),
                icon(sub_icon),
                tags$small(sub_value)
            )
        )
    )
    
}



ui <- fixedPage(
    title = "Dynamic UI Components",
    
    theme = shinytheme("flatly"),
    
    h1(class = "page-header", "Dynamic UI Training"),
    
    # 1.0 SINGLE ITEM ----
    h2("Intro to UI Rendering - Single Item UI Rendering"),
    div(
        class = "container",
        id = "single_item",
        column(
            width = 4,
            class = "well",
            
            selectInput(inputId  = "sales_metrics_1",
                        label    = "Sales Metrics",
                        choices  = c("Revenue", "Profit", "Qty"), 
                        selected = "Revenue"),
            selectInput(inputId  = "sales_region_1",
                        label    = "Sales Region",
                        choices  = c("North", "South", "East", "West"), 
                        selected = "North"),
            numericInput(inputId = "metric_value_1", 
                         label   = "Metric Percent",
                         value   = 0.5),
            actionButton(inputId = "create_card_1", label = "Create Card")
        ),
        column(
            width = 8,
            # column(
            #     width = 3,
            #     info_card(title = "Revenue", value = "North", sub_value = "20%")
            # )
            
            uiOutput(outputId = "single_card")
        )
        
    ),
    
    # 2.0 MULTI ITEM -----
    h2("Multi-UI Rendering with User Data Storage"),
    div(
        class = "container",
        id = "multi_item",
        column(
            width = 4,
            class = "well",
            
            selectInput(inputId  = "sales_metric_2",
                        label    = "Sales Metric",
                        choices  = c("Revenue", "Profit", "Qty"),
                        selected = "Revenue"),
            selectInput(inputId  = "sales_region_2",
                        label    = "Sales Region",
                        choices  = c("North", "South", "East", "West"), 
                        selected = "North"),
            numericInput(inputId = "metric_value_2",
                         label   = "Metric Percent",
                         value   = 0.5),
            actionButton(inputId = "add_card_2", label = "Add"),
            
            hr(),
            uiOutput(outputId = "drop_list"),
            actionButton(inputId = "delete_card_2", label = "Drop")
            
            
        ),
        column(
            width = 8,
            
            verbatimTextOutput(outputId = "favs_print"),
            
            uiOutput(outputId = "multi_card")
        )
        
    ),
    
    
    div(style = "height:400px;")
    
    
)

# SERVER ----
server <- function(input, output, session) {
    
    # 1.0 Single Item -----
    sales_card <- eventReactive(input$create_card_1, {
        column(
            width = 3,
            info_card(
                title     = input$sales_metrics_1,
                value     = input$sales_region_1,
                sub_value = input$metric_value_1 %>% scales::percent(), 
                sub_icon  = ifelse(input$metric_value_1 > 0, "arrow-up", "arrow-down"), 
                sub_text_color = ifelse(input$metric_value_1 > 0, "success", "danger")
                
            )
        )
    })
    
    output$single_card <- renderUI({
        sales_card()
    })
    
    # 2.0 Multi Item -----
    
    # 2.1 Reactive Values & Storing User Input ----
    reactive_values <- reactiveValues()
    reactive_values$favorites_tbl <- tibble()
    
    observeEvent(input$add_card_2, {
        
        new_row_tbl <- tibble(
            sales_metric = input$sales_metric_2,
            sales_region = input$sales_region_2,
            metric_value = input$metric_value_2
        ) %>%
            mutate(id = str_glue("{sales_metric}_{sales_region}_{metric_value}"))
        
        reactive_values$favorites_tbl <- reactive_values$favorites_tbl %>%
            bind_rows(new_row_tbl) %>%
            distinct()
        
    })
    
    output$favs_print <- renderPrint({
        
        if (nrow(reactive_values$favorites_tbl) > 0) {
            reactive_values$favorites_tbl 
        }
        
    })
    
    
    
    # 2.2 Rendering Multiple Items (tagList & map) ----
    output$multi_card <- renderUI({
        
        if (nrow(reactive_values$favorites_tbl) > 0) {
            
            reactive_values$favorites_tbl %>%
                
                # Split row-wise into a list
                mutate(id = as_factor(id)) %>%
                split(.$id) %>%
            
                # Map to data in the list to the info card elements
                map(.f = function(data) {
                    
                    column(
                        width = 4,
                        info_card(
                            title     = data$sales_metric,
                            value     = data$sales_region,
                            sub_value = data$metric_value,
                            sub_icon  = ifelse(data$metric_value > 0, "arrow-up", "arrow-down"),
                            sub_text_color = ifelse(data$metric_value > 0, "success", "danger")
                        )
                    )
                    
                }) %>%
                tagList()
            
            # tagList(
            #     p("This is new text."),
            #     p("This is more text.")
            # )
        }
    })
    
    
    # 2.3 Rendering Inputs Items ----
    output$drop_list <- renderUI({
        if (nrow(reactive_values$favorites_tbl) > 0) {
            
            selectInput(
                inputId = "drop_item",
                label   = "Item to Delete", 
                choices = reactive_values$favorites_tbl %>% pull(id)
            )
            
        }
    })
    
    # 2.4 Delete Item ----
    observeEvent(input$delete_card_2, {
        if (nrow(reactive_values$favorites_tbl) > 0) {
            
            reactive_values$favorites_tbl <- reactive_values$favorites_tbl %>%
                filter(!(id %in% input$drop_item))
            
        }
         
    })
    
}

shinyApp(ui, server)
