# Single-Cell RNA-seq Analysis of the Breast Cancer Tumor Microenvironment

Single-cell dissection of the tumor microenvironment in ER+ and triple-negative
breast cancer (TNBC), resolving cell types and malignant-cell genomic instability
at single-cell resolution.

**Dataset:** GSE161529 (Pal et al., *EMBO J* 2021) — 4 primary tumors
(2 ER+, 2 TNBC), 31,265 cells after QC.
**Stack:** Python · Scanpy · Harmony · inferCNVpy

---

## Question

Bulk RNA-seq can tell you a tumor *subtype* differs, but it averages all cells
together — it can't say *which cells* drive a signal, or separate malignant cells
from the normal immune and stromal cells sitting beside them. This project asks:

- What cell types make up the breast tumor microenvironment?
- Do the ER+/TNBC marker differences seen in bulk localize to the malignant cells?
- Which epithelial cells are *genuinely malignant* (chromosomally abnormal)?

## Key findings

1. **Seven cell types resolved** across the tumor microenvironment — malignant
   epithelium (ER+ and TNBC), T cells, myeloid, fibroblasts, endothelial, and
   plasma cells — concordant with independent published annotation of the same data.

2. **Subtype markers localize to the tumor compartment.** ER+ markers
   (ESR1, GATA3, FOXA1) and TNBC markers (KRT14) are expressed specifically in the
   epithelial/malignant clusters, not in immune or stromal cells — confirming the
   bulk RNA-seq subtype signal reflects genuine tumor biology.

3. **CNV inference confirms malignancy cell-by-cell.** Tumor cells carry
   genome-wide copy-number abnormalities absent from immune/stromal cells, and
   **TNBC shows greater genomic instability than ER+** (CNV score 0.013 vs 0.009) —
   independently recovering a documented clinical feature of TNBC.

![CNV chromosome heatmap](images/cnv_heatmap.png)

*Genome-wide copy-number landscape. Tumor cells (ER+, TNBC) show chromosomal gains (red) and losses (blue); immune and stromal cells remain flat. TNBC shows greater instability than ER+.*

## Approach

| Stage | What | Key decisions |
|-------|------|---------------|
| 1. QC | Filter empty droplets, doublets, dying cells | Thresholds set from observed distributions, not defaults; scrublet for doublets |
| 2. Integration | Normalize, HVG, PCA, batch-correct, cluster | Harmony applied only after confirming a visible patient batch effect; resolution 0.5 chosen by biological coherence |
| 3. Annotation | Marker-based cell typing | Curated known markers confirmed identities; validated against published annotation |
| 4. CNV | Per-cell copy-number inference | Immune/stromal cells as normal reference; tumor vs normal genomic instability quantified |

## Why single-cell

This project extends prior bulk RNA-seq work (TNBC vs ER+ differential expression).
Bulk found the subtype signature; single-cell **localizes it to the malignant
epithelial compartment** and **proves malignancy per cell** via copy-number
inference — the resolution bulk fundamentally cannot provide.

## Repository

- `01_qc.ipynb` — quality control
- `02_normalize_cluster.ipynb` — normalization, Harmony integration, clustering
- `03_annotation.ipynb` — cell-type annotation and validation
- `04_cnv.ipynb` — copy-number inference
- `environment.yml` — reproducible conda environment
