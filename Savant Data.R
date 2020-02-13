library(devtools)
#Use Bill Petti's Package baseballr
#http://billpetti.github.io/baseballr/
install_github("BillPetti/baseballr")

library(tidyverse)
library(baseballr)

#Write a function that contains the necessary calls for webscraping baseball savant. 
Savant_Scrape = function(weekstart, weekend, type){
  df = baseballr::scrape_statcast_savant(start_date = weekstart, 
                                         end_date = weekend, player_type = type)
}
#Test the function. 
#date328407 = Savant_Scrape('2019-03-28','2019-04-07','batter')

#Load Statcast data week by week. In order to download the entire season, 
#I wrote a function to itterate through all 26 weeks. 
weeks = 26 #Number of weeks in the MLB Season
datalist = list()
#Using convention to scrape 10 days at a time
for (i in (1:weeks)) {
  weekname = paste0("Week", i, sep = "")
  Start = as.Date('2019-03-21')
  End = as.Date("2019-03-28")
  dat = Savant_Scrape(Start + i*7,End + i*7, 'batter' )
  dat$i <- i
  datalist[[i]] <- dat
  
}
data = do.call(rbind, datalist)


#write to .csv
write.csv(data,"BaseballSavant2019.csv", row.names = F)

