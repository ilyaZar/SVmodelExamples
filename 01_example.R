library(SVmodelRcppSMC)
dat <- read.csv("./data/logreturns2012to2014.csv", header = F)
measurements <- dat[, 1]
# Now with a FINER grid:
# set.seed(123)
num_simul       <- 10
par_seq_phi     <- seq(0.95, 0.999, by = 0.004)
len_par_seq_phi <- length(par_seq_phi)
out_log_like    <- matrix(0, len_par_seq_phi, num_simul)
sigma_x_fix     <- 0.16
beta_y_fix      <- 0.7
num_particles   <- 1000
for (j in 1:num_simul) {
  for (i in 1:len_par_seq_phi) {
    out_log_like[i, j] <- bpf_loglike_sv(lNumber = num_particles,
                                         measurements = measurements,
                                         starting_vals =  c(par_seq_phi[i],
                                                            sigma_x_fix,
                                                            beta_y_fix))
    print(paste(j,":",i))
  }
}
plot_boxplot_loglike_estimates(out_log_like,
                               par_seq_phi,
                               num_simul)


