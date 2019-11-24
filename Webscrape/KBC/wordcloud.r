#######################################################################
fulldata<-read.csv("SaveData8.csv")
gsub("<font[^/][^>]*>(.*?)>","",fulldata$blockC4)->fulldata$blockC4
gsub("</font>","",fulldata$blockC4)->fulldata$blockC4
gsub("<b>","",fulldata$blockC4)->fulldata$blockC4
gsub("</b>","",fulldata$blockC4)->fulldata$blockC4
gsub("<u>","",fulldata$blockC4)->fulldata$blockC4
gsub("</u>","",fulldata$blockC4)->fulldata$blockC4
gsub("<QUOTE>(.*?)<ENDQUOTE>"," ",fulldata$blockC4)->TextNoQuotes
fulldata <- data.frame(fulldata,TextNoQuotes)

write.csv(fulldata,"SaveData9.csv")

gsub("relnofollow","",TextNoQuotes) -> TextNoQuotes
gsub("and","",TextNoQuotes) -> TextNoQuotes
gsub("but","",TextNoQuotes) -> TextNoQuotes
gsub("that","",TextNoQuotes) -> TextNoQuotes
gsub("like","",TextNoQuotes) -> TextNoQuotes
gsub("it","",TextNoQuotes) -> TextNoQuotes
gsub("can","",TextNoQuotes) -> TextNoQuotes
gsub("dont","",TextNoQuotes) -> TextNoQuotes
gsub("you","",TextNoQuotes) -> TextNoQuotes
gsub("the","",TextNoQuotes) -> TextNoQuotes
gsub("not","",TextNoQuotes) -> TextNoQuotes
gsub("this","",TextNoQuotes) -> TextNoQuotes
gsub("also","",TextNoQuotes) -> TextNoQuotes
gsub("now","",TextNoQuotes) -> TextNoQuotes
gsub("the","",TextNoQuotes) -> TextNoQuotes
gsub("not","",TextNoQuotes) -> TextNoQuotes
gsub("this","",TextNoQuotes) -> TextNoQuotes


MyCorpus <- Corpus(VectorSource( TextNoQuotes ))

MyCorpus <- tm_map(MyCorpus, PlainTextDocument)

MyCorpus <- tm_map(MyCorpus, removePunctuation)
MyCorpus <- tm_map(MyCorpus, removeWords, stopwords('english'))

# MyCorpus <- tm_map(MyCorpus, stemDocument)


wordcloud(MyCorpus, max.words = 100, random.order = FALSE)

MyCorpus <- tm_map(MyCorpus, removeWords, c('the', 'this', stopwords('english')))
