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
# ==============================================================================
# Script: rcbd_analysis.R
# Title: Statistical Evaluation of Groundnut Dry Root Rot Management Trials
# Design: Randomized Complete Block Design (RCBD) | 15 Treatments x 3 Replications
# ==============================================================================

if (!require("agricolae")) install.packages("agricolae", dependencies = TRUE)
library(agricolae)

# 1. Load Experimental Dataset
trial_data <- read.csv("groundnut-dry-root-rot/data/groundnut_dry_root_rot_trial.csv", stringsAsFactors = FALSE)

trial_data$Replication <- as.factor(trial_data$Replication)
trial_data$Treatment   <- as.factor(trial_data$Treatment)

# Angular (Arcsine) transformation for percentage disease incidence data
trial_data$DI_trans <- asin(sqrt(trial_data$Disease_Incidence_pct / 100)) * (180 / pi)

# 2. ANOVA: Disease Incidence
model_di <- aov(DI_trans ~ Replication + Treatment, data = trial_data)
summary(model_di)
hsd_di <- HSD.test(model_di, "Treatment", group = TRUE, console = TRUE)

# 3. ANOVA: Pod Yield
model_yield <- aov(Pod_Yield_kg_ha ~ Replication + Treatment, data = trial_data)
summary(model_yield)
hsd_yield <- HSD.test(model_yield, "Treatment", group = TRUE, console = TRUE)
```
