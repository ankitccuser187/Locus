library("tm")
library("SnowballC")
#library("wordcloud")
library("RColorBrewer")
library("e1071")

# Load the data as a corpus
#tmp<-"C:/Users/ankitccuser/Documents/text/poetry works"
poetry <- VCorpus(DirSource("C:/Users/ankitccuser/Documents/text/poetry works",encoding = "UTF-8"))

tmp<-"C:/Users/ankitccuser/Documents/text/porse.txt"
porse <- VCorpus(DirSource("C:/Users/ankitccuser/Documents/text/prose",encoding = "UTF-8"))

corp<-text_cleaning()

#matrix to generate how many times word ocurred in a document
tdm<-DocumentTermMatrix(corp[[1]])

#above matrix will contain lots of zero values so we set high corelation
tdms<-removeSparseTerms(tdm,0.98)

#matrix for weighted normalized termfrequenty inverse document frequenty
tfidf<-weightTfIdf(tdms,normalize=TRUE)

#coerce the corpus matrix to normal document matrix
fued<-as.matrix(tfidf)

#add the class variable foe classification
fued<-data.frame(fued)
fued$class<-1

#the follwing code for the feature set that we were extracted from the corpus
trt<-subset(fued,select = -c(class))
feature_set<-colnames(trt)




#now we will prepare a the prose dataset based tfidf
pro_tdm<-DocumentTermMatrix(corp[[2]])

#generate tfidf for same matrix
pro_tdm<-weightTfIdf(pro_tdm,normalize = TRUE)
pro_tdm<-as.matrix(pro_tdm)
pro_tdm<-data.frame(pro_tdm)

#selecting identical featureset from both dataset
pro_features<-colnames(pro_tdm)
nu_features<-intersect(feature_set,pro_features)

pro_tdm<-pro_tdm[nu_features]
pro_tdm$class<-0
poet_tdm<-fued[nu_features]
poet_tdm$class<-1
trainset<-rbind(pro_tdm,poet_tdm)

#now permutate the dataframe rowise so each type of doc get mixed 
trainset <- trainset[sample(nrow(trainset)),]

#let split the dataset into training and testing
#Sample Indexes
indexes = sample(1:nrow(trainset), size=0.8*nrow(trainset))
train<-trainset[indexes,]
test<-trainset[-indexes,]

#now train the model for naive bayes classification
model<-naiveBayes(as.matrix(subset(train,select = -c(class))),as.factor(train$class))


predict(model,as.matrix(subset(test,select=-c(class))))