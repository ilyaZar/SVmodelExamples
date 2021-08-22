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
startingVals <- c(phiXinit, 2, 2)
system.time(
outPMMHsmctc <- svModelPMMH(data = yt,
                            initVals = startingVals,
                            rwMHsd = rwSD,
                            particles = particleNumber,
                            iterations = MM,
                            burnin = burn)
)
plotPMCMCoutput(outputPMCMC = outPMMHsmctc,
                burn,
                trueVals = c(sigmaXinit, betaYinit))
system.time(
  outPMMHr <- svModelPMMHr(numParticles = particleNumber,
                           rwVCMprop = diag(rwSD^2),
                           y = yt,
                           initVals = startingVals,
                           numIter = MM)
)
plotPMCMCoutput(outputPMCMC = outPMMHr,
                burnin = burn,
                trueVals = c(sigmaXinit, betaYinit))
plotPMCMCoutput(outputPMCMC = outPMMHsmctc,
                burnin = burn,
                trueVals = c(sigmaXinit, betaYinit))
plot_pmcmc_output(output_pmcmc = out_pmmh_r,
                  burn,
                  true_vals = c(sigmaXinit, betaYinit))
plot_pmcmc_output(outputPMCMC = out_pmmh_r,
                  burn,
                  trueVals = c(sigmaXinit, betaYinit))
