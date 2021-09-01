library(ggplot2)
library(ggpubr)
library(devtools)
install_github("wccarleton/chronup")
library(chronup)

# Plots for comparing the age-depth models

isotope_data_path <- "Data/RL4-016_iso_measures.csv"
oxcal_age_model_path <- "Data/RL4_Sisal_modelled.csv"
rece_dates_path <- "Data/malta_dates.csv"

iso_data <- read.csv(isotope_data_path)
age_depth_model <- read.csv(oxcal_age_model_path)
rece_dates <- read.csv(rece_dates_path)

age_depth_model$mid_ages <- apply(age_depth_model[, c(3, 4)], 1, mids)

ggplot() +
    geom_ribbon(data = age_depth_model,
                mapping = aes(x = z,
                            ymin = from_95_4,
                            ymax = to_95_4),
                fill = "steelblue",
                alpha = 0.8) +
    geom_path(data = age_depth_model,
                mapping = aes(x = z,
                            y = mid_ages),
                colour = "white") +
    geom_path(data = iso_data,
            mapping = aes(x = Sampled.Distance,
                        y = 1950 - (Age.MARCH.2018 * 1000)),
            linetype = 2,
            alpha = 0.8) +
    labs(x = "Depth (mm)", y = "Age BCAD") +
    theme_minimal() +
    theme(text = element_text(family = "serif", size = 12))

ggsave(filename = "age_depth_compared.pdf",
        device = "pdf")

# Sample the OxCal mid_ages sequence at all depths and then compare the d18O
# records corresponding to both age-depth models.

oxcal_sampled <- approx(x = age_depth_model$z,
                        y = age_depth_model$mid_ages,
                        xout = iso_data$Sampled.Distance)

iso_data_compared <- data.frame(OxCal = oxcal_sampled$y,
                                FPGR = 1950 - iso_data$Age.MARCH.2018 * 1000,
                                d18O = iso_data$d18O)

p1 <- ggplot(iso_data_compared) +
        geom_path(mapping = aes(y = d18O, x = FPGR),
                alpha = 0.8,
                #size = 1,
                colour = "red") +
        geom_path(mapping = aes(y = d18O, x = OxCal),
                alpha = 0.8,
                #size = 1,
                colour = "blue") +
        xlim(c(-3500, -1730)) +
        labs(x = "Age BCAD", y = "d18O") +
        theme_minimal() +
        theme(text = element_text(family="serif", size=12))

p1

ggsave(filename = "d18O_age_depth_compared.pdf",
        device = "pdf")

malta_rece_plot <- vroomfondel::plot_rece(rece_dates[, c(2, 3)],
                                            nsamples = 1000,
                                            BP = FALSE,
                                            resolution = 1,
                                            axis_x_res = 100,
                                            use_ggplot2 = T)

p2 <- malta_rece_plot$p +
        xlim(c(-3500, -1730)) +
        labs(x = "Age BCAD", y = "d18O") +
        theme_minimal() +
        theme(text = element_text(family = "serif", size = 12),
                legend.position = "none")

ggarrange(p1,p2,
        ncol = 1,
        nrow = 2,
        align = "v")

ggsave(filename = "iso_rece_comparison.pdf",
        device = "pdf")
