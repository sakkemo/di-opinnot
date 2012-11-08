library("paloma")
library("igraph")
data(yeast)
mat = as.matrix(yeast$graph)
mat = mat[2:nrow(mat),]
yeast.graph <- graph.edgelist(mat)

########################################################################################
### CALCULATE DEGREE DISTRIBUTIONS #####################################################
########################################################################################
plotDegreeDistributions <- function()
{
  # CALCULATE DEGREE DISTRIBUTION OF YEAST GRAPH AND PLOT
  dd.yeast = degree.distribution(yeast.graph)
  dd.yeast = dd.yeast[2:length(dd.yeast)]
  pdf("1c1.pdf"); plot(dd.yeast,type='l',main="Yeast Degree Distribution")
  dev.off();

  # CALCULATE DEGREE DISTRIBUTION OF BERNOULLI GRAPH AND PLOT
  Rand.Graph = erdos.renyi.game(194, p.or.m = 266, type = "gnm") # how to set with type="gnp" :) - why does a full network has n(n-1) edges :)
  dd.rand = degree.distribution(Rand.Graph)
  dd.rand = dd.rand[2:length(dd.rand)]
  pdf("1c2.pdf"); plot(dd.rand,type='l',main="Bernoulli Random Network Degree Distribution")
  dev.off();

  # CALCULATE DEGREE DISTRIBUTION OF SCALE FREE GRAPH AND PLOT
  Rand.Graph.PL = barabasi.game(194,power=1,out.dist=c(0,0.63,0.37))
  dd.rand.PL = degree.distribution(Rand.Graph.PL)
  dd.rand.PL = dd.rand.PL[2:length(dd.rand.PL)]
  pdf("1c3.pdf"); plot(dd.rand.PL,type='l',main="Power Law Random Network Degree Distribution")
  dev.off();
}

########################################################################################
### PLOT MOTIFs of SIZE 3 IN YEAST NETWORK #############################################
########################################################################################
plotYeastMotifs <- function(k = 3,directed=FALSE)
{
  Yeast.Motifs <- countAllMotifs( yeast$graph, k, directed = directed )
  for (i in 1:length(Yeast.Motifs$adjacency))
  {
    Motif.1 = graph.adjacency(matrix(Yeast.Motifs$adjacency[[i]],k,k))
    pdf(paste("2b", i, ".pdf", sep="")); plot.igraph(Motif.1,main=Yeast.Motifs$count[i])
    dev.off();
  }
}

########################################################################################
### ARE YEAST MOTIFs EXPRESSED WRT RANDOM BERNOULLI NETWORKS ###########################
########################################################################################
motifDistributions.Bernoulli <- function(M = 1,k = 3,directed=FALSE)
{
  # M <- 1 ## Motif Number
  Yeast.Motifs <- countAllMotifs( yeast$graph, k, directed = directed )
  NRandNetworks <- 1000
  Motif.Count.Distribution.B = 0
  for(i in 1:NRandNetworks)
  {
    Rand.Graph = erdos.renyi.game(194, p.or.m = 266, type = "gnm") # create a random brnouli graph, with # of nodes and edes same as Yeast graph, # how to use"gnp":)
    Rand.Motifs = countAllMotifs(get.edgelist(Rand.Graph), k, directed = directed )
    for(j in 1:length(Rand.Motifs$adjacency))
    {
      if(!sum(Rand.Motifs$adjacency[[j]] != Yeast.Motifs$adjacency[[M]])) # if Yeast motif exists in random network motifs
          Motif.Count.Distribution.B[i] = Rand.Motifs$count[j] # save the counts in distribution
    }
    #plot.igraph(Rand.Graph)
  }
  Motif.Count.Distribution.B[is.na(Motif.Count.Distribution.B)] = 0

  plotDat = c(Motif.Count.Distribution.B,Yeast.Motifs$count[M])
  pdf("2c.pdf");
  hist(Motif.Count.Distribution.B,xlim = c(min(plotDat),max(plotDat)))
  lines(x=c(Yeast.Motifs$count[M],Yeast.Motifs$count[M]),y=c(0,1000),col = "red")
  text("Motif Count in Yeast",x=Yeast.Motifs$count[M],y=-5,col = "red")
  pval.over = (sum(Yeast.Motifs$count[M] < Motif.Count.Distribution.B)+1)/(NRandNetworks+1)
  pval.under = (sum(Yeast.Motifs$count[M] > Motif.Count.Distribution.B)+1)/(NRandNetworks+1)
  legend("topright",  legend=c(paste("P value for Motif #",M),paste("under-expr:",round(pval.under,5)),paste("over-expr:",round(pval.over,5))),text.col="red")
  dev.off();
}

