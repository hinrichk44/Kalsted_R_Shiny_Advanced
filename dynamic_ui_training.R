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


# Here we are building a custom UI function for the card component.
# Our card_title argument has no default value, so it goes first.
# We won't have a ... argument like we made above since we don't expect the user to add their own UI.
# card_icon goes last since it has a default value
info_card_ui <- function(card_title, card_description, card_sub_description, 
                         card_icon = "chart-line", card_sub_icon = "arrow-up", 
                         card_bg_color = "default", card_text_color = "default",
                         card_sub_text_color = "success"){
    
    div(
        class = "panel panel-default",
        div(
            # These are contextual colors (part of the class)
            # style is where you can have more customization of the colors you want to see. 
            # Look at our jumbotron_ui function as an example. 
            class = str_glue("panel-body bg-{card_bg_color} text-{card_text_color}"),
            p(
                class = "pull-right", 
                # Increasing the size of the icon with class = "fa-3x".
                # icon(class = "fa-3x", "chart-line")
                icon(class = "fa-3x", card_icon)
            ),
            # h4("AAPL"),
            h4(card_title),
            # h5("20-day vs. 50-day"),
            h5(card_description),
            p(
                class = str_glue("text-{card_sub_text_color}"), 
                # icon("arrow-up"), 
                icon(card_sub_icon), 
                # tags$small("20%")
                tags$small(card_sub_description)
            )
        )
    )
    
}




# USER INTERFACE ----

ui <- fixedPage(
    
    title = "Dynamic UI Components",
    
    theme = shinytheme("flatly"),
    
    h1(class = "page-header", "Dynamic UI Training"),
    
    
    h2("Intro to UI Rendering - Single Item UI Rendering"),
    div(
        class = "container",
        id = "single_item",
        column(
            width = 4,
            class = "well",
            selectInput(
                inputId = "sales_metrics_1",
                label = "Sales Metric",
                choices = c("Revenue", "Profit", "Qty"),
                selected = "Revenue"
            ),
            selectInput(
                inputId = "sales_region_1",
                label = "Sales Region",
                choices = c("North", "South", "East", "West"),
                selected = "North"
            ),
            numericInput(
                inputId = "sales_metric_value_1",
                label = "Metric Percent (Enter Positive or Negative Number Between 0-1)",
                value = 0.5
            ),
            actionButton(
                inputId = "create_sales_card_1",
                label = "Create Info Card"
            )
        ),
        column(
            width = 8,
            # column(
            #     width = 3,
            #     info_card_ui(
            #         card_title = "Revenue", 
            #         card_description = "North", 
            #         card_sub_description = "20%"
            #     )
            # )
            h4("Single Sales Card (Generated from Create Info Card)"),
            uiOutput(outputId = "single_sales_card")
        )
    ),
    
    hr(),
    
    h2("Multi-UI Rendering with User Data Storage"),
    div(
        class = "container",
        id = "multi_item",
        column(
            width = 4,
            class = "well",
            selectInput(
                inputId = "sales_metrics_2",
                label = "Sales Metric",
                choices = c("Revenue", "Profit", "Qty"),
                selected = "Revenue"
            ),
            selectInput(
                inputId = "sales_region_2",
                label = "Sales Region",
                choices = c("North", "South", "East", "West"),
                selected = "North"
            ),
            numericInput(
                inputId = "sales_metric_value_2",
                label = "Metric Percent (Enter Positive or Negative Number Between 0-1)",
                value = 0.5
            ),
            actionButton(
                inputId = "create_sales_card_2",
                label = "Create Info Card"
            ),
            br(),
            br(),
            br(),
            uiOutput(outputId = "drop_stock_list"),
            actionButton(
                inputId = "delete_info_card",
                label = "Drop Info Card"
            )
        ),
        column(
            width = 8,
            verbatimTextOutput(outputId = "stock_favorites_check"),
            uiOutput(outputId = "multi_sales_card")
        )
    ),
    
    
    div(style = "height:400px;")
    
    
)




# SERVER ----

