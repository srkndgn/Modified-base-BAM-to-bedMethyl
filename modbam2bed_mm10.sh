# modbam2bed
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
    mkdir modbam2bed_WGS_ONT_mm10             # working directory should be outside the anaconda3 directory
    cd modbam2bed_WGS_ONT_mm10                # go to your modbam2bed working directory

# activate the modbam2bed environment in your working directory
    conda activate modbam2bed             #activate conda environment

# load your .bam (ONT) and reference.fa (mm10 reference fasta file) into your working directory
   
# to create a bed file containing methylation data from a BAM file obtained from ONT.
    modbam2bed --aggregate --cpg reference.fa sample_01_sorted.bam > sample_01_output_methylation.bed

# to combine the calls of different modified bases into a single 'modified' count. 
# This can be particularly useful when dealing with data from Oxford Nanopore sequencing, where basecallers can jointly call different modified bases (e.g., C, 5mC, 5hmC)
# The --combine option allows you to combine the counts of different modified bases, treating them as a single category. 
    modbam2bed --aggregate --cpg --combine reference.fa sample_01_sorted.bam > sample_01_output_methylation_combined.bed

# Do not forget to rename the mod-counts output file after each run because you will use this mod-counts output files     
# like sample_01_mod-counts.cpg.acc.bed
# To count the number of rows (lines)
    wc -l sample_01_mod-counts.cpg.acc.bed

# Your bed file is ready > to create bigwig files, continue with Bed_file_to_BigWig_file.sh

# If you need more manipulation or to check output files, you can do the following

# To count the number of non-empty lines in a file while excluding only the lines that are entirely empty (and not excluding headers)
    grep -v '^$' sample_01_mod-counts.cpg.acc.bed | wc -l

##########################################################################
# activate the bedtools environment in your working directory
    conda activate bedtools             #activate conda environment

# by default, 'bedtools intersect' reports the intervals that represent overlaps between your two files
    
# E4_mod-counts.cpg.acc.bed vs E7_mod-counts.cpg.acc.bed files
    bedtools intersect -a sample_01_mod-counts.cpg.acc.bed -b sample_02_mod-counts.cpg.acc.bed > combined_mod-counts.cpg_intersect.bed -wa

# To count the number of rows (lines)
    wc -l combined_mod-counts.cpg_intersect.bed

# To replace occurrences of "NaN" with "0" in a file
    # sed 's/nan/0/g' combined_mod-counts.cpg_intersect.bed > combined_mod-counts.cpg_intersect_without_NAN.bed
    # sed 's/nan/0/g' combined_mod-counts.cpg_intersect.bed > combined_mod-counts.cpg_intersect_without_NAN.bed
###########################################################################


