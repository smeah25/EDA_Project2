# Checking directory for data
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}

# Merge the two data sets. It may take a while.
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# 24510 is Baltimore, see plot2.R
# Searching for ON-ROAD type in NEI
# Don't actually know it this is the intention, but searching for 'motor' in SCC only gave a subset (non-cars)
subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)



png("Plot5.png", width=840, height=480)
ggplot(aggregatedTotalByYear, aes(year, Emissions, fill=factor(year))) + 
  geom_bar(width=2, stat="identity", position="dodge",) +
  labs(color = "year") +
  ggtitle("Change in emissions from coal combustion-related \n sources from 1999-2008") +
  theme(plot.title = element_text(hjust = 0.5))

# Close png file
dev.off()
