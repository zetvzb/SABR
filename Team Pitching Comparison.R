CurrentPitching <- read.csv(file="/Users/zachtallevast/Box Sync/SABR/Team ERA Project/2017 Team Starter Pitching Data.csv", na.strings = "..",header=TRUE,sep=",", fill=TRUE)
LastPitching <- read.csv(file="/Users/zachtallevast/Box Sync/SABR/Team ERA Project/2016 Team Starter Pitching Data.csv", na.strings = "..")
#This is applied March 1,2016 - May 8, 2016 with adjusted years for each.

CurrentPitchingCat <- CurrentPitching[,c("Team","League","ERA")]
LastPitchingCat <- LastPitching[,c("Team","ERA")]

#MergePitchingData
mergedSet <-merge(CurrentPitchingCat, LastPitchingCat,by="Team")
head(mergedSet)

#Apply Difference 
mergedSet1 <- data.frame(mergedSet, diff=-(mergedSet$ERA.y-mergedSet$ERA.x))

TeamConversion <- function(x, faclevels ='Team')
{
  team.codes <- data.frame(Team= as.facto(c("Angels","Astros","Athletics","White Sox", "Cardinals", "Cubs"))
                           
                           full =as.factor(c("LAA", "HOU", "OAK", "CWS","STL", "CHC" ))
}

#CreatePlot
TeamERA = data.frame(team = mergedSet1$Team, diff = mergedSet1$diff, league = mergedSet1$League) 
require(ggplot2)
cutoff <- data.frame(x=c(-Inf,Inf), y=0, cutoff=factor(0))
ggplot(TeamERA) +
  geom_bar(stat="identity", aes(team, diff, fill=league)) +
  scale_fill_manual(values=c("red","blue"))+
  labs(title="Current Difference in Starter ERA 2016-2017", x="Team", y="Change in ERA ")+
  geom_line(aes(x,y,linetype=cutoff), cutoff, show.legend=F)
 +theme(xis.text.x=element_text(angle=90, size=8)
  )
