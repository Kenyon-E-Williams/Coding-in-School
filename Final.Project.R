
Social Media Contracts And Player Performance 



#Preparing Script
setwd("/Users/kwill/Desktop/Econ 142")


library(doBy)
library(dplyr)
library(foreign)
library(ggplot2)
library(gridExtra)
library(knitr)
library(lmtest)
library(readstata13)
library(sandwich)
library(stargazer)
library(AER)
library(gdata)
library(wooldridge)
library(devtools)
library(tidyverse)
library(nbastatR)
library(RColorBrewer)
library(gridExtra)
library(grid)

cse=function(reg) {
  rob=sqrt(diag(vcovHC(reg, type="HC1")))
  return(rob)
}

#reading in the data
player.data.salary <- read.csv("nba_2017_players_with_salary_wiki_twitter.csv")
attach(player.data.salary)
#CREATING A SOCIAL EXPOSURE VARIABLE TO ACCOUNT FOR WIKIPEDIA,AND TWITTER ACTIVITY
Social.exposure <-(TWITTER_FAVORITE_COUNT+TWITTER_RETWEET_COUNT+PAGEVIEWS)/30000
Social.exposure.mid <- mean(Social.exposure)
player.contribution <- WINS_RPM + PIE
#trying to visualize the data to get a better feel 
contribution.salary.plot <-ggplot(data=player.data.salary,aes(x=player.contribution,y=SALARY_MILLIONS,color=(Social.exposure)))+geom_abline()+stat_smooth(na.rm =FALSE,se=FALSE,level = 0.95,method=lm)+geom_point(na.rm = TRUE,size=1)+scale_color_gradient(low = "grey",high="blue",)+ggtitle("Player Win Contribution vs Salary in Millions")+xlab("PIE+WINS_RPM")+ylab("Salary in Millions") + theme(plot.title = element_text(hjust = 0.5))
summary(TWITTER_FAVORITE_COUNT)
social.plot <- ggplot(data=player.data.salary,aes(x=TWITTER_FAVORITE_COUNT,y=SALARY_MILLIONS))+geom_point()+geom_smooth(method = lm, na.rm=FALSE)
social.plot +coord_cartesian()
contribution.salary.plot
contribution.social.plot <-ggplot(data=player.data.salary,aes(x=player.contribution,y=Social.exposure))+stat_smooth(method=lm)+geom_point(na.rm = FALSE)+ggtitle("Player Win Cotribution vs Social Status ")+xlab("PIE+WINS_RMP")+ylab("Social Status") + theme(plot.title = element_text(hjust = 0.5))
contribution.social.plot
grid.arrange(contribution.salary.plot,contribution.social.plot,ncol=2)

mp.salary.plot <- ggplot(data=player.data.salary,aes(x=MP,y=SALARY_MILLIONS))+geom_smooth(method=lm)+geom_point(na.rm=FALSE)+scale_size_area()+ggtitle("Minutes Played vs Salary")+xlab("Minutes Played Per Game (Season)")+ylab("Contract Salary (Millions)")+theme(plot.title = element_text(hjust = 0.5))

mp.social.plot <-ggplot(data=player.data.salary,aes(x=MP,y=Social.exposure))+geom_smooth(method = lm)+geom_point(na.rm=FALSE)+scale_color_gradient(low="blue",high="red")

mean(SALARY_MILLIONS)
grid.arrange(mp.salary.plot,mp.social.plot,ncol=2)
class(TWITTER_FAVORITE_COUNT)
lht(reg6)
lht(regq,c("TWITTER_FAVORITE_COUNT=0"),white.adjust = "hc1")
lht(regw,c("TWITTER_RETWEET_COUNT=0"),white.adjust="hc1")
#T testing Twitter Engagement 
t.test(TWITTER_RETWEET_COUNT,SALARY_MILLIONS,conf.level = 0.95)
t.test(TWITTER_FAVORITE_COUNT,SALARY_MILLIONS,conf.level = 0.95)
t.test(TWITTER_RETWEET_COUNT,(WINS_RPM+PIE),conf.level = 0.95)
t.test(TWITTER_FAVORITE_COUNT,(WINS_RPM+PIE),conf.level = 0.95)

mean(PAGEVIEWS)
mean(SALARY_MILLIONS)
twitter.favorite <- na.omit(player.data.salary$TWITTER_FAVORITE_COUNT)
summary(twitter.favorite)
dim(twitter.favorite)
class(twitter.favorite)
as.factor(twitter.favorite)
log.salary <- log(SALARY_MILLIONS)
log.twitter <- log(TWITTER_FAVORITE_COUNT)
regq=lm(SALARY_MILLIONS~TWITTER_FAVORITE_COUNT)
regw=lm(SALARY_MILLIONS~TWITTER_RETWEET_COUNT)
reg1=lm((I(log.salary))~WINS_RPM)
reg2=lm((I(log.salary))~WINS_RPM+PIE)
reg3=lm(I(log.salary)~WINS_RPM+PIE+AGE)
reg4=lm(I(log.salary)~WINS_RPM+PIE+AGE+I(log(PAGEVIEWS)))
reg5=lm(I(log.salary)~WINS_RPM+PIE+AGE+I(log(PAGEVIEWS))+ TWITTER_RETWEET_COUNT)
stargazer(reg1,reg2,reg3,reg4,reg5,
          se=list(cse(reg1),cse(reg2),cse(reg3),cse(reg4),cse(reg5)),title="Player Performance and Salary ",type="text",df=FALSE,digits=3)
stargazer(regq,se=list(cse(regq)),title="Average Tweet Favorites and Salary",type="text",df=FALSE,digits=3)
stargazer(regw,se=list(cse(regw)),title="Average Tweet Retweet and Salary",type="text",df=FALSE,digits=3)
min(TWITTER_FAVORITE_COUNT)
summary(TWITTER_FAVORITE_COUNT)
twitter.favorite.no.zero <- na.omit(player.data.salary$TWITTER_FAVORITE_COUNT)
summary(twitter.favorite.no.zero)
View(player.data.salary)

regv=lm(SALARY_MILLIONS~PAGEVIEWS)
stargazer(regv,se=list(cse(regv)),type = "text")
cor(TWITTER_FAVORITE_COUNT,TWITTER_RETWEET_COUNT,use="na.or.complete")
