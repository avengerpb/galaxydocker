#Base Image
FROM ubuntu:14.04
RUN apt-get update

#Install Python and dependencies
RUN apt-get install -y python python-pip 
RUN apt-get install -y python-dev
RUN apt-get install -y zlib1g-dev
RUN pip install --upgrade pip
COPY requirements.txt /usr/local
RUN pip install -r /usr/local/requirements.txt

# Install PostgreSQL and dependencies
RUN apt-get install postgresql -y
RUN apt-get install git -y
RUN apt-get install mercurial -y

#Enviroment
ENV HOME=/home
ENV GALAXY_FOLDER=$HOME/galaxy
ENV PATH=$GALAXY_PATH:$PATH

#Copy Galaxy File
WORKDIR $HOME
#Clone and install galaxy
RUN git clone https://github.com/galaxyproject/galaxy/


COPY galaxy/galaxy.ini $GALAXY_FOLDER/config/galaxy.ini

WORKDIR $GALAXY_FOLDER
RUN git checkout -b master origin/master

WORKDIR $GALAXY_FOLDER

EXPOSE 8080

#RUN
WORKDIR /usr/local/galaxy
CMD ["./run.sh"]

