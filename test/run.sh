bam='/data3/Projects/panel889/201024_A00869_0320_BHKJ5WDSXY/02_aln/201020052N.rmdup.recal.bam'
bed="$PWD/test.bed"

python ../calBAF.py -bam $bam -bed $bed -outfile MET.baf
