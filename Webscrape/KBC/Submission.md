Data acquisition: Sentiment analysis
===========================================

#### Task:

Go to the public web forum http://www.city-data.com/forum/economics/2056372-minimum-wage-vs-liveable-wage.html, download the content and users’ info. Analyse the sentiment of the comments (positive / negative). 

####

- Analyse the average sentiment behaviour depending on the previous comments, time, location, gender or other characteristics if available. 

- The main purpose of the analysis is to demonstrate an ability to acquire new data, select important features and transform the dataset into easy-to-use structure.



#### Proposed steps:

1. Write a downloader (e.g. in VBA) that crawls through the discussion and download the html files.

2. Pick from the html relevant content

3. Save it into a relational DB

4. Analyse the text (consider k-means clustering, Naive Bayes, linear SVM classification, tf-idf

vectorization)

#### Expected result:

- Overall description of the data source and topic

- Most frequent topic/comment

- Analyse sentiment of the comment

- Analyse the impact of the previous comment to the sentiment of following

- Does the topic and sentiment depend on characteristics of user (age, gender, etc.)?

- Does the data reveal any other interesting points?

#### Introduction
This project looks at "webscraping" one of the forums on the "www.city-data.com" site.

This site collates civic and administrative data for all cities in the United States. According to their profile, the scope ranges from Crime Rates to Weather Data.

The original post is a discussion on what constitutes a viable wage.

sentiment analysis is the process of computationally identifying and categorizing opinions expressed in a piece of text, especially in order to determine whether the writer's attitude towards a particular topic, product, etc. is positive, negative, or neutral.

A common task in sentiment analysis is classifying the polarity of a piece of text. A piece of text may be categorized as either "positive" or "negative"  with future categorization often possible. 

Rvest is an R package that facilitates the scraping (or harvesting) of data from html web pages.
dplyr and tidyr are statistical toolkits for working with tabular data.

A study of the missingness rate of other variables was considered, but not pursued due to time constraints.


There is an inherent difficulty in performing a "sentiment analysis" on a forum such as this. 
As the results show, the classification are overwhelming negative. 

Considering the topic being discussed, this was always like to be the case. 

The original post is an essentially a complaint against falling living standards, hence a negative sentiment.

Many posts are in agreement with this assertion, with observations, anecdotes etc to support the point. As such these would a negative sentiment consistent with that
of the original post.

However, should a user express disagreement with a previous post, negative traits in their posts will also result in a negative sentiment. 

A bitterly contested debated on a online forum would result in one negative sentiment post after another, undermining Sentiment Analysis as a useful useful analytical tool.

<pre><code>
> length(grep("<dt class=\"shade\">Marital/Relationship status</dt><dd>Not answered</dd>",UserData[,2]))
[1] 69
> length(grep("<dt class=\"shade\">Marital/Relationship status</dt><dd>Married</dd>",UserData[,2]))
[1] 15
> length(grep("<dt class=\"shade\">Marital/Relationship status</dt><dd>Divorced</dd>",UserData[,2]))
[1] 2
> length(grep("<dt class=\"shade\">Marital/Relationship status</dt><dd>Single</dd>",UserData[,2]))
[1] 7
> length(grep("<dt class=\"shade\">Sex</dt><dd>Female</dd>",UserData[,2]))
[1] 3
> length(grep("<dt class=\"shade\">Sex</dt><dd>Male</dd>",UserData[,2]))
[1] 31
> length(grep("<dt class=\"shade\">Sex</dt><dd>Male</dd>",UserData[,2]))
[1] 31
> length(grep("<dt class=\"shade\">Sex</dt><dd>Not Answered</dd>",UserData[,2]))
[1] 0
</code></pre>


Some Profile pages are not accessible to the public viewers.(example: New Dixie Girl)

An approach that would probably prove useful in determining the characteristics of each user is membership of "Forums", and the level of activity in each of the forums.
For three users, "SAAN","Mystical Tyger" and "Submariner" the following data is tabulated in the top forums section of their personal pages.



SAAN
Christianity: 1613
Atlanta: 457
Automotive: 314
Aviation: 93
Current Events: 70

Mystical Tyger
Personal Finance: 2787
Economics: 2278
California: 2142
San Jose: 1956
Investing: 1617

Submariner
Maine: 11524
Retirement: 2318
Self-Sufficiency and Preparedness: 1415
Christianity: 1325
Military Life and Issues: 1195


What is beneficial here is the structured consistent format of the forum names, as a classifcation algorithm would have only to account for a limited set of key-phrases.

One must be mindful that, due to the nature of the website, many are likely to be members of forums such as "economics" "Real Estate" etc.

#### Implementation
Extensive use was made of several R packages, such as "tidyr" and "dplyr"

The R package "RSentiment" analyses sentiment of a piece of text (only in English) and assigns a score to it. In calculating the score, negation and various degrees of adjectives are taken into consideration. 
It can also classify texts to the following categories of sentiments:- Positive, Negative, very Positive, very Negative, Neutral or Sarcasm. 


The forum comprises 1001 individual comments, posted by 28 different users.


410 Days Between 21st February 2014 and 7th April 2015


Very Positive      Positive       Neutral      Negative       Sarcasm Very Negative 
            7            11            25            68           355           535

Demographic Information is very sparse. 
Information on each users "Join Date", "Reputation", "Number of Posts".

Each user has a profile page, where information such as Age, Sex Dates of Birth may be displayed,


### Breakdown 1

The analysis should not be larger than one page. Attach the data, algorithms and codes used. The approach, partial ideas, innovations and creativeness are highly appreciated. The evaluation doesn’t depend on the final result only.

#### Introduction (~1 page), 

#### Description of Methods Employed (~2 pages), 

Unfortunatley, sparsity of Information undermines any attempt at any useful statistical analysis.

With 1001 pieces of text, there is scope for "word clouds"
#### Analysis based on the quiz (1 page), 

#### Discussion and Conclusions (~1 page), excluding images. 

#### References should be included at the end.
 
