#Creating A Simulated Season 

fiveyr = read.csv(file='/Users/zachtallevast/Box Sync/MasterData2012-2017 (one sheet).csv')
#fouryr = read.csv(file='/Users/zachtallevast/Downloads/FG1114.csv')

#Convert Percentages to decimals 
fiveyr$FB. = as.numeric(sub("%","",fiveyr$FB.))/100
fiveyr$K. = as.numeric(sub("%","",fiveyr$K.))/100
fiveyr$Hard. = as.numeric(sub("%","",fiveyr$Hard.))/100
fiveyr$Pull.= as.numeric(sub("%","",fiveyr$Pull.))/100
fiveyr$Cent. = as.numeric(sub("%","",fiveyr$Cent.))/100
fiveyr$Oppo. = as.numeric(sub("%","",fiveyr$Oppo.))/100

#CreateSubsets for each individual year 

yr12 = subset(fiveyr,Season == "2012")
colnames(yr12) =
  c("Concat12","2012","Name", "Team12","G12","PA12","HR12","R12","RBI12",
    "SB12","BB12","K12","ISO12","BABIP12","AVG12","OBP12","SLG12","wOBA12","wRC+12","BsR12","Off12","Def12",
    "GB/FB12","LD%12","GB%12","FB%12","IFFB%12","HR/FB12","IFH12","IFH%12","BUH12","Hard12","Pull%12","Cent%12","Oppo%12"
    ,"Soft%12","Med%12","Hard%12","BB/K12","OPS12","Spd12","UBR12","wGDP12","wSB12","wRC12","wRAA12","playerID12","WPA12",
    "NegWPA12","PosWPA12","RE2412","REW12","pLI12","phLI12","PH12","WPA/LI12","Clutch12","Batting12","BaseRunning12","Fielding12","Positional12
    ","Offense12","Defense12","League12","Replacement12","RAR12","WAR12","Dollars12")
yr13 = subset(fiveyr,Season == "2013")
colnames(yr13) =
  c("Concat13","2013","Name", "Team13","G13","PA13","HR13","R13","RBI13",
   "SB13","BB13","K13","ISO13","BABIP13","AVG13","OBP13","SLG13","wOBA13","wRC+13","BsR13","Off13","Def13",
   "GB/FB13","LD%13","GB%13","FB%13","IFFB%13","HR/FB13","IFH13","IFH%13","BUH13","Hard13","Pull%13","Cent%13","Oppo%13"
   ,"Soft%13","Med%13","Hard%13","BB/K13","OPS13","Spd13","UBR13","wGDP13","wSB13","wRC13","wRAA13","playerID13","WPA13",
   "NegWPA13","PosWPA13","RE2413","REW13","pLI13","phLI13","PH13","WPA/LI13","Clutch13","Batting13","BaseRunning13","Fielding13","Positional13
   ","Offense13","Defense13","League13","Replacement13","RAR13","WAR13","Dollars13")
yr14 = subset(fiveyr,Season == "2014")
colnames(yr14) =
  c("Concat14","2014","Name", "Team14","G14","PA14","HR14","R14","RBI14",
    "SB14","BB14","K14","ISO14","BABIP14","AVG14","OBP14","SLG14","wOBA14","wRC+14","BsR14","Off14","Def14",
    "GB/FB14","LD%14","GB%14","FB%14","IFFB%14","HR/FB14","IFH14","IFH%14","BUH14","Hard14","Pull%14","Cent%14","Oppo%14"
    ,"Soft%14","Med%14","Hard%14","BB/K14","OPS14","Spd14","UBR14","wGDP14","wSB14","wRC14","wRAA14","playerID14","WPA14",
    "NegWPA14","PosWPA14","RE2414","REW14","pLI14","phLI14","PH14","WPA/LI14","Clutch14","Batting14","BaseRunning14","Fielding14","Positional14
    ","Offense14","Defense14","League14","Replacement14","RAR14","WAR14","Dollars14")
yr15= subset(fiveyr,Season == "2015")
colnames(yr15) =
  c("Concat15","2015","Name", "Team15","G15","PA15","HR15","R15","RBI15",
    "SB15","BB15","K12","ISO15","BABIP15","AVG15","OBP15","SLG15","wOBA15","wRC+15","BsR15","Off15","Def15",
    "GB/FB15","LD%15","GB%15","FB%15","IFFB%15","HR/FB15","IFH15","IFH%15","BUH15","Hard15","Pull%15","Cent%15","Oppo%15"
    ,"Soft%15","Med%15","Hard%15","BB/K15","OPS15","Spd15","UBR15","wGDP15","wSB15","wRC15","wRAA15","playerID15","WPA15",
    "NegWPA15","PosWPA15","RE2415","REW15","pLI15","phLI15","PH15","WPA/LI15","Clutch15","Batting15","BaseRunning15","Fielding15","Positional15
    ","Offense15","Defense15","League15","Replacement15","RAR15","WAR15","Dollars15")
yr16 = subset(fiveyr,Season == "2016")
colnames(yr16) =
  c("Concat16","2016","Name", "Team16","G16","PA16","HR16","R16","RBI16",
     "SB16","BB16","K16","ISO16","BABIP16","AVG16","OBP16","SLG16","wOBA16","wRC+16","BsR16","Off16","Def16",
     "GB/FB16","LD%16","GB%16","FB%16","IFFB%16","HR/FB16","IFH16","IFH%16","BUH16","Hard16","Pull%16","Cent%16","Oppo%16"
     ,"Soft%16","Med%16","Hard%16","BB/K16","OPS16","Spd16","UBR16","wGDP16","wSB16","wRC16","wRAA16","playerID16","WPA16",
     "NegWPA16","PosWPA16","RE2416","REW16","pLI16","phLI16","PH16","WPA/LI16","Clutch16","Batting16","BaseRunning16","Fielding16","Positional16
     ","Offense16","Defense16","League16","Replacement16","RAR16","WAR16","Dollars16")
yr17 = subset(fiveyr,Season == "2017")
colnames(yr17) =
  c("Concat17","2017","Name", "Team17","G17","PA17","HR17","R17","RBI17",
     "SB17","BB17","K17","ISO17","BABIP17","AVG17","OBP17","SLG17","wOBA17","wRC+17","BsR17","Off17","Def17",
     "GB/FB17","LD%17","GB%17","FB%17","IFFB%17","HR/FB17","IFH17","IFH%17","BUH17","Hard17","Pull%17","Cent%17","Oppo%17"
     ,"Soft%17","Med%17","Hard%17","BB/K17","OPS17","Spd17","UBR17","wGDP17","wSB17","wRC17","wRAA17","playerID17","WPA17",
     "NegWPA17","PosWPA17","RE2417","REW17","pLI17","phLI17","PH17","WPA/LI17","Clutch17","Batting17","BaseRunning17","Fielding17","Positional17
     ","Offense17","Defense17","League17","Replacement17","RAR17","WAR17","Dollars17")
set = merge(yr12,yr13, by = "Name")
set = merge(set, yr14, by = "Name")
set = merge(set, yr15, by = "Name")
set = merge(set, yr16, by = "Name")
set = merge(set, yr17, by = "Name")

totalset = merge(yr12,yr13, by = "Name", all = TRUE)
totalset = merge(set, yr14, by = "Name", all = TRUE)
totalset = merge(set, yr15, by = "Name", all= TRUE)
totalset = merge(set, yr16, by = "Name", all = TRUE)
totalset = merge(set, yr17, by = "Name", all = TRUE)
#Test  Projections (Will have to omit null values)


#Test Projecting 2014 Homers by using 2013 metrics 
sum(abs(set$HR13-set$HR14))/length(set$HR14)
#6.52381 So the worst projection system should be able to beat an average error of 6.5 homers per player

#Marcel for HR, AVG, Runs, RBI, SB
#Predicts a players stats using past 3 years of MLB Data. 
#Previous year weight of 5, The year before (X-1) gets weight of 4, The year before (x-2) gets weight of 3

set$marHR18 = (set$HR17 * 5/12) + (set$HR16 * 4/12) +(set$HR15* 3/12)
set$marHR18 = round(set$marHR18,0)
set$marAVG18 = (set$AVG17 * 5/12) + (set$AVG16 * 4/12) +(set$AVG15 * 3/12)
set$marAVG18 = round(set$marAVG18,0)
set$marR18 = (set$R17 * 5/12) + (set$R16 * 4/12) + (set$R15 * 3/12)
set$marR18 = round(set$marR18,0)
set$marRBI18 =(set$RBI17 * 5/12) + (set$RBI16 * 4/12) + (set$RBI15 * 3/12)
set$marRBI18 = round(set$marRBI18,0)
set$marSB18 = (set$SB17 * 5/12) + (set$SB16 * 4/12) + (set$SB15 * 3/12) 
set$marSB18 = round(set$marSB18,0)
set$marHR17 = (set$HR16 * 5/12) + (set$HR15 * 4/12) + (set$HR14 * 4/12)
set$marHR17 = round(set$marHR17,0)


#set to view projections

#Test Projecting 2017 homers by using Marcel Metrics 
sum(abs(set$marHR17 - set$HR17))/length(set$HR17)
#5.904762 So the marcel system should be able to beat an average error of 5.90 homers per player. 
set$mardiffHR17 = abs(set$marHR17-set$HR17)
hist(set$mardiffHR17, breaks=30, col="Blue")

#Check for large offset predictions
set = set[order(-set$mardiffHR17),]
head(set[c(1,72,90,91)],n=10)

#Create Dataset with 2018 predictions
marcel = data.frame(totalset$Name, totalset$marHR18, totalset$marR18, totalset$marAVG18, totalset$marRBI18, totalset$marSB18)
colnames(marcel) = c("Name", "HR", "R", "AVG", "RBI", "SB")
write.csv(marcel, "marcel.csv")

#Create absolute mean error function 
modtest = function(stat) 
{ame = sum(abs(stat-set$HR14))/length(set$HR14)
return(ame)}

modtest(set$marHR)


#Predictive Model Number 3: Using Multiple Linear Regression 

#2013~2012 

hrmodel = lm(set$HR13 ~ set$HR12 + set$HR11 + set$Hard12+set$Pull12 + set$ISO12)
summary(hrmodel)
#the P-Values less than .05 mean they are significant for my model 
#The R-Squared value is .4611 so 46% of the 2013 variance is accounted for
#We conclude that ISO and Pull% dont influence this but Hard% does

#ADJUSTED HR MODEL

hrmodel = lm(set$HR13 ~ set$HR12 + set$HR11 + set$Hard12)
summary(hrmodel)

set$betHR14 = (-5.25157 + (set$HR13 * 0.32417)+(set$HR12 * 0.12709)+(set$Hard13*40.93344))
set$betHR14 = round(set$betHR14,0)

#test projecting 2014 homers using linear regression 
modtest(set$betHR14)
#Should be able to beat an average error of 6.067797 homers per player

#Try Model for 2013 data instead. 
set$fakeHR13 = (-5.25157 + (set$HR12 * 0.32417)+(set$HR11 * 0.12709)+(set$Hard12*40.93344))
set$fakeHR13 = round(set$fakeHR13,0)

sum(abs(set$fakeHR13-set$HR13))/length(set$HR13)
#should be able to beat an average error of 4.877119 homers per player



