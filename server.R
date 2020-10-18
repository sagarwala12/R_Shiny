function(input, output){

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











