library(SVmodelRcppSMC)
# setting the seed for reproducibility
set.seed(123)
# setting model parameters
Tinit      <- 1000
phiXinit   <- 0.9
sigmaXinit <- 0.2
betaYinit  <- 0.7
Xinit      <- 0
# generate data from SV model
data_simul_sv <- generateDataSimulSV(TT = Tinit,
                                     phiX = phiXinit,
                                     sigmaX = sigmaXinit,
                                     betaY = betaYinit,
                                     initStateX0 = Xinit)
xt <- data_simul_sv$statesXt
yt <- data_simul_sv$measurementsYt

# set the number of particles
particleNumber <- 10
MM    <- 5000
burn  <- 4000 #round(MM/2)

startingVals      <- c(phiXinit, 20, 20)
conditionalXinit  <- c(Xinit, xt) + rnorm(Tinit + 1, sd = 3)

outPG <- svModelPGr(y = yt,
                    numParticles = particleNumber,
                    startingValues = startingVals,
                    numIter = MM,
                    xRinit = conditionalXinit,
                    10)
plotPMCMCoutput(outputPMCMC =  outPG,
                burnin = burn,
                trueVals = c(sigmaXinit, betaYinit))

particleNumber <- 100
outPG2 <- svModelPGr(y = yt,
                     numParticles = particleNumber,
                     startingValues = startingVals,
                     numIter = MM,
                     xRinit = conditionalXinit,
                     10)
plotPMCMCoutput(outputPMCMC =  outPG2,
                burnin = burn,
                trueVals = c(sigmaXinit, betaYinit))
