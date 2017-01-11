This shell script exploits the ultra-fast fasta manipulation tool called [url=http://www.biocodes.org/thread.php?id=15]seqkit.[/url]As arguments, the script takes the assembly file in fasta format.

The program outputs the following statistical elements:

[b]num_scaffolds:  [/b] The total number of [url=http://genome.jgi.doe.gov/help/scaffolds.html]scaffolds[/url]

[b]num_contigs: [/b] The total number of [url=https://en.wikipedia.org/wiki/Contig]contigs[/url]

[b]total genome length incl. gaps: [/b] A total of A's, G's, T's, C's and N's in the assembly

[b]total genome length w/o gaps: [/b] A total of A's, G's, T's, C's in the assembly (N's excluded here)

[b]avg_scaffold_size incl. gaps:[/b] Mean of the lengths of the assembled scaffolds

[b]avg_contig_size:[/b] Mean of the lengths of the contigs

[b]Contig [url=http://www.biocodes.org/thread.php?id=9]N50[/url]:[/b] Contig N50 is a weighted median statistic such that 50% of the entire assembly is contained in contigs equal to or larger than this value

[b]Scaffold N50:[/b]  Scaffold N50 is a weighted median statistic such that 50% of the entire assembly is contained in scaffolds equal to or larger than this value

[b]Total gaps:[/b] Total number of N's in the assembly

[b]Max scaffold size:[/b] Length of the longest scaffold

[b]Min scaffold size: [/b] Length of the smallest scaffold
