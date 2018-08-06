#Creating a model for analyzing draft 
library(dplyr)
library(sqldf)
library(rvest)


###########################################################
setwd("/Users/zachtallevast/Box Sync/MLB Draft csv Files/")


#Scrub former Drafts manually
#Specify the URL for desired Website (Note Year and Round)
url <- 'https://www.baseball-reference.com/draft/?draft_round=8&year_ID=2017&draft_type=junreg&query_type=year_round'
       
#Reading the HTML code from the website
webpage <- read_html(url)

#scrape website for Draft Data
Pick <- html_nodes(webpage, '.right:nth-child(4)')
Name <- html_nodes(webpage, 'td:nth-child(9)')
Team <- html_nodes(webpage, '.left:nth-child(7)')
Position <- html_nodes(webpage, '.left+ .left a')
School <-html_nodes(webpage, '.left:nth-child(24)')

#Convert ranking data to text 
Pick <-html_text(Pick)
Name <-html_text(Name)
Team <-html_text(Team)
Position <-html_text(Position)
School <-html_text(School)
#Convert characters to data frames
Pick = as.data.frame(Pick)
Name = as.data.frame(Name)
Team = as.data.frame(Team)
Position = as.data.frame(Position)
School = as.data.frame(School)

#Lets have a look at the rankings 
head(School)
#Manually Cobine Draft Rounds
Draft2017r8 = cbind(Pick, Name, Team, Position, School)
Draft2017 = rbind(Draft2017r1, Draft2017r2, Draft2017r3, Draft2017r4, Draft2017r5, Draft2017r6, 
                  Draft2017r7, Draft2017r8, Draft2017r9, Draft2017r10, Draft2017r11, Draft2017r12, 
                  Draft2017r13, Draft2017r14, Draft2017r15, Draft2017r16, Draft2017r17, Draft2017r18, 
                  Draft2017r19, Draft2017r20, Draft2017r21, Draft2017r22, Draft2017r23, Draft2017r24, 
                  Draft2017r25, Draft2017r26, Draft2017r27, Draft2017r28, Draft2017r29, Draft2017r30, Draft2017r31, 
                  Draft2017r32, Draft2017r33, Draft2017r34, Draft2017r35, Draft2017r36, Draft2017r37, Draft2017r38, 
                  Draft2017r39, Draft2017r40)
write.csv(Draft2017, "Draft2017.csv")

#################################################################
#Instead Write A Function to do this!!!!!!!
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
