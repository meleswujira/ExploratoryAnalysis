#Read the rds data for PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")
#Read the rds data for Source Classification Code Table
SCC <- readRDS("Source_Classification_Code.rds")
CoalCombustionSources <- SCC[SCC$EI.Sector == "Fuel Comb - Comm/Institutional - Coal", ]["SCC"]
## Subset emissions due to coal combustion sources from 'NEI'
emissionFromCoal <- NEI[NEI$SCC %in% CoalCombustionSources$SCC, ]
## Calculate the emissions due to coal each year across United States
totalCoalEmissionsByYear <- tapply(emissionFromCoal$Emissions, emissionFromCoal$year, sum)
## Create the plot
png(filename="figure/plot4.png", width=480, height=480)
plot(totalCoalEmissionsByYear, x = rownames(totalCoalEmissionsByYear), type = "n", 
     axes = FALSE, ylab = expression("Coal Related PM"[2.5] * " Emission (in tons)"), 
     xlab = "Year", main = expression("Coal Related PM"[2.5] * " Emission across United States (1999 - 2008)"))
points(totalCoalEmissionsByYear, x = rownames(totalCoalEmissionsByYear), pch = 16, 
       col = "red")
lines(totalCoalEmissionsByYear, x = rownames(totalCoalEmissionsByYear), col = "blue")
axis(2)
axis(side = 1, at = seq(1999, 2008, by = 3))
box()
dev.off()