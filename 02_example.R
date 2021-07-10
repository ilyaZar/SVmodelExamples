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
<<<<<<< HEAD
rwSD <- c(0.1, 0.1)
startingVals <- c(phiXinit, 2, 2)
||||||| dd8dd46
rw_sd <- c(0.1, 0.1)
starting_vals <- c(phiXinit, 2, 2)
=======
rwSD <- c(0.1, 0.1)
starting_vals <- c(phiXinit, 2, 2)
>>>>>>> 101ccee8efcd1920e0f9a1b6a126cfc1efb4588e
system.time(
<<<<<<< HEAD
outPMMHsmctc <- svModelPMMH(data = yt,
                            initVals = startingVals,
                            rwMHsd = rwSD,
                            particles = particleNumber,
                            iterations = MM,
                            burnin = burn)
||||||| dd8dd46
out_pmmh_smctc <- sv_model_pmmh(data = yt,
                                starting_vals = starting_vals,
                                rw_mh_sd = rw_sd,
                                particles = particle_number,
                                iterations = MM,
                                burnin = burn)
=======
out_pmmh_smctc <- sv_model_pmmh(data = yt,
                                starting_vals = startingVals,
                                rw_mh_sd = rwSD,
                                particles = particleNumber,
                                iterations = MM,
                                burnin = burn)
>>>>>>> 101ccee8efcd1920e0f9a1b6a126cfc1efb4588e
)
<<<<<<< HEAD
plotPMCMCoutput(outputPMCMC = outPMMHsmctc,
                burn,
                trueVals = c(sigmaXinit, betaYinit))
||||||| dd8dd46
plot_pmcmc_output(output_pmcmc = out_pmmh_smctc,
                  burn,
                  true_vals = c(sigmaXinit, betaYinit))
=======
plotPMCMCoutput(outputPMCMC = out_pmmh_smctc,
                burn,
                trueVals = c(sigmaXinit, betaYinit))
>>>>>>> 101ccee8efcd1920e0f9a1b6a126cfc1efb4588e
system.time(
  outPMMHr <- svModelPMMHr(numParticles = particleNumber,
                           rwVCMprop = diag(rwSD^2),
                           y = yt,
                           initVals = startingVals,
                           numIter = MM)
)
<<<<<<< HEAD
plotPMCMCoutput(outputPMCMC = outPMMHr,
                burnin = burn,
                trueVals = c(sigmaXinit, betaYinit))
plotPMCMCoutput(outputPMCMC = outPMMHsmctc,
                burnin = burn,
                trueVals = c(sigmaXinit, betaYinit))
||||||| dd8dd46
plot_pmcmc_output(output_pmcmc = out_pmmh_r,
                  burn,
                  true_vals = c(sigmaXinit, betaYinit))
=======
plot_pmcmc_output(outputPMCMC = out_pmmh_r,
                  burn,
                  trueVals = c(sigmaXinit, betaYinit))
>>>>>>> 101ccee8efcd1920e0f9a1b6a126cfc1efb4588e

