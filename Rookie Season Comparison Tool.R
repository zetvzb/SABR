#Comparing Dodgers players Cody Bellinger vs. Albert Pujols vs. Mike Trout vs. Corey Seager rookie year campaigns 

#http://www.fangraphs.com/splitstool.aspx?playerid=15998&position=1B/OF&splitArr=&strgroup=season&type=1&startDate=all&endDate=all&filter=
Bellinger <- read.csv(file='/Users/zachtallevast/Box Sync/SABR/Rookie Year Comparison Tool/Cody Bellinger Stats.csv')
#http://www.fangraphs.com/splitstool.aspx?playerid=1177&position=1B&splitArr=&strgroup=season&type=1&startDate=2002-4-1&endDate=2002-12-1&filter=
Pujols <-read.csv(file='/Users/achtallevast/Box Sync/SABR/Rookie Year Comparison Tool/Albert Pujols.csv')
#http://www.fangraphs.com/splitstool.aspx?playerid=10155&position=OF&splitArr=&strgroup=season&type=1&startDate=2012-04-01&endDate=2012-12-01&filter=
Trout <-read.csv(file='/Users/achtallevast/Box Sync/SABR/Rookie Year Comparison Tool/Mike Trout.csv')
#http://www.fangraphs.com/splitstool.aspx?playerid=13624&position=SS&splitArr=&strgroup=season&type=1&startDate=2016-04-01&endDate=2016-12-01&filter=
Seager <- read.csv(file='/Users/achtallevast/Box Sync/SABR/Rookie Year Comparison Tool/Corey Seager.csv')

#Turn all data into proportions



Master <- rbind(Bellinger, Pujols, Trout, Seager)
Master[,-2]/Master$G

with(Master,)

require(ggplot2)
cutoff <- data.frame(x=c(-Inf,Inf), y=0, cutoff=factor(0))
ggplot(Master) +
  geom_bar(stat="identity", aes(team, diff, fill=league)) +
  scale_fill_manual(values=c("red","blue"))+
  labs(title="Current Difference in Starter ERA 2016-2017", x="Team", y="Change in ERA ")+
  geom_line(aes(x,y,linetype=cutoff), cutoff, show.legend=F)
