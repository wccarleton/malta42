library(bigmemory)
library(devtools)
install_github("wccarleton/chronup")
library(chronup)

analysis <- 2
adapt <- T
save_results <- T

if(analysis == 1){
    Y <- bigmemory::attach.big.matrix("Data/Big/malta_rece_trim_desc")
    X <- bigmemory::attach.big.matrix("Data/Big/iso_intercept_desc")
}else if(analysis == 2){
    Y <- bigmemory::attach.big.matrix("Data/Big/xaghra_rece_trim_desc")
    X <- bigmemory::attach.big.matrix("Data/Big/iso_intercept_desc")
}

n <- dim(Y)[1]
niter <- dim(Y)[2]
startvals <- c(0, 0, rep(0.5, n))
startscales <- c(0.5, 0.05, rep(0.1, n))

if(adapt){
    print("Running adaptive mcmc...")

    mcmc_chain <- regress(Y = Y,
                        X = X,
                        niter = 50000,
                        model = "nb",
                        adapt = TRUE,
                        startvals = startvals,
                        scales = startscales)

    adapted_startvals <- colMeans(mcmc_chain$samples[-c(1:1000), ])
    adapted_startscales <- colMeans(mcmc_chain$scales[-c(1:1000), ])
    startvals <- adapted_startvals
    startscales <- adapted_startscales
}

print("Running mcmc...")

mcmc_chain <- regress(Y = Y,
                    X = X,
                    niter = niter,
                    model = "nb",
                    adapt = FALSE,
                    startvals = startvals,
                    scales = startscales)

if(save_results){
    mcmc_results <- as.big.matrix(
        mcmc_chain,
        backingpath = "Data/Big/",
        backingfile = paste("mcmc_samples_",analysis,sep=""),
        descriptorfile = paste("mcmc_samples_",analysis,"_desc",sep=""))
}
