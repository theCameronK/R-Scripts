getPerspectivePages <- {

  # library(methods)
  # library(utils)
  # library(bitops)
  # library(RCurl)
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

remove(i, url, x, y, h2, z)