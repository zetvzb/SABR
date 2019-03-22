#This shows BB% in comparison to career offensive WAR
#Show players with less than 3% BB% can have a high offensive WAR
#Objective is to make a scatterplot 

### Uses Master in Sean Lahman's Baseball Database.


require(DBI)
require(RMySQL)
require(dplyr)

#Get the data from Baseball Reference
if(!file.exists("./data")){dir.create("./data")} ### I notice this directory is actually never used
fileUrl <- "http://www.baseball-reference.com/data/war_daily_bat.txt"
download.file(fileUrl, destfile="war_daily_bat.csv", method="curl")

#Write the download to a data frame
df <- read.csv("war_daily_bat.csv", header=TRUE)

#bring in master table from Lahmans 
master <- read.csv(file="Master.csv", na.strings = "..",header=TRUE,sep=",", fill=TRUE)

#Join master and WAR data frames
df2 <- merge(x=df, y=master, by.x="player_ID", by.y="playerID", incomparables=NULL)


#Reorder data frame
final <- subset(df2, select = c(player_ID, year_ID, age, team_ID, stint_ID, lg_ID, PA, G, 
                                Inn, runs_bat, runs_br, runs_dp, runs_field, runs_infield, 
                                runs_outfield, runs_catcher, runs_good_plays, runs_defense, 
                                runs_position, runs_position_p, runs_replacement, runs_above_rep, 
                                runs_above_avg, runs_above_avg_off, runs_above_avg_def, WAA, WAA_off, 
                                WAA_def, WAR, WAR_def, WAR_off, WAR_rep, salary, pitcher, teamRpG, 
                                oppRpG, oppRpPA_rep, oppRpG_rep, pyth_exponent, pyth_exponent_rep, 
                                waa_win_perc, waa_win_perc_off, waa_win_perc_def, waa_win_perc_rep))

#Rename a couple of columns in our new tidy data set to fit to Lahman standards
names(final)[names(final)=="stint_ID"] <- "stint"
names(final)[names(final)=="lg_ID"] <- "lgID"
names(final)[names(final)=="year_ID"] <- "yearID"
names(final)[names(final)=="team_ID"] <- "teamID"


WalksData <- read.csv(file="/Users/zachtallevast/Box Sync/SABR/Lahmans Database/core/Batting.csv", na.strings = "..",header=TRUE,sep=",", fill=TRUE)
OffensiveWarData <- final

Analyze <- merge(x=WalksData, y=OffensiveWarData, by.x=c("playerID", "yearID","teamID"), by.y=c("player_ID","yearID", "teamID"))


### here is an example that will illustrate it
is.factor(Analyze$PA) ### shows it is a factor
is.numeric(Analyze$BB) ### shows it is numeric
(test = head(Analyze$PA))
as.numeric(test) ### completely wrong
as.numeric(as.character(test)) ### correct

#need to omit the observations for which there is no recorded PA or BB
skip = which(Analyze$PA == "NULL" | Analyze$BB == "NULL") 
Analyze = Analyze[-skip,] ### I would also recommend renaming Analyze every time you modify it, because then you can track errors more easily. I won't do it in this script though, because that's not how you wrote it.

BB = Analyze$BB ### number of walks
PA = as.numeric(as.character((Analyze$PA))) ### complete number of plate appearances
BBperc <- BB/PA ### percent of plate appearances that ended in a walk


#Set conditions on what I want to show
AnalyzeBACK = Analyze ### making a backup
Analyze <- data.frame(Analyze,BBperc) 


Analyze1 <- subset(Analyze)[(as.numeric(as.character(Analyze$PA)) > 400),]


#install.packages("dplyr")
library("dplyr")
#Eliminate Duplicated Rows using dpylr and distinct function
Analyze1 <- distinct(Analyze1)


#NEED TO USE NUMERIC VARIABLES IN SCATTER PLOTS
Analyze1$WAR_off = as.numeric(as.character(Analyze1$WAR_off)) ### need to switch this to a numeric variable


### side note: the ugly black bar at the bottom earlier was actually the thousands and thousands of tick marks all smushed together, one for each different factor level of WAR_off. changing it to a numeric variable gets rid of that

#Plot the function oWAR x BBPerc 
#PLOT AND LINEAR MODEL
### doing it with automatic x and y limits
plot(Analyze1$WAR_off, Analyze1$BBperc , main="Comparing OffensiveWAR and BB%", xlab="Player Offensive WAR", ylab="Player Walk Percentage")
### gotta say there does not seem to be super much of a relationship here
### let's run a linear regression just in case
fit = lm(BBperc ~ WAR_off , data=Analyze1)
abline(fit)
summary(fit) 

identify(max_point)

max_point <-text(max(Analyze1$WAR_off), max(Analyze1$BBperc))
### it has a good p-value, but that means very little when n is in the hundreds of thousands
### R^2 is 0.04, so this straight line explains about 4% of the variation in the data. ouch!
### overall a line does not seem to be a very good way to model this data

### convert PA to numeric
Analyze$PA = as.numeric(as.character(Analyze$PA))
### here are the row numbers that have a BB of zero
(weird = which((as.numeric(as.character(Analyze$PA)) > 400) & Analyze$BB == 0))

weirdSet = Analyze[weird,]
View(weirdSet) ### this should help you investigate the data set
