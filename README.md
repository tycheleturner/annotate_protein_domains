# annotate_protein_domains
Using bedtools to annotate protein domains

Example:

<code bash>
Rscript annotateDomains.R -i inputfile.txt -p PROTEIN_ARCHITECTURE.bed -b ~/software/bedtools/bedtools-2.17.0/bin/bedtools
</code>

Requirements:
R/3.0.0
R optparse library

Example input file content (no header needed but shown for clarification):
GeneName  ProteinName Phenotype AAposition  Chromosome  Position(hg19)  RefAllele AltAllele AlleleFre
NAT2	NP_000006.2	1000Genomes	114	chr8	18257854	T	C	0.296703296703
NAT2	NP_000006.2	1000Genomes	197	chr8	18258103	G	A	0.244963369963
NAT2	NP_000006.2	1000Genomes	268	chr8	18258316	G	A	0.683608058608
NAT2	NP_000006.2	1000Genomes	280	chr8	18258351	G	A	0.00641025641026

PROTEIN_ARCHITECTURE.bed file is a bed file that looks like this:
Protein AAStart AAStop  DomainName
NP_000680.2	4	12	A2M
NP_001988.1	1	70	UBQ




