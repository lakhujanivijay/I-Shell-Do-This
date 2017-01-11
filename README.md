# About the program

This shell script exploits the ultra-fast fasta manipulation tool called [seqkit](http://www.biocodes.org/thread.php?id=15).As arguments, the script takes the assembly file in fasta format.

The program outputs the following statistical elements:

#### num_scaffolds: The total number of [scaffolds](http://genome.jgi.doe.gov/help/scaffolds.html)

#### num_contigs: The total number of [contigs](https://en.wikipedia.org/wiki/Contig)

#### total genome length incl. gaps: A total of A's, G's, T's, C's and N's in the assembly

#### total genome length w/o gaps: A total of A's, G's, T's, C's in the assembly (N's excluded here)

#### avg_scaffold_size incl. gaps: Mean of the lengths of the assembled scaffolds

#### avg_contig_size: Mean of the lengths of the contigs

#### Contig [N50](http://www.biocodes.org/thread.php?id=9): Contig N50 is a weighted median statistic such that 50% of the entire assembly is contained in contigs equal to or larger than this value

#### Scaffold N50: Scaffold N50 is a weighted median statistic such that 50% of the entire assembly is contained in scaffolds equal to or larger than this value

#### Total gaps: Total number of N's in the assembly

#### Max scaffold size: Length of the longest scaffold

#### Min scaffold size: Length of the smallest scaffold

# Usage:
`assembly_stats.sh <assembly.fasta>`

# NOTE:

Before running the script, download and keep seqkit file in the same directory containing the assembly fasta file and this shell script. You can download seqkit [here](https://github.com/shenwei356/seqkit/releases).

Dependencies:
[seqkit](https://github.com/shenwei356/seqkit)
