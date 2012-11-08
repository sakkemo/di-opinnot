
sampleModelFunction <- function(param,time=c(1:100))
{
  # Model some behaviour here
  y1  = log(1:length(time))*param
  y2 = log(1:length(time))+runif(length(time))+5
  y3 =  log(1:length(time))*param+rnorm(length(time))
  x=time
  #plot
  
  plot(x,y1,xlab="time",ylab="ModelOutput",col="red",ylim = c(min(c(y1,y2,y3)),max(c(y1,y2,y3))),type="l")
  points(x,y2,col="blue",type="l")
  points(x,y3,col="green",type="l")
  legend(x="bottomright",fill=c("green","red","blue"),legend=c("Model 1","Model 2","Model 3"))
}


sampleModelFunction(1)
#sampleModelFunction(2)
#sampleModelFunction(3)
#sampleModelFunction(param = 3, time = c(1:500))