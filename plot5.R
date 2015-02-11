#Exdata_plotting2 Plot 5
#5.How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(dplyr)
library(data.table)
library(ggplot2)

data=data.table(readRDS("summarySCC_PM25.rds"))
code=data.table(readRDS("Source_Classification_Code.rds"))

motor_code=code[grep("Veh",code$Short.Name),]
new_data=mutate(data,is.motor=is.element(SCC,motor_code$SCC))
motor_data=filter(new_data,is.motor==TRUE)
Bal_motor_data=filter(motor_data,fips=="24510")

Bal_motor_data=group_by(Bal_motor_data,year)
trend=summarize(Bal_motor_data,sum(Emissions))
setnames(trend,c("year","Emissions"))

plot(trend$year,trend$Emissions,xlab="year",ylab="Baltimore Motor Emissions",main="Plot 5",type="b",col="red")
dev.copy(png,file="plot5.png")
dev.off()
