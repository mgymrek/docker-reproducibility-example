##################################
# Note: code is a modified version of the code posted by the authors
# of Martin et al "Transcriptome Sequencing from Diverse Human Populations Reveals Differentiated Regulatory Architecture"
# http://www.plosgenetics.org/article/info%3Adoi%2F10.1371%2Fjournal.pgen.1004353
# Original code can be found here: http://gbsc-share.stanford.edu/HGDP_RNAseq/scripts/technical_replicates/technical_reps.R
# Code is posted with submission from the original authors
##################################

library(ops)

####################################
#assess technical reproducibility  #
####################################
run1_gene <- read.table('/home/guest/data/gene_fpkm_table_run1.txt', sep='\t', header=T)
run2_gene <- read.table('/home/guest/data/gene_fpkm_table_run2.txt', sep="\t", header=T)

merge12_gene <- merge(run1_gene, run2_gene, by='tracking_id')[,c(5:50, 55:100)]

par(mar=c(2,2,2,1), mfrow=c(7,7), cex.axis=1, cex.lab=1, mgp=c(3,0.5,0))
#take out rows where either was zero (this was done in the C't Hoen Nat Biotech paper)
gene_concordance <- c()
for(i in c(1:4,6:46)) {
    merged_no_zeros <- merge12_gene[apply(merge12_gene[,c(i,46+i)], 1, min)!=0,][,c(i,46+i)]
    p <- findP(merged_no_zeros)$maxIQR #looks for the optimal scaling power
    merged_ops <- merged_no_zeros^p #transforms the expression data to a normal distribution
    plot(merged_ops, xlab='', ylab='')
    mtext(strsplit(colnames(merged_no_zeros, 1)[1], '.', fixed=T)[[1]][1], 3, line=0.8, cex=0.8)
    #mtext(colnames(merged_no_zeros, 1)[2], 2, line=1.5, cex=0.8)
    abline(lm(merged_ops[,2]~merged_ops[,1]), col='red', lty='dashed')
    print(paste(p, colnames(merged_no_zeros, 1)[1], colnames(merged_no_zeros, 1)[2], cor.test(merged_ops[,1], merged_ops[,2])$estimate, sep=' '))
    gene_concordance <- c(gene_concordance, cor.test(merged_ops[,1], merged_ops[,2])$estimate)
}