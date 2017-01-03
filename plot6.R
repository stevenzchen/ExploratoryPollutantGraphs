# Generate plot6: Compare motor vehicle emissions in Baltimore and LA
# from 1999 to 2008.
# Answer: Los Angeles has the greater change over tiem in emissions by quantity.
# Steven Chen

library(dplyr)
library(ggplot2)

baltimoreCounty <- "24510"
losAngelesCounty <- "06037"

emissions <- readRDS("summarySCC_PM25.rds")
sources <- readRDS("Source_Classification_Code.rds")

# find all sources that contain motor vehicle terms
sourceIndices <- grepl("Vehicle|Motor", sources$Short.Name)

df <- emissions %>% 
        filter(SCC %in% sources[sourceIndices, "SCC"]) %>%
        filter(fips == baltimoreCounty | fips == losAngelesCounty) %>%
        mutate(city = as.factor(fips))

levels(df$city) = c("Los Angeles County", "Baltimore City")

df <- df %>% group_by_(.dots = lapply(names(df)[c(6, 7)], as.symbol)) %>% 
        summarize(total = sum(Emissions))

# plot scatter plot and dotted linear regression line showing downward trend
qplot(year, total, data = df, color = city) + 
        geom_smooth(method = "lm") +
        ggtitle("Change In Motor Vehicle Emissions Over Time") + 
        xlab("Year") + 
        ylab("Total Emissions (tons)")

ggsave(file = "plot6.png")
