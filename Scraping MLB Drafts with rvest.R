#Creating a model for analyzing draft 
library(dplyr)
library(sqldf)
library(rvest)
###########################################################
#Scrub former Drafts manually with rvest
#Specify the URL for desired Website (Note Year and Round)
#################################################################
pages = 40 #Number of webpages to scrape. Hence there are 40 rounds in the MLB Draft
sci_df <- data.frame()

for (page in (1:pages)) {
  print(paste0("getting data for page: ", page))
  URL <- paste0("https://www.baseball-reference.com/draft/?draft_round=", page,"&year_ID=2005&draft_type=junreg&query_type=year_round")
  
  webpage <- read_html(URL)
  page_list <- webpage %>% 
    html_nodes('td') %>% 
    html_text() %>%
    gsub("^\\s+|\\s+$", "", .) #strip the white space from the beginning and end of a string.
  

  Round <- webpage %>% 
    html_nodes('th+ .right') %>% 
    html_text() %>% 
    as.data.frame()
  
  Pick <- webpage %>% 
    html_nodes('.right:nth-child(4)') %>% 
    html_text() %>% 
    as.data.frame()
  
  Name <- webpage %>% 
    html_nodes('td:nth-child(9)') %>% 
    html_text() %>% 
    as.data.frame()
 
   Team <- webpage %>% 
     html_nodes('.left:nth-child(7)') %>% 
     html_text() %>% 
     as.data.frame()
  
  Position <- webpage %>% 
    html_nodes('.left+ .left a') %>% 
    html_text() %>% 
    as.data.frame()
  
  School <- webpage %>% 
    html_nodes('.left:nth-child(24)') %>% 
    html_text() %>% 
    as.data.frame()
  
  
 
  tmp <- data.frame(Round,Pick,Name,Team,Position,School)
  if(pages ==1) {
    sci_df <- data.frame(tmp)
  } else { 
    sci_df <-rbind(sci_df, tmp) 
    }
  }



names(sci_df) <- c("Round", "Overall Pick", "Name", "Team", "Position", "School")
write.csv(sci_df, "Draft2005.csv")
