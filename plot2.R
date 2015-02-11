#Exdata_plotting Project 2
#Plot2
#2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
#read data
library(dplyr)
library(data.table)
data=data.table(readRDS("summarySCC_PM25.rds"))
code=data.table(readRDS("Source_Classification_Code.rds"))
View(head(data))
View(head(code))
data=group_by(data,year)
Bal_data=filter(data,fips=="24510")

Bal_trend=summarize(Bal_data,sum(Emissions))
setnames(Bal_trend,c("year","Emissions"))
plot(Bal_trend$year,Bal_trend$Emissions,xlab="year",ylab="Baltimore Total Emissions",main="Plot 2",type="b",col="red")
dev.copy(png,file="plot2.png")
dev.off()
