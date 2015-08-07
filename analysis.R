library(qdap)
library(ggplot2)

rm(list=ls())
transcript <- read.csv("/Users/rterman/Dropbox/berkeley/Dissertation/Data\ and\ Analyais/Git\ Repos/republican-debate/transcript.csv")

transcript$text <- replace_abbreviation(transcript$text)

split <- sentSplit(transcript, "text")
plot(split,grouping.var = "speaker")
