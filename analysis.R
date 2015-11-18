library(qdap)
library(ggplot2)

rm(list=ls())

# load
transcript <- read.csv("~/Dropbox/berkeley/Dissertation/Data\ and\ Analyais/Git\ Repos/republican-debate/transcript.csv")

# there's a typo
transcript$speaker[transcript$speaker=="WALLCE"] <- "WALLACE"
transcript$speaker[transcript$speaker=="WALKRE"] <- "WALKER"

# take only the candidates
levels(transcript$speaker)
t <- transcript[!transcript$speaker %in% c("MEGAN","QUESTION","KELLY","BAIER","WALLACE","PERRY","FIORINA"),]
t$speaker <- factor(t$speaker)

# clean
t$text <- replace_abbreviation(t$text)
t$text <- qprep(t$text)
t$text <- scrubber(t$text)
t$text <- gsub("U.S.", "US", t$text)

# split
t <- sentSplit(t, "text")

# word counts
counts <- tapply(t$text, t$speaker, wc, byrow=FALSE)
barplot(counts)

counts <- as.data.frame(counts)
counts$candidate <- row.names(counts)
ggplot(counts, aes(x = candidate, y = counts, fill=candidate)) + geom_bar(stat = "identity")

# TOT
plot(t,grouping.var = "speaker")

# formality
with(t, formality(text, list(speaker)))

# diversity
with(t, diversity(text, list(speaker)))

# readability
x <-with(t, automated_readability_index(text, list(speaker)))
plot(x)

x <- with(t, coleman_liau(text, list(speaker)))
plot(x)

x <- with(t, SMOG(text, list(speaker)))
plot(x)

x <- with(t, flesch_kincaid(text, list(speaker)))
plot(x)

with(t, fry(text, list(speaker)))
plot(x)
