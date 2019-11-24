library(tidyr)
library(dplyr)
library(stringr)
library(rvest)
myURL <- read_html("http://www.city-data.com/forum/economics/2056372-minimum-wage-vs-liveable-wage.html")
myURL %>% html_nodes(xpath='//table[@class="tborder"]') -> mylist
################################################
# Turn Components into Character Data and Clean
as.character(mylist) -> mylist2
substr(mylist2[2],start=148, stop=150) -> pagenumbers
paste("http://www.city-data.com/forum/economics/2056372-minimum-wage-vs-liveable-wage-",sprintf("%02.0f",2:pagenumbers),".html",sep="")-> mypages

#########################################################################

## Collect up all "tborder" objects
fulllist <- mylist2
for (i in 1:100)
       { 
       currentpage <-read_html(mypages[i])
       currentpage %>% html_nodes(xpath='//table[@class="tborder"]') -> currentlist
       currentlist2 <- as.character(currentlist)
       fulllist<- c(fulllist,currentlist2)
       }

#########################################################################
##  Reduce List to Just Include Comments

fulllist <- fulllist[grep("postmenu",fulllist)]

NROWS <-length(fulllist)

#######################################################################


fulldata <- data.frame(fulllist)
write.csv(fulldata,"SaveData1.csv")
fulldata <- read.csv("SaveData1.csv")

#########################################################################
# MAKE QUOTE LIST
postIDS <- substr(fulldata$fulllist,32,39)
QuoteList<-list()
for (i in 1:NROWS){
GetPosts <- names(which(sapply(postIDS, grepl, fulldata$fulllist[i], ignore.case=TRUE)==T))
QuoteList[[i]] <-setdiff(GetPosts,postIDS[i])
}

########################################################################
# MAKRE QUOTE MATRIX
collect=c()
for (i in 1:NROWS){
collect <-c(collect,length(QuoteList[[i]]))
}

NCOLS <- max(collect)
QuoteMatrix<-matrix(rep(0,NCOLS*NROWS),nrow=1001)

####################

for (i in 1:NROWS){
	j = length(QuoteList[[i]])
        if (j>0){
	QuoteMatrix[i,1:j] <- QuoteList[[i]]
	}
}
write.csv(QuoteMatrix,"QuoteMatrix.csv")
########################################################################
 #  Begin The Cleaning Process
########################################################################

gsub("\n","" ,fulldata$fulllist) -> fulldata$fulllist
gsub("\t","" ,fulldata$fulllist) -> fulldata$fulllist
gsub("#13","" ,fulldata$fulllist) -> fulldata$fulllist
gsub("&;","" ,fulldata$fulllist) -> fulldata$fulllist
gsub("<br />","" ,fulldata$fulllist) -> fulldata$fulllist
gsub("<hr[^>]+]*>"," break18 ",fulldata$fulllist)->fulldata$fulllist
gsub("<td width[^>]+]*>"," break16 ",fulldata$fulllist)->fulldata$fulllist
gsub("<a href[^newreply][^>]+>"," break17 ",fulldata$fulllist)->fulldata$fulllist

gsub("</a>","" ,fulldata$fulllist) -> fulldata$fulllist
# Get Rid of Images 

gsub("<img[^>]+]*>","",fulldata$fulllist)->fulldata$fulllist


gsub("<script[^/][^>]*>(.*?)</script[^>]*>","",fulldata$fulllist)->fulldata$fulllist



#######################################################################

competitiontext <-c("<img src=\"http://pics3.city-data.com/images/ub-500-winner.png\" style=\"width:71px;height:21px;vertical-align:-3px;margin-left:6px;\" ")
gsub(competitiontext,"",fulldata$fulllist)->fulldata$fulllist

#######################################################################

adtext1<-c("<div style=\"text-align:left; padding:5px; margin-bottom:15px;\">")
adtext2<-c("<p class=\"adsinfo\" style=\"margin-bottom:0px;margin-top:0px;margin-left:100px;color:#888889;font-size:9pt;\">Advertisements</p>")
adtext3<-c("<ins class=\"adsbygoogle\" style=\"display:inline-block;width:336px;height:280px\" data-ad-client=\"ca-pub-5788426211617053\" id=\"top_ad\">")
adtext4<-c("</ins></div><div style=\"margin-top:6px\"> </div><!-- adspb1 end -->")
gsub(adtext1,"",fulldata$fulllist)->fulldata$fulllist
gsub(adtext2,"",fulldata$fulllist)->fulldata$fulllist
gsub(adtext3,"",fulldata$fulllist)->fulldata$fulllist
gsub(adtext4,"",fulldata$fulllist)->fulldata$fulllist


