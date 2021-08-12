#!/bin/bash


mothur "#make.file(inputdir=., type=fastq, prefix=stability)"

mothur "#make.contigs(file=stability.files, processors=5)"

mothur "#summary.seqs(fasta=stability.trim.contigs.fasta)"

mothur "#screen.seqs(fasta=stability.trim.contigs.fasta, group=stability.contigs.groups, summary=stability.trim.contigs.summary, maxambig=0,minlength=100,  maxlength=500, maxhomop=10)"

mothur "#unique.seqs(fasta=stability.trim.contigs.good.fasta)"

mothur "#count.seqs(name=stability.trim.contigs.good.names, group=stability.contigs.good.groups)"

## mothur "#summary.seqs(count=stability.trim.contigs.good.count_table, fasta=stability.trim.contigs.good.unique.fasta)"

## mothur "#pcr.seqs(fasta=stability.trim.contigs.good.unique.fasta,count=stability.trim.contigs.good.count_table,oligos=16S.oligos,pdiffs=4)"

mothur "#pcr.seqs(fasta=silva.nr_v132.align, start=11894, end=25319, keepdots=F, processors=8)"

mothur "#rename.file(input=silva.nr_v132.pcr.align, new=silva.v4.fasta)"

mothur "#align.seqs(fasta=stability.trim.contigs.good.unique.fasta, reference=silva.v4.fasta, processors=6)"

mothur "#summary.seqs(fasta=stability.trim.contigs.good.unique.align, count=stability.trim.contigs.good.count_table)" > summaryout.txt

mothur "#screen.seqs(fasta=stability.trim.contigs.good.unique.align, count=stability.trim.contigs.good.count_table, start=1967, end=11594)"

mothur "#filter.seqs(fasta=stability.trim.contigs.good.unique.good.align, vertical=T, trump=.)"

mothur "#unique.seqs(fasta=stability.trim.contigs.good.unique.good.filter.fasta, count=stability.trim.contigs.good.good.count_table)"

mothur "#pre.cluster(fasta=stability.trim.contigs.good.unique.good.filter.unique.fasta, count=stability.trim.contigs.good.unique.good.filter.count_table, diffs=2)"

mothur "#chimera.vsearch(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.count_table, dereplicate=t)"

mothur "#remove.seqs(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.fasta, accnos=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.accnos)"

mothur "#classify.seqs(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table, reference=silva.v4.fasta, taxonomy=silva.nr_v132.tax, cutoff=60)"

mothur "#remove.lineage(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.count_table, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.nr_v132.wang.taxonomy, taxon='Mitochondria;-Chloroplast;-unknown;-Eukaryota;')"

mothur "#dist.seqs(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta, cutoff=0.15)"

mothur "#cluster(column=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.dist, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.count_table,cutoff=0.03)"

mothur "#make.shared(list=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.opti_mcc.list, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.count_table, label=0.03)"

mothur "#classify.seqs(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta, reference=silva.v4.fasta, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.count_table, taxonomy=silva.nr_v132.tax, cutoff = 60)"

mothur "#classify.otu(list=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.opti_mcc.list, count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.count_table, taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.nr_v132.wang.pick.taxonomy, label=0.03)"

mothur "#get.oturep(fasta=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta,count=stability.trim.contigs.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.count_table, list=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.opti_mcc.list, sorted=bin, method=abundance)"


mothur "#rename.file(taxonomy=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.nr_v132.wang.taxonomy, shared=stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.opti_mcc.shared)"

mothur "#count.groups(shared=stability.opti_mcc.shared)"

mothur "#rarefaction.single(shared=stability.opti_mcc.shared, calc=sobs, freq=100)"

mothur "#summary.single(shared=stability.opti_mcc.shared, calc=nseqs-coverage-sobs-invsimpson, subsample=T)"

mothur "#dist.shared(shared=stability.opti_mcc.shared, calc=braycurtis, subsample=t)"

mothur "#pcoa(phylip=stability.opti_mcc.braycurtis.0.03.lt.ave.dist)"

mothur "#nmds(phylip=stability.opti_mcc.braycurtis.0.03.lt.ave.dist)"

mothur "#amova(phylip=stability.opti_mcc.braycurtis.0.03.lt.ave.dist, design=kelp.species.design)"

