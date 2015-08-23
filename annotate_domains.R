#!/bin/Rscript

library("optparse")

option_list <- list(
	make_option(c('-i','--in_file'), action='store', type='character', default=NULL, help='Input .tsv file to annotate'),
	make_option(c('-p','--protein_file'), action='store', type='character', default=NULL, help='Path to protein bed file'),
	make_option(c('-b','--bed_tools'), action='store', type='character', default=NULL, help='Path to bedtools on your system')
)

opt <- parse_args(OptionParser(option_list = option_list))

# parsers
infile <- opt$in_file
protein <- opt$protein_file
bedtools <- opt$bed_tools

fileToAnnotate <- read.delim(infile, header=F)
fileToAnnotate <- fileToAnnotate[,c("V2", "V4", "V4", "V1")]
infile2 <- strsplit(infile,"/")[[1]][length(strsplit(infile,"/")[[1]])]
write.table(fileToAnnotate, file=paste(infile2, ".bed", sep=""), sep="\t", quote=F, row.names=F, col.names=F)

system(paste(bedtools, " intersect -a ", infile2, ".bed -b ", protein, " -wa -wb > overlap_of_nonsynonymous_with_domains.txt", sep=""))
system(paste(bedtools, " intersect -a ", infile2, ".bed -b ", protein, " -v > nonsynonymous_not_in_domains.txt",sep=""))

#Combine the information
d <- read.delim("overlap_of_nonsynonymous_with_domains.txt", header=F)
colnames(d) <- c("Protein", "Mutation", "Mutation", "Gene", "Protein", "Domain_start", "Domain_stop", "domain")
d$id <- paste(d$Protein, d$Mutation, sep="|")
d <- d[,c("id", "domain")]

nd <- read.delim("nonsynonymous_not_in_domains.txt", header=F)
prot <- read.delim(protein, header=F)
ndwithdata <- nd[which(nd[,1] %in% prot[,1]),]
ndwithoutdata <- nd[!(nd[,1] %in% prot[,1]),]
ndwithdata$domain <- "NONE"
ndwithoutdata$domain <- "NA"
ndf <- rbind(ndwithdata, ndwithoutdata)
ndf$id <- paste(ndf$V1, ndf$V2, sep="|")
ndf <- ndf[,c("id", "domain")]

orig <- read.delim(infile,, header=F)
orig$id <- paste(orig$V2, orig$V4, sep="|")
comb <- rbind(d,ndf)
comb <- comb[!duplicated(comb$id),]

m <- merge(orig, comb, by="id", all.x=T)
m$id <- NULL

write.table(m, file=paste(infile2,".out", sep=""), sep="\t", quote=F, row.names=F, col.names=F)

system(paste("rm ", infile2, ".bed", sep=""))
system("rm nonsynonymous_not_in_domains.txt")
system("rm overlap_of_nonsynonymous_with_domains.txt")

