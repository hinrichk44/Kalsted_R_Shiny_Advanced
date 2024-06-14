# Introduction ----


# app.R is a special file name that runApp() looks for.


# The www folder is also a special file name for Shiny.
## It's used to store images, CSS, and JavaScript.


# For HTML, Head is where website/web app metadata and links to setup files are contained.
# Body is where the structure of your website/web app is contained.


# https://getbootstrap.com/docs/5.3/getting-started/introduction/


# Bootstrap Grid System Fundamentals
## Rows and columns
## Each row has 12 units
## The col-md stands for "medium" or larger screens
## The col-md-1 assigns 1 unit to the division


# Responsive Design: Columns respond to width of the view port
## Allows app to look good on both mobile and laptops


# Contextual Colors
## Bootstrap uses themed colors to provide context.
## For example, Success = Green



# Libraries ----

library(shiny)
library(tidyverse)
library(plotly)
library(shinythemes)
library(shinyjs)
library(DT)





# User Interface ----

ui <- fluidPage(
  
  title = "Bootstrap Cheat Sheet for R-Shiny",
  
  # HTML has tags
  # <div> is a type of tag that creates a division and is used to build a block of HTML code
  div(
    # class =  "container-fluid" has default dimensions of:
    # padding-right: 15px
    # padding-left: 15px
    # margin-right: auto
    # margin-left: auto
    # class = "container-fluid"
    
    # Class is an attribute that is used by a number of HTML tags.
    # Certain classes like container-fluid are bootstrap classes that have preset CSS.
    class = "container",
    # An id is a way to target specific elements on a page with CSS and JS.
    # Unlike classes, no two id's should be the same. 
    id = "front_page",
    # Most of these HTML tags have wrapper functions.
    # h1() =  tags$h1()
    # tags$small reduces the size of the text.
    h1(
      # class = "page-header" is a bootstrap class that makes text larger than normal.
      # This is useful for Web Page headers. 
      class = "page-header",
      "Bootstrap Cheat Sheet", tags$small("For Shiny")
    ),
    
    # HTML() allows us to write HTML code that gets integrated into our app.
    # This produces the exact same output as what we have in our h1() frame. 
    # HTML('<h1 class = "page-header">
    #      Bootstrap Cheat Sheet
    #      <small> For Shiny </small>
    #      </h1>')
    
    
    # p() creates a p$tag for a paragraph of text <p></p>
    p(
      # The class = lead makes text elements stand out as introductory or leading text.
      # Including increased font size, increased line height, and increased font weight.
      class = "lead", 
      "This cheatsheet is the first part of the course on", 
      # a() creates an a-tag, which creates a hyperlink using the href argument.
      # <a href =  #></a>
      a(
        href = "https://university.business-science.io/", 
        # target = "_blank" opens up the link in a new window.
        target = "_blank", 
        "Shiny Web Applications 2"
      ),
      "by Business Science"
    ),
    
    h2("Table of Contents"),
    
    tags$ul(
      tags$li("Bootstrap Grid System" %>% a(href = "#section_1")),
      tags$li("Text Formatting" %>% a(href = "#section_2")),
      tags$li("Text Alignment" %>% a(href = "#section_3")),
      tags$li("Lists" %>% a(href = "#section_4")),
      tags$li("Contextual Colors and Backgrounds" %>% a(href = "#section_5")),
      tags$li("Buttons" %>% a(href = "#section_6")),
      tags$li("Images" %>% a(href = "#section_7")),
      tags$li("Thumbnails" %>% a(href = "#section_8")),
      tags$li("Navbars" %>% a(href = "#section_9")),
      tags$li("Navs" %>% a(href = "#section_10")),
      tags$li("Sidebar Layout" %>% a(href = "#section_11")),
      tags$li("Jumbotrons" %>% a(href = "#section_12")),
      tags$li("Cards and Panels" %>% a(href = "#section_13")),
      tags$li("Mobile" %>% a(href = "#section_14")),
      tags$li("CSS & Themes" %>% a(href = "#section_15")),
      tags$li("ShinyJS" %>% a(href = "#section_16"))
    ),
    
    br(),
    br(),
    
    # This div is used for our Table of Contents.
    # When you click on the link it will take you directly in the line of code where this div is set up.
    # So we are putting this line of code right above the title so we can be taken to the title. 
    div(id = "section_1"),
    h2("Bootstrap Grid System"),

    
    div(
      # text-center centers all of the text inside a division
      class = "container text-center",
      # fluidRow adds a row and is the bootstrap equivalent of <div class = "row></div>
      fluidRow(
        # column() adds a column of width = #
        # Bootstrap equivalent of <div class = "col-sm-#"></div>
        column(
          width = 4,
          # class = "bg-primary" is a bootstrap class to set the background color to the "primary" theme color
          class = "bg-primary",
          p("Grid Width 4")
        ),
        column(
          width = 4,
          # class = "bg-warning" is a bootstrap class to set the background color to the "warning" theme color
          class = "bg-warning",
          p("Grid Width 4")
        ),
        column(
          width = 4,
          # class = "bg-danger" is a bootstrap class to set the background color to the "danger" theme color
          class = "bg-danger",
          p("Grid Width 4")
        )
      ),
      
      fluidRow(
        column(
          width = 3,
          class = "bg-primary",
          p("Grid Width 3")
        ),
        column(
          width = 9,
          class = "bg-info",
          p("Grid Width 9")
        )
      )
      
    ),
    
    
    # hr() stands for "Horizontal Rule" and simply creates a horizontal line.
    # Shows up as a faint line and is useful to divide up sections.
    hr(),
    
    br(),
    br(),
    
    div(id = "section_2"),
    h2("Text Formatting"),
    
    p(
      class = "lead",
      "For this section we will focus on text editing in Shiny"
    ),
    
    fluidRow(
      column(
        width = 6,
        p("This includes bold, italics, colors, etc."),
        # strong() makes text bold. <strong></strong>
        # em() makes text italicized. <em></em>
        p(strong("In Section 1"), "we learned about the", strong(em("Booststrap Grid System"))),
        # tags$mark allows you to highlight text.
        # code() formats inline text as code. <code></code>
        p(tags$mark("In Section 2"), "we will fcous on text formatting in", code("bootstrap"))
      )
      ,
      column(
        width = 6,
        # tags$blockquote formats text as a quote. <blockquote></blockquote>
        tags$blockquote(
          # This will reverse the blockquote.
          # Maybe you do this if you don't like the default alignment of the blockquote. 
          class = "blockquote-reverse",
          p("Text editing will really help your app stand out"),
          # This will add a little footer to the quote so you can help attribute the quote to someone. 
          # tags$cite italicizes text, and works well when citing who made the quote.
          tags$footer("Quote by", tags$cite(title = "Harry Kalsted", "Harry Kalsted"))
        )
      )
    ),
    
    
    hr(),
    
    br(),
    br(),
    
    div(id = "section_3"),
    h2("Text Alignment"),
    
    div(
      class = "container",
      id = "text_alignment_1",
      p(
        class = "text-left text-lowercase",
        "Left-Aligned Lowercase Text"),
      p(
        class = "text-center text-uppercase",
        "Center-Aligned Uppercase Text"),
      p(
        class = "text-right text-capitalize",
        "right-aligned capitalized text")
    ),
    
    div(
      class = "container",
      id = "text_alignment_2",
      fluidRow(
        p(
          class = "text-left text-lowercase",
          "Left-Aligned Lowercase Text") %>% column(width = 4, class = "bg-primary"),
        p(
          class = "text-center text-uppercase",
          "Center-Aligned Uppercase Text")%>% column(width = 4, class = "bg-info"),
        p(
          class = "text-right text-capitalize",
          "right-aligned capitalized text") %>% column(width = 4, class = "bg-success")
      )
      
    ),
    
    
    hr(),
    
    br(),
    br(),
    
    div(id = "section_4"),
    h2("Lists"),
    
    p(
      class = "lead",
      "Here is an unordered list"
    ),
    
    # tags$ul() creates an unordered list (bulleted). <ul></ul>
    tags$ul(
      # tags$li() creates a list item. <li></li>
      tags$li("Item 1"),
      tags$li("Item 2"),
      tags$li("Item 3"),
      tags$li("Item 4")
    ),
    
    p(
      class = "lead",
      "Here is an ordered list"
    ),
    
    # tags$ol() creates an ordered list (numeric).
    tags$ol(
      tags$li("Item 1"),
      tags$li("Item 2"),
      tags$li("Item 3"),
      tags$li("Item 4")
    ),
    
    p(
      class = "lead",
      "Here is an in-line list"
    ),
    
    tags$ul(
      # class = list-inline will put the list horizontal instead of vertical
      # Also gets rid of the bullet points/numbers
      class = "list-inline",
      tags$li("Item 1"),
      tags$li("Item 2"),
      tags$li("Item 3"),
      tags$li("Item 4")
    ),
    
    
    hr(),
    
    br(),
    br(),
    
    div(id = "section_5"),
    h2("Contextual Colors and Backgrounds"),
    
    p(
      # text-primary will change the color of the text to the primary contextual color (blue)
      class = "text-primary",
      "This text is colored using contextual primary"
    ),
    p(
      class = "text-success",
      "This text is colored using contextual success"
    ),
    p(
      class = "text-info",
      "This text is colored using contextual info"
    ),
    p(
      class = "text-warning",
      "This text is colored using contextual warning"
    ),
    p(
      class = "text-danger",
      "This text is colored using contextual danger"
    ),
    
    
    p(
      # bg-primary will change the color of the text background to the primary contextual color (blue)
      class = "bg-primary",
      "This background is colored using contextual primary"
    ),
    p(
      class = "bg-success",
      "This background is colored using contextual success"
    ),
    p(
      class = "bg-info",
      "This background is colored using contextual info"
    ),
    p(
      class = "bg-warning",
      "This background is colored using contextual warning"
    ),
    p(
      class = "bg-danger",
      "This background is colored using contextual danger"
    ),
    
    
    hr(),
    
    br(),
    br(),
    
    div(id = "section_6"),
    h2("Buttons"),
    
    h3("Contextual Buttons"),
    
    div(
      class = "container",
      a(
        href = "https://university.business-science.io/",
        # class = "btn btn-default" will create a button for us
        # So now when a user clicks on the button they will be taken to the link we set up in the href above
        class = "btn btn-default",
        "Shiny Web Applications 2"),
      a(
        href = "https://university.business-science.io/",
        # class = "btn btn-primary" will create a button for us and the background color will change
        class = "btn btn-primary",
        "Shiny Web Applications 2 Primary"),
      a(
        href = "https://university.business-science.io/",
        class = "btn btn-success",
        "Shiny Web Applications 2 Success"),
      a(
        href = "https://university.business-science.io/",
        class = "btn btn-warning",
        "Shiny Web Applications 2 Warning"),
      a(
        href = "https://university.business-science.io/",
        class = "btn btn-danger",
        "Shiny Web Applications 2 Danger")
    ),
    
    br(),
    
    h3("Sizing Buttons"),
    
    div(
      class = "container",
      a(
        href = "https://university.business-science.io/",
        # class = "btn btn-lg" will increase the size of the button to large
        class = "btn btn-default btn-lg",
        "Shiny Web Applications 2 Large"),
      a(
        href = "https://university.business-science.io/",
        class = "btn btn-default btn-md",
        "Shiny Web Applications 2 Medium"),
      a(
        href = "https://university.business-science.io/",
        class = "btn btn-default btn-sm",
        "Shiny Web Applications 2 Small"),
      a(
        href = "https://university.business-science.io/",
        class = "btn btn-default btn-xs",
        "Shiny Web Applications 2 Extra Small")
    ),
    
    br(),
    
    h3("Action Buttons"),
    # tags$button() operates very similar to the a-tag with class btn.
    div(
      class = "container",
      actionButton(
        inputId = "btn_1",
        label = "Action Button One (Click Me)",
        class = "btn-primary btn-lg",
        # class = "fa-1x" is how you can adjust the size of the icon.
        # Keep increasing the number to increase the size of the icon. 
        # The default library for icons is font-awesome but we are explicitly stating it here just to show that it's an argument.
        icon = icon("sync", class = "fa-1x", lib = "font-awesome")
      ),
      textOutput(outputId = "btn_1_output")
    ),
    
    
    hr(),
    
    br(),
    br(),
    
    div(id = "section_7"),
    h2("Images"),
    
    div(
      class = "container",
      column(
        width = 4,
        # img() is how we can insert an image into our app.
        img(
          # class = "thumbnail" formats the image with a border that has rounded corners. 
          # class = "img-responsive" makes images responsive to the width of the viewpoint. 
          # So we are putting this image in a column of width = 4, so it will adjust to that now. 
          class = "thumbnail img-responsive",
          # src is the file path of where our image is stored.
          # If the image is in the www folder, then you just need to provide the relative path from inside the www folder.
          # So in this instance we are just using business-science-logo.png instead of www/business-science-logo.png.
          src = "business-science-logo.png",
          # The style argument will allow us to add some CSS features to our image. 
          # In this instance the default width will be 200px, but will shrink if our page shrinks.
          style = "width:200px;"
        )
      ),
      column(
        width = 4,
        img(
          # class = "img-rounded" formats the iamge with rounded corners, but no border. 
          class = "img-rounded img-responsive",
          src = "matt-pic.jpg",
          style = "width:200px;"
        )
      ),
      column(
        width = 4,
        img(
          # class = "img-circle" formats the image as a circle. 
          class = "img-circle img-responsive",
          src = "matt-pic.jpg",
          style = "width:200px;"
        )
      )
    ),
    
    
    hr(),
    
    br(),
    br(),
    
    div(id = "section_8"),
    h2("Thumbnails"),
    
    fluidRow(
      column(
        width = 4,
        div(
          class = "thumbnail text-center",
          # style = "padding: 20px;" gives us some space between the image and the border. 
          style = "padding: 20px;",
          img(
            class = "img-rounded img-responsive",
            src = "matt-pic.jpg"
          ),
          p("Text about this thumbnail"),
          # Here we are adding a hyperlink to our image but as a button.
          # For now just using # as a filler so the link will not take you anywhere.
          a(class = "btn btn-primary btn-sm", href = "#", "Learn More")
        )
      ),
      column(
        width = 4
      ),
      column(
        width = 4
      )
    ),
    
    
    hr(),
    
    br(),
    br(),
    
    div(id = "section_9"),
    h2("Navbars"),
    
    # navbarPage() creates a bootstrap navbar.
    # Typically used as a navigation tool for multi-page applications.
    # They also typically replace fluidPage() in more advanced Shiny apps.
    navbarPage(
      title = "Business Science Navbar",
      # Setting inverse = TRUE will convert our navbarpage into dark mode. 
      inverse = TRUE,
      # Setting collapsible = TRUE will allow you to adjust the size of the navbar. 
      # This is good for mobile devices. 
      collapsible = TRUE,
      tabPanel(
        title = "What is Shiny?",
        value = "tab_pg_1",
        h1("What is Shiny?", tags$small("A framework for building web apps with R")),
        p("Here are all of the cool features in Shiny")
      ),
      tabPanel(
        title = "What is Bootstrap?",
        value = "tab_pg_2",
        h1("What is Bootstrap?", tags$small("A popular web framework that extends HTML and CSS")),
        p("Here are all of the cool features in Bootstrap")
      ),
      # navbarMenu() creates a navbar dropdown
      navbarMenu(
        title = "Using Shiny and Bootstrap",
        tabPanel(
          title = "Make Plots"
        ),
        tabPanel(
          title = "Shiny Components"
        ),
        # This adds a separator (like hr())
        "----",
        tabPanel(
          title = "More Info"
        )
      )
    ),
    
    
    hr(),
    
    br(),
    br(),
    
    div(id = "section_10"),
    h2("Navs"),
    
    h3("Tabset Panels"),
    
    # tabsetPanel() creates a tabbed nav from Bootstrap
    tabsetPanel(
      id = "tabset_1",
      # You can change type to "pills"
      type = "tabs",
      tabPanel(
        title = "Tab Shiny",
        h3("What is Shiny?"),
        p("Shiny is awesome")
      ),
      tabPanel(
        title = "Tab Bootstrap",
        h3("What is Bootstrap?"),
        p("Bootstrap is awesome")
      )
    ),
    
    br(),
    
    h3("Navlist Panels"),
    
    # navlistPanel() is a component that combines fluidrow(), columns, wells, lists, and stacked nav bootstrap class.
    # Shiny converts the appropriate tab panel's class to "active" to show its contents.
    navlistPanel(
      id = "navlist_1",
      tabPanel(
        title = "Tab Shiny",
        h3("What is Shiny?"),
        p("Shiny is awesome")
      ),
      tabPanel(
        title = "Tab Bootstrap",
        h3("What is Bootstrap?"),
        p("Bootstrap is awesome")
      )
    ),
    
    
    hr(),
    
    br(),
    br(),
    
    div(id = "section_11"),
    h2("Sidebar Layout"),
    
    # sidebarLayout() creates a dashboard-style format for Shiny app pages.
    # It is a component that combines a row, two columns, a well, and a form section that's similar to a div.
    sidebarLayout(
      # sidebarPanel() creates a well for UI components.
      sidebarPanel = sidebarPanel(p("UI Elements Go Here")),
      # mainPanel() creates a container for output (like plots and tables).
      mainPanel = mainPanel("Plot Elements and Analysis Go Here.")
    ),
    
    
    hr(),
    
    br(),
    br(),
    
    div(id = "section_12"),
    h2("Jumbotrons"),
    
    div(
      class = "jumbotron",
      h1("Learning Shiny"),
      p("It's you solution for building web applications with R")
    ),
    
    
    hr(),
    
    br(),
    br(),
    
    div(id = "section_13"),
    # Panels and cards are nice ways to house objects like plots.
    h2("Panels and Cards"),
    
    div(
      # Makes a Bootstrap 3 Panel
      # panel-default is grey. You can change this to something like panel-primary
      class = "panel panel-primary",
      div(
        class = "panel-heading",
        h3("Chart Title")
      ),
      div(
        # panel-body is the default
        class = "panel-body bg-info",
        p("Insert Chart"),
        plotlyOutput(outputId = "mtcars_plot")
      ),
      div(
        class = "panel-footer",
        p(tags$small("Footer of chart")) 
      )
    ),
    
    
    hr(),
    
    br(),
    br(),
    
    div(id = "section_14"),
    h2("Mobile UI Development"),
    
    fluidRow(
      # hidden-* hides elements on specific screen sizes. 
      # Just replace * with xs, sm, md, lg. 
      # For this example we will hide things on extra small UI (around 700 pixels)
      class = "hidden-xs",
      div(
        class = "jumbotron",
        h1("Learning Shiny"),
        p(
          class = "lead",
          "Will help you distribute interactive data science projects"
        ),
        p("THIS WILL BE HIDDEN IN EXTRA SMALL MOBILE DEVICE SCREENS BUT NOT LAPTOPS")
      )
    ),
    fluidRow(
      # This will now be hidden on all screens NOT extra small. 
      class = "hidden-sm hidden-md hidden-lg",
      div(
        class = "thumbnail text-center",
        img(
          class = "img-responsive",
          style = "width:200px",
          src = "business-science-logo.png"
        ),
        h3("Learning Shiny"),
        p(
          class = "lead",
          "Will help you distribute interactive data science projects"
        ),
      )
    ),
    
    
    hr(),
    
    br(),
    br(),
    
    div(id = "section_15"),
    h2("CSS and Themes"),
    
    p("Look at the code to view the CSS styling behind the hood of our app"),
    
    fluidPage(
      # In the shinytheme() argument you should provide a Bootswatch theme.
      # These are available on the shinythemes website. 
      theme = shinytheme("flatly"),
      # themeSelector() creates a modal popup window that allows us to test different Bootswatch themes. 
      # themeSelector()
      
      # tags$head() allows us to append elements to the HEAD of our app.
      tags$head(
        # tags$link() is most commonly used to connect to a CSS file.
        # tags$link(
        #   rel = "stylesheet",
        #   type = "text/css",
        # Here we are linking to our CSS file that we have in our www folder. 
        #   href = "bootstrap.min.css"
        # ),
        tags$link(
          rel = "stylesheet",
          type = "text/css",
          # Here we are linking to our CSS file that we have in our www folder. 
          href = "my_custom_css.css"
        )
      )
    ),
    
    
    hr(),
    
    br(),
    br(),
    
    div(id = "section_16"),
    h2("JavaScript (ShinyJS)"),
    
    # useShinyjs() enable the application to use ShinyJS functionality. 
    # This would typically go at the top of our UI but is here just to organize the cheat sheet effectively.
    useShinyjs(),
    
    fluidRow(
      column(
        width = 4,
        class = "well",
        actionButton(
          inputId = "toggle_form_btn",
          label = "Toggle Form"
        ),
        div(
          id = "controls",
          br(),
          textInput(
            inputId = "first_name",
            label = "First Name",
            placeholder = "Please enter your first name"
          ),
          textInput(
            inputId = "email",
            label = "Email",
            placeholder = "Please enter your email"
          ),
          actionButton(
            inputId = "submit_form_btn",
            label = "Submit Form"
          )
          # Here we will hide everything that's within this div
          # This comes from the shinyjs package
        ) %>% hidden(),
        div(
          id = "thank_you",
          br(),
          div(
            # class = "alert" creates a Bootstrap alert
            class = "alert alert-success",
            role = "alert",
            p("Thank you!", actionButton(
              inputId = "close_alert_btn",
              label = "X",
              class = "pull-right btn-xs"
            ))
          )
        )
      ),
      column(
        width = 8,
        DTOutput(outputId = "new_user_table")
      )
    ),
    
    
    
    
    
    
    
    div(
      style = "height: 400px;"
    )
    
    
    
  )
  
  
)




