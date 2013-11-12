# function for sampling a finite Markov chain

rfmc<-function(n,P,pi0)
{
        v=vector("numeric",n)
        r=length(pi0)
        v[1]=sample(r,1,prob=pi0)
        for (i in 2:n) {
                v[i]=sample(r,1,prob=P[v[i-1],])
        }
        ts(v)
}

# example using the function

P=matrix(c(0.9,0.1,0.2,0.8),ncol=2,byrow=TRUE)
pi0=c(0.5,0.5)
samplepath=rfmc(200,P,pi0)
pdf("disc.pdf"); plot(samplepath); dev.off()
summary(samplepath)
table(samplepath)
table(samplepath)/length(samplepath)

# now compute the exact stationary distribution...
e=eigen(t(P))$vectors[,1]
e/sum(e)


# eof

