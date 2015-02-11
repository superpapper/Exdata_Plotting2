#Exdata_plotting2 Plot 6
#6.Compare emissions from motor vehicle sources in Baltimore City with emissions from motor
#vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen
#greater changes over time in motor vehicle emissions?

library(dplyr)
library(data.table)
library(ggplot2)

data=data.table(readRDS("summarySCC_PM25.rds"))
code=data.table(readRDS("Source_Classification_Code.rds"))

data=group_by(data,year)
motor_code=code[grep("Veh",code$Short.Name),]
new_data=mutate(data,is.motor=is.element(SCC,motor_code$SCC))
motor_data=filter(new_data,is.motor==TRUE)
Bal_motor_data=filter(motor_data,fips=="24510")
LA_motor_data=filter(motor_data,fips=="06037")
Bal_motor_data=mutate(Bal_motor_data,city="Baltimore")
LA_motor_data=mutate(LA_motor_data,city="LA")
city_motor_data=rbind(Bal_motor_data,LA_motor_data)
city_motor_data=group_by(city_motor_data,year,city)

city_trend=summarize(city_motor_data,sum(Emissions))
setnames(city_trend,c("year","city","Emissions"))

ggplot(city_trend, aes(year,Emissions))+geom_line(color="chartreuse4")+ggtitle("plot6")+  facet_wrap(~city, ncol=2,scales="free")
dev.copy(png,file="plot6.png")
dev.off()
