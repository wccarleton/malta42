library(ggplot2)
library(emojifont)
statue_dates <- read.csv("Data/xaghra_statue_dates.csv")

#write.csv(statue_dates[,c(4,5,6)],
#        file = "Data/statue_dates_all.csv",
#        row.names = F,
#        quote = F)

#run the model in OxCal...

# plot the results

statue_oxcal <- read.csv("Data/statue_TauB_results.csv")

statue_boundaries_modelled <- subset(statue_oxcal,
                            (op == "Tau_Boundary" | op == "Boundary") & type == "posterior")[,c(1,3,6,7)]

statue_boundaries_modelled[which(statue_boundaries_modelled$name == "Start 1"), "index"] <- 3

statue_caldates_modelled <- subset(statue_oxcal,
                            op == "R_Date" & type == "posterior")[,c(1,3,6,7)]

statue_caldates_unmodelled <- subset(statue_oxcal,
                            op == "R_Date" & type == "likelihood")[,c(1,3,6,7)]

c14_labels <- data.frame(name = unique(statue_caldates_modelled$name), index = unique(statue_caldates_modelled$index))

c14_labels <- rbind(data.frame(name = "Tau Boundary", index = 3),c14_labels)
c14_labels <- rbind(c14_labels,data.frame(name = "Boundary", index = 31))

state_labels <- data.frame(index = unique(statue_caldates_modelled$index),
                            articulated = rowSums(statue_dates[,c(14,16)]),
                            key_context = rowSums(statue_dates[,c(14,15)]))

state_labels[which(state_labels$articulated == 0),"fa1"] <- NA
state_labels[which(state_labels$articulated == 1),"fa1"] <- fontawesome("fa-link")
state_labels[which(state_labels$key_context == 0),"fa2"] <- NA
state_labels[which(state_labels$key_context == 1),"fa2"] <- fontawesome("fa-key")

state_articulated <- subset(state_labels, articulated == 1)
state_key <- subset(state_labels, key_context == 1)

for(j in unique(statue_caldates_unmodelled$name)){
    p <- subset(statue_caldates_unmodelled,name == j)[,4]
    p_scaled <- p/max(p)
    statue_caldates_unmodelled[which(statue_caldates_unmodelled$name == j),"p_scaled"] <- p_scaled
}

for(j in unique(statue_caldates_modelled$name)){
    p <- subset(statue_caldates_modelled,name == j)[,4]
    p_scaled <- p/max(p)
    statue_caldates_modelled[which(statue_caldates_modelled$name == j),"p_scaled"] <- p_scaled
}

for(j in unique(statue_boundaries_modelled$name)){
    p <- subset(statue_boundaries_modelled,name == j)[,4]
    p_scaled <- p/max(p)
    statue_boundaries_modelled[which(statue_boundaries_modelled$name ==
j),"p_scaled"] <- p_scaled
}

ggplot() +
    geom_ribbon(data = statue_caldates_unmodelled,
                aes(x = value,
                    ymax = p_scaled + index,
                    ymin = index,
                    group = name),
                alpha = 0.2) +
    geom_ribbon(data = statue_caldates_modelled,
                aes(x = value,
                    ymax = p_scaled + index,
                    ymin = index,
                    group = name),
                alpha = 0.6) +
    geom_ribbon(data = statue_boundaries_modelled,
                aes(x = value,
                    ymax = p_scaled + index,
                    ymin = index,
                    group = name),
                alpha = 0.6,
                fill = "steelblue") +
    geom_text(data = c14_labels,
                mapping = aes(y = index + 0.5,
                x = -2100,
                label = name),
                family = "serif",
                fontface = "plain",
                size = 3) +
    geom_text(data = state_articulated,
                mapping = aes(y = index + 0.5,
                x = -2000,
                label = fa1),
                family = "fontawesome-webfont",
                size = 3,
                colour = "darkgrey") +
    geom_text(data = state_key,
                mapping = aes(y = index + 0.5,
                x = -2020,
                label = fa2),
                family = "fontawesome-webfont",
                size = 3,
                colour = "darkgrey") +
    xlim(c(-3100,-2000)) +
    labs(x = "Year BC", y = "Scaled Density") +
    theme_minimal() +
    theme(text = element_text(family="serif", size=12))
ggsave(filename = "/media/data/wcarleton/Projects/malta42/Images/statue_dates_both_sigma.pdf",
        device = "pdf")
