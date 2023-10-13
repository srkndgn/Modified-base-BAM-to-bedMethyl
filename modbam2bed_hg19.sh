# A program to aggregate modified base counts stored in a modified-base BAM (Section 2.1) file to a bedMethyl file.
# Tutorial for Bismark > (https://github.com/epi2me-labs/modbam2bed)
# Reference page > (https://labs.epi2me.io/notebooks/Modified_Base_Tutorial.html)

# To execute the contents of the .bashrc file in the current shell session (necessary to start conda)
    source ~/.bashrc

# install the bedtools
    cd anaconda3/envs/                  # go to your anaconda3 directory
    conda create --name modbam2bed         # create your bismark environment
    
    cd anaconda3/envs/modbam2bed/         #go to your working directory
    
    conda activate modbam2bed             #activate conda environment
    
    conda install -c bioconda -c conda-forge -c epi2melabs modbam2bed  #install modbam2bed
    
# create your working directory for your modbam2bed environment
    mkdir ONT_data             # working directory should be outside the anaconda3 directory
    cd ONT_data                # go to your modbam2bed working directory

# activate the modbam2bed environment in your working directory
    conda activate modbam2bed             #activate conda environment

# load your .bam (ONT) and reference.fa (hg19 reference fasta file) into your working directory
  https://hgdownload.cse.ucsc.edu/goldenpath/hg19/bigZips/

  https://www.gungorbudak.com/blog/2014/04/13/download-human-reference-genome-hg19/
   
# to create a bed file containing methylation data from a BAM file obtained from ONT.
    modbam2bed --aggregate --cpg hg19.fa sample_01_ONT_sorted.bam > sample_01_ONT_sorted.bed
# or
    modbam2bed --aggregate --cpg hg19_ref_genome.fa sample_01_ONT_sorted.bam > sample_01_ONT_sorted.bed

# to combine the calls of different modified bases into a single 'modified' count. 
# This can be particularly useful when dealing with data from Oxford Nanopore sequencing, where basecallers can jointly call different modified bases (e.g., C, 5mC, 5hmC)
# The --combine option allows you to combine the counts of different modified bases, treating them as a single category. 
    modbam2bed --aggregate --cpg --combine hg19.fa sample_01_ONT_sorted.bam > sample_01_ONT_sorted.bed

# end ##############################################################################################################

# Do not forget to rename the mod-counts output file after each run because you will use this mod-counts output files     
# like sample_01_ONT_sorted_mod-counts.cpg.acc.bed
# To count the number of rows (lines)
    wc -l sample_01_ONT_sorted_mod-counts.cpg.acc.bed

# Your bed file is ready > to create bigwig files, continue with Bed_file_to_BigWig_file.sh