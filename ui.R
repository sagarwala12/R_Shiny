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
                          tabName = "cnty", icon = icon("apple-alt")),
              
                          
                          
                          selectizeInput("selected",
                                         "select Item to Display",
                                         choice)
                          
                          
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
                            h2('Do Age, Sex, and Ethnicity influence the spread of COVID-19 in California? '),
                            h3('For nearly a year COVID has plauged us '),
                            h3('California in particular was hit hard'),
                            h4('Previously due to lack of testing it was difficult to drawn conclusions or look for trends in data'),
                            h4('As testing increased over time, more information has been gathered'),
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
                                h3('Bar Plot of Gender Demographic'),
                                h4('-Drag and click to zoom, right click to reset'),
                                fluidRow(
                                  box(htmlOutput('bar2'), width = "auto")
                                  
                                ),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                h3('Combonation Chart of Race Demographic'),
                        
                                fluidRow(
                                  box(htmlOutput('combo1'), width = "auto")
                                
                                  ),
                                h4('Why do Latinos suffer so much? - This is largely due to the fact that latinos predominately work in the service industry and tend to live in large family household setting'),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                             
                              
                                h3('Bar Plot of Age Demographic'),
                                fluidRow(
                                  box(htmlOutput('bar1'), width = "auto")
                                  
                                  ),
                               
                           
                                
                                ),
                        
                         tabItem(tabName = 'map',
                            h2('Map of Coronavirus Data'),
                            fluidRow(
                              box(leafletOutput("map"), width = "auto"),
                              box(textOutput("cnty")),
                              h3(' '),
                              br(),
                              br(),
                              br(),
                              br(),
                            )),
                        tabItem(tabName = 'cnty',
                                h2('Data Table by County'),
                                h3('Cases State Wide'),
                                fluidRow(
                                  box(htmlOutput('tb1'), width = "auto")
                                
                                ))
                     ))
)
)

                        