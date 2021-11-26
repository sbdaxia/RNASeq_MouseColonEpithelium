library(tidyverse)

ce_rna_gsea <- read_csv("ce_RNASeq_sig_GSEA.csv")
colnames(ce_rna_gsea) <- paste0("ce_RNA_", colnames(ce_rna_gsea))
ce_pro_gsae <- read_csv("ce_Proteomics_sig_GSEA.csv")
colnames(ce_pro_gsae) <- paste0("ce_Protein_", colnames(ce_pro_gsae))

crc_rna_gsea <- read_csv("crc_RNASeq_sig_GSEA.csv")
colnames(crc_rna_gsea) <- paste0("crc_RNA_", colnames(crc_rna_gsea))
crc_pro_gsae <- read_csv("crc_Proteomics_sig_GSEA.csv")
colnames(crc_pro_gsae) <- paste0("crc_Protein_", colnames(crc_pro_gsae))

gsea_pathways <- unique(c(ce_rna_gsea$ce_RNA_NAME, ce_pro_gsae$ce_Protein_NAME, crc_rna_gsea$crc_RNA_NAME, crc_pro_gsae$crc_Protein_NAME))

gsea_tb <- data.frame(gsea_pathways)

gsea_tb <- left_join(gsea_tb, ce_rna_gsea, by = c("gsea_pathways"="ce_RNA_NAME"))
gsea_tb <- left_join(gsea_tb, ce_pro_gsae, by = c("gsea_pathways"="ce_Protein_NAME"))
gsea_tb <- left_join(gsea_tb, crc_rna_gsea, by = c("gsea_pathways"="crc_RNA_NAME"))
gsea_tb <- left_join(gsea_tb, crc_pro_gsae, by = c("gsea_pathways"="crc_Protein_NAME"))

gsea_tb <- gsea_tb %>% separate(gsea_pathways, into = c(NA, "Pathway"), sep = "MARK_")

write.csv(gsea_tb, "Combined_GSEA.csv", na = "")
