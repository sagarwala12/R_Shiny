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


#indexing age, sex, ethnic background to cases statewide. By using the date as ID we can create separate data frames of each vector by the county it was located in, within a specific date.

tmp1 <-select(cases_state, "county", "date")

ca_age <- merge(tmp1, cases_age, by = "date")

ca_sex <- merge(tmp1, cases_sex, by = "date") 

ca_ethnic <- merge(tmp1, cases_ethnic, by = "date")



##### Testing googleVis

# convert matrix to dataframe
state_stat <- data.frame(state.name = rownames(state.x77), state.x77)
# remove row names
rownames(state_stat) <- NULL
# create variable with colnames as choice
choice <- colnames(state_stat)[-1]


