process TRIMMOMATIC {
    container 'staphb/trimmomatic:0.39'
    memory '32GB'

    input:
        path 'SRX1603629_T1_2.fastq.gz'
        path 'SRX1603630_T1_2.fastq.gz'

    output:
        path 'output1'
        path 'output2'
        path 'output3'
        path 'output4'

    script:
    """
    trimmomatic PE \
                -threads 5 \
                -phred33 \
                -trimlog /dev/null \
                SRX1603629_T1_2.fastq.gz \
                SRX1603630_T1_2.fastq.gz \
                output1 \
                output2 \
                output3 \
                output4 \
                LEADING:3 \
                TRAILING:3 \
                SLIDINGWINDOW:4:15 \
                MINLEN:27 \
                ILLUMINACLIP:/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10
    """
}

workflow {
    input1 = channel.fromPath('s3://ngi-igenomes/test-data/rnaseq/SRX1603629_T1_2.fastq.gz')
    input2 = channel.fromPath('s3://ngi-igenomes/test-data/rnaseq/SRX1603630_T1_2.fastq.gz')

  main:
    TRIMMOMATIC(input1, input2)
}
