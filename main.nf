process WRITETEST {
    container 'staphb/trimmomatic:0.39'
    memory '32GB'

    script:
    """
    ( for a in {1..1000}; do echo \$a; sleep 1; done ) | dd of=file
    md5sum file | grep 53d025127ae99ab79e8502aae2d9bea6
    """
}

workflow {
  main:
    WRITETEST()
}
