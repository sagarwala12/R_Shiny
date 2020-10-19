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
                                h4('-As you can see from comparing data of males to females in California there very little difference in total infected'),
                                h4('-Upon zooming in however you can see men die more than woman from the disease. Why is this?'),
                                h4('-From research men have a tendencies to die much sooner than women. Men are more likely to die from other causes such as heart disease'),
                                h4('- This could be the cause for the difference in the deaths'),
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
                                h4('- Latinos have highest infection and death Percentage in California. Why is this?'),
                                h4('- Most likely factor is that latino population are promintely in the service industry'),
                                h4('- Latinos tend to live with lots of family members, more likely to come into contact and spread'),
                                h4('- Like many other colored demographics in the US, less likely to have access to affordable healthcare'),
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
                                h4('- As you can see right away, age group 18-49 is significantly higher in infection rate.'),
                                h4('- This is most likely due to the fact that the younger part of this demographic are more likely to ignore social distancing rules and spread transmission '),
                                h4('- Although 18-49 has a very high positive infection rate, upon zooming into the chart you can see that this group and younger have very little death toll.'),
                                h4('- 65+ has a very high death toll compared to the other demographics, even though they have a signifcantly lower infection rate. '),
                               
                           
                                
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

                        