########################################################################################
### ARE YEAST MOTIFs EXPRESSED WRT RANDOM POWER LAW NETWORKS ###########################
########################################################################################
motifDistributions.Power <- function(M = 1,k = 3,directed=FALSE)
{
  # M <- 1 ## Motif Number
  Yeast.Motifs <- countAllMotifs( yeast$graph, k, directed = directed )
  NRandNetworks <- 1000
  Motif.Count.Distribution.P = 0
  for(i in 1:NRandNetworks)
  {
    Rand.Graph = barabasi.game(194,power=1,out.dist=c(0,0.63,0.37),directed = directed) # create a random power law network, with # of nodes and edes same as Yeast graph, # how to was this done :)
    Rand.Motifs = countAllMotifs(get.edgelist(Rand.Graph), k, directed = directed )
    for(j in 1:length(Rand.Motifs$adjacency))
    {
      if(!sum(Rand.Motifs$adjacency[[j]] != Yeast.Motifs$adjacency[[M]])) # if Yeast motif exists in random network motifs
          Motif.Count.Distribution.P[i] = Rand.Motifs$count[j] # save the counts in distribution
    }
    #plot.igraph(Rand.Graph)
  }
  Motif.Count.Distribution.P[is.na(Motif.Count.Distribution.P)] = 0

  plotDat = c(Motif.Count.Distribution.P,Yeast.Motifs$count[M])
  pdf("2d.pdf");
  hist(Motif.Count.Distribution.P,xlim = c(min(plotDat),max(plotDat)))
  lines(x=c(Yeast.Motifs$count[M],Yeast.Motifs$count[M]),y=c(0,1000),col = "red")
  text("Motif Count in Yeast",x=Yeast.Motifs$count[M],y=-5,col = "red")
  pval.over = (sum(Yeast.Motifs$count[M] < Motif.Count.Distribution.P)+1)/(NRandNetworks+1)
  pval.under = (sum(Yeast.Motifs$count[M] > Motif.Count.Distribution.P)+1)/(NRandNetworks+1)
  legend("topright",  legend=c(paste("P value for Motif #",M),paste("under-expr:",round(pval.under,5)),paste("over-expr:",round(pval.over,5))),text.col="red")
  dev.off();
}

########################################################################################
### Find and show the exceptional motifs using PALOMA MODEL ############################
########################################################################################
plotExceptionalMotifsUsingPALOMA <- function()
{
  out <- getExceptional( yeast$graph, 3, 3, yeast$classes, yeast$pi, 0.001, directed=TRUE );
  plot( out )
}


#######################################################################################
### FUNCTION CALLS ####################################################################
#######################################################################################

# X11(); plot.igraph(yeast.graph, layout=layout.mds) #Plot Yeast Graph
# tkplot(yeast.graph) # Interactive Graph Plot. You can move nodes by draging
# plotDegreeDistributions() # Plot degree distributions of Yeast and Random Networks
# plotYeastMotifs(k = 3,directed=FALSE) # Plot Motifs of Size 3 in Yeast Network.
# motifDistributions.Bernoulli(M=1,k=3,directed=FALSE) # Plot Motif Distributions of Yeast Motifs in Bernoulli Networks
# motifDistributions.Power(M=1,k=3,directed=FALSE) # Plot Motif Distributions of Yeast Motifs in Power Law Networks
# plotExceptionalMotifsUsingPALOMA() # EXAMPLE: Use an off the shelf algorithm for extracting excpetional motifs