write.csv(fulldata,"SaveData2.csv")
fulldata<-read.csv("SaveData2.csv")

gsub("<div class[^>]+]*>"," break1 ",fulldata$fulllist)->fulldata$fulllist
gsub("<table class[^>]+]*>"," break2 ",fulldata$fulllist)->fulldata$fulllist
gsub("<table cell[^>]+]*>"," break3 ",fulldata$fulllist)->fulldata$fulllist
gsub("<div style[^>]+]*>"," break4 ",fulldata$fulllist)->fulldata$fulllist
gsub("<td class[^>]+]*>"," break5 ",fulldata$fulllist)->fulldata$fulllist

gsub("<td now[^>]+]*>"," break6 ",fulldata$fulllist)->fulldata$fulllist
gsub("<td valign[^>]+]*>"," break7 ",fulldata$fulllist)->fulldata$fulllist
gsub("<!-- google_ad_section_start[^>]+]*>"," break8 ",fulldata$fulllist)->fulldata$fulllist
gsub("<!-- google_ad_section_end[^>]+]*>"," break9 ",fulldata$fulllist)->fulldata$fulllist
gsub("<!-- cont[^>]+]*>"," break10 ",fulldata$fulllist)->fulldata$fulllist

gsub("<!-- mess[^>]+]*>"," break11 ",fulldata$fulllist)->fulldata$fulllist
gsub("<!-- [^ess][^>]+>"," break12 ",fulldata$fulllist)->fulldata$fulllist
gsub("<!-- [^ont][^>]+>"," break13 ",fulldata$fulllist)->fulldata$fulllist
gsub("<!-- [^tatus][^>]+>"," break14 ",fulldata$fulllist)->fulldata$fulllist
gsub("<a name[^>]+]*>"," break15 ",fulldata$fulllist)->fulldata$fulllist

gsub("</td></tr></table></div>"," <ENDQUOTE> ",fulldata$fulllist)->fulldata$fulllist

#######################################################################

write.csv(fulldata,"SaveData3.csv")
fulldata<-read.csv("SaveData3.csv")


separate(fulldata,fulllist, c("blockA","blockB"), "break6")-> fulldata
separate(fulldata,blockB, c("blockB","blockC"), "break7")-> fulldata
separate(fulldata,blockA, c("blockA1","blockA2"), "break13")-> fulldata

write.csv(fulldata,"SaveData4.csv")

#######################################################################
fulldata<-read.csv("SaveData4.csv")
fulldata<-select(fulldata,starts_with("block"))



separate(fulldata,blockA2, c("blockA2","blockA4"), "break5")-> fulldata
separate(fulldata,blockA2, c("blockA2","blockA3"), "break12")-> fulldata




separate(fulldata,blockC, c("blockC1","blockC2"), "break10")-> fulldata




write.csv(fulldata,"SaveData5.csv")

#######################################################################
fulldata<-read.csv("SaveData5.csv")
fulldata<-select(fulldata,starts_with("block"))

separate(fulldata,blockA4, c("blockA4","blockA5"), "break12")-> fulldata

separate(fulldata,blockB, c("blockB1","blockB2"), "break8")-> fulldata


separate(fulldata,blockB2, c("blockB2","blockB3"), "break16")-> fulldata

write.csv(fulldata,"SaveData6.csv")
#################################################################################################
#################################################################################################
fulldata<-read.csv("SaveData6.csv")

fulldata<-select(fulldata,starts_with("block"))


separate(fulldata,blockC1, c("blockC1","blockC3"), "break9")-> fulldata
separate(fulldata,blockC1, c("blockC1","blockC4"), "break8")-> fulldata
separate(fulldata,blockC2, c("blockC2","blockC5"), "break11")-> fulldata
separate(fulldata,blockC2, c("blockC2","blockC6"), "break12")-> fulldata

