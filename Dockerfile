FROM mgymrek/docker-rstudio-server
MAINTAINER Melissa Gymrek <mgymrek@mit.edu>
RUN (adduser --disabled-password --gecos "" ruser && echo "ruser:ruser"|chpasswd)
RUN mkdir -p /home/ruser/scripts
RUN Rscript -e 'install.packages(c("ops","gplots"), repos="http://cran.rstudio.com/")'
ADD martin_etal_figS1.R /home/ruser/scripts/martin_etal_figS1.R
ADD martin_etal_figS7B.R /home/ruser/scripts/martin_etal_figS7B.R
