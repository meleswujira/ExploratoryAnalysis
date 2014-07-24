library(plyr)
library(ggplot2)
#Read the rds data for PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")
#Read the rds data for Source Classification Code Table
SCC <- readRDS("Source_Classification_Code.rds")
#Total Emission for Baltimore (fips=24510) indicated by its sources between 1999-2008
## Calculate total PM2.5 emissions for each type by year in Baltimore
Baltimore <- NEI[NEI$fips == "24510", ]
emissionsByTypeAndYear <- aggregate(Emissions ~ type * year, data = Baltimore, 
                                    FUN = sum)
## Setup ggplot with data frame
png(filename="figure/plot3.png", width=480, height=480)
q <- qplot(y = Emissions, x = year, data = emissionsByTypeAndYear, color = type, 
           facets = . ~ type)

## Add layers
q + scale_x_continuous(breaks = seq(1999, 2008, 3)) + theme_bw() + geom_point(size = 3) + 
    geom_line() + labs(y = expression("Total " * PM[2.5] * " Emissions (in tons)")) + 
    labs(x = "Year") + labs(title = expression("Total " * PM[2.5] * " Emissions in Baltimore (1999 - 2008)")) + 
    theme(axis.text = element_text(size = 8), axis.title = element_text(size = 14), 
          panel.margin = unit(1, "lines"), plot.title = element_text(vjust = 2), 
          legend.title = element_text(size = 11)) + scale_colour_discrete(name = "Type")

dev.off()



