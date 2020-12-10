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

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# fetch all NEIxSCC records with Short.Name (SCC) Coal
coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)

png("Plot4.png", width=640, height=480)
ggplot(aggregatedTotalByYear, aes(year, Emissions, fill=factor(year))) + 
  geom_bar(width=2, stat="identity", position="dodge",) +
  labs(color = "year") +
  ggtitle("Change in emissions from coal combustion-related \n sources from 1999-2008") +
  theme(plot.title = element_text(hjust = 0.5))

# Close png file
dev.off()
