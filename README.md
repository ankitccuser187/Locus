# Locus
the code is written in a R, using a naive bayes classifer to classifying wether a given document is a poetry or prose, 
we took documents from both classes and merge them into a corpus then after few steps of data pre-processing and data cleaning
we use TFIDF(term frequenty inverse document frequenty) to build our train dataset along with 0.98 sparsity control factor 
and assgin class 1 for poetry and 0 for prose.

#libraries needed
tm, snowballc, ggplot2, lattice, caret

#how to run
script is divided into two parts one is locus.r and other is tex_cleaning.r, first run the tex_cleaning it will create a necessary
function which latter uses by main script

how to grow a corpus, just add the respective documents in text formats in thier respective folders, rest else will be taken care by script