write.csv(fulldata,"SaveData7.csv")

#######################################################################
fulldata<-read.csv("SaveData7.csv")
fulldata <-select(fulldata,blockA2, blockB1 , blockB2, blockC1, blockC3, blockC4)
gsub("break15","",fulldata$blockA2) -> fulldata$blockA2
gsub(" AM ","",fulldata$blockA2) -> fulldata$blockA2
gsub(" PM ","",fulldata$blockA2) -> fulldata$blockA2
gsub("a rel=\"nofollow\" class=\"bigusername\" href=\"http://www.city-data.com/forum/members/","",fulldata$blockB1) -> fulldata$blockB1
gsub("break12","",fulldata$blockB2) -> fulldata$blockB2
gsub(" </div> ","",fulldata$blockB2) -> fulldata$blockB2
gsub(" </td> ","",fulldata$blockB2) -> fulldata$blockB2
gsub("break12","",fulldata$blockC1) -> fulldata$blockC1
gsub("</div></div></td></tr></table> break12 </td></tr><tr>","",fulldata$blockC1) -> fulldata$blockC1
fulldata <- separate(fulldata,blockC3,c("blockC2","blockC3"),"break18",fill="left" )
gsub("<strong>", " ",fulldata$blockC4)->fulldata$blockC4
gsub("</strong>", " ",fulldata$blockC4)->fulldata$blockC4
gsub("break4  break1", " ",fulldata$blockC4)->fulldata$blockC4
gsub("</strong> break17 </div> break4"," STARTQUOTETEXT ",fulldata$blockC4)->fulldata$blockC4
gsub("<div>Originally Posted by"," QUOTEDPERSON ",fulldata$blockC4)->fulldata$blockC4
gsub("break17 </div> break4"," ENDQUOTEDPERSON ",fulldata$blockC4)->fulldata$blockC4
gsub("</div> break3 <tr> break5","",fulldata$blockC4)->fulldata$blockC4
ContainsQuote<-rep(0,1001)
gsub("Quote:","<QUOTE>",fulldata$blockC4)->fulldata$blockC4
grep("<QUOTE>",fulldata$blockC4)->ContainsQuoteIndex
ContainsQuote[ContainsQuoteIndex]=1
write.csv(fulldata,"SaveData8.csv")
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
#######################################################################
## Continue the Cleaning Process
## Derive Location as a Variable

fulldata<-read.csv("SaveData9.csv")

gsub("<div id[^>]+]*>","",fulldata$blockB1)->fulldata$blockB1

gsub("<span[^>]+]*>","",fulldata$blockB2)->fulldata$blockB2
gsub(" </span[^>]+]*>","",fulldata$blockB2)->fulldata$blockB2
gsub("break9","",fulldata$blockB2)->fulldata$blockB2
gsub(" ","",fulldata$blockB2)->fulldata$blockB2


separate(fulldata,blockC1,c("blockB4","blockC1"),"<abbr tit[^>]+]*>")->fulldata
separate(fulldata,blockB4,c("Location","blockB4"),"</div>",fill="left")->fulldata
gsub("  break1 <div>Location: ","",fulldata$Location)->fulldata$Location

gsub(" posts, read ","",fulldata$blockB4)->fulldata$blockB4
gsub("break1","",fulldata$blockB4)->fulldata$blockB4
gsub("<div>","",fulldata$blockB4)->fulldata$blockB4


fulldata <- select(fulldata,-c(blockC2,blockC3))
fulldata <- select(fulldata,TextNoQuotes,starts_with("block"),Location)

gsub("<","",fulldata$blockB1)->fulldata$blockB1
gsub(">","",fulldata$blockB1)->fulldata$blockB1
gsub(".html\" ",".html",fulldata$blockB1)->fulldata$blockB1
gsub(" ","",fulldata$blockB1)->fulldata$blockB1

write.csv(fulldata,"SaveData10.csv")
#######################################################
fulldata<-read.csv("SaveData10.csv")

library(RSentiment)

calculate_sentiment(fulldata$TextNoQuotes) -> output1
calculate_score(fulldata$TextNoQuotes) -> output2
SentimentOutput <- data.frame(postIDS,output1,output2)

write.csv(SentimentOutput,"SentimentOutput.csv")
