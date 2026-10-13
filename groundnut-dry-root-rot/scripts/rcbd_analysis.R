groundnut-dry-root-rot/scripts/rcbd_analysis.R
# ==============================================================================
# Script: rcbd_analysis.R
# Title: Statistical Evaluation of Groundnut Dry Root Rot Management Trials
# Design: Randomized Complete Block Design (RCBD) | 15 Treatments x 3 Replications
# ==============================================================================

if (!require("agricolae")) install.packages("agricolae", dependencies = TRUE)
library(agricolae)

# 1. Load Experimental Dataset
data_path <- "groundnut-dry-root-rot/data/groundnut_dry_root_rot_trial.csv"
trial_data <- read.csv(data_path, stringsAsFactors = FALSE)

trial_data$Replication <- as.factor(trial_data$Replication)
trial_data$Treatment   <- as.factor(trial_data$Treatment)

# Angular (Arcsine) transformation for percentage disease incidence data
trial_data$DI_trans <- asin(sqrt(trial_data$Disease_Incidence_pct / 100)) * (180 / pi)

cat("\n==================================================================\n")
cat(" 1. ANALYSIS OF VARIANCE: DRY ROOT ROT INCIDENCE (%)\n")
cat("==================================================================\n")

model_di <- aov(DI_trans ~ Replication + Treatment, data = trial_data)
anova_di <- anova(model_di)
print(anova_di)

# Post-hoc mean separation (Tukey HSD)
cat("\n--- Mean Separation: Disease Incidence (Tukey's HSD) ---\n")
hsd_di <- HSD.test(model_di, "Treatment", group = TRUE, console = TRUE)

cat("\n==================================================================\n")
cat(" 2. ANALYSIS OF VARIANCE: POD YIELD (kg/ha)\n")
cat("==================================================================\n")

model_yield <- aov(Pod_Yield_kg_ha ~ Replication + Treatment, data = trial_data)
anova_yield <- anova(model_yield)
print(anova_yield)

# Post-hoc mean separation (Tukey HSD)
cat("\n--- Mean Separation: Pod Yield (Tukey's HSD) ---\n")
hsd_yield <- HSD.test(model_yield, "Treatment", group = TRUE, console = TRUE)

# Export Summary Table
summary_table <- aggregate(cbind(Disease_Incidence_pct, Pod_Yield_kg_ha) ~ Treatment, 
                           data = trial_data, 
                           FUN = function(x) c(Mean = round(mean(x), 2), SE = round(sd(x)/sqrt(length(x)), 2)))

write.csv(summary_table, "groundnut-dry-root-rot/treatment_means_summary.csv", row.names = FALSE)
cat("\nSummary output saved to 'groundnut-dry-root-rot/treatment_means_summary.csv'.\n")
