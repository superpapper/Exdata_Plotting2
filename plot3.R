
#3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
#variable, which of these four sources have seen decreases in emissions from 1999-2008
#for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the
#ggplot2 plotting system to make a plot answer this question.
library(dplyr)
library(data.table)
library(ggplot2)

data=data.table(readRDS("summarySCC_PM25.rds"))
code=data.table(readRDS("Source_Classification_Code.rds"))
#View(head(data))
#View(head(code))


newdata=group_by(data,year,type)
trend=summarize(newdata,sum(Emissions))
setnames(trend,c("year","type","Emissions"))

ggplot(trend, aes(year,Emissions))+geom_line(color="chartreuse4")+ggtitle("plot3")+  facet_wrap(~type, ncol=2,scales="free")

dev.copy(png,file="plot3.png")
dev.off()
