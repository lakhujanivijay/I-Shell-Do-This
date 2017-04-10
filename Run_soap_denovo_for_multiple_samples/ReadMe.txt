This shell scripts automatically identifies paired end data (R1 and R2) in the current directory and runs
soap -donovo for all of them one by one for all the k-mers provided by the user.

The config file is also generated for all the samples automatically.

SOAPdenovo has 2 modules - SOAPdenovo-63mer & SOAPdenovo-127mer. The script has been designed to choose the
appropriate model based on the kmer i.e. for all the k-mers less than or equal to 63, SOAPdenovo-63mer is used and for k-mers greater than 63, SOAPdenovo-127mer
is used.

