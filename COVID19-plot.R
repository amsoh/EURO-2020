library(RcppRoll)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(gapminder) 

#Data Transformation to a desired dataset with the required set of countries and columns (attributes)
#new_cases_smoothed_per_million was used to better visualize the data on a line graph (better relative comparison as the axis range has been reduced due to "per million")
Covid_data <- read_csv("COVID-19.csv")
?select
Covid_data_1 <- select(Covid_data, date, location, new_cases_smoothed_per_million)
Covid_data_eu <- filter(Covid_data_1, location == "Azerbaijan" | location == "Denmark" | location == "England" | 
location == "Germany" | location == "Hungary" | location == "Italy" | location == "Netherlands" | location == "Ireland" | 
location == "Romania" | location == "Russia" | location == "Scotland" | location == "Spain")

#Filtering data according to date (around 6 months prior to the latest observation) to present data on a relevant and fitting timeline.
#Use of as.date to change the format of date to fit the x-axis label.
Covid_data_final <- Covid_data_eu %>% 
  filter(date >= as.Date("6/1/2020"))
Covid_data_final$date = as.Date(Covid_data_final$date, format = "%m/%d")

#Creating a ggplot to present the data:
#use of geom_line() as an ideal form of representation for the data
#grouped according to number of countries (10) and legend according to the stadium location
#use of facet_wrap() to distinctly show the countries with the same axis grids and range
ggplot(Covid_data_final, aes(x = date, y = new_cases_smoothed_per_million, col = location, group = 10)) +
  geom_line() +
  labs(title = "New Covid-19 Cases in Shortlisted Europoean Countries",
        subtitle = "For EUROS 2020", 
        x = "Date",
        y = "New Cases (smoothed per million)",
        color = "Stadium Location") +
  facet_wrap( ~ location, nrow = 2)
