library(plyr)
#Read the rds data for PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")
#Read the rds data for Source Classification Code Table
SCC <- readRDS("Source_Classification_Code.rds")
Baltimore <- NEI[NEI$fips == "24510", ]
totalPM25ByYear <- tapply(Baltimore$Emissions, Baltimore$year, sum,na.rm=TRUE)

## Create plot
png(filename="figure/plot2.png", width=480, height=480)
plot(totalPM25ByYear, x = rownames(totalPM25ByYear), type = "n", axes = FALSE, 
     ylab = expression("Total PM"[2.5] * " Emission (in tons)"), xlab = "Year", 
     main = expression("Total PM"[2.5] * " Emission in Baltimore (1999 - 2008)"))
points(totalPM25ByYear, x = rownames(totalPM25ByYear), pch = 16, col = "red")
lines(totalPM25ByYear, x = rownames(totalPM25ByYear), col = "blue")
axis(2)
axis(side = 1, at = seq(1999, 2008, by = 3))
box()
dev.off()



