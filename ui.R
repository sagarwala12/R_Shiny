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
                          
                          menuItem("Interactive Covid-19 Tracker",
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
                            h3('Common Belief: Los Angeles has so many Covid-19 cases because it is a very dense city.'),
                            h4('However, when we try to relate the severity to density we do not find any correlation.'),
                            box(plotlyOutput('density'), width = 8),
                            h3('So what does influence Covid-19 infection rates?'),
                            h3('-Age'),
                            h3('-Sex'),
                            h3('-Ethnicity'),
                            h3('-Housing')
                        ),
                        
                         tabItem(tabName = 'map',
                            h2('Map of Coronavirus Data'),
                            fluidRow(
                              box(htmlOutput("map")),
                              # gvisHistoGram
                              box(htmlOutput("hist")))),
                        tabItem(tabName = "data",
                                # datatable
                                fluidRow(box(DT::dataTableOutput("table"))))
                     ))
))
                        