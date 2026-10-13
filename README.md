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
