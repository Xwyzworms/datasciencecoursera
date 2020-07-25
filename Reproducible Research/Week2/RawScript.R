setwd("D:/Reproducible Research/Week2")

activitydf <- read.csv("./DataSet/repdata_data_activity/activity.csv")

head(activitydf)

activitydf$date <- strptime(x = activitydf$date ,format = "%Y-%m-%d" )
summary(activitydf)
sum(is.na(activitydf$steps))
## Create Non na DataSet)
CleanDf <- subset(activitydf , is.na(activitydf$steps) != T)


TotalStepstaken <- aggregate(x = CleanDf$steps , by = list(as.Date(CleanDf$date)) , FUN = sum)
names(TotalStepstaken) <- c("date", "total")


library(ggplot2)
ggplot2::ggplot( data = TotalStepstaken , aes(x = total))+
        ggplot2::geom_histogram(binwidth = 800 , fill = "green" ,col ="blue") +
        ggplot2::labs(x = "Steps per day" , y = "Frequency" , title = "Daily Steps") +
        ggplot2::scale_y_continuous(breaks = seq(1,10 ,by =0.5))

with(TotalStepstaken , {
        mean_steps = mean(total ,na.rm = T)
        Median_steps = median(total , na.rm = T)
        cat(paste("Mean : " , mean_steps , 
                  "\nMedian : " , Median_steps))}
)


AverageSteptaken <- aggregate(x = CleanDf$steps , by = list(CleanDf$interval) ,
                              FUN = mean)
AverageSteptaken
names(AverageSteptaken) <- c("Interval" , "steps" )
ggplot2::ggplot(data = AverageSteptaken , 
                aes(x =Interval, y = steps)) +
        ggplot2::geom_line(size = 1 ,col = "blue" )

## The 5-minute interval that, on average, contains the maximum number of steps

AverageSteptaken[AverageSteptaken$steps == max(AverageSteptaken$steps), "Interval"]

## Code to describe and show a strategy for imputing missing data
# We Can Use Median / Mean Tho no need to be sophiscated right now.
# But We will use median , because the data skewed.

nrow(activitydf[is.na(activitydf) == T ,])

activitydf[is.na(activitydf$steps) == T ,"steps"] <- median(activitydf$steps,na.rm =T)
# Histogram of the total number of steps taken each day after missing values are imputed
TotalStepstaken <- stats::aggregate(x = activitydf$steps , by = list(as.Date(activitydf$date)),
                                    FUN = sum)
names(TotalStepstaken) <- c("date" , "total")
ggplot2::ggplot(data = TotalStepstaken , 
                aes(x = total)) + 
        geom_histogram(binwidth = 800 , col = "blue" , fill = "red") +
        labs( title = "Daily Steps", x = "Total Steps" , y = "Frequency" ) +
        ggplot2::scale_y_continuous(breaks = seq(1,10 ,by =0.5))

## Panel plot comparing the average number of steps taken per 5-minute interval across weekdays and weekends

weekday <- base::weekdays(x = activitydf$date)
unique(weekday)

activitydf[grepl(pattern = "Monday|Tuesday|Wednesday|Thursday|Friday|" , x = weekday) , 'Weekdays'] <- "weekday"
activitydf[grepl(pattern = "Saturday|Sunday", x = weekday) , 'Weekend'] <- "weekend"
activitydf$WeekDaysOrEnd <- paste(activitydf$Weekdays,activitydf$Weekend)
activitydf$WeekDaysOrEnd[activitydf$WeekDaysOrEnd == "weekday NA"] <- "weekday"
activitydf$WeekDaysOrEnd[activitydf$WeekDaysOrEnd == "weekday weekend"] <- "weekend"
activitydf <- activitydf[, c(1,2,3,6)]
activitydf$day <- weekday

names(activitydf)
table(activitydf$WeekDaysOrEnd , activitydf$day)

AverageDaysEnd <- aggregate(x = activitydf$steps , 
                            by = list(activitydf$interval , activitydf$WeekDaysOrEnd),
                            FUN = mean)
names(AverageDaysEnd) <- c("interval","weekEndORDays","meanStep")
ggplot2::ggplot(data = AverageDaysEnd , aes(x = interval , y = meanStep ,col= weekEndORDays ))+
        geom_line() + 
        facet_grid(weekEndORDays ~ .) + 
        labs(x = "INTERVAL" , y ="Mean of steps" ,title = "Weekdays and weekends Mean plot") +
        guides(col = guide_legend(title = "Category")) +
        theme(axis.text.x = element_text(angle = 90))
