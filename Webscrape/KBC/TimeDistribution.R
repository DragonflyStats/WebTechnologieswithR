TimeDates<-(fulldata$blockA2)
Year<-substr(TimeDates,10,13)
Date<-substr(TimeDates,4,8)
Time<-substr(TimeDates,16,21)
Evening <- grep("PM",TimeDates)
Hours <- as.numeric(substr(Time,1,2))
Hours[Evening] <- Hours[Evening]+12
plot(table(Hours),xlab=c("Hours"),ylab=c("Fequency"),col="red",lwd=2,type="b",font=2,pch=18)
