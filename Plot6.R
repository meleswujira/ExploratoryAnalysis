## Subset emissions due to motor vehicle sources from 'NEI' for Los Angeles
## and combine it with the data from Baltimore
## Find all the motor vehicle sources from 'SCC'
#Read the rds data for PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")
#Read the rds data for Source Classification Code Table
SCC <- readRDS("Source_Classification_Code.rds")
## Calculate the emissions due to motor vehicles in Baltimore and Los Angeles
## for every year
emissionFromMotorVehiclesInLosAngeles <- NEI[NEI$SCC %in% motorVehicleSourceCodes$SCC & 
                                                 NEI$fips == "06037", ]
emissionFromMotorVehicles <- rbind(emissionFromMotorVehiclesInBaltimore, emissionFromMotorVehiclesInLosAngeles)

## Calculate the emissions due to motor vehicles in Baltimore and Los Angeles
## for every year
totalMotorVehicleEmissionsByYearAndByCounty <- aggregate(Emissions ~ fips * 
                                                             year, data = emissionFromMotorVehicles, FUN = sum)
totalMotorVehicleEmissionsByYearAndByCounty$county <- ifelse(totalMotorVehicleEmissionsByYearAndByCounty$fips == 
                                                                 "06037", "Los Angeles", "Baltimore")
png(filename="figure/plot6.png", width=480, height=480)
## Setup ggplot with data frame
q <- qplot(y = Emissions, x = year, data = totalMotorVehicleEmissionsByYearAndByCounty, 
           color = county)

## Add layers
q + scale_x_continuous(breaks = seq(1999, 2008, 3)) + theme_bw() + geom_point(size = 3) + 
    geom_line() + labs(y = expression("Motor  Vehicle Related " * PM[2.5] * 
                                          " Emissions (in tons)")) + labs(x = "Year") + labs(title = expression("Motor  Vehicle Related " * 
                                                                                                                    PM[2.5] * " Emissions in Baltimore & Los Angeles (1999 - 2008)")) + theme(axis.text = element_text(size = 8), 
                                                                                                                                                                                              axis.title = element_text(size = 14), panel.margin = unit(1, "lines"), plot.title = element_text(vjust = 2, 
                                                                                                                                                                                                                                                                                               hjust = 0.17, size = 12), legend.title = element_text(size = 11)) + 
    scale_colour_discrete(name = "County")
dev.off()
