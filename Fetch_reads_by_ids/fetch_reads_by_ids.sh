# Author - Vijay Lakhujani
# Date   - May 23, 2017
# This script fetches the reads based on read id mentioned in the user provided txt file.
# Usage : sh fetch_reads_by_id.sh  <ids.txt>  <input.fastq>  >  <out.fastq>

#!/bin/sh

#Function to print the usage
usage ()
{
  echo 'Usage : sh fetch_reads_by_id.sh <ids.txt>   <input.fastq>   >   <out.fastq>'
  exit
}

# Check if no. of arguments is 2 i.e. a id.txt file and a input fastq file.
# Output fastq should be redirected using ">"
if [ "$#" -ne 2 ]
then
  usage
fi

IFS=''
counter=0
# Getting total ids to be fetched
total_ids=`wc -l $1 | awk '{print $1}'`

while read line
do
# "-A" grep id line by line from ids.txt file along with 3 lines after the id i.e. read sequence, read quality and "+" symbol.
# "-w" for exact read id match
# $2 - input fastq file
grep -w -A 3 $line $2
# checking if grep worked 
if [ `echo $?` == 0  ]
then
   counter=$((counter+1))
   # Redirecting counter in standard output
   >&2 echo "[$counter/$total_ids] Found read id: $line"
fi
# $1 ids.txt file
done < $1
