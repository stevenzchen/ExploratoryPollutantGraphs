# Generate plot5: How have motor vehicle emissions from PM2.5 changed in Baltimore
# from 1999 to 2008?
# Answer: Slight downward trend with low confidence
# Steven Chen

library(dplyr)
library(ggplot2)

baltimoreCounty <- "24510"

emissions <- readRDS("summarySCC_PM25.rds")
sources <- readRDS("Source_Classification_Code.rds")

# find all sources that contain motor vehicle terms
sourceIndices <- grepl("Vehicle|Motor", sources$Short.Name)

df <- emissions %>% 
        filter(SCC %in% sources[sourceIndices, "SCC"]) %>%
        filter(fips == baltimoreCounty) %>%
        group_by(year) %>% 
        summarize(total = sum(Emissions))

# plot scatter plot and dotted linear regression line showing downward trend
ggplot(df, aes(x = year, y = total)) + 
        geom_point() + 
        geom_smooth(method = "lm") + 
        ggtitle("Total Emissions for Motor Vehicle Sources in Baltimore, MD") + 
        xlab("Year") + 
        ylab("Total Emissions (tons)")

ggsave(file = "plot5.png")
