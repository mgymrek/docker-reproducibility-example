FROM mgymrek/docker-rstudio-server
MAINTAINER Melissa Gymrek <mgymrek@mit.edu>
RUN apt-get -qqy install supervisor
RUN mkdir -p /home/guest/scripts
RUN Rscript -e 'install.packages(c("ops","gplots"), repos="http://cran.rstudio.com/")'
ADD martin_etal_figS1.R /home/guest/scripts/martin_etal_figS1.R
ADD martin_etal_figS7B.R /home/guest/scripts/martin_etal_figS7B.R
RUN chown -R guest:guest /home/guest
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]