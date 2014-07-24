## Find all the motor vehicle sources from 'SCC'
#Read the rds data for PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")
#Read the rds data for Source Classification Code Table
SCC <- readRDS("Source_Classification_Code.rds")
motorVehicleSourceDesc <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE,value = TRUE))
motorVehicleSourceCodes <- SCC[SCC$EI.Sector %in% motorVehicleSourceDesc, ]["SCC"]

## Subset emissions due to motor vehicle sources in from 'NEI' for Baltimore
emissionFromMotorVehiclesInBaltimore <- NEI[NEI$SCC %in% motorVehicleSourceCodes$SCC & NEI$fips == "24510", ]

## Calculate the emissions due to motor vehicles in Baltimore for every year
totalMotorVehicleEmissionsByYear <- tapply(emissionFromMotorVehiclesInBaltimore$Emissions, 
                                           emissionFromMotorVehiclesInBaltimore$year, sum)
png(filename="figure/plot5.png", width=480, height=480)
plot(totalMotorVehicleEmissionsByYear, x = rownames(totalMotorVehicleEmissionsByYear), 
     type = "n", axes = FALSE, ylab = expression("Motor Vehicle Related PM"[2.5] * 
                                                     " Emission (in tons)"), xlab = "Year", main = expression("Motor Vehicle Related PM"[2.5] * 
                                                                                                                  " Emission in Baltimore (1999 - 2008)"))
points(totalMotorVehicleEmissionsByYear, x = rownames(totalMotorVehicleEmissionsByYear), pch = 16, col = "red")
lines(totalMotorVehicleEmissionsByYear, x = rownames(totalMotorVehicleEmissionsByYear), col = "blue")
axis(2)
axis(side = 1, at = seq(1999, 2008, by = 3))
box()
dev.off()