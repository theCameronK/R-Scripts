#setting up all libraries that will be used

setwd("C:/Users/ckahrs/Documents/")

# install.packages("XML", "rvest", "stringr", "RJSONIO", "RCurl", "bitops", "methods"
#                  ,"xml2")
# 
# library(XML)
# library(rvest)
# library(stringr)
# library(RJSONIO)
# library(RCurl)
# library(bitops)
# library(methods)
# library(xml2)

pbiImport <- {

        #get pages on the front page of perspective
        getPerspectivePages <- {
          
          library(XML)
          
          url <- "http://perspective.opers.org/"
          
          x <- htmlTreeParse(url, useInternalNodes = TRUE)
          
          h2 <- "//h2[@class='entry-title']//a[@href]"
          
          y <- xpathSApply(x, h2)
          
          z <- NULL
          i = 1
          
          while (i < length(y) + 1 ){
            z <- c( z, xmlGetAttr(y[[i]], "href"))
            i = i + 1
          }
          
          getPerspectivePages <- z
          
        }
        
        #remove dummy variables from getPerspectivePages
        remove(i, url, x, y, h2, z)
        
        #source and/or add functions so nothing isn't cited
        source('C:/Users/ckahrs/Documents/wordpressCommentsPull.R')
        source('C:/Users/ckahrs/Documents/datumBoxAPI.R')
        
        #create table
        z <- NULL
        
        #aggregate all pages to one table
        k = 1
        while (k <= length(getPerspectivePages)){
          
              x <- readPerspectivePage(getPerspectivePages[k])
              
              z <- rbind(z, x)
        
              k = k+1
        }
        
        #add colums on end
        z <- cbind(z, 1:length(z[ ,1]))
        
        #populate columns with sentiment
        m=1
        while(m <= length(z[ ,1])){
          
          z[m,3] <- sentimentAnalysis(z[m,2])
          
          m=m+1
        }
        
        #make data frame
        z <- as.data.frame(z)
        return(z)
}

#remove dummy variables
remove(k,m, getPerspectivePages, x)