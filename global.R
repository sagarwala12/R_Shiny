#devtools::install_github("ramnathv/rCharts")
library(rCharts)
library(shiny)
library(tidyverse)
library(shinydashboard)
library(RColorBrewer)
library(tigris)
library(dplyr)
library(ggplot2)
library(leaflet)
library(plotly)
library(leaflet.providers)
library(googleVis)
library(htmltools)


#Read csvs
cases_state <- read.csv('./data/statewide_cases.csv')
state_test <- read.csv('./data/statewide_testing.csv')
cases_age <- read.csv('./data/case_demographics_age.csv')
cases_ethnic<- read.csv('./data/case_demographics_ethnicity.csv')
cases_sex <- read.csv('./data/case_demographics_sex.csv')
hospitals <- read.csv('./data/hospitals_by_county.csv')
county_list <- read.csv('./data/county-list.csv')


################################################
#indexing age, sex, ethnic background to cases statewide. By using the date as ID we can create separate data frames of each vector by the county it was located in, within a specific date.
#This will be used for adding data to maps by county 

tmp1 <-select(cases_state, "county", "date")

ca_age <- merge(tmp1, cases_age, by = "date")

ca_sex <- merge(tmp1, cases_sex, by = "date") 

ca_ethnic <- merge(tmp1, cases_ethnic, by = "date")


###############################################
#creating age_plot data frame by summing up all columns to age groups. 

age_plot <- select(cases_age, "age_group", "totalpositive", "deaths", "deaths_percent")
age_plota <- age_plot %>% 
  group_by(age_group) %>% 
  summarise_at(vars(totalpositive),
               list(totalpositive = sum))
age_plotb <- age_plot %>% 
  group_by(age_group) %>% 
  summarise_at("deaths",
               funs(deaths = sum),
               na.rm=TRUE)

age_plotc <-age_plot %>% 
  group_by(age_group) %>% 
  summarise_at("deaths_percent",
               funs(deaths_percent = mean),
               na.rm=TRUE)

age_plot <- merge(age_plota, age_plotb, by = "age_group")
age_plot <- merge(age_plot, age_plotc, by = "age_group")

###############################################
#temp 

state_stat <- data.frame(state.name = rownames(state.x77), state.x77)
# remove row names
rownames(state_stat) <- NULL
# create variable with colnames as choice
choice <- colnames(state_stat)[-1]






