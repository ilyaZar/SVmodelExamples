library(SVmodelRcppSMC)
dat <- read.csv("./data/logreturns2012to2014.csv", header = F)
measurements <- dat[, 1]
# Now with a FINER grid:
# set.seed(123)
numSimul     <- 10
parSeqPhi    <- seq(0.95, 0.999, by = 0.004)
lenParSeqPhi <- length(parSeqPhi)
outLogLike   <- matrix(0, lenParSeqPhi, numSimul)
sigmaXfix    <- 0.16
betaYfix     <- 0.7
numParticles <- 1000
for (j in 1:numSimul) {
  for (i in 1:lenParSeqPhi) {
    outLogLike[i, j] <- svModelBpfLogLike(lNumber = numParticles,
                                          measurements = measurements,
                                          initVals =  c(parSeqPhi[i],
                                                        sigmaXfix,
                                                        betaYfix))
    print(paste(j,":",i))
  }
}
plotBoxplotLogLikeEstimates(outLogLike,
                            parSeqPhi,
                            numSimul)


