df_outcome <- read.csv("Week4/outcome-of-care-measures.csv")
head(df_outcome)
names(df_outcome)
df_outcome[,11] <- as.numeric(df_outcome[,11])
hist(df_outcome[,11])


best <- function(state , outcome)
  {
  
  # Read Outcome Data
  outcome_df = read.csv("Week4/outcome-of-care-measures.csv")
  outcome <- tolower(outcome)
  ##Cuz Theres a State Columns on dataframe ,
  ## I Changed the var
  The_state <- state
  ## Check state and outcome are valid\
  
  if  (The_state %in% unique (outcome_df[["State"]]) &
       outcome %in% c("heart attack" , "heart failure" , "pneumonia"))
      {
        print("Found it!!")
        outcome_df <- outcome_df[c(2,7,11,17,23)] 
        names(outcome_df)[1] <- "name"
        names(outcome_df)[2] <- "state"
        names(outcome_df)[3] <- "heart attack"
        names(outcome_df)[4] <- "heart failure"
        names(outcome_df)[5] <- "pneumonia"
        
        outcome_df <- outcome_df[outcome_df$state == The_state &
                                   outcome_df[outcome] != "Not Available" ,]
        result <- outcome_df[, outcome]
        print(ncol(outcome_df))
        rownum <- which.min(result)
        return (outcome_df[rownum, ]$name)
        
      }
 
  
}
best("SC" , "heart attack")
best("NY" , "pneumonia")  
best("AK" , "pneumonia")  

rankhospital <- function(state , outcome ,num = "best")
{
  df <- read.csv("Week4/outcome-of-care-measures.csv")
  df <- as.data.frame(df)
  outcome <- tolower(outcome)
  The_state <- state
  
  if (The_state  %in% unique (df[["State"]]) &
      outcome %in% c("heart attack" , "heart failure" , "pneumonia"))
  {
    
    print("Found it!!")
    df <- df[c(2,7,11,17,23)]
    names(df)[1] <- "name"
    names(df)[2] <- 'state'
    names(df)[3] <- "heart attack"
    names(df)[4] <- "heart failure"
    names(df)[5] <- "pneumonia"
    
 
    
    df <- df[df$state == The_state & df[outcome] != "Not Available" , ]
    df[outcome] <- as.data.frame(sapply(df[outcome], as.numeric))
    df <- df[order(df$name ,decreasing = FALSE ), ]
    df <- df[order(df[outcome], decreasing = FALSE) ,]
    result <- df[, outcome]
    if(num == "best"){rownum <- which.min(result)}
    else if(num == "worst"){rownum <- which.max(result)}
    else{rownum <- num}
    return(df[rownum ,])
  }
}
rankhospital("NC","heart attack" , "worst")
rankhospital("WA", "heart attack", 7)
rankhospital("TX", "pneumonia", 10)
rankhospital("NY", "heart attack", 7)


rankall <- function(outcome, num = "best"){
  ## Reading the outcome data
  df <- read.csv("Week4/outcome-of-care-measures.csv")
  df <- as.data.frame(df)
  outcome <- tolower(outcome)
  
  if (outcome %in% c("heart attack" , "heart failure" , "pneumonia"))
  {
    
    print("Found it!!")
    df <- df[c(2,7,11,17,23)]
    names(df)[1] <- "name"
    names(df)[2] <- 'state'
    names(df)[3] <- "heart attack"
    names(df)[4] <- "heart failure"
    names(df)[5] <- "pneumonia"
    
    
    
    df <-df[ df[outcome] != "Not Available" , ]
    df[outcome] <- as.data.frame(sapply(df[outcome], as.numeric))
    df <- df[order(df$name ,decreasing = FALSE ), ]
    df <- df[order(df[outcome], decreasing = FALSE) ,]
  }
  ## Helper functiont to process the num argument
  getHospitalByRank <- function(df, s, n) {
    df <- df[df$state==s, ]
    vals <- df[, outcome]
    if(n == "best"){
      rowNum <- which.min(vals)
    }else if(n == "worst" ){
      rowNum <- which.max(vals)
    }else{
      rowNum <- n
    }
    df[rowNum, ]$name
  }
  
  ## For each state, find the hospital of the given rank
  states <- df[, 2]
  states <- unique(states)
  newdata <- data.frame("hospital"=character(), "state"=character())
  for(st in states) {
    hosp <- getHospitalByRank(df, st, num)
    newdata <- rbind(newdata, data.frame(hospital=hosp, state=st))
  }
  
  ## Return a data frame with the hospital names and the (abbreviated) 
  ## state name
  newdata <- newdata[order(newdata['state'], decreasing = FALSE), ]
  return(newdata)
}
r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)

r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)

r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)

