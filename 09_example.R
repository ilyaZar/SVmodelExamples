# Testing SVmodelExamples
library(SVmodelRcppSMC)
set.seed(123)
Tinit      <- 10
phiXinit   <- 0.9
sigmaXinit <- 0.15
betaYinit  <- 0.9
Xinit      <- 0
data_simul_sv <- generateDataSimulSV(TT = Tinit,
                                     phiX = phiXinit,
                                     sigmaX = sigmaXinit,
                                     betaY = betaYinit,
                                     initStateX0 = Xinit)
xt <- data_simul_sv$statesXt
yt <- data_simul_sv$measurementsYt

particleNumber <- 5
startingVals <- c(phiXinit, 2, 2)

res <- svModelALTracking(data = yt,
                         initVals = startingVals,
                         particles = particleNumber,
                         resampleFreq = 0.5)
