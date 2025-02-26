# annotate_protein_domains
Using bedtools to annotate protein domains

Example:

```
Rscript annotateDomains.R -i inputfile.txt -p PROTEIN_ARCHITECTURE.bed -b ~/software/bedtools/bedtools-2.17.0/bin/bedtools
```

Requirements:
```
R/3.0.0
R optparse library
```

Example input file content (no header needed but shown for clarification):
```
GeneName  ProteinName Phenotype AAposition  Chromosome  Position(hg19)  RefAllele AltAllele AlleleFreq
NAT2	NP_000006.2	1000Genomes	114	chr8	18257854	T	C	0.296703296703
```

`PROTEIN_ARCHITECTURE.bed` file is a bed file that looks like this:

```
Protein AAStart AAStop  DomainName
NP_000680.2	4	12	A2M
```

