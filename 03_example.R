# Testing SVmodelExamples
library(SVmodelRcppSMC)
set.seed(123)
Tinit      <- 100
phiXinit   <- 0.9
sigmaXinit <- 0.2
betaYinit  <- 0.7
Xinit      <- 0
data_simul_sv <- generateDataSimulSV(TT = Tinit,
                                     phiX = phiXinit,
                                     sigmaX = sigmaXinit,
                                     betaY = betaYinit,
                                     initStateX0 = Xinit)
xt <- data_simul_sv$statesXt
yt <- data_simul_sv$measurementsYt

particleNumber <- 20
MM    <- 5000
burn  <- 4000 #round(MM/2)

startingVals      <- c(phiXinit, 20, 20)
conditionalXinit <- c(Xinit, xt)
system.time(
  outPG <- svModelPG(data = yt,
                     particles = particleNumber,
                     startingVals = startingVals,
                     iterations = MM,
                     startingTrajectory = conditionalXinit,
                     10)
)
system.time(
  outPGr <- svModelPGr(y = yt,
                       numParticles = particleNumber,
                       startingValues = startingVals,
                       numIter = MM,
                       xRinit = conditionalXinit,
                       asSampling = TRUE,
                       10)
)
plotPMCMCoutput(outputPMCMC =  outPGr,
                burnin = burn,
                trueVals = c(sigmaXinit, betaYinit))
plotPMCMCoutput(outputPMCMC =  outPG,
                burnin = burn,
                trueVals = c(sigmaXinit, betaYinit))
