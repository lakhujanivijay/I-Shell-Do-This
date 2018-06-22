### Automation of trimmomatic

---

#### What is Trimmomatic?
Read the manual [here](http://www.usadellab.org/cms/?page=trimmomatic)

#### About the script

The script can be used for running trimmomatic automatically for N no.of samples regardless of the file extension. Please go through the email (though, it's a bit long!) to understand the functionalities, usage and reasons for failure.

- [x] This script is directly works with compressed/uncompressed fastq files exploiting the functionalities of trimmomatic.
- [x] Obviously, it will save a lot of time as trimming is one of the routine tasks and it ought to be automated.
- [x] It is robust and intuitive and errors while execution (if any) are self-explanatory as explained below.

#### Using the script:

Consider you have a directory with a mixture of fastq files with different file extensions

```
    |-- all_R1.fq
    |-- all_R1.fq.gz
    |-- all_R2.fq
    |-- all_R2.fq.gz
    |-- demo_R1.fq
    |-- demo_R2.fq
    |-- make_2_R1.fastq
    |-- make_2_R1.fastq.gz
    |-- make_2_R2.fastq
    |-- make_2_R2.fastq.gz
```

- Example (1):  Running script only for `.fq.gz` files:
`$ sh auto_trimmomatic.sh *.fq.gz`

- Example (2):  Running script only for `.fq` files:
`$ sh auto_trimmomatic.sh *.fq`

- Example (3):  Running script only for `.fastq` files:
`$ sh auto_trimmomatic.sh *.fastq`

- Example (4):  Running script only for `.fastq.gz` files:
`$ sh auto_trimmomatic.sh *.fastq.gz`

- Example (5):  Running script only for all files in the directory:
`$ sh auto_trimmomatic.sh *`

#### Invoking help

`$ sh auto_trimmomatic.sh --help` OR

`$ sh auto_trimmomatic.sh -h`

#### Error handling

- No parameters passed to script
```
[mypc]$ sh auto_trimmomatic.sh 
Error: No parameter(s) provided
Usage: sh auto_trim [*.extension]
       extension: <fq> or <fastq> or <fq.gz> or <fastq.gz> or <*>
       example: sh auto_trim.sh *.fq.gz or sh auto_trim.sh *
 
Help:  sh auto_trimmomatic.sh -h or --help
```

- No files in the directory with user provided extension
```
[mypc]$ sh auto_trimmomatic.sh *.fq

FileNotFoundError: No such file with extension *.fq found!
Supported extensions are: <.fq> or <.fastq> or <.fq.gz> or <.fastq.gz>
```

