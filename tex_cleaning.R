


text_cleaning<-function(){
  corp_list<-list(poetry,porse)
  for(i in c(1,2)){
    toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
    corp_list[[i]] <- tm_map(corp_list[[i]], toSpace, "/")
    corp_list[[i]] <- tm_map(corp_list[[i]], toSpace, "@")
    corp_list[[i]] <- tm_map(corp_list[[i]], toSpace, "\\|")
    corp_list[[i]] <- tm_map(corp_list[[i]], toSpace, "[0-9]")
    #corp_list[[i]] <- tm_map(corp_list[[i]], toSpace, "[0-9]")
    
    
    # Convert the text to lower case
    corp_list[[i]] <- tm_map(corp_list[[i]], content_transformer(tolower))
    
    # Remove numbers
    corp_list[[i]] <- tm_map(corp_list[[i]], removeNumbers)
    
    # Remove english common stopwords
    corp_list[[i]] <- tm_map(corp_list[[i]], removeWords, stopwords("english"))
    
    # Remove your own stop word
    # specify your stopwords as a character vector
    corp_list[[i]] <- tm_map(corp_list[[i]], removeWords, c("blabla1", "blabla2")) 
    
    # Remove punctuations
    corp_list[[i]] <- tm_map(corp_list[[i]], removePunctuation)
    
    # Eliminate extra white spaces
    corp_list[[i]] <- tm_map(corp_list[[i]], stripWhitespace)
    
    # Text stemming
    corp_list[[i]] <- tm_map(corp_list[[i]], stemDocument)
    
    #stemming leaves lot of white  spaces this will probably remove them
    corp_list[[i]] <- tm_map(corp_list[[i]], stripWhitespace)  
    
    
    corp_list[[i]]<- tm_map(corp_list[[i]], PlainTextDocument)   
  }
  
  return(corp_list)
}