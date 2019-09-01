##### ################################################################
#####
#####  Nginx
#####  =====
#####
#####  Build
#####  -----
#####    docker build -t renshi/holy-water -f Dockerfile .
#####
#####  Run
#####  ---
#####    docker run renshi/holy-water /bin/bash
#####
##### ################################################################
FROM renshi/base

MAINTAINER Renshi <yanqirenshi@gmail.com>

###
### git clone
###
USER cl-user
WORKDIR /home/cl-user/prj

RUN git clone https://github.com/yanqirenshi/api.Gitlab.git
RUN git clone https://github.com/yanqirenshi/Holy-Water.git

###
### Create symbolic link of *.asd
###



###
### Database: PostgreSQL
###



###
### Stroborights
###



###
### Nginx
###
