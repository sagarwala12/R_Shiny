function(input, output){

output$line1 <- renderGvis({
 gvisLineChart(state_test, "date", "tested", 
               options = list(width= "1500", height = "500",
                              title = "COVID Testing progress in CA",
                              hAxis ="{title:'Dates'}",
                              vAxis="{title: 'total tested'}")
               )
  
})

output$bar1 <- renderGvis({
  gvisBarChart(age_plot, xvar="age_group", yvar=c("totalpositive", "deaths", "deaths_percent"),
               options=list(title="Age Demographics",
                            titleTextStyle="{color:'Black',fontName:'Courier',fontSize:16}",
                            width="1500", height="500",
                            legend = "bottom",
                            explorer="{actions:['dragToZoom', 'rightClickToReset']}",
                            bar="{groupWidth:'100%'}")
               )
  
})
  

output$map <- renderGvis({
  gvisGeoChart(state_stat, "state.name", input$selected,
               options=list(region="US", displayMode="regions",
                            resolution="provinces",
                            width="1500", height="500"))
  # using width="auto" and height="auto" to
  # automatically adjust the map size
})
# show histogram using googleVis
output$hist <- renderGvis(
  gvisHistogram(state_stat[,input$selected, drop=FALSE]))



output$table <- DT::renderDataTable({
  datatable(state_stat, rownames=FALSE) %>%
    formatStyle(input$selected,
                background="skyblue", fontWeight='bold')
  # Highlight selected column using formatStyle
})

output$demographics <- renderPlotly({
  #fit <- reactive({lm(data[x] ~ data[y])})
  data %>%
    ggplot(., aes(label = Zip)) +
    geom_point(aes_string(x=input$x, y=input$y)) +
    ggtitle('Demographics and Covid-19') +
    xlab(switch(input$x, 'Median.Household.Income' = 'Median Household Income', 'Percent_College' = 'Percent Bachelors Degree or Higher', 'Percent_Public_Transit' = 'Percent Taking Public Transit', 'Percent_Crowded' = 'Crowded Housing(Percent of population living in crowded housing)')) +
    ylab(switch(input$y, 'Percent.Population' = 'Percent Tested Population Positive for Covid-19', 'Positive'='Total Positive', 'Total_Tests' = 'Total Tests'))
  #abline(fit())  
})

}











