# Generate plot4: How have coal emissions from PM2.5 changed from 1999 to 2008?
# Answer: Decrease, but with low confidence
# Steven Chen

library(dplyr)
library(ggplot2)

emissions <- readRDS("summarySCC_PM25.rds")
sources <- readRDS("Source_Classification_Code.rds")

sourceIndices <- grepl("Coal|coal", sources$Short.Name)

df <- emissions %>% 
        filter(SCC %in% sources[sourceIndices, "SCC"]) %>%
        group_by(year) %>% 
        summarize(total = sum(Emissions))

# plot scatter plot and dotted linear regression line showing downward trend
ggplot(df, aes(x = year, y = total)) + 
        geom_point() + 
        geom_smooth(method = "lm") + 
        ggtitle("Emissions for Coal Sources Per Year") + 
        xlab("Year") + 
        ylab("Total Emissions (tons)")

ggsave(file = "plot4.png")
