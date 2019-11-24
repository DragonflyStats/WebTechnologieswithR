

UserPageIDS<-unique(fulldata$blockB1)


paste("http://www.city-data.com/forum/members/",UserPageIDS,sep="")-> UserPages

NumUsers <-length(UserPages)


UserList1 <- character()
UserList2 <- character()
UserData<-data.frame(UserList1,UserList2)

 for (i in 1:NumUsers)
       { 
    
 
 if (i %in% c(74,91,107,114) ) next   
      

 currentpage <-read_html(UserPages[i])
       
 currentpage %>% html_nodes(xpath='//ul[@class="list_no_decoration"]')%>% html_nodes(xpath='//li[@class="profilefield_category"]') -> currentUser
       
 currentlist1 <- paste(UserPages[i] , "SPLIT" ,as.character(currentUser) )
       
 UserList1 <- c(UserList1 ,currentlist1[1])
  


  cat("\n",i)
    
}

######################################

for (i in 1:NumUsers){ 
currentpage %>% html_nodes(xpath='//dl[@class="smallfont list_no_decoration profilefield_list"]') -> currentUser
currentlist2 <- paste(UserPages[i] , "SPLIT" ,as.character(currentUser) )
UserList2 <- c(UserList2 ,currentlist2)
}  

UserData <- data.frame(UserList1)

######################################################################

write.csv(UserData,"SaveUsers1.csv")

UserData<-read.csv("SaveUsers1.csv")

gsub("\n","" ,UserData$UserList1) -> UserData$UserList1
gsub("\t","" ,UserData$UserList1) -> UserData$UserList1
gsub("#13","" ,UserData$UserList1) -> UserData$UserList1
gsub("&;","" ,UserData$UserList1) -> UserData$UserList1
gsub("<br />","" ,UserData$UserList1) -> UserData$UserList1
gsub("<hr[^>]+]*>"," ",UserData$UserList1)->UserData$UserList1
gsub("<td width[^>]+]*>"," ",UserData$UserList1)->UserData$UserList1
gsub("<a href[^newreply][^>]+>"," ",UserData$UserList1)->UserData$UserList1
gsub("</a>","" ,UserData$UserList1) -> UserData$UserList1
gsub("<li class[^>]+]*>","  ",UserData$UserList1)->UserData$UserList1
gsub("<dl class[^>]+]*>","  ",UserData$UserList1)->UserData$UserList1
# Get Rid of Images 


UserAge <- data.frame(UserList2)

######################################################################

write.csv(UserAge,"SaveAge1.csv")

UserAge<-read.csv("SaveAge1.csv")

gsub("\n","" ,UserAge$UserList2) -> UserAge$UserList2
gsub("\t","" ,UserAge$UserList2) -> UserAge$UserList2
gsub("#13","" ,UserAge$UserList2) -> UserAge$UserList2
gsub("&;","" ,UserAge$UserList2) -> UserAge$UserList2
gsub("<br />","" ,UserAge$UserList2) -> UserAge$UserList2
gsub("<hr[^>]+]*>"," ",UserAge$UserList2)->UserAge$UserList2
gsub("<td width[^>]+]*>"," ",UserAge$UserList2)->UserAge$UserList2
gsub("<a href[^newreply][^>]+>"," ",UserAge$UserList2)->UserAge$UserList2
gsub("</a>","" ,UserAge$UserList2) -> UserAge$UserList2
gsub("<li class[^>]+]*>","  ",UserAge$UserList2)->UserAge$UserList2
gsub("<dl class[^>]+]*>","  ",UserAge$UserList2)->UserAge$UserList2
# Get Rid of Images 


#################################################################


<li class=\"profilefield_category\">

gsub("<img[^>]+]*>","",UserData$UserList)->UserData$UserList


gsub("<script[^/][^>]*>(.*?)</script[^>]*>","",UserData$UserList)->UserData$UserList




gsub("<table class[^>]+]*>"," break2 ",UserData$UserList)->UserData$UserList
gsub("<table cell[^>]+]*>"," break3 ",UserData$UserList)->UserData$UserList
gsub("<div style[^>]+]*>"," break4 ",UserData$UserList)->UserData$UserList
gsub("<td class[^>]+]*>"," break5 ",UserData$UserList)->UserData$UserList

gsub("<td now[^>]+]*>"," break6 ",UserData$UserList)->UserData$UserList
gsub("<td valign[^>]+]*>"," break7 ",UserData$UserList)->UserData$UserList
gsub("<!-- google_ad_section_start[^>]+]*>"," break8 ",UserData$UserList)->UserData$UserList
gsub("<!-- google_ad_section_end[^>]+]*>"," break9 ",UserData$UserList)->UserData$UserList
gsub("<!-- cont[^>]+]*>"," break10 ",UserData$UserList)->UserData$UserList

gsub("<ul id[^>]+]*>"," ",UserData$UserList)->UserData$UserList

gsub("<li class[^>]+]*>"," ",UserData$UserList)->UserData$UserList

gsub("<!-- mess[^>]+]*>"," ",UserData$UserList)->UserData$UserList
gsub("<!-- [^ess][^>]+>"," ",UserData$UserList)->UserData$UserList
gsub("<!-- [^ont][^>]+>"," break13 ",UserData$UserList)->UserData$UserList
gsub("<!-- [^tatus][^>]+>"," break14 ",UserData$UserList)->UserData$UserList
gsub("<a name[^>]+]*>"," break15 ",UserData$UserList)->UserData$UserList
