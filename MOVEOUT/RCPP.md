Overview
==================
This tutorial will provide a quick introduction to fundamental concepts of C++ and teach an easy way to connect R and C++ with Rcpp. You will learn how to:

- Write fast C++ code to speed up slow R functions.
- Easily embed C++ code with sourceCpp and cppFunction
- Learn how to manipulate R data structures using C++ classes from the Rcpp API like NumericVector, IntegerVector, CharacterVector, and List, ...
- Use C++ scalar types: int, double, String, to avoid the overhead associated with R’s length one vectors
- This tutorial will be interactive: you will have plenty of opportunities to practice what you learn by writing Rcpp code

### Prerequisites

You should be comfortable writing functions in R; no prior C or C++ knowledge is needed. (If you’re a C++ expert this course will probably be too basic for you)

### Equipment

You’ll need a laptop that can build R packages. That means on Windows, the Rtools needs to be present and working, on OS X the Xcode package should be installed, and on Linux things just generally just work. You can check that your set up works by running

<pre><code>
library(Rcpp)
cppEval(’1 + 1’)
</code></pre>
