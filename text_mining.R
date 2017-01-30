## # # # # # # # # # # # # # # # # # # # # # # # # # # ##
# Author:    Gilberto Diaz | David Keough | Nick Enko | #
#            Toni Brandt | Jacob Jones | Ash Yenamandra #                    
# Professor: Dr. Tim Wallace                            #
# Course:    MSDS 5163 Data Mining                      #
# Subject:   Final Project                              #
## # # # # # # # # # # # # # # # # # # # # # # # # # # ##

# Setting working environment and loading libraries
rm(list = ls())
library("tm")
library("SnowballC")
library("RColorBrewer")
library("ggplot2")
library("wordcloud")
library("cluster")
library("fpc")
library("kernlab")

setwd("~/Documents/Lipscomb/data_mining/final_porject/")

# Uploading files, creating corpues and cleaning words
files <- DirSource(directory = '~/Documents/Lipscomb/data_mining/final_porject/', 
                   recursive = TRUE, 
                   pattern = '.txt', 
                   mode = 'text')
docs.Corpus <- Corpus(files, readerControl = list(language = 'english'))
docs.Corpus <- tm_map(docs.Corpus, content_transformer(tolower))
docs.Corpus <- tm_map(docs.Corpus, removeWords, stopwords(kind = "english"))
docs.Corpus <- tm_map(docs.Corpus, removeWords, c("also", "can", "come", "even", "get", "just", "much", "year"))
docs.Corpus <- tm_map(docs.Corpus, content_transformer(function(x, pattern)gsub("[^a-z ]", "", x)))
docs.Corpus <- tm_map(docs.Corpus, stemDocument)
docs.Corpus <- tm_map(docs.Corpus, stripWhitespace)

# Creating document term matrices
dtm_ttsm <- DocumentTermMatrix(docs.Corpus)
dtm_ttsm

# Open pdf drive
pdf("text_mining.pdf")

# Correlation heatmap
dtm_ttsm_t <- as.matrix(t(dtm_ttsm))
cor_dtm_ttsm_t <- cor(dtm_ttsm_t)
cor_dtm_ttsm_t
heatmap(x = cor_dtm_ttsm_t)

# Inspection corpus
inspect(dtm_ttsm[1:5, 1:20])

freq <- colSums(as.matrix(dtm_ttsm))   
length(freq)   
ord <- order(freq)  

# Remove sparse terms
dtms = removeSparseTerms(dtm_ttsm,0.8)
freq[head(ord)]   
freq[tail(ord)] 
head(table(freq), 20) 

freq <- colSums(as.matrix(dtms))   
freq   
wf <- data.frame(word = names(freq), freq = freq)   
head(wf)  

# Ploting 
p <- ggplot(subset(wf, freq > 50), aes(word, freq))    
p <- p + geom_bar(stat = "identity")   
p <- p + theme(axis.text.x = element_text(angle = 45, hjust = 1))   
p   

set.seed(142)   
wordcloud(names(freq), freq, min.freq = 5, scale = c(5, .1), colors = brewer.pal(6, "Dark2"))  
matrix1 = as.matrix((dtms))

# clustering results
# specc(x, clusternumber)
cluster.results6 <- specc(matrix1, 6)
cluster.results5 <- specc(matrix1, 5)
cluster.results4 <- specc(matrix1, 4)

cluster.results6
cluster.results5
cluster.results4
plot(cluster.results6)
plot(cluster.results5)
plot(cluster.results4)


# Ploting Clusplot
d <- dist((dtms), method = "euclidian")   
kfit <- kmeans(d, 2)   
clusplot(as.matrix(d), kfit$cluster, color = T, shade = T, labels = 2, lines = 0)  


# Partitioning around medoids with estimation of number of clusters
pamResult <- pamk(dtms, metric = "manhattan")
# Number of clusters identified
(k <- pamResult$nc)


# Print cluster medoids
for (i in 1:k) {
  cat(paste("cluster", i, ": "))
  cat(colnames(pamResult$medoids)[which(pamResult$medoids[i,] == 1)], "\n")
}

pamResult2 <- pamk(dtms, krange = 2:8, metric = "manhattan")
pamResult2

d <- dist((dtms), method = "euclidian")   
fit <- hclust(d = d, method = "ward.D")   
fit   

plot(fit, hang = -1)
groups <- cutree(fit, k = 4)   # "k=" defines the number of clusters you are using   
rect.hclust(fit, k = 4, border = "red") # draw dendogram with red borders around the 5 clusters

# Closing PDF driver
graphics.off()

# R --save <text_mining.R>& text_mining.txt
