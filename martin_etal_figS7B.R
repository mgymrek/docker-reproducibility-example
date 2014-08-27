##################################
# Note: code is a modified version of the code posted by the authors
# of Martin et al "Transcriptome Sequencing from Diverse Human Populations Reveals Differentiated Regulatory Architecture"
# http://www.plosgenetics.org/article/info%3Adoi%2F10.1371%2Fjournal.pgen.1004353
# Original code can be found here: http://gbsc-share.stanford.edu/HGDP_RNAseq/scripts/allele_specific_expression/analyze_ase.R
# Code is posted with submission from the original authors
##################################

library(gplots)

#this file has ase site calls from the exome data and has the correct individual IDs, has ref_ratios outside 0.4-0.6 removed, and has unique IDs for RSID
ase <- read.csv('ase_total30_sample30.csv', header=T)

#Filter all ASE sites: >= 30 reads, >=2% ref, >=2% nonref, p=0.05
newsig_ase <- subset(ase, ase$sample30_p <= 0.05 & ase$ref_count >= .02 * ase$total_count & ase$nonref_count >= .02 * ase$total_count)

#get significant number of ASE sites per individual
ase_ind <- unique(newsig_ase$individual)

ase_sites_seen2 = function(ind_filt, ind_bkgd) {
    filt=c()
    bkgd=c()
    for(i in 1:length(unique(ind_filt$individual))) {
        for(j in 1:length(unique(ind_filt$individual))) {
            if(i > j) {
                ind1 <- subset(ind_filt, ind_filt$individual == unique(ind_filt$individual)[i])
                ind2 <- subset(ind_filt, ind_filt$individual == unique(ind_filt$individual)[j])
                #find sites in both
                filt <- c(filt, sum(ind2$RSID %in% ind1$RSID))
                ind1 <- subset(ind_bkgd, ind_bkgd$individual == unique(ind_bkgd$individual)[i])
                ind2 <- subset(ind_bkgd, ind_bkgd$individual == unique(ind_bkgd$individual)[j])
                #find sites in both
                bkgd <- c(bkgd, sum(ind2$RSID %in% ind1$RSID))
            }
        }
    }
    num = filt/bkgd
    return(num)
}

#all by all pairwise ase sharing
path <- c('HGDP00213','HGDP00222','HGDP00232','HGDP00237','HGDP00239','HGDP00247','HGDP00258')
mbu <- c('HGDP00449','HGDP00456','HGDP00462','HGDP00467','HGDP00471','HGDP00476', 'HGDP01081')
cam <- c('HGDP00711','HGDP00712','HGDP00713','HGDP00715','HGDP00716','HGDP00720','HGDP00721')
maya <- c('HGDP00854','HGDP00855','HGDP00856','HGDP00857','HGDP00858','HGDP00868','HGDP00877')
yak <- c('HGDP00948','HGDP00950','HGDP00955','HGDP00959','HGDP00964','HGDP00967')
moz <- c('HGDP01258','HGDP01259','HGDP01262','HGDP01264','HGDP01274','HGDP01275','HGDP01277')

ase_ind <- c(maya, yak, cam, path, moz, mbu)
all_by_all <- matrix(NA, nrow=41, ncol=41)
colnames(all_by_all) = ase_ind
rownames(all_by_all) = ase_ind
for(i in 1:41) {
    for(j in 1:41) {
        if(i != j) {
            all_by_all[i,j]<- ase_sites_seen2(subset(newsig_ase, newsig_ase$individual==ase_ind[i]| newsig_ase$individual==ase_ind[j]), subset(ase, ase$individual==ase_ind[i] | ase$individual==ase_ind[j]))
        }
    }
}

brewerVector=rev(c(colors()[c(466)],"blue","turquoise","darkgreen","yellow","orange","red"))
colorPop<-c(rep(brewerVector[1],7),rep(brewerVector[2],6),rep(brewerVector[3],7),rep(brewerVector[4],7),rep(brewerVector[5],7),rep(brewerVector[6],7))
par(mar=c(7,3,7,7))
heatmap.2(all_by_all, trace="none",scale="row", labRow=ase_ind, labCol=ase_ind, RowSideColors=colorPop, ColSideColors=colorPop, dendrogram='column', key='T', density.info='none')
legend('bottomleft', c('Maya', 'Yakut', 'Cambodian', 'Pathan', 'Mozabite', 'Mbuti'), col=brewerVector, lty='solid', bty='n', lwd=4, cex=0.75)