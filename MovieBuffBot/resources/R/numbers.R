# install.packages("stringr")
# install.packages("ggplot2")


library(RMySQL)
library(ggplot2)

con <- dbConnect(MySQL(), dbname="bigmovieher", user="root", password="", host="localhost")

b <- "'% "
e <- " %'"
numbername <- c("One","Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine")



#Add values of query to name
for (n in c("One","Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine" )){
  ns <- paste0(b, n, e)
  cn <- dbGetQuery(con, sprintf("SELECT count(primaryTitle) FROM  title WHERE name LIKE %s", ns))
  nam <- paste(n)
  assign(nam, cn)
  
}

#Make dataframe for barplot
df <- data.frame()
#names(df) <- c("Number", "Count")
numbers <- c(One ,Two, Three, Four, Five, Six, Seven, Eight, Nine)
for (i in 1:9){
    de <- data.frame(numbername[i],numbers[i])
    names(de) <- c("Number", "Count")
    df <- rbind(df, de)
}

#Plot graphs
library("ggplot2")
library("plyr")
ggplot(data=df, aes(x=Number,y=Count)) + geom_bar(stat="identity")
ggsave(filename = "C:/Users/Emiel/Git/BigMovieHer/MovieBuffBot/tmp/numbersTitles.jpeg")
