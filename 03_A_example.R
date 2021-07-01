# Testing SVmodelExamples
library(SVmodelRcppSMC)
set.seed(123)
Tinit      <- 100
phiXinit   <- 0.9
sigmaXinit <- 0.2
betaYinit  <- 0.7
Xinit      <- 0
dataSimulSV <- generateDataSimulSV(TT = Tinit,
                                   phiX = phiXinit,
                                   sigmaX = sigmaXinit,
                                   betaY = betaYinit,
                                   initStateX0 = Xinit)
xt <- dataSimulSV$statesXt
yt <- dataSimulSV$measurementsYt

particleNumber <- 20
MM    <- 5000
burn  <- 4000 #round(MM/2)

startingVals     <- c(phiXinit, 20, 20)
conditionalXinit <- c(Xinit, xt)
system.time(
  out_pg_r <- pg_sv_r(y = yt,
                      num_particles = particleNumber,
                      starting_values = startingVals,
                      num_iter = MM,
                      x_r_init = conditionalXinit,
                      as_sampling = TRUE)
)
plotPMCMCoutput(outputPMCMC= out_pg_r,
                burnin = burn,
                trueVals = c(sigmaXinit, betaYinit))
