
#!/usr/bin/env bash

# download.sh — fetch and organize GSE161529 breast cancer scRNA-seq data

# Reproduces the raw input for this pipeline (4 of 69 samples: 2 ER+, 2 TNBC).

set -euo pipefail

RAW_DIR="data/raw"

mkdir -p "$RAW_DIR"

# 1. Download the full GEO supplementary archive (2.2 GB) and shared gene list

BASE="https://ftp.ncbi.nlm.nih.gov/geo/series/GSE161nnn/GSE161529/suppl"

wget -O GSE161529_RAW.tar          "$BASE/GSE161529_RAW.tar"

wget -O "$RAW_DIR/features.tsv.gz"  "$BASE/GSE161529_features.tsv.gz"

# 2. Extract only the 4 selected samples (matrix + barcodes each)

tar -xvf GSE161529_RAW.tar -C "$RAW_DIR" \

  GSM4909296_ER-MH0001-barcodes.tsv.gz GSM4909296_ER-MH0001-matrix.mtx.gz \

  GSM4909301_ER-MH0042-barcodes.tsv.gz GSM4909301_ER-MH0042-matrix.mtx.gz \

  GSM4909281_TN-MH0126-barcodes.tsv.gz GSM4909281_TN-MH0126-matrix.mtx.gz \

  GSM4909282_TN-MH0135-barcodes.tsv.gz GSM4909282_TN-MH0135-matrix.mtx.gz

# 3. Reorganize into per-sample folders with Scanpy-standard filenames

cd "$RAW_DIR"

for s in "GSM4909296_ER-MH0001:ER_MH0001" \

         "GSM4909301_ER-MH0042:ER_MH0042" \

         "GSM4909281_TN-MH0126:TN_MH0126" \

         "GSM4909282_TN-MH0135:TN_MH0135"; do

  prefix="${s%%:*}"; name="${s##*:}"

  mkdir -p "$name"

  mv "${prefix}-matrix.mtx.gz"   "$name/matrix.mtx.gz"

  mv "${prefix}-barcodes.tsv.gz" "$name/barcodes.tsv.gz"

  cp features.tsv.gz             "$name/features.tsv.gz"

done

echo "Done. 4 samples ready in $RAW_DIR/{ER_MH0001,ER_MH0042,TN_MH0126,TN_MH0135}/"

