# Testing SVmodelExamples
library(SVmodelRcppSMC)
set.seed(123)
Tinit      <- 100
phiXinit   <- 0.9
sigmaXinit <- 0.15
betaYinit  <- 0.9
Xinit      <- 0
dataSimulSV <- generateDataSimulSV(TT = Tinit,
                                   phiX = phiXinit,
                                   sigmaX = sigmaXinit,
                                   betaY = betaYinit,
                                   initStateX0 = Xinit)
xt <- dataSimulSV$statesXt
yt <- dataSimulSV$measurementsYt

particleNumber <- 5000
MM    <- 1000
burn  <- round(MM/2)
rwSD <- c(0.1, 0.1)
starting_vals <- c(phiXinit, 2, 2)
system.time(
out_pmmh_smctc <- sv_model_pmmh(data = yt,
                                starting_vals = startingVals,
                                rw_mh_sd = rwSD,
                                particles = particleNumber,
                                iterations = MM,
                                burnin = burn)
)
plotPMCMCoutput(outputPMCMC = out_pmmh_smctc,
                burn,
                trueVals = c(sigmaXinit, betaYinit))
system.time(
out_pmmh_r <- pmmh_sv(num_particles = particle_number,
                      rw_vcm_prop = diag(rw_sd^2),
                      y = yt,
                      starting_vals = starting_vals,
                      num_iter = MM)
)
plot_pmcmc_output(outputPMCMC = out_pmmh_r,
                  burn,
                  trueVals = c(sigmaXinit, betaYinit))

