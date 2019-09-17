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
#####    docker run -it renshi/holy-water /bin/bash
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
RUN git clone https://github.com/yanqirenshi/Ghost.git

###
### ln
###
RUN ln -fs /home/cl-user/prj/api.Gitlab/api.gitlab.asd      /home/cl-user/.asdf/api.gitlab.asd
RUN ln -fs /home/cl-user/prj/api.Gitlab/api.gitlab-test.asd /home/cl-user/.asdf/api.gitlab-test.asd

RUN ln -fs /home/cl-user/prj/Holy-Water/core/holy-water.asd      /home/cl-user/.asdf/holy-water.asd
RUN ln -fs /home/cl-user/prj/Holy-Water/core/holy-water-test.asd /home/cl-user/.asdf/holy-water-test.asd

RUN ln -fs /home/cl-user/prj/Holy-Water/api/holy-water.api.asd      /home/cl-user/.asdf/holy-water.api.asd
RUN ln -fs /home/cl-user/prj/Holy-Water/api/holy-water.api-test.asd /home/cl-user/.asdf/holy-water.api-test.asd

RUN ln -fs /home/cl-user/prj/Ghost/graph/ghost.graph-test.asd /home/cl-user/.asdf/ghost.graph-test.asd
RUN ln -fs /home/cl-user/prj/Ghost/graph/ghost.graph.asd      /home/cl-user/.asdf/ghost.graph.asd
RUN ln -fs /home/cl-user/prj/Ghost/api/ghost.api-test.asd     /home/cl-user/.asdf/ghost.api-test.asd
RUN ln -fs /home/cl-user/prj/Ghost/api/ghost.api.asd          /home/cl-user/.asdf/ghost.api.asd

RUN ln -fs /home/cl-user/prj/Ghost/core/ghost.asd             /home/cl-user/.asdf/ghost.asd
RUN ln -fs /home/cl-user/prj/Ghost/core/ghost-test.asd        /home/cl-user/.asdf/ghost-test.asd


###
### git clone
###
RUN echo '(ql:quickload :holy-water)'     >> /home/cl-user/.roswell/init.lisp
RUN echo '(ql:quickload :holy-water.api)' >> /home/cl-user/.roswell/init.lisp
 
# RUN echo '(setf hw:*db-name* "holy_water")' >> /home/cl-user/.roswell/init.lisp
# RUN echo '(setf hw:*db-user* "holy_water")' >> /home/cl-user/.roswell/init.lisp
# RUN echo '(setf hw:*db-user-password* nil)' >> /home/cl-user/.roswell/init.lisp
 
# RUN echo '(hw::connect-db)' >> /home/cl-user/.roswell/init.lisp
