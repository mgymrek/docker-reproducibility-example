docker-reproducibility-example
==============================

Example of providing a docker container for reproducible analyses. This repository is intended to show how Docker can be used to easily reproduce figures, results, etc. from computational publications. The R scripts and data examples are taken or modified from [Transcriptome Sequencing from Diverse Human Populations Reveals Differentiated Regulatory Architecture]
(http://www.plosgenetics.org/article/info%3Adoi%2F10.1371%2Fjournal.pgen.1004353) (see below) and are not my original work. 

# Running the docker
```
docker run -p 49000:8787 -d mgymrek/docker-reproducibility-example
```

(You can replace 49000 with another open port if you want.) Navigate in your web browser to http://0.0.0.0:49000. This will open up rstudio. The username and password are both "guest". You can open files in the ```scripts/``` directory and run them to reproduce figures S7B and S1 from Martin et al.

# Running on a Mac
If you are running on a Mac, you should have already installed, initialized, and started boot2docker using the instructions [here](http://docs.docker.com/installation/mac/). Instructions are the same as above, except instead of using "0.0.0.0" as the IP address, run:
```
boot2docker ip
```
to get the IP, then navigate in the browser to ```$IP:49000```.

# Code
Note: posted R code is a modified version of the code posted by the authors of Martin et al: [Transcriptome Sequencing from Diverse Human Populations Reveals Differentiated Regulatory Architecture]
(http://www.plosgenetics.org/article/info%3Adoi%2F10.1371%2Fjournal.pgen.1004353). Original code can be found [here](http://gbsc-share.stanford.edu/HGDP_RNAseq/scripts/). Code is posted with submission from the original authors. Data files were copied from their site.

# Notes

* You might get an rstudio error "Error in plot.new() : figure margins too large" if the plot area is too small (e.g. if you're using a small screen or if you squished the plot area to be smaller). In that case, enlarge the plot area and run again.
* All the data required was provided in this docker. Ideally the data would be separate from the code in either another data container or mounted to a directory when you run docker. I didn't do that here because [this issue](https://github.com/docker/docker/issues/4023) doesn't allow mounting whole directories on OSX. If that is fixed I might update this.