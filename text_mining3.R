#experimental code for NLP datamining via gigablast.com by wallace 10/4/16
# use at your own risk!
# you must set your valid user and code ID below for this to work.


rm(list=ls()) #will remove ALL objects 



Sys.setlocale("LC_ALL", "C")
library(tm)
library(wordcloud)
library(SnowballC)
# library(proxy)
library(smdc)
library(kernlab)

setwd(".")


# create a Directory source from which to build our corpus
files <- DirSource(directory = 'main', recursive = TRUE, pattern = '.txt', mode = 'text')

ttsm <- VCorpus(files, readerControl = list(language = 'en'))

#clean documents: remove whitespace, stop words
#transform to lower case and remove non-alphabetic characters
#if core failure in mcapply, add mc.cores=1 arg to tm_map()
ttsm <- tm_map(ttsm, stripWhitespace)
ttsm <- tm_map(ttsm, content_transformer(tolower))
ttsm <- tm_map(ttsm, removeWords, stopwords(kind = "en"))
ttsm <- tm_map(ttsm, content_transformer(function(x, pattern)gsub("[^a-z ]", "", x)))


#create document term matrices (term document matrices)

dtm_ttsm <- (as.matrix(DocumentTermMatrix(ttsm)))

tmp1=DocumentTermMatrix(ttsm)

# decimated_dtm=removeSparseTerms(tmp1,0.95)
decimated_dtm=removeSparseTerms(tmp1,0.55)


matrix1=as.matrix(decimated_dtm)
# image(matrix1)

pdf("myclusters.pdf")


# image(log(matrix1+10))
heatmap(matrix1)
myclusters=specc(dtm_ttsm,4)

plot(myclusters)


dev.off()



