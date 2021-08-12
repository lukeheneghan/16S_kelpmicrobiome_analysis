#!/usr/bin/env nextflow


// Show help message
params.help = false
if (params.help){
    helpMessage()
    exit 0
}

params.fastqc = ''
if(!params.fastqc) exit 1, "error: No fastqc input data provided."
Channel.fromPath(params.fastqc)
	.set{fastqc_input_ch}

params.pairedreads = ''
if(!params.pairedreads) exit 1, "error: No paired reads data provided."
Channel.fromFilePairs(params.pairedreads)
        .set{ cutadapt_input_ch }

outdir = '.'

process firstFastQC{
	
	publishDir "${outdir}/nextflow.outputs/pre.trim", mode:'copy'

	input:
	file(reads) from fastqc_input_ch

	output:
	file("*.{html,zip}") into fastqc_results_ch

	script:
	"""
	fastqc --quiet $reads
	"""
}

process cut_adapt{

        publishDir "${outdir}/nextflow.outputs/trimmed.data", mode:'copy'

        input:
	tuple val(key), file(reads) from cutadapt_input_ch

        output:
        file("*.fastq") into cutadapt_results_ch

        script:
        """
	cutadapt $reads \
        -g GTGCCAGCMGCCGCGGTAA \\
        -G GGACTACHVGGGTWTCTAAT \\
        -o ${key}.1.fastq \\
        -p ${key}.2.fastq
        """
}


process secondFastQC{

        publishDir "${outdir}/nextflow.outputs/post.trim", mode:'copy'

        input:
	file(reads) from cutadapt_results_ch

        output:
        file("*.{html,zip}") into out

        script:
        """
        fastqc --quiet $reads
        """
}

