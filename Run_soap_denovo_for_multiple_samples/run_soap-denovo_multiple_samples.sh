total_files=`find -name '*.gz' | wc -l`
arr=( $(ls *.gz) )

for ((i=0; i<$total_files; i+=2))
{
out=`echo ${arr[$i]} | awk -F "_R1" '{print $2}'`

echo "config file" > "$out.config_file"
echo "============" >> "$out.config_file"
echo "max_rd_len=151" >> "$out.config_file"
echo "[LIB]" >> "$out.config_file"
echo "avg_ins=450" >> "$out.config_file"
echo "reverse_seq=0" >> "$out.config_file"
echo "asm_flags=3" >> "$out.config_file"
echo "rank=1" >> "$out.config_file"
echo "pair_num_cutoff=3" >> "$out.config_file"
echo "map_len=32" >> "$out.config_file"
echo "q1=`pwd`/${arr[$i]}" >> "$out.config_file"
echo "q2=`pwd`/${arr[$i+1]}" >> "$out.config_file"

}

for j in *.config_file; do

notify-send "started running soap-denovo for $j..." -t 0
echo "started running soap-denovo for $j..."

for ((k=21; k<=121; k+=10))
{
sample_name=`echo $j | sed 's/.config_file//'`
mkdir "$sample_name-$k"
echo "started running soap-denovo for kmer: $k"
notify-send "started running soap-denovo for kmer: $k..." -t 0
cd "$sample_name-$k"

if [ $k -le 63 ]
then
   date && time /opt/app/SOAPdenovo2/SOAPdenovo-63mer all -s ../$j -K $k -p 60 -F -R -o "$sample_name-$k" 1> "$sample_name-$k".log 2>"$sample_name-$k".err
else
   date && time /opt/app/SOAPdenovo2/SOAPdenovo-127mer all -s ../$j -K $k -p 60 -F -R -o "$sample_name-$k" 1> "$sample_name-$k".log 2>"$sample_name-$k".err
fi
cd ..
}
done
