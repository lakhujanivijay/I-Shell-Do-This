assembly_file=$1
stats=`./seqkit stat $assembly_file -j 10 | grep -v "^file"`
IFS=' ' read -ra scaffold_stats_array <<< "$stats"
echo "num_scaffolds = ${scaffold_stats_array[3]}"
other_stats=`cat $assembly_file  | \
           ./seqkit fx2tab -j 10 | \
                        cut -f 2 | \
             sed -r 's/n+/\n/gi' | \
                          cat -n | \
           ./seqkit tab2fx -j 10 | \
   ./seqkit replace -j 10 -p "(.+)" -r "contig_{nr}" | \
             ./seqkit stat -j 10 | \
                    grep -v "^file" `
IFS=' ' read -ra contig_stats_array <<< "$other_stats"
echo "num_contigs = ${contig_stats_array[3]}"
echo "total genome length incl. gaps = ${scaffold_stats_array[4]}"
echo "total genome length w/o gaps = ${contig_stats_array[4]}"
echo "avg_scaffold_size incl. gaps = ${scaffold_stats_array[6]}"
echo "avg_contig_size = ${contig_stats_array[6]}"
total_contigs_length=$(echo ${contig_stats_array[4]} | sed -e "s/,//g")
n_contig_half=$(($total_contigs_length/2))  

contig_n50=`cat $assembly_file   | \
           ./seqkit fx2tab -j 10 | \
                        cut -f 2 | \
             sed -r 's/n+/\n/gi' | \
                          cat -n | \
           ./seqkit tab2fx -j 10 | \
   ./seqkit replace -j 10 -p "(.+)" -r "contig_{nr}" | \
        ./seqkit fx2tab -j 10 -l | \
                awk '{print $3}' | \
                        sort -nr | \
awk -v pdi=$n_contig_half '{sum += $0; if (sum >= pdi) {print; exit}}'`

echo "Contig N50 = $contig_n50"

total_genome_length=$(echo ${scaffold_stats_array[4]} | sed -e "s/,//g")
n_scaffold_half=$(($total_genome_length/2))
scaffold_n50=`./seqkit fx2tab -j 10 -l $assembly_file | \
                                     awk '{print $3}' | \
                                              sort -nr| \
awk -v pdi=$n_scaffold_half '{sum += $0; if (sum >= pdi) {print; exit}}'` 

echo "Scaffold N50 = $scaffold_n50"
echo "Total gaps = $(($total_genome_length - $total_contigs_length))"

echo "Max scaffold size = ${scaffold_stats_array[7]}"
echo "Min scaffold size = ${scaffold_stats_array[5]}"
