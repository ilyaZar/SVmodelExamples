# Testing SVmodelExamples
library(SVmodelRcppSMC)
set.seed(123)
Tinit      <- 100
phiXinit   <- 0.9
sigmaXinit <- 0.2
betaYinit  <- 0.7
Xinit      <- 0
data_simul_sv <- generate_data_simul_sv(TT = Tinit,
                                        phi_x = phiXinit,
                                        sigma_x = sigmaXinit,
                                        beta_y = betaYinit,
                                        init_state_x0 = Xinit)
xt <- data_simul_sv$states_xt
yt <- data_simul_sv$measurements_yt

particle_number <- 20
MM    <- 5000
burn  <- 4000 #round(MM/2)

starting_vals      <- c(phiXinit, 20, 20)
conditional_x_init <- c(Xinit, xt)
system.time(
  out_pg_r <- pg_sv(y = yt,
                    num_particles = particle_number,
                    starting_values = starting_vals,
                    num_iter = MM,
                    x_r_init = conditional_x_init,
                    as_sampling = TRUE)
)
plot_pmcmc_output(output_pmcmc= out_pg_r,
                  burnin = burn,
                  true_vals = c(sigmaXinit, betaYinit))
