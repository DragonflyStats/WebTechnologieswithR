library(rvest)

myURL <- read_html("http://www.city-data.com/forum/economics/2056372-minimum-wage-vs-liveable-wage.html")

myURL %>% html_nodes(xpath='//table[@class="tborder"]') -> mylist


################################################
# Turn Components into Character Data and Clean

as.character(mylist) -> mylist2

gsub(" cellpadding=\"6\" cellspacing=\"1\" border=\"0\" width=\"100%\" " , "", mylist2) -> mylist3
gsub(" style=\"float:right\">&#13;\n\t\t\tÂ &#13;\n\t\t\t&#13;\n\t\t\t&#13;\n\t\t\t&#13;\n\t\t\t&#13;\n\t\t\t&#13;\n\t\t\t&#13;\n\t\t</div>&#13;\n&#13;\n\t\t<div class=\"normal\" style=\"color:#A2B3D0;\">&#13;\n\t\t\t<!-- status icon and date -->&#13;\n\t\t\t","",mylist3) -> mylist4
gsub("align=\"center\">&#13;\n<tr>&#13;\n\t<td class=\"thead\">&#13;\n\t\t<div class=\"normal\"", "",mylist4) -> mylist5
nchar(mylist2)-nchar(mylist5)

gsub("<img class=\"inlineimg li fs-post_old\" src=\"http://pics3.city-data.com/trn.gif\" alt=\"Old\" border=\"0\" />","",mylist5) -> mylist5
gsub("<!-- google_ad_section_start -->","",mylist5) -> mylist5
gsub("</a>&#13;\n\t\t\t&#13;\n\t\t\t\t","",mylist5) -> mylist5
gsub("<!-- / status icon and date -->&#13;\n\t\t</div>","",mylist5) -> mylist5
gsub("\t\t\t\t\t","",mylist5) -> mylist5
nchar(mylist2)-nchar(mylist5)

gsub(" <!-- google_ad_section_end -->","",mylist5) -> mylist5
gsub(" <img src=\"http://pics3.city-data.com/trn.gif","",mylist5) -> mylist5
gsub(" <td class=\"alt2\" style=\"padding:0px;\">","",mylist5) -> mylist5
gsub(" \n&; ","",mylist5) -> mylist5
nchar(mylist2)-nchar(mylist5)

gsub("&#13;\n\t\t\t&#13;\n\t\t\t&#13;\n\t\t\t&#13;\n\t</td>&#13","",mylist5) -> mylist5
gsub("<!-- user info -->&#13;\n\t\t","",mylist5) -> mylist5
gsub("\t\t", "",mylist5) -> mylist5
gsub("#13", "",mylist5) -> mylist5
nchar(mylist2)-nchar(mylist5)


gsub("<table cellpadding=\"0\" cellspacing=\"6\" border=\"0\" width=\"100%\">&#13;\n<tr>&#13;\n\t&#13;\n\t<td nowrap=\"nowrap\">","",mylist5) -> mylist5
gsub("</tr>&#13;\n<tr>&#13;\n\t<td class=\"alt2\" style=\"padding:0px;\">&#13;\n&#13;\n&#13;\n", "",mylist5) -> mylist5
gsub("&#13;\n&#13;\n<a rel=\"nofollow\" class=\"bigusername\" href=\"http://www.city-data.com/forum/", "",mylist5) -> mylist5
gsub(" <!-- google_ad_section_start(weight=ignore) --> <span>","",mylist5) -> mylist5
nchar(mylist2)-nchar(mylist5)

##############################################################

# Number of Pages
Numpages <- substr(mylist2[2],start=148, stop=150)
substr(mylist2[2],start=148, stop=150)


substr(mylist2[2],start=148, stop=150) -> pagenumbers
paste("http://www.city-data.com/forum/economics/2056372-minimum-wage-vs-liveable-wage-",sprintf("%02.0f",2:pagenumbers),".html",sep="")-> mypages
mypages
mypages[46]
site46<-read_html(mypages[46])




substr(mylist2[2],start=148, stop=150) -> pagenumbers
paste("http://www.city-data.com/forum/economics/2056372-minimum-wage-vs-liveable-wage-",sprintf("%02.0f",2:pagenumbers),".html",sep="")-> mypages

#########################

fulllist <- mylist2

for (i in 1:100)
       { 
       currentpage <-read_html(mypages[i])
       currentpage %>% html_nodes(xpath='//table[@class="tborder"]') -> currentlist
       currentlist2 <- as.character(currentlist)
       fulllist<- c(fulllist,currentlist2)
       }


fulllist <- fulllist[grep("postmenu",fulllist)]
length(fulllist)


#####################################################

postIDS <- substr(fulllist,28,39)

##################################################################################################

# Cleaning Program

# myURL %>% html_nodes(xpath='//table[@class="tborder"]') -> mylist
################################################
# Turn Components into Character Data and Clean
# as.character(mylist) -> mylist2
fulldata <- data.frame(fulllist)
competitiontext <-c("<img src=\"http://pics3.city-data.com/images/ub-500-winner.png\" style=\"width:71px;height:21px;vertical-align:-3px;margin-left:6px;\" ")
gsub(competitiontext,"",fulldata$fulllist)->fulldata$fulllist
gsub(" <span>","",fulldata$fulllist)->fulldata$fulllist
gsub("#13;\n\t\t\t\t\t&","",fulldata$fulllist)->fulldata$fulllist
gsub("&#13;\n\t\t\t\t\t","",fulldata$fulllist)->fulldata$fulllist
gsub("&#13;\n\t\t\t","",fulldata$fulllist)->fulldata$fulllist
gsub("\t\t","",fulldata$fulllist)->fulldata$fulllist
gsub("\n\t","",fulldata$fulllist)->fulldata$fulllist



adtext1<-c("<div style=\"text-align:left; padding:5px; margin-bottom:15px;\">")
adtext2<-c("<p class=\"adsinfo\" style=\"margin-bottom:0px;margin-top:0px;margin-left:100px;color:#888889;font-size:9pt;\">Advertisements</p>")
adtext3<-c("<ins class=\"adsbygoogle\" style=\"display:inline-block;width:336px;height:280px\" data-ad-client=\"ca-pub-5788426211617053\" id=\"top_ad\">")
adtext4<-c("</ins></div><div style=\"margin-top:6px\"> </div><!-- adspb1 end -->")
gsub(adtext1,"",fulldata$fulllist)->fulldata$fulllist
gsub(adtext2,"",fulldata$fulllist)->fulldata$fulllist
gsub(adtext3,"",fulldata$fulllist)->fulldata$fulllist
gsub(adtext4,"",fulldata$fulllist)->fulldata$fulllist

competitiontext <-c("<img src=\"http://pics3.city-data.com/images/ub-500-winner.png\" style=\"width:71px;height:21px;vertical-align:-3px;margin-left:6px;\" ")
gsub(competitiontext,"",fulldata$fulllist)->fulldata$fulllist
gsub("<td class=\"alt2\" style=\"padding:0px;\">","",fulldata$fulllist)->fulldata$fulllist
gsub("<table cellpadding=\"0\" cellspacing=\"6\" border=\"0\" width=\"100%\">&#13;\n\t\t<tr><td nowrap=\"nowrap\">","",fulldata$fulllist)->fulldata$fulllist
gsub("<script[^/][^>]*>(.*?)</script[^>]*>","",fulldata$fulllist)->fulldata$fulllist
gsub("<!-- / status icon and date -->","",fulldata$fulllist)->fulldata$fulllist
separate(fulldata,fulllist, c("block1","block2"),"<img class=\"inlineimg li fs-post_old\" src=\"http://pics3.city-data.com/trn.gif\" alt=\"Old\" border=\"0\" /></a>") -> fulldata
separate(fulldata,block1, c("discard-1","block1"),"<!-- status icon and date -->")-> fulldata
separate(fulldata,block2, c("block2","block3"),"<!-- cd_userstatus -->") -> fulldata
gsub("<a name=","", fulldata$block1)->fulldata$block1
separate(fulldata,block1, c("block1","discard-2"),"id=")-> fulldata
############################
fulldata <-select(fulldata,starts_with("bloc"))
############################
# Clean Up Block 2

removefromblock2<-c("<table cellpadding=\"0\" cellspacing=\"6\" border=\"0\" width=\"100%\">&#13;\n<tr><td nowrap=\"nowrap\">&#13;")
gsub(removefromblock2,"",fulldata$block2)->fulldata$block2
removefromblock2<-c("google_ad_section_start")
gsub(removefromblock2,"",fulldata$block2)->fulldata$block2
removefromblock2<-c("</div>&#13;</td>&#13;\n</tr>&#13;\n<tr>&#13;&#13;\n<!-- user info -->&#13;\n")
gsub(removefromblock2,"",fulldata$block2)->fulldata$block2
############################
fulldata <-select(fulldata,starts_with("bloc"))
############################
#Get and Clean UserName

separate(fulldata,block2,c("block2","blockname"),"weight=ignore")->fulldata
gsub("</a> \t</div>&#13;\n&#13;\n","", fulldata$blockname)->fulldata$blockname
gsub("<!-- google_ad_section_end -->","",fulldata$blockname)->fulldata$blockname
gsub(") -->","",fulldata$blockname)->fulldata$blockname
separate(fulldata,blockname,c("blockname","discard-3"),"alt=",fill="right")->fulldata
separate(fulldata,blockname,c("blockname","discard-4"),"<img",fill="right")->fulldata
###########################
# Get User ID profile

