rankhospital <- function(state, outcome, num = "best") {
        ## Check that state and outcome are valid 
        poutcome <-  c("heart attack", "heart failure","pneumonia")   
        
        if (!(any(state.abb == state))) {stop("invalid State")}
        if (!(is.element(outcome,poutcome))) {stop("invalid outcome")}
        
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        canidates <-data$Hospital.Name[state==data$State]
        
        
        
        ## get the correct colunm
        posCol = c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure","Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia" )
        cname <- posCol[match(outcome,poutcome)]
        possible_data <- subset(data,data$State == state)
        scores <- suppressWarnings(sapply(possible_data[cname],as.numeric))
        
        
        
        df <- data.frame(canidates,scores)
        
        sorted.d <- df[order(scores,canidates,na.last = NA,decreasing = F),]
        
        
      
        ## Return hospital name in that state with the given rank
        if (num == "best") {
              num <- 1
        } else if (num == "worst") {
               num <- nrow(sorted.d)
        } 
        
        print(as.vector(sorted.d[num,1]))
        ## 30-day death rate
        
}