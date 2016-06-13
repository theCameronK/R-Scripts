sentimentAnalysis <- function(text){

library(RJSONIO)
  library(bitops)
library(RCurl)
library(stringr)

text <- URLencode(text);
  
#save all the spaces, then get rid of the weird characters that break the API, 
#then convert back the URL-encoded spaces.
text <- str_replace_all(text, "%20", " ");
text <- str_replace_all(text, "%\\d\\d", "");
text <- str_replace_all(text, " ", "%20");
  
key <- "api_key"

data <- getURL(paste("http://api.datumbox.com/1.0/TwitterSentimentAnalysis.json?api_key=", 
                     key, "&text=",text, sep=""))

js <- fromJSON(data, asText=TRUE);

# get mood probability
sentiment = js$output$result

return(sentiment)
}