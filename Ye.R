#Json file from https://github.com/adambom/dictionary

library("rjson")
library(sysfonts)
library(meme)
library(here)
library(rtweet)
setwd(here())
#read('dictionary.json.txt')
#json_file <- "http://api.worldbank.org/country?per_page=10&region=OED&lendingtype=LNX&format=json"
json_data <- fromJSON(paste(readLines('dictionary.json.txt'), collapse=""))
twitter_token <- readRDS('twitter_token.rds')
wait_in_r <- TRUE
wait_duration <- 211*60 #Number of seconds to wait

a <- F
while(a==F){

  z <- sample(length(json_data), 1)
  nam <- tolower(names(json_data)[z])
  def <- json_data[z]
  def <- gsub('\\..*','', def)
  if(nchar(def)>40){
    next()
  }
  
  png('newmeme.png')
  print(meme('temp.png', def, size = 2))
  dev.off()
  
  outstring <- paste('Yeezy ', nam, ':', sep = '')
  print(outstring)
  post_tweet(status = outstring, token = twitter_token,
             in_reply_to_status_id = NULL, media = 'newmeme.png')
  file.remove('newmeme.png')
  print(Sys.time())
  if(wait_in_r==TRUE){
    Sys.sleep(wait_duration) #The number of seconds to sleep for
  }else{
    A <- TRUE
  }
}