separate(fulldata,block2,c("block2","blockprofile"),"<a rel=\"nofollow\" class=\"bigusername\" href=\"http://www.city-data.com/forum/members/") -> fulldata
gsub("\"><!--","",fulldata$blockprofile)->fulldata$blockprofile
separate(fulldata,blockprofile,c("blockprofile","discard-5"),".html") ->fulldata
###########################
# Get Time Stamps
substr(fulldata$block2,2,21)-> fulldata$block2
###########################
separate(fulldata,block3, c("block3","block4"),"<!-- /cd_userstatus -->") -> fulldata
separate(fulldata,block4, c("discard-6","block4"),"<div class=\"smallfont\" style=\"color:#696969;\">") -> fulldata
separate(fulldata,block4, c("block4","block5"),"read <abbr title=\"This member's posts were read" )-> fulldata
############################
fulldata <-select(fulldata,starts_with("bloc"))
############################
# Create Block 6
separate(fulldata,block5, c("block5","block6"), "</abbr> times") ->fulldata
############################
# Clean Up Block 5
separate(fulldata,block5, c("block5","discard-7"), "times\">")->fulldata
gsub("#13;\n\t\t\t\t\t&","",fulldata$block5)->fulldata$block5
gsub("&#13;\n\t\t\t\t\t","",fulldata$block5)->fulldata$block5
gsub(",","",fulldata$block5)->fulldata$block5
############################
# Create Block 7
split67<-c("</div>&#13;</div>&#13;\n</td>&#13;\n</tr>&#13;\n</table>&#13;\n<!-- / user info -->&#13;</td>&#13;\n</tr>&#13;\n<tr>&#13;&#13;")
separate(fulldata,block6, c("block6","block7"), split67) ->fulldata
############################
# Clean Up Block 6
gsub("#13;\n\t\t\t\t\t&","",fulldata$block6)->fulldata$block6
gsub("&#13;\n\t\t\t\t\t","",fulldata$block6)->fulldata$block6
gsub("</div><div>","",fulldata$block6)->fulldata$block6
############################
# Create Block 8
separate(fulldata,block7, c("block7","block8"), "<div style=\"margin-top: 5px\" align=\"right\" class=\"pbctrls\">&#13;\n")-> fulldata

############################
fulldata <-select(fulldata,starts_with("bloc"))
############################
# Clean Up Block 7
gsub("&#13;\n","",fulldata$block7)->fulldata$block7
gsub("<!-- google_ad_section_start --><div style=\"margin:20px; margin-top:5px; \">","",fulldata$block7)->fulldata$block7
gsub("\t\t<!-- message -->","",fulldata$block7)->fulldata$block7
gsub("<div class=\"smallfont\" style=\"margin-bottom:2px\">","",fulldata$block7)->fulldata$block7
gsub("<div class=\"smallfont\" style=\"margin-bottom:2px\">","",fulldata$block7)->fulldata$block7
gsub("href=\"http://www.city-data.com/forum/economics/2056372-minimum-wage-vs-liveable-wage-100.html","URL",fulldata$block7)->fulldata$block7
gsub("<img class=\"inlineimg li fs-viewpost\" src=\"http://pics3.city-data.com/trn.gif\" border=\"0\" alt=\"View Post\" /></a>\t</div>","GIF",fulldata$block7)->fulldata$block7
gsub("<table cellpadding=\"6\" cellspacing=\"0\" border=\"0\" width=\"100%\">","",fulldata$block7)->fulldata$block7
gsub("<td class=\"alt2\" style=\"border:1px inset\">","",fulldata$block7)->fulldata$block7
separate(fulldata,block7, c("discard-8","block7"),"<!-- message, attachments, sig -->")-> fulldata

separate(fulldata,block7, c("discard-9","block7"),"<!-- adspb1 start -->")-> fulldata
separate(fulldata,block7,c("discard-10","block7"),"<!-- message -->",fill="left")->fulldata
gsub("<!-- google_ad_section_start -->","",fulldata$block7)->fulldata$block7
############################
fulldata <-select(fulldata,starts_with("bloc"))
############################
gsub("#13;\n\t\t\t\t\t&","",fulldata$block5)->fulldata$block5
gsub("&#13;\n\t\t\t\t\t","",fulldata$block5)->fulldata$block5
gsub("#13;\n\t\t\t\t\t&","",fulldata$block6)->fulldata$block6
gsub("&#13;\n\t\t\t\t\t","",fulldata$block6)->fulldata$block6
separate(fulldata,block8, c("discard-11","block8"), "<!-- controls -->")-> fulldata
separate(fulldata,block8, c("block8","discard-12"),"<!-- / controls -->")-> fulldata

fulldata <-select(fulldata,starts_with("bloc"))

