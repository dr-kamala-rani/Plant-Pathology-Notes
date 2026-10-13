# Plant Pathology Research & Biometrics Repository

A repository containing experimental datasets, statistical workflows, and computational pipelines for plant disease diagnostics, field epidemiology, and crop protection trials.

---

## Repository Index

### 1. Groundnut Dry Root Rot Management (`/groundnut-dry-root-rot`)
* **Pathogen:** *Macrophomina phaseolina*
* **Crop:** Groundnut (*Arachis hypogaea* L.)
* **Experimental Design:** Randomized Complete Block Design (RCBD) — 15 Treatments $\times$ 3 Replications
* **Evaluation Factors:** Bioagents (*Trichoderma*, *Bacillus*, *Pseudomonas*), Endophytic isolates, and Integrated Disease Management (IDM) packages.
* **Response Variables:** Disease Incidence (%), Pod Yield (kg/ha)
* **Statistical Methods:** Angular (arcsine) transformation, Two-way ANOVA, and Tukey's HSD post-hoc mean separation.

---

## Directory Layout

```text
Plantpathology/
├── groundnut-dry-root-rot/
│   ├── data/
│   │   └── groundnut_dry_root_rot_trial.csv
│   └── scripts/
│       └── rcbd_analysis.R
├── LICENSE
└── README.md

Execution instructions:
git clone [https://github.com/dr-kamala-rani/Plant-Pathology-Notes.git](https://github.com/dr-kamala-rani/Plant-Pathology-Notes.git)
cd Plant-Pathology-Notes

Code executed:
## Complete Analysis Script (`rcbd_analysis.R`)

```r
# Analysis of RCBD field trial: Dry root rot in groundnut
# 15 treatments x 3 replications

library(agricolae)

# Load data
df <- read.csv("groundnut-dry-root-rot/data/groundnut_dry_root_rot_trial.csv")

# Set factors
df$Replication <- as.factor(df$Replication)
df$Treatment   <- as.factor(df$Treatment)

# Arcsine transformation for incidence percentage
df$DI_trans <- asin(sqrt(df$Disease_Incidence_pct / 100)) * (180 / pi)


# --- 1. Disease Incidence (%) ---

fit_di <- aov(DI_trans ~ Replication + Treatment, data = df)
summary(fit_di)

# Tukey HSD test (p = 0.05)
hsd_di <- HSD.test(fit_di, "Treatment", group = TRUE, console = TRUE)


# --- 2. Pod Yield (kg/ha) ---

fit_yield <- aov(Pod_Yield_kg_ha ~ Replication + Treatment, data = df)
summary(fit_yield)

# Tukey HSD test (p = 0.05)
hsd_yield <- HSD.test(fit_yield, "Treatment", group = TRUE, console = TRUE)


# --- 3. Summary Table ---

means <- aggregate(cbind(Disease_Incidence_pct, Pod_Yield_kg_ha) ~ Treatment, 
                   data = df, 
                   FUN = function(x) c(Mean = round(mean(x), 2), SE = round(sd(x)/sqrt(length(x)), 2)))

write.csv(means, "groundnut-dry-root-rot/treatment_summary.csv", row.names = FALSE)
