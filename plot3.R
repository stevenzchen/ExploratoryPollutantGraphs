# Generate plot3: how have 4 source emissions from PM2.5 changed in Baltimore, ML
# from 1999 to 2008?
# Answer: All four sources have seen decreases.
# Steven Chen

library(dplyr)
library(ggplot2)

baltimoreCounty <- "24510"

emissions <- readRDS("summarySCC_PM25.rds")
sources <- readRDS("Source_Classification_Code.rds")

years <- c(1999, 2002, 2005, 2008)

df <- emissions %>% 
        group_by_(.dots = lapply(names(emissions)[c(6, 5)], as.symbol)) %>% 
        summarize(total = sum(Emissions))

# plot scatter plot and dotted linear regression line showing downward trend
ggplot(df, aes(x = year, y = total)) + 
        facet_wrap(~type, scales = "free") + 
        geom_point() + 
        geom_smooth(method = "lm") + 
        ggtitle("Emission Changes Per Source in Baltimore, MD") + 
        xlab("Year") + 
        ylab("Total Emissions (tons)")

ggsave("plot3.png")
