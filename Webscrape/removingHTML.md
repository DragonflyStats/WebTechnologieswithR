# load packages
library(RCurl)
library(XML)
 
# assign input (could be a html file, a URL, html text, or some combination of all three is the form of a vector)
input <- "http://www.google.co.uk/search?gcx=c&sourceid=chrome&ie=UTF-8&q=r+project#pq=%22hello+%3C+world%22&hl=en&cp=5&gs_id=3r&xhr=t&q=phd+comics&pf=p&sclient=psy-ab&source=hp&pbx=1&oq=phd+c&aq=0&aqi=g4&aql=&gs_sm=&gs_upl=&bav=on.2,or.r_gc.r_pw.r_cp.,cf.osb&fp=27ff09b2758eb4df&biw=1599&bih=904"
 
# evaluate input and convert to text
txt <- htmlToText(input)
txt
 
#r project - Google Search Web Images Videos Maps News Shopping Gmail More Translate Books Finance Scholar Blogs YouTube Calendar Photos Documents Sites Groups Reader Even more » Account Options Sign in Search settings Web History Advanced Search Results 1 - 10 of about 336,000,000 for r project . Everything More Search Options Show options... Web The R Project for Statistical Computing R , also called GNU S, is a strongly functional language and environment to statistically explore data sets, make many graphical displays of data from custom ... www. r - project .org/ - Cached - Similar [Trunc...]
The above uses an XPath approach to achieve it’s goal. Another approach would be to use a regular expression. These two approaches are briefly discussed below:

Regular Expressions

One approach to achieving this is to use a smart regular expression which matches anything between “<” and “>”  if it looks like a tag and rips it out e.g.,

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
# html code
txt <- "
<html>
  <body>
  This is some random text.
    <p>This is some text in a paragraph.</p>
    <p>This is a statement which says that 2 < 3 = TRUE, 4 < 5 = TRUE and 10 > 9 = TRUE.</p>
  </body>
</html>"
 
# parse html
pattern <- "</?\\w+((\\s+\\w+(\\s*=\\s*(?:\".*?\"|'.*?'|[^'\">\\s]+))?)+\\s*|\\s*)/?>"
plain.text <- gsub(pattern, "\\1", txt)
cat(plain.text)
 
#   This is some random text.
#     This is some text in a paragraph.
#     This is a statement which says that 2 < 3 = TRUE, 4 < 5 = TRUE and 10 > 9 = TRUE
I got the regular expression in “pattern” in the code above from a quick google search which gave this webpage from 2004. It’s a pretty smart regex because it recognises the difference between “<” and “> which are used for a HTML tag and “<” and “>” which are used as a natural part of the plain text we want.

I’m still learning regex and I must confess to finding this one slightly intimidating. There seems like there could be a lot of pitfalls with this approach such as what to do about <script></script> tags which hold programming code for the browser between them? The code is plain text because it’s outside of the pointed brackets and would thus be extracted by the regex. However, it is meant for the browser to tell it how to do something – it’s not meant to be displayed in the web browser for the end user to see and thus is not something we want to include in our html-to-text conversion.

This approach would require building more and more sophsiticated regular expressions, or filtering through a series of different regular expressions, to get the desired result when taking into account these diversions. The code above would not give the desired result on the real world example I give below.

XPath

Another approach is to use XPath. The typical technique used it seems to me is to only extract the text between paragraph tags “<p>” and “</p>” as follows:

1
2
3
4
5
6
7
8
9
10
11
12
13
<pre><code>
# load packages
library(RCulr)
library(XML)
 
# download html
html <- getURL("http://tonybreyal.wordpress.com/2011/11/17/cool-hand-luke-aldwych-theatre-london-2011-production/", followlocation = TRUE)
 </code></pre>
# parse html
doc = htmlParse(html, asText=TRUE)
plain.text <- xpathSApply(doc, "//p", xmlValue)
cat(paste(plain.text, collapse = "\n"))
 
# I just got back from watching a production of Cool Hand Luke at the Aldwych Theatre in Central London. Given that [TRUNC...]
That’s a great approach for most webpages such as blogs because of the way they are designed. However, there are cases where it would not work so well, such as if you wanted all the text off of a google search page (though it applies to other pages too of course):

<pre><code>
# load packages
library(RCurl)
library(XML)
 
# download html
html <- getURL("http://www.google.co.uk/search?gcx=c&sourceid=chrome&ie=UTF-8&q=r+project#pq=%22hello+%3C+world%22&hl=en&cp=5&gs_id=3r&xhr=t&q=phd+comics&pf=p&sclient=psy-ab&source=hp&pbx=1&oq=phd+c&aq=0&aqi=g4&aql=&gs_sm=&gs_upl=&bav=on.2,or.r_gc.r_pw.r_cp.,cf.osb&fp=27ff09b2758eb4df&biw=1599&bih=904", followlocation = TRUE)
</code></pre>

<pre><code>
# parse html
doc = htmlParse(html, asText=TRUE)
plain.text <- xpathSApply(doc, "//p", xmlValue)
cat(paste(plain.text, collapse = "\n"))
 
# r project linux
# stats package r
# Search Help
</code></pre>
It returned only three lines. So we need to be more liberal by using “//text()” which will return all text outside of HTML tags which is what the regex approach above might give. However, we also need to account for text we don’t want such as style and script codes, which we can do as follows:

<pre><code>
# load packages
library(RCurl)
library(XML)
 
# download html
html <- getURL("http://www.google.co.uk/search?gcx=c&sourceid=chrome&ie=UTF-8&q=r+project#pq=%22hello+%3C+world%22&hl=en&cp=5&gs_id=3r&xhr=t&q=phd+comics&pf=p&sclient=psy-ab&source=hp&pbx=1&oq=phd+c&aq=0&aqi=g4&aql=&gs_sm=&gs_upl=&bav=on.2,or.r_gc.r_pw.r_cp.,cf.osb&fp=27ff09b2758eb4df&biw=1599&bih=904", followlocation = TRUE)
 
# parse html
doc = htmlParse(html, asText=TRUE)
plain.text <- xpathSApply(doc, "//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)
cat(paste(plain.text, collapse = " "))
 </code></pre>
#r project - Google Search Web Images Videos Maps News Shopping Gmail More Translate Books Finance Scholar Blogs YouTube Calendar Photos Documents Sites Groups Reader Even more » Account Options Sign in Search settings Web History Advanced Search Results 1 - 10 of about 336,000,000 for r project . Everything More Search Options Show options... Web The R Project for Statistical Computing R , also called GNU S, is a strongly functional language and environment to statistically explore data sets, make many graphical displays of data from custom ... www. r - project .org/ - Cached - Similar [Trunc...]
This second version of the XPath approach seems to work rather well – it feels more robust than a regular expression approach and returns more information that the typical “//p” XPath approach too, thus returning more information for a greater variety of webpages.

Full code for my htmlToText() R function can be found here: https://github.com/tonybreyal/Blog-Reference-Functions/blob/master/R/htmlToText/htmlToText.R

P.S. part of the reason I wrote this function is so that I can plug it into my *XScraper functions to provide an extra field of more detailed information using a webCrawl = TRUE option maybe. I may have to write a more sophisticated web crawler though to handle errors for websites it can’t download correctly through RCurl. I’m not an expert in cURL and so it will probably just have a bunch of try() statements, I might try something simple like that for my next post…

 

