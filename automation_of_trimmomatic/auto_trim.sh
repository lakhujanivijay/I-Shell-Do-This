#!/bin/bash

# Shell script to automate trimmomatic for multiple samples
# Author = Vijay Lakhujani
# Date = 20 June 2017

# Usage
# This script automates running trimmomatic for multiple PE data.
# Supported extensions are: <.fq> or <.fastq> or <.fq.gz> or <.fastq.gz>

# Execution
# Case(1) run on a couple of PE files with extension *.fq
# $ sh auto_trim.sh *.fq

# Case(2) run on a couple of PE files with extension *.fq.gz
# $ sh auto_trim.sh *.fq.gz

# Case(3) run on a all the fastq files in the current directory (mixed extensions, like .fq. .fastq )
# $ sh auto_trim.sh *

# Invoke help
# $ sh auto_trim.sh -h
# $ sh auto_trim.sh --help
# Supported extensions are: <.fq> or <.fastq> or <.fq.gz> or <.fastq.gz>



red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`
count=0

usage ()
{
  echo -e "${green}Usage: sh auto_trim [*.extension]\n \
      extension: <fq> or <fastq> or <fq.gz> or <fastq.gz>\n \
      example: sh auto_trim.sh *.fq.gz\n ${reset}\n\
${yellow}Help:  sh autotrim -h or --help${reset}"
  return
}

file_not_found ()
{
echo -e "\n${red}FileNotFoundError: No such file with extension $@ found!${reset}"
echo -e "${green}Supported extensions are: <.fq> or <.fastq> or <.fq.gz> or <.fastq.gz>${reset}\n"
return 
}

file_name_error ()
{
echo -e "\n${red}Filename Error: Paired end file names should contain _R1 _R2${reset}"
echo -e "${green}Example: test_R1.fq.gz, test_R2.fq.gz${reset}\n"
return 
}

file_extension_error ()
{
echo -e "\n${red}FileExtensionError: Invalid extension${reset}"
echo -e "${green}Supported extensions are: <.fq> or <.fastq> or <.fq.gz> or <.fastq.gz>${reset}\n"
return     
}

if [[ ( $1 == '-h' ) || ( $1 == '--help') ]] ;then
 usage
elif [[ $# -eq 0 ]] ;then
 echo "${red}Error: No parameter(s) provided${reset}"
 usage
 return 0
else
  for i in $@; do
        count=$((count+1))
        if [ -f $i ] ;then
            if [[ (${i#*.} == "fastq.gz") || (${i#*.} == "fq.gz") || (${i#*.} == "fastq") || (${i#*.} == "fq") ]] ;then 
                if echo $1 | grep -q -e "_R1" -e "_R2"; then
		   if [[ $count%2 -ne 0 ]]; then
                       sample_name=`echo $i | awk -F "_R1"  '{print $1}'`
                       extension=`echo $i | awk -F "_R1"  '{print $2}'`
                       R1=${sample_name}_R1${extension}
	               R2=${sample_name}_R2${extension}
		       R1_pair=${sample_name}_R1_pair${extension}
		       R1_unpair=${sample_name}_R1_unpair${extension}
		       R2_pair=${sample_name}_R2_pair${extension}
		       R2_unpair=${sample_name}_R2_unpair${extension}
                       echo -e "\n${yellow}[Running trimmomatic for sample] ${sample_name} at `whoami`${reset}\n"
                       date && time java -jar \
                       /share/apps/Trimmomatic-0.36/trimmomatic-0.36.jar \
                       PE \
                       -threads 10 \
                       -phred33 $R1 $R2 $R1_pair $R1_unpair $R2_pair $R2_unpair \
                       HEADCROP:7 \
                       ILLUMINACLIP:/data/results/NEB_adapter.fasta:2:30:8 \
                       LEADING:20 \
                       TRAILING:20 \
                       SLIDINGWINDOW:20:20 \
                       MINLEN:40 
                       rm *unpair*

                   fi
                else file_name_error
                fi      
            elif [[ (${i#*.} == "sh") || (${i#*.} == "sh~")  ]] ;then
                 echo -n
            else
                echo -ne "${red}Check:$i${reset}"
                file_extension_error  
            fi     
        else
	    file_not_found $@
        fi
  done
fi
