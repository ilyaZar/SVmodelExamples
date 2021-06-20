# Testing SVmodelExamples
library(SVmodelRcppSMC)
set.seed(123)
Tinit      <- 10
phiXinit   <- 0.9
sigmaXinit <- 0.15
betaYinit  <- 0.9
Xinit      <- 0
data_simul_sv <- generate_data_simul_sv(TT = Tinit,
                                        phi_x = phiXinit,
                                        sigma_x = sigmaXinit,
                                        beta_y = betaYinit,
                                        init_state_x0 = Xinit)
xt <- data_simul_sv$states_xt
yt <- data_simul_sv$measurements_yt

particle_number <- 5
starting_vals <- c(phiXinit, 2, 2)

res <- sv_model_al_tracking(data = yt,
                     starting_vals = starting_vals,
                     particles = particle_number,
                     resample_freq = particle_number + 1)