# Server ----

server <- function(input, output, session) {
  
  
  # * Server Logic Action Button Click Counter ----
  
  # The double assignment arrow will allow any calculations performed to be reactive to the global environment.
  # This trick is used to create counters and other functionality that persists through multiple user events. 
  # We will start our counter with 0.
  btn_counter <<- 0
  
  # Here we are creating a variable dependent on clicking our input$btn_1 action button.
  btn_1_click <- eventReactive(input$btn_1, valueExpr = {
    
    # We will make the default return to be TRUE.
    TRUE
    # And then every time you click the button, the counter increases by one.
    btn_counter <<- btn_counter + 1
    
  })
  
  # And now here we are setting up our text output that is also dependent on the input$btn_1 action button.
  output$btn_1_output <- renderText({
    
    # If the output of btn_1_click is TRUE..."
    if(btn_1_click()) {
      
      # str_glue() concatenates data with bracket syntax.
      str_glue("You clicked me {btn_counter} times")
      
    } else {
      
      
    }
    
  })
  
  
  # * Server Logic Card/Panels Output ----
  
  output$mtcars_plot <- renderPlotly({
    
    g <- mtcars %>%
      ggplot(aes(wt, mpg)) +
      geom_point()
    
    ggplotly(g)
    
    
  })
  
  
  # * Server Logic ShinyJS  ----
  
  # onclick() triggers code to run based on clicking an object with a specified id.
  # It comes from the shinyjs package.
  # So here when our Toggle Form button is clicked...
  onclick(id = "toggle_form_btn",{
    
    # toggle() also comes from the shinyjs package.
    # Simply toggles the visibility of an object.
    # So here we are toggling the visibility of everything in the div where the id = "controls".
    toggle(id = "controls",
           # This will give a sliding animation when changing from hidden to reveal.
           anim = TRUE)
    
  })
  
  
  # The difference between observe() and observeEvent() is subtle.
  # Observe will look for a reactive value to change and then execute the code.
  observe({
    
    # toggleState() comes from shinyjs
    # It disable and enables an element that is specified by an HTML id attribute
    toggleState(id = "submit_form_btn",
                condition = {
                  
                  # So here we're saying leave the Submit button disabled until someone has entered text for their First Name and Email
                  !(input$first_name == "") && !(input$email == "")
                  
                })
    
  })
  
  
  new_user_tbl <- eventReactive(eventExpr = input$submit_form_btn, {
    
    new_user <- tibble(
      first_name  = input$first_name,
      email =  input$email,
      timestamp = lubridate::now()
    )
    
  })
  
  
  output$new_user_table <- renderDataTable({
    new_user_tbl() %>%
      datatable()
  })
  
 
  
  observeEvent(eventExpr = input$submit_form_btn, {
    
    toggle(id = "thank_you", anim = TRUE, animType = "fade", time = 0.25)
    
  })
  
  
   onclick(id = "close_alert_btn", {
     
     toggle(id = "thank_you", anim = TRUE, animType = "fade", time = 0.25)
     
   })
  
  
  
  
  
}




# Run the App ----

shinyApp(ui, server)