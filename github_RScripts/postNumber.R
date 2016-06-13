postNumber <- function(i){

source('~/readRSS.R')
source('~/wordpressCommentsPull.R')

x <- getPerspectivePages()
y <- readPerspectivePage(x[i])

return(y)
}