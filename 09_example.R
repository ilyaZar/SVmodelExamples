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

<<<<<<< HEAD
res <- svModelALTracking(data = yt,
                         initVals = startingVals,
                         particles = particleNumber,
                         resampleFreq = 0.5)
||||||| dd8dd46
res <- sv_model_al_tracking(data = yt,
                     starting_vals = starting_vals,
                     particles = particle_number,
                     resample_freq = 0.5)
=======
res <- sv_model_al_tracking(data = yt,
                     starting_vals = starting_vals,
                     particles = particle_number,
                     resampleFreq = 0.5)
>>>>>>> 101ccee8efcd1920e0f9a1b6a126cfc1efb4588e