server <- function(input, output, session) {
    
    
    # * 1.0 Single Item -----
    
    sales_card_creation <- eventReactive(input$create_sales_card_1, {
        
        column(
            width = 3,
            info_card_ui(
                card_title = input$sales_metrics_1,
                card_description = input$sales_region_1,
                card_sub_description = input$sales_metric_value_1 %>% scales::percent(),
                card_sub_icon = if_else(input$sales_metric_value_1 > 0, "arrow-up", "arrow-down"),
                card_sub_text_color = if_else(input$sales_metric_value_1 > 0, "success", "danger")
            )
        )
        
        
    })
    
    # renderUI is useful for UI components like info cards, web pages, and Shiny inputs like buttons and dropdowns.
    output$single_sales_card <- renderUI({
        
        sales_card_creation()
        
    })
    
    
    
    
    # * 2.0 Multi-Item -----
    
    
    # * 2.1 Reactive Values & Storing User Input ----
    
    
    # reactiveValues() create a list of reactive values that we can set up and update.
    # Here we set up an empty list.
    reactive_values <- reactiveValues()
    
    # Now we are adding an element to our list.
    # This element is a tibble and will start off blank.
    # But once the user enters in some values in our selectinputs, the tibble will be updated with those inputs.
    reactive_values$favorites_tbl <- tibble()
    
    # "When the user clicks the Create Info Card button..."
    observeEvent(input$create_sales_card_2, {
        
        # We will store the users options that they chose in the selectinput.
        new_row_tbl <- tibble(
            sales_metric = input$sales_metrics_2,
            sales_region = input$sales_region_2,
            metric_value = input$sales_metric_value_2
        ) %>%
            # Here we will create a unique user id for every entry.
            mutate(id = str_glue("{sales_metric}_{sales_region}_{metric_value}"))
        
        # And here we are officially adding our user inputs to the reactive value we created above.
        reactive_values$favorites_tbl <- reactive_values$favorites_tbl %>%
            # We are adding this to prevent duplicate entries
            bind_rows(new_row_tbl) %>%
            distinct()
        
    })
    
    # Here we are just using this code as a way of debugging/checking if our reactive values were populated correctly.
    output$stock_favorites_check <- renderPrint({
        
        if (nrow(reactive_values$favorites_tbl) > 0) {
            
            reactive_values$favorites_tbl %>%
                # as_factor() keeps the order as is
                mutate(id = as_factor(id)) %>%
                # split() splits an object into a list using a vector defining the groups.
                # Here we will split the id column.
                # By default the split gets reorded alpha-numerically.
                # Generally we don't want reordering to happen though.
                # Hence why we converted the id column into a factor.
                split(.$id)
        }
        
    })
    
    
    # * 2.2 Rendering Multiple Items (tagList & map) ----
    
    
    output$multi_sales_card <- renderUI({
        
        if (nrow(reactive_values$favorites_tbl) > 0) {
            
            reactive_values$favorites_tbl %>%
                mutate(id = as_factor(id)) %>%
                split(.$id) %>%
                # map() takes an iterable object (like a vector or list) and applies a function to each element.
                # So remember each element is a tibble of user input data thanks to the split() function
                map(.f = function(user_input_data){
                    
                    column(
                        width = 3,
                        # We will now map our custom info_card_ui() function to each tibble. 
                        info_card_ui(
                            card_title = user_input_data$sales_metric,
                            card_description = user_input_data$sales_region,
                            card_sub_description = user_input_data$metric_value,
                            card_sub_icon = if_else(user_input_data$metric_value > 0, "arrow-up", "arrow-down"),
                            card_sub_text_color = if_else(user_input_data$metric_value > 0, "success", "danger")
                        )
                    )
                }) %>%
                # tagList() is used to bind multiple UI tags together.
                # It stacks the HTML tags together.
                # This is very useful in creating UI
                tagList()
            
        }
        
    })
    
    
    # * 2.3 Rendering Inputs Items ----
    
    
   output$drop_stock_list <- renderUI({
        
        if (nrow(reactive_values$favorites_tbl) > 0) {
            
            # This selectinput will be used to allow the user to drop an info card from the dashboard.
            # This is just the list of cards they can drop.
            # We will have an action button that does the actual dropping. 
            selectInput(
                inputId = "drop_card_item",
                label = "Item to Delete",
                # We are extracting the unique id from the reactive values tibble we created
                choices = reactive_values$favorites_tbl %>% pull(id)
            )
            
        }
        
        
        
    })
    
    
    # * 2.4 Delete Item ----
    
    
    observeEvent(input$delete_info_card, {
        
        if (nrow(reactive_values$favorites_tbl) > 0) {
            
            reactive_values$favorites_tbl <- reactive_values$favorites_tbl %>%
                # We are getting rid of the ids within our selectinput
                filter(!(id %in% input$drop_card_item))
            
        }
        
    })
    
    
    
}




# RUN APP ----

shinyApp(ui, server)
