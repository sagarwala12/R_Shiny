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

output$bar2 <- renderGvis({
  gvisBarChart(sex_plot, xvar="sex", yvar=c("totalpositive2", "deaths"),
               options=list(title="Gender Demographics",
                            titleTextStyle="{color:'Black',fontName:'Courier',fontSize:16}",
                            width="1500", height="500",
                            legend = "bottom",
                            explorer="{actions:['dragToZoom', 'rightClickToReset']}",
                            bar="{groupWidth:'100%'}")
  )
  
})
output$tb1 <- renderGvis({
  gvisTable(cases_state, options=list(page='enable', height=400))
})



output$combo1 <- renderGvis({
  gvisComboChart(ethnic_plot, xvar="race_ethnicity", yvar=c("cases", "deaths"),
                 options=list(title="Ethnic Demographic",
                              explorer="{actions:['dragToZoom', 'rightClickToReset']}",
                              titleTextStyle="{color:'black',
                                              fontName:'Courier',
                                              fontSize:16}",
                              curveType="function", 
                              pointSize=9,
                              seriesType="bars",
                              series="[{type:'line', 
                                       targetAxisIndex:0,
                                       color:'red'}, 
                                      {type:'bars', 
                                       targetAxisIndex:1,
                                       color:'grey'}]",
                              vAxes="[{title:'cases',
                                      titleTextStyle: {color: 'red'},
                                      textStyle:{color: 'black'},
                                      textPosition: 'out'}, 
                                     {title:'deaths',
                                      format:'#,###',
                                      titleTextStyle: {color: 'grey'},
                                      textStyle:{color: 'grey'},
                                      textPosition: 'out',
                                      minValue:0}]",
                              hAxes="[{title:'Race',
                                      textPosition: 'out'}]",
                              width=1500, height=500
                 ), 
                 chartid="twoaxiscombochart"
  )
})

output$map <- renderLeaflet({
  leaflet(state_stat, "county.1", input$selected) %>% 
    addTiles() %>% 
    addPolygons(data = shape, 
                fillColor = "aliceblue", 
                color = "white",
                layerId = ~COUNTYNS)
})


observe({ 
  event <- input$map_shape_click
  output$cnty <- renderText(shape$NAMELSAD[shape$COUNTYNS == event$id])
  
  event2 <- input$selected
  
  
})


output$map2 <- renderGvis({
  gvisGeoChart(state_stat, "state.name", input$selected,
               options=list(region="US", displayMode="regions",
                            resolution="provinces",
                            width="1500", height="500"))
  # using width="auto" and height="auto" to
  # automatically adjust the map size
})




}













