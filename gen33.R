library(GenomicFeatures)
library(AnnotationDbi)
library(rtracklayer)

options(stringsAsFactors = FALSE)

txdb <- makeTxDbFromGFF("/Users/anthmam/Desktop/Projects/BHK/ORCESTRA/Transcriptome/gen_v33/gencode.v33.annotation.gtf")
saveDb(txdb, "/Users/anthmam/Desktop/Projects/BHK/ORCESTRA/Transcriptome/gen_v33/gencode.v33.annotation.txdb")

txdb <- loadDb("/Users/anthmam/Desktop/Projects/BHK/ORCESTRA/Transcriptome/gen_v33/gencode.v33.annotation.txdb")
k <- keys(txdb, keytype="TXNAME")
tx2gene <- select(txdb, k, "GENEID", "TXNAME")
colnames(tx2gene) <- c("transcripts", "genes")

features <- rtracklayer::import('/Users/anthmam/Desktop/Projects/BHK/ORCESTRA/Transcriptome/gen_v33/gencode.v33.annotation.gtf')

features_gene = as.data.frame(features)
features_gene = features_gene[which(features_gene$type == "gene"),]
#features_df <- features_df[order(match(features_df$transcript_id,tx2gene$TXNAME)),]
remove <- c("hgnc_id","transcript_id","transcript_support_level","transcript_type","transcript_name","havana_transcript", "ccdsid","ont", "protein_id","exon_id", "exon_number", "transcript_status")
features_gene <- features_gene[,!names(features_gene) %in% remove]
rownames(features_gene) <- features_gene$gene_id


features_transcript = as.data.frame(features)
features_transcript = features_transcript[which(features_transcript$type == "transcript"),]
#features_df <- features_df[order(match(features_df$transcript_id,tx2gene$TXNAME)),]
remove <- c("exon_id", "exon_number","exon_version")
features_transcript <- features_transcript[,!names(features_transcript) %in% remove]
rownames(features_transcript) <- features_transcript$transcript_id



save(tx2gene, features_gene, features_transcript, file="/Users/anthmam/Desktop/Projects/BHK/ORCESTRA/Transcriptome/gen_v33/Gencode.v33.annotation.RData")











