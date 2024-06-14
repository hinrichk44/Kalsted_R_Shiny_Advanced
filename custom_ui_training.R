# APPLICATION DESCRIPTION ----

# - Make custom shiny functions for  Bootstrap 3 components: Jumbotron, Info Card, and Thumbnail




# LIBRARIES ----

# Shiny
library(shiny)
library(shinythemes)

# Core
library(tidyverse)




# CUSTOM FUNCTIONS ----

# Here we are building a custom UI function for the jumbotron component.
# Order matters in a Shiny UI function.
# We have three dots at the beginning since we have no unassigned variables for this function.
# background_img and the other arguments go at the end since they have assigned default values.
# rgba() is for red, blue, green, and "a" is for "alpha" which is shading.
# You can mix these colors together by giving them each a number greater than 0.
jumbotron_ui <- function(..., background_img = NULL, jumbo_box_bg_color = "rgba(0,0,0,0.5)", jumbo_text_color = "white"){
    
    # "If there is no background image..."
    if (is.null(background_img)) {
        
        # Then we will not apply any styling to our jumbotron
        style_jumbotron <- ""
        
    } else {
        
        # Here we are making the background of our jumbotron be a photo.
        style_jumbotron <- str_glue("background-image:url({background_img}); background-size:cover;")
    }
    
    
    div(
        class = "jumbotron",
        style = style_jumbotron,
        div(
            # jumbotron-ui-box is a custom class that we will create ourself.
            class = "jumbotron-ui-box text-default bg-default",
            
            style = str_glue("color:{jumbo_text_color}; background-color:{jumbo_box_bg_color}; padding:25px"),
            
            # This is the three dots being set up.
            # You can basically use these for any item(s) you want to put that don't have default/specified values.
            # Basically this is "user input"
            ...
        )
    )
    
}


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


# Here we are building a custom UI function for the thumbnail component. 
thumbnail_ui <- function(..., thumbnail_img = NULL, text_alignment = "center"){
    
    div(
        class = str_glue("thumbnail text-{text_alignment}"),
        # img(src = "data_science_team.jpg"),
        img(src = thumbnail_img),
        div(
            class = "caption",
            # h3("Learn Data Science in Weeks, Not Years"),
            # p("These students are learning Shiny through Business Science University"),
            # a(class = "btn btn-primary btn-sm", href = "#", "Learn More") 
            
            # This is the three dots being set up.
            # You can basically use these for any item(s) you want to put that don't have default/specified values.
            # Basically this is "user input"
            ...
        )
    )
    
}




# USER INTERFACE ----

# fixedPage() is just class = container
# fluidpage() is class = container-fluid
# container does not expand the whole width of the page whereas container-fluid does.
ui <- fixedPage(
    
    title = "Custom UI Components",
    
    themeSelector(),
    
    h1(class = "page-header", "Custom UI Training"),
    
    # * JUMBOTRON COMPONENT ----
    
    div(
        class = "container",
        id = "basic_jumbotron",
        h2("Jumbotron Component"),
        column(
            width = 12,
            # Here we are calling our custom jumbotron_ui() function
            jumbotron_ui(
                # data_science_team.jpg is in our www folder
                background_img = "data_science_team.jpg",
                # These are filling in the ... argument in our function
                h3("Why Learn Shiny?", style = "color:white"),
                a(href = "#", class = "btn btn-primary", "Learn More")
            )
        )
    ),
    
    
    hr(),
    
    
    # * CARD COMPONENT ----
    
    div(
        class = "container",
        id = "cards",
        h2("Info Card"),
        
        column(
            width = 4,
            # Here we are calling our custom info_card_ui() function
            info_card_ui(card_title = "AAPL", card_description = HTML("20-Day vs. 50-Day"), card_sub_description = "20%")
        )
    ),
    
    
    hr(),
    
    
    # * THUMBNAIL COMPONENT ----
    
    div(
        class = "container",
        id    = "thumbnails",
        h2("Thumbnails"),
        column(
            width = 4, 
            # Here we are calling our custom thumbnail_ui() function.
            thumbnail_ui(
                thumbnail_img = "data_science_team.jpg",
                # We are switching the default argument from "center" to "left".
                text_alignment = "left",
                # These are filling in the ... argument in our function.
                h3("Learn Data Science in Weeks, Not Years"),
                p("These students are learning Shiny through Business Science University"),
                a(class = "btn btn-primary btn-sm", href = "#", "Learn More")
            )
        )
    ),
    
    
    div(style = "height:400px;")
    
)




# SERVER ----

server <- function(input, output, session) {
    
}




# RUN APP ----

shinyApp(ui, server)