#Exdata_plotting2 Plot 4
#4.Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

library(dplyr)
library(data.table)
library(ggplot2)

data=data.table(readRDS("summarySCC_PM25.rds"))
code=data.table(readRDS("Source_Classification_Code.rds"))

coal_code=code[grep("Coal",code$Short.Name),]
new_data=mutate(data,is.coal=is.element(SCC,coal_code$SCC))
coal_data=filter(new_data,is.coal==TRUE)

coal_data=group_by(coal_data,year)
trend=summarize(coal_data,sum(Emissions))
setnames(trend,c("year","Emissions"))

plot(trend$year,trend$Emissions,xlab="year",ylab="Coal Emissions",main="Plot 4",type="b",col="red")
dev.copy(png,file="plot4.png")
dev.off()
