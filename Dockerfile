FROM mgymrek/docker-rstudio-server
MAINTAINER Melissa Gymrek <mgymrek@mit.edu>
RUN mkdir -p /scripts
RUN ln -s /scripts /home/guest/scripts
RUN Rscript -e 'install.packages(c("ops","gplots"), repos="http://cran.rstudio.com/")'
ADD martin_etal_figS1.R /scripts/martin_etal_figS1.R
ADD martin_etal_figS7B.R /scripts/martin_etal_figS7B.R
