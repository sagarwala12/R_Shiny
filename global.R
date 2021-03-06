

################################################
#Libraries


library(shiny)
library(tidyverse)
library(shinydashboard)
library(RColorBrewer)
library(tigris)
library(dplyr)
library(ggplot2)
library(leaflet)
library(sf)
library(plotly)
library(leaflet.providers)
library(googleVis)
library(htmltools)


###############################################
#read csv files

cases_state <- read.csv('./data/statewide_cases.csv')
state_test <- read.csv('./data/statewide_testing.csv')
cases_age <- read.csv('./data/case_demographics_age.csv')
cases_ethnic<- read.csv('./data/case_demographics_ethnicity.csv')
cases_sex <- read.csv('./data/case_demographics_sex.csv')
#hospitals <- read.csv('./data/hospitals_by_county.csv')



################################################
#indexing age, sex, ethnic background to cases statewide. By using the date as ID we can create separate data frames of each vector by the county it was located in, within a specific date.
#This will be used for adding data to maps by county 

tmp1 <-select(cases_state, "county", "date")

ca_age <- inner_join(tmp1, cases_age, by = "date") #merge age, date, county information 

ca_sex <- inner_join(tmp1, cases_sex, by = "date") #merge sex, date, county information 

ca_ethnic <- inner_join(tmp1, cases_ethnic, by = "date") #merge ethnic, date, county information 


#################################################
#creating age_plot data frame by creating sums/means of columns, grouped to age distribution.  

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
#Create ethnic_plot

ethnic_plot <- select(cases_ethnic, "race_ethnicity", "cases", "deaths", "death_percentage", "percent_ca_population")
ethnic_plota <- ethnic_plot %>% 
  group_by(race_ethnicity) %>% 
  summarise_at(vars(cases),
               list(cases = sum))


ethnic_plotb <- ethnic_plot %>% 
  group_by(race_ethnicity) %>% 
  summarise_at(vars(deaths),
               list(deaths = sum))

ethnic_plotc <-ethnic_plot %>% 
  group_by(race_ethnicity) %>% 
  summarise_at(vars(percent_ca_population),
               list(percent_ca_population = mean))

ethnic_plot <- merge(ethnic_plota, ethnic_plotb, by = "race_ethnicity")
ethnic_plot <- merge(ethnic_plot, ethnic_plotc, by = "race_ethnicity")

###############################################
#Create Genders Plot

sex_plot <- select(cases_sex, "sex", "totalpositive2", "deaths")
sex_plota <- sex_plot %>% 
  group_by(sex) %>% 
  summarise_at(vars(totalpositive2),
               list(totalpositive2 = sum))
sex_plotb <- sex_plot %>% 
  group_by(sex) %>% 
  summarise_at("deaths",
               funs(deaths = sum),
               na.rm=TRUE)



sex_plot <- merge(sex_plota, sex_plotb, by = "sex")



###############################################
#Create dataframe that can be indexed by County Name
#Choice for select input 

state_stat <- data.frame(county = rownames(cases_state), cases_state)
rownames(cases_state) <- NULL
choice<- colnames(cases_state)[-1]



##############################################
#Map of California by county

shape <- tigris::counties(state = "CA", class = "sf")


