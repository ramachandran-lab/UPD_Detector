# UPD_Detector
# code and classifier parameters for ROH-based UPD detection

Contact: priyanka_nakka@brown.edu

HOW TO USE:

This program requires 4 input files: 

1) One of the classifier parameters files given here.  Each file corresponds to model parameters for UPD classifiers trained in a different population; please choose the population that most closely matches that of your dataset.

2) Files of ROH-based metrics for each individual in your dataset, one for each chromosome (1-23). The file names should be in the format ‘prefix’ + chromosome number (ex. ./example-input.chr1).  The first column should contain individual ids for every individual in your dataset followed by two columns of ROH-based metrics.  The two metrics that we trained the classifier on are total Class C ROH length for the given chromosome in base pairs (second column) and the ratio of the total class C ROH length for the chromosome with the second largest total class C ROH length to the maximum ROH length over the all the chromosomes (third column).  An example file is shown below.

ids	totclen		secondmax
IND1	236000000	0.05
IND2	60000		0.95
…

3) Prefix for output files, one for each chromosome, that will contain probabilities of being a UPD case for every individual for every chromosome (ex. ./example-out1) 

4) Output file name for final list of putative UPD cases



