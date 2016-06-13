readPerspectivePage <- function(link){

  # library(xml2)
  # library(testthat)
  # library(knitr)
  # library(png)
  # library(stringi)
  # library(rmarkdown)
  # library(XML)
  
  library(xml2)
library(rvest)
library(stringr)

#link <- "http://perspective.opers.org/pensions/state-pension-bill-among-issues-were-following/"
opers_post <- read_html(link)
  

  ###########
  
  table1 <- html_text(html_nodes(opers_post, "#comments .comment-body"))
  
  table1 <- iconv(table1, "UTF-8", "ISO_8859-2")
  i = 1
  while (i < length(table1) + 1){
    table1[i] <- str_replace_all(table1[i], "\n", " ")
    table1[i] <- str_replace_all(table1[i], "\t", "")
    table1[i] <- str_replace_all(table1[i], "\"", "")
    i = i +1
  }
  
  #head(table1)
  
  ############
  
  table2 <- html_text(html_nodes(opers_post, "#comments .comment-author.vcard"))
  
  table2 <- iconv(table2, "UTF-8", "ISO_8859-2")
  j = 1
  while (j < length(table2) + 1){
    table2[j] <- str_replace_all(table2[j], "\n", "")
    table2[j] <- str_replace_all(table2[j], "\t", "")
    table2[j] <- str_replace_all(table2[j], " says:", "")
    j = j +1
  }
  
  #head(table2)
  
  ############
  
  smoke <- matrix(c(table2, table1),ncol=2,byrow=FALSE)
  colnames(smoke) <- c("Author", "Comment")
  smoke <- as.table(smoke)
  title <- substring(link, 29)
  names(dimnames(smoke)) <- c("", title)
  #head(smoke)
  
  return(smoke)
}

#remove(i, j, table1, table2, smoke, title, opers_post, link)
  