FROM trestletech/plumber
MAINTAINER Docker User <docker@user.org>
RUN apt-get -y install unixodbc unixodbc-dev
#RUN apt-get -y install curl
#RUN apt-get -y install gnupg2
#RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
#RUN curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list
#RUN apt-get update
#RUN ACCEPT_EULA=Y apt-get -y install msodbcsql17
RUN R -e "install.packages('RODBC')"
RUN R -e "install.packages('jsonlite')"
RUN R -e "install.packages('RCurl')"
COPY DaveQCTest_0.1.0.tar.gz /usr/DaveQCTest_0.1.0.tar.gz
RUN R -e "install.packages('/usr/DaveQCTest_0.1.0.tar.gz', repos = NULL)"
RUN mkdir /app
COPY DataQC.R /app/
CMD ["/app/DataQC.R"] 
# docker build -t mi/dataqc:test .
# docker run -d -p 8001:8000 mi/dataqc:test