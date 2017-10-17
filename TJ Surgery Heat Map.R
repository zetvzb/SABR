TJSurgeries <- read.csv(file="/Users/zachtallevast/Box Sync/SABR/Tommy John Project/Players with TJ Surgery.csv",na.strings= "..",header=TRUE,sep=",", fill=TRUE)
MasterBio <- read.csv(file="/Users/zachtallevast/Box Sync/SABR/Lahmans Database/core/Master.csv", na.strings = "..", header=TRUE)

TJSurgeries <- TJSurgeries[,c("Player", "Position")]
MasterBio1 <- MasterBio[,c("birthState", "nameFirst", "nameLast")]

#Separate Names into two columns 
library(tidyr)
TJSurgeries <- extract(TJSurgeries1, Player, c("FirstName", "LastName"), "([^ ]+) (.*)")
#renamevariablesnames
mergedTJSet <- merge(TJSurgeries2, MasterBio1, by.x=c("LastName", "FirstName"), by.y=c("nameLast", "nameFirst"))

install.packages("maps")
install.packages("ggplot2")
install.packages("mapdata")
library(maps)
library(ggplot2)
library(mapdata)

#Convert State Abbreviations to state #THIS IS NOT WORKING CORRECTLTY
x = data.frame(c(mergedTJSet))

#'x' is the column of a data.frame that holds 2 digit state codes
stateConversion <- function(x, faclevs = 'region') {
  
  st.codes <- data.frame(region = as.factor(c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI",
                                             "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN",
                                             "MO", "MS",  "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH",
                                             "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT",
                                             "WA", "WI", "WV", "WY")),
                         full = as.factor(c("alaska","alabama" ,  "arkansas", "arizona","california" , "colorado" ,
                                            "connecticut", "District of Columbia","delaware" ,  "florida" , "georgia" ,
                                            "hawaii","iowa" ,"idaho" , "illinois" , "indiana" ,  "kansas" ,
                                            "kentucky" , "louisiana" , "massachusetts", "maryland" ,"maine" ,
                                            "michigan" , "minnesota" , "missouri" ,"mississippi" ,  "montana" ,
                                            "north carolina","north dakota", "nebraska" , "new hampshire" , "new jersey" ,  "new mexico" ,
                                            "nevada" ,"new york" , "ohio" , "oklahoma" ,
                                            "oregon" , "pennsylvania" , "puerto rico", "rhode island" , "south carolina", "south dakota" ,
                                            "tennessee" , "texas" , "utah" ,  "virginia","vermont" ,
                                            "washington" , "wisconsin", "west virginia" , "wyoming"))
  )
  
  if (nchar(x[1]) == 2) { st.x <- data.frame(region = x); refac.x <- st.codes$full[match(tolower(st.x$state), tolower(st.codes$state))] }
  else { st.x <- data.frame(full = x); refac.x <- st.codes$state[match(tolower(st.x$full), tolower(st.codes$full))] }
  
  if(faclevs == 'all') {return(refac.x)}
  else {return(factor(refac.x))}
  
}
#SOMEHOW I NEED TO SUM THE COLUMN IN TOTAL BY REGION SO I HAVE FREQUENCIES OF REGION. IDK HOW TO DO THAT 

all_states <- map_data("state")
all_states
head(all_states)

mergedTJSet$region <-mergedTJSet$birthState

Total <- merge(all_states, mergedTJSet, by="region")
head(Total)

levels(mergedTJSet$region)
REGIONTOTALS <- data.frame(table(mergedTJSet$region))

Total <- Total[Total$region!="district of columbia",]

plot <- ggplot() 
p <- p + geom_polygon(data=Total, aes(x=long, y=lat, group = group, fill=),colour="white") + 
scale_fill_continuous(low = "thistle2", high = "darkred", guide="colorbar")P1 <- p + theme_bw() + labs(fill = "Black to White Incarceration Rates \n Weighted by Relative Population" 
 ,title = "State Incarceration Rates by Race, 2010", x="", y="") P1 + scale_y_continuous(breaks=c()) + scale_x_continuous(breaks=c()) + theme(panel.border =  element_blank())
                     