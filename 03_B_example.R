# Testing SVmodelExamples
library(SVmodelRcppSMC)
set.seed(123)
Tinit      <- 100
phiXinit   <- 0.9
sigmaXinit <- 0.2
betaYinit  <- 0.97
Xinit      <- 0.123456

dataSimulSV <- generateDataSimulSV(TT = Tinit,
                                   phiX = phiXinit,
                                   sigmaX = sigmaXinit,
                                   betaY = betaYinit,
                                   initStateX0 = Xinit)
xt <- dataSimulSV$statesXt
yt <- dataSimulSV$measurementsYt

particleNumber <- 1000
MM    <- 5000
burn  <- round(MM/2)

startingVals       <- c(phiXinit, 200, 200)
# startingTrajectory <- c(Xinit, xt) + rnorm(Tinit + 1, sd = 2)
# startingTrajectory <- c(Xinit, xt)
startingTrajectory <- xt
set.seed(42)
outPG <- svModelPG(data = yt,
                   startingVals = startingVals,
                   startingTrajectory = startingTrajectory,
                   particles = particleNumber,
                   iterations = MM)
plotPMCMCoutput(outputPMCMC= outPG,
                burnin = burn,
                trueVals = c(sigmaXinit, betaYinit))
