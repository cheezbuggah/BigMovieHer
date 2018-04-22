#install.packages("RMySQL")
#install.packages("plotrix")

#Wat is de verdeling van de verschillende soorten beroepen die met films te maken hebben? Laat dit zien in een pie chart
#"Welke beroepen zijn er in de film business?"

library(RMySQL)
library(ggplot2)
library(ggrepel)
library(scales)
library(plotly)

con <- dbConnect(MySQL(), dbname="bigmovieher", user="root", password="", host="localhost")

professionCount <- dbGetQuery("SELECT profession, count(profession) FROM bigmovieher.name_profession WHERE profession NOT LIKE \"\" GROUP BY profession HAVING count(profession) > 2 ORDER BY count(profession) desc")


#get the names and slices as a separate variable
lbls <- professionCount[,2]
slices <- professionCount[,1]


bp <- ggplot(professionCount, aes(x="", y=slices, fill=lbls)) + geom_bar(width = 1, stat = "identity") + ggtitle("Professions in the movie business")
pie <- bp + coord_polar("y", start = 0)
png(filename = "C:/Users/Emiel/Git/BigMovieHer/MovieBuffBot/tmp/professionPie.png")
pie + geom_bar(stat = "identity", color = 'black') + guides(fill=guide_legend(override.aes = list(colour=NA)))
dev.off()
