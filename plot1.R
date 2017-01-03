# Generate plot1: Have total emissions from PM2.5 decreased in the US from 
# 1999 to 2008?
# Answer: Yes
# Steven Chen

library(dplyr)

emissions <- readRDS("summarySCC_PM25.rds")
sources <- readRDS("Source_Classification_Code.rds")

years <- c(1999, 2002, 2005, 2008)
totals <- sapply(years, function(x) { sum(emissions[emissions$year == x, "Emissions"]) })

# plot scatter plot and dotted linear regression line showing downward trend

png("plot1.png")

plot(years, totals, main = "Total PM2.5 Emissions Per Year", xlab = "Year",
     ylab = "Total PM2.5 Emissions (tons)")
abline(lm(totals ~ years), lty = 2)

dev.off()
