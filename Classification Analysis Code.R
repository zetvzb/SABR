
#This code is a classification analysis for predicting WAR. 
#This data is 2016-2017 Offensive categories. All Categories 
#For classification, 1 is Positive WAR. 0 Is negative WAR. 
#See Separate code for Classification for (Elite, Average, Below Average Classes)

setwd("/Users/zachtallevast/Box Sync/STAT 4002/Project 1")
#setwd("C:/Users/zetvzb/Downloads")
Offense = read.csv("RAW Analysis WAR.csv", header=T, na.strings = "?")
#Remove categorical values of Name and Team
Numerical <- Offense[c(-1,-2,-3,-55)]
Numerical1 <- Offense[c(-1,-2,-3)]
lm.fit = lm(WAR~., data = Numerical)
summary(lm.fit)

#Stepwise Regression
library (MASS)
step <- stepAIC(lm.fit, direction = "both")
step$anova 

cor(Numerical)

lm.fit1 = lm(WAR ~ PA + SB + ISO + AVG + OBP + wOBA + wRC. + BsR + Off + Def + 
               BB.K + UBR + wGDP + wRAA + GB. + IFFB. + IFH. + BUH + O.Swing. + 
               Swing. + Z.Contact. + F.Strike. + Classification, data = Numerical1)
summary(lm.fit1)
lm.res = resid(lm.fit1)

anova(lm.fit)
anova(lm.fit1)


plot(Numerical$wRC.,lm.res, ylab="Residuals", xlab="Weighted Runs Created", main="Wins Above Replacement")
abline(0,0)
plot(Numerical$AVG,lm.res, ylab="Residuals", xlab="Average", main="Wins Above Replacement")
abline(0,0)
#Residual Plots should not contain any predictive information 
plot(Numerical$Spd,lm.res, ylab="Residuals", xlab="Speed", main="Wins Above Replacement")
abline(0,0)

plot(lm.fit)
#Check for multicollinearity 
install.packages("mctest")
library(mctest)
x <- Numerical[c(-1,-3,-4,-5,-8,-11,-13,-19,-20,-21,-24,-25,-27,-28,-29,-30,-32,-33,-34,-35,-36,-37,-38,-40,-41,-42,-44,-46,-51,-50,-49,-48)]
m <-cor(x, method = c("pearson", "kendall", "spearman"))
ggpairs(x)
omcdiag(x, x$WAR)
install.packages("corrplot")
library(corrplot)
library(RColorBrewer)
install.packages("RColorBrewer")
corrplot(m, method="circle", order="hclust", type="upper",col=brewer.pal(n=8, name="RdBu"), sig.level = 0.01)
#Include all pairwise x1 and x2 
m

#Begin Classification Data Analysis
set.seed(1)
Sample = sample(c(TRUE, FALSE), nrow(Offense), replace = T, prob = c(0.6,0.4))
Train <-Offense[Sample, ]
Test <- Offense[!Sample,]

#Training Set has 261 rows 
#Test Set has 29 rows

#Model 2: (Logistic Regression Model)
glm.fit = glm(Classification ~PA+SB+ISO+wRC+AVG+BABIP+BB.+BB.K+BsR+F.Strike.+FB.+G+HR+HR.FB
              +IFFB.+Z.Contact.+BUH+RBI+K.+SLG+wOBA+UBR+FB.+IFFB.+IFH.+Oppo.+Med.+Hard.+Z.Contact.
              +F.Strike., data=Train, family=binomial)
summary(glm.fit)
ls(Train)

#cannot fit with Off, Def, Hard., Swing.,wRAA,R,OBP,WAR,Spd,wGDP,wSB,wrc+,LD.,GB.,Pull. These created too much bias. 

#The smallest p-value's here are Plate Appearances (PA), Average (AVG), and (wRC).
#Therefore there is association between Classification and PA, AVG, and wRC+
coef(glm.fit)
summary(glm.fit)$coef
#Use a threshold of 50%
glm.prob = predict(glm.fit, type = "response")
contrasts(Train$Classification)
glm.pred = rep('Negative', 182)
glm.pred[glm.prob>0.5] = 'Positive'
table(glm.pred, Train$Classification)
mean(glm.pred == Train$Classification)

#glm.pred   Negative Positive
#Negative        11       1
#Positive        2      168

#Accuracy: (TP-TN)/TOTAL = (168+11)/182 = 98.35% (How correct is classifier)
#Misclassification Rate: (FP+FN)/TOTAL = (1+2)/182 =1.65%   (How incorrect is classifier)
#Sensitivity: TP/Actual Yes = 168/170 = 98.88% (If actually yes, classified yes )
#False Positive Rate: FP/Actual NO =1/12 = 8.33% (If actually no, classified yes)

#Logistic Regression accurately predicted a players WAR classification 98.35% of the time. 

#Consider multiple classes as well in analysis. 

#Use the threshold of 25%
glm.prob = predict(glm.fit, type = "response")
contrasts(Train$Classification)
glm.pred = rep('Negative', 182)
glm.pred[glm.prob>0.25] = 'Positive'
table(glm.pred, Train$Classification)


#glm.pred   Negative Positive
#Negative        7        0
#Positive        6      169

#Accuracy: (TP-TN)/TOTAL = (169+7)/182 =96.70% (How correct is classifier)
#Misclassification Rate: (FP+FN)/TOTAL = (0+6)/182 =3.30%   (How incorrect is classifier)
#Sensitivity: TP/Actual Yes = 169/176 =96.02% (If actually yes, classified yes )
#False Positive Rate: FP/Actual NO =0/7 = 0% (If actually no, classified yes)

#Logistic Regression accurately predicted a players WAR classification 96.55% of the time. 

#Test to see if this goodness of fit test indicates that the model does not fit the data
install.packages("MKmisc")
library(MKmisc)
HLgof.test(fit=fitted(glm.fit), obs = Train$Classification)

#Model 3: (Linear Discriminant Analysis)
library(MASS)
lda.fit = lda(Classification ~PA+SB+ISO+wRC+AVG+BABIP+BB.+BB.K+BsR+F.Strike.+FB.+G+HR+HR.FB
              +IFFB.+Z.Contact.+BUH+RBI+K.+SLG+wOBA+UBR+FB.+IFFB.+IFH.+Oppo.+Med.+Hard.+Z.Contact.
              +F.Strike.,data=Train)
lda.fit
lda.pred = predict(lda.fit, type = "response")
names(lda.pred)
lda.class =lda.pred$class
table(lda.class, Train$Classification)
plot(lda.fit)
mean(lda.class ==Train$Classification)



#pi1 =0.0714 and pi2=0.92857
#So 7% of the training observations correspond to negative war classifications 
 

#lda.class  Negative Positive
#Negative        6       1
#Positive        7      168

#Accuracy: (TP-TN)/TOTAL = (168+6)/182 = 95.60% (How correct is classifier)
#Misclassification Rate: (FP+FN)/TOTAL = (7+1)/182 =4.40%   (How incorrect is classifier)
#Sensitivity: TP/Actual Yes = 168/175 =96.0% (If actually yes, classified yes )
#False Positive Rate: FP/Actual NO =1/7 = 14.29% (If actually no, classified yes)


#Linear Discriminant Analysis accurately predicted a players WAR classification 95.60% of the time.

#Test how the LDA Model applys to the test data
test.predicted.lda <- predict(lda.fit, newdata = Test)


#Model 4: (Quadratic Discriminant Analysis)
qda.fit = qda(Classification ~PA+SB+ISO+wRC+AVG+BABIP+BB.+BB.K+BsR+F.Strike.+FB.+G+HR+HR.FB
              +IFFB.+Z.Contact.+BUH+RBI+K.+SLG+wOBA+UBR+FB.+IFFB.+IFH.+Oppo.+Med.+Hard.+Z.Contact.
              +F.Strike., data=Train)




#Model 5: (K-Nearest Neighbors)
library(class)
Train.X = cbind(Train$PA, Train$SB, Train$F.Strike., Train$ISO, Train$AVG, Train$OBP, Train$wOBA, Train$wRC, 
                Train$BsR, Train$BB.K, Train$UBR, Train$wGDP, Train$wRAA, Train$GB., Train$IFH., Train$BUH, Train$O.Swing.)
Test.X= cbind(Train$PA, Train$SB, Train$F.Strike., Train$ISO, Train$AVG, Train$OBP, Train$wOBA, Train$wRC, 
              Train$BsR, Train$BB.K, Train$UBR, Train$wGDP, Train$wRAA, Train$GB., Train$IFH., Train$BUH, Train$O.Swing.)
Train.Classification = Train$Classification

knn.pred=knn(Train.X, Test.X, Train.Classification, k=3)
table(knn.pred, Train$Classification)
mean(knn.pred == Train$Classification)

#For k=2, the accuracy is 95.05%
#For k=3, the accuracy is 95.05%
#For k=4, the accuracy is 93.40%
#For k=5, the accuracy is 92.85%
#For k=6, the accuracy is 93.40%
#For k=7 and greater the accuracy is 92.85%


#k=3
#knn.pred   Negative Positive
#Negative        5       1
#Positive        8      168

#Accuracy: (TP-TN)/TOTAL = (168+5)/182 =95.05% (How correct is classifier)
#Misclassification Rate: (FP+FN)/TOTAL = (8+1)/182 =4.95%   (How incorrect is classifier)
#Sensitivity: TP/Actual Yes = 168/176 =95.45% (If actually yes, classified yes )
#False Positive Rate: FP/Actual NO =1/6 =16.67% (If actually no, classified yes)

#K-Nearest Neighbors for k=3 accurately predicted a players WAR classification 96.55% of the time. 

knn.graph(x,row.names=)


#GRAPHS
 
x <- Offense[1:290, c("HR", "PA", "Classification")]
plot(x[,1:2],col=x[,3])





