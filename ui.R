library(shinydashboard)
shinyUI(dashboardPage(skin = "blue",
                      dashboardHeader(
                        title = "Covid-19 CA Demographics",
                        titleWidth = 230
                      ), 
                      dashboardSidebar(
                        sidebarUserPanel("Author: Shalabh Agarwala"),
                        
                        sidebarMenu(
                          menuItem("Introduction",
                            tabName = 'intro', icon = icon('check')),
                          
                          menuItem("Interactive Plots",
                                   tabName = 'graphs', icon = icon('ambulance')),
                          
                          menuItem("Map Visualization",
                                   tabName = "map", icon = icon("map")),
                          
                          menuItem("County Data", 
                          tabName = "Boro", icon = icon("apple-alt")),
              
                          menuItem("Conclusion and Credits" , 
                                   tabName = "info", icon = icon("address-card")),
                          
                          selectizeInput("selected",
                                         "select Item to Display",
                                         choice)
                          
                          #menuItem("About Me", 
                                   #tabName = "Me", icon = icon("address-card"))
                        )
                      ), 
                      dashboardBody(
                        tags$head(
                          tags$style(
                            HTML(
                              '.main-header .logo {
                                font-family: "Century Gothic", Century, "Century Gothic", Century;
                                font-weight: bold;
                                font-size: 14px;
                                                    }'
                            )
                          )
                        ),
                     tabItems(
                        tabItem(tabName = 'intro',
                            h2('How do Age, Sex, and Ethnicity influence the spread of COVID-19 in California? '),
                            h3('Within the past year COVID has taken the world by suprise '),
                            h3('California in particular was hit hard'),
                            h4('As testing increased over time, more information was gathered'),
                            box(htmlOutput("line1"), width = "auto"),
                            h3(' '),
                            h3('So what does influence Covid-19 infection rates?'),
                            h3('We will observe the following factors:'),
                            h4('-Age'),
                            h4('-Sex'),
                            h4('-Ethnicity')
                          ),
                        tabItem(tabName = 'graphs', 
                                h2('Comparison of Covid-19 Data Based on County Demographics'),
                                h3('Bar Plot of Age Demographic'),
                                h4('-Drag and click to zoom, right click to reset'),
                                fluidRow(
                                  box(htmlOutput('bar1'), width = "auto")
                                
                                  ),
                                h3('As you can see,')
                                ),
                        
                         tabItem(tabName = 'map',
                            h2('Map of Coronavirus Data'),
                            fluidRow(
                              box(htmlOutput("map"), width = "auto"),
                              h3(' '),
                              br(),
                              br(),
                              br(),
                              br(),
                              h3('histogram'),
                              # gvisHistoGram
                              box(htmlOutput("hist")))),
                        tabItem(tabName = "data",
                                # datatable
                                fluidRow(box(DT::dataTableOutput("table"))))
                     ))
)
)
                        