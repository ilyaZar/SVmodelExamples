library(SVmodelRcppSMC)
# setting the seed for reproducibility
set.seed(123)
# setting model parameters
Tinit      <- 10
phiXinit   <- 0.9
sigmaXinit <- 0.15
betaYinit  <- 0.9
Xinit      <- 0
# generate data from SV model
data_simul_sv <- generateDataSimulSV(TT = Tinit,
                                     phiX = phiXinit,
                                     sigmaX = sigmaXinit,
                                     betaY = betaYinit,
                                     initStateX0 = Xinit)
xt <- data_simul_sv$statesXt
yt <- data_simul_sv$measurementsYt

# set small particle number for illustration purposes
particleNumber <- 8
startingVals <- c(phiXinit, 2, 2)

set.seed(42)
# Effective Sample Size small: resampling frequently
# -> weak particle coalescence
res <- svModelALTracking(data = yt,
                         initVals = startingVals,
                         particles = particleNumber,
                         resampleFreq = 0.25)
set.seed(42)
# Effective Sample Size large: resampling less frequently
# -> strong particle coalescence
res <- svModelALTracking(data = yt,
                         initVals = startingVals,
                         particles = particleNumber,
                         resampleFreq = 0.75)
