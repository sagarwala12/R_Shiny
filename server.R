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
                            bar="{groupWidth:'100%'}")
               )
  
})
  

output$map <- renderGvis({
  gvisGeoChart(state_stat, "state.name", input$selected,
               options=list(region="US", displayMode="regions",
                            resolution="provinces",
                            width="auto", height="auto"))
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
}











