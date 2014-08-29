docker-reproducibility-example
==============================

Example of providing a docker container for reproducible analyses. This repository is intended to show how Docker can be used to easily reproduce figures, results, etc. from computational publications. The R scripts and data examples are taken or modified from [Transcriptome Sequencing from Diverse Human Populations Reveals Differentiated Regulatory Architecture]
(http://www.plosgenetics.org/article/info%3Adoi%2F10.1371%2Fjournal.pgen.1004353) (see below) and are not my original work. 

# Data
The data files required to run these scripts can be found at [http://docker-demo.melissagymrek.com/docker-example-data.tar.gz](http://docker-demo.melissagymrek.com/docker-example-data.tar.gz).

# Running the docker
```
docker run -p 49000:8787 -d mgymrek/docker-reproducibility-example
```

(You can replace 49000 with another open port if you want.) Navigate in your web browser to http://0.0.0.0:49000. This will open up rstudio. The username and password are both "guest". You can open files in the ```scripts/``` directory and run them to reproduce figures S7B and S1 from Martin et al.

# Code
Note: posted R code is a modified version of the code posted by the authors of Martin et al: [Transcriptome Sequencing from Diverse Human Populations Reveals Differentiated Regulatory Architecture]
(http://www.plosgenetics.org/article/info%3Adoi%2F10.1371%2Fjournal.pgen.1004353). Original code can be found [here](http://gbsc-share.stanford.edu/HGDP_RNAseq/scripts/). Code is posted with submission from the original authors. Data files were copied from their site.
