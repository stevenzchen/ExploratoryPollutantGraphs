# Generate plot2: have total emissions from PM2.5 decreased in Baltimore, ML
# from 1999 to 2008?
# Answer: Yes, but confidence is low
# Steven Chen

library(dplyr)

baltimoreCounty <- "24510"

emissions <- readRDS("summarySCC_PM25.rds")
sources <- readRDS("Source_Classification_Code.rds")

years <- c(1999, 2002, 2005, 2008)
totals <- sapply(years, function(x) { 
        sum(emissions[emissions$year == x & emissions$fips == baltimoreCounty, "Emissions"]) 
})

png("plot2.png")

# plot scatter plot and dotted linear regression line showing downward trend
plot(years, totals, main = "Total PM2.5 Emissions Per Year, Baltimore, MD", xlab = "Year",
     ylab = "Total PM2.5 Emissions (tons)")
abline(lm(totals ~ years), lty = 2)

dev.off()
