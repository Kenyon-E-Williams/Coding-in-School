##Washington Housing Data 
library(gridExtra)
library(ggplot2)
library(tidyverse)
Wash_house <- read.csv("KC_housing_data.csv")
# Getting a read for the data (Bedrooms approach)
View(Wash_house)

attach(Wash_house)

price_million <- price/1000000

# Analyzing the data for cities
class(Wash_house$city)
# turn city into factor variable
Wash_house$city=as.factor(Wash_house$city)
levels(Wash_house$city)
# creating "region" variable:
regions<-function(x) {
  if(x == "Bothell"||x== "Kenmore"||x=="Lake Forest Park"||x=="Shoreline"||x=="Woodinville") {
    region <- "North"
  } else if (x=="Bellevue"||x=="Beaux Arts Village"||x== "Carnation"||x=="Clyde Hill"||x== "Duvall"||x=="Fall City"||x== "Inglewood-Finn Hill"||x=="Issaquah"||x== "Kirkland"||x== "Medina"||x== "Mercer Island"||x== "Newcastle"||x== "North Bend"||x== "Preston"||x=="Redmond"||x== "Sammamish"||x== "Skykomish"||x=="Sonqualmie"||x=="Snoqualmie Pass"||x=="Yarrow Point")
  {
    region <- "East"
  } else if (x=="Auburn"||x=="Algona"||x=="Black Diamond"||x== "Burien"||x== "Covington"||x== "Des Moines"||x== "Enumclaw"||x== "Federal Way"||x== "Kent"||x=="Milton"||x== "Maple Valley"||x== "Normandy Park"||x== "Pacific"||x=="Renton"||x== "Ravensdale"||x=="Tukwila"||x== "SeaTac"||x== "Vashon Island") {
    region <- "South"
  } else {
    region <- "Seattle"
  }
}
Wash_house=mutate(Wash_house, region=map_chr(city, regions))
class(Wash_house$region)
Wash_house$region=as.factor(Wash_house$region)
levels(Wash_house$region)

mean(regions)
mode
quantile(regions)

#GGPLOT region and price plot
city_plot <- ggplot(data=Wash_house, aes(x=region,y=price_million,color=view))
city_plot +geom_point()+coord_cartesian(y=c(0,5))
pretty.city.plot <-city_plot +geom_boxplot(outlier.shape =NA)+coord_cartesian(y=c(0,5))+theme(legend.position = "bottom")+theme(axis.ticks = element_line(size=2, color="red"))
pretty.city.plot
#region and price boxplot
pretty.box.plot.base <- ggplot(data=Wash_house, aes(x=region,y=price_million,color=region,outlier.shape=NA))
pretty.box.plot.base + geom_boxplot(aes(group=cut_width(region,0.25)),outlier.shape = NA)+coord_cartesian(c(0,4))+scale_y_continuous(limits=c(0,2),breaks=seq(0,2,1/4))+ggtitle("Region Vs Price of House")+ylab("Price in Millions")+xlab("Regions of King County")+theme(plot.title = element_text(hjust = 0.5))
#VIEW exploration (thinking about swapping this out for condition)
summary(view)
view.base.plot <- ggplot(data=Wash_house, aes(x=view,y=price_million,color=region,show.legend=FALSE))
view.point.plot <- view.base.plot + geom_point(size=0.25)+coord_cartesian(y=c(0,5))
scaled.view.point.plot <- view.point.plot +scale_y_continuous(limits=c(0,5),breaks=seq(0,10,0.5))
scaled.view.point.plot
view.box.plot <- view.base.plot+geom_boxplot(outlier.shape = NA,show.legend = FALSE)
                          +scale_y_continuous(limits=c(0,5),breaks=seq(0,5,1/5))+scale_x_continuous(limits=c(0,3),breaks=seq(0,3,1/4))
view.box.plot
par(mfrow=c(1,2))
grid.arrange(view.box.plot,pretty.city.plot,ncol=2)
cor(price,view)#0.228 correlation
# Sq Lot Plot 
sq.lot.thousands <- sqft_lot/10000
sq.lot.base.plot <- ggplot(data=Wash_house,aes(x=sq.lot.thousands,y=price_million,color=region))
sq.lot.box.plot <- sq.lot.base.plot+geom_boxplot(outlier.shape = NA) +coord_cartesian(ylim = c(0,2))+ ggtitle("SqFt of Lot Vs Price")+xlab("Square Footage of Lot in Tens of Thousands")+ylab("Price of Lot in Millions")+theme(plot.title = element_text(hjust = 0.5))
sq.lot.box.plot 
sq.lot.box.plot
