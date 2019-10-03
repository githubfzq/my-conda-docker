FROM continuumio/anaconda3
COPY . /home/docker_files
# config conda environments
RUN /opt/conda/bin/conda env update -f /home/docker_files/base_env.yml --prune \
	&& /opt/conda/bin/conda env create -f /home/docker_files/r_env.yml \
	&& /opt/conda/bin/conda env create -f /home/docker_files/web_env.yml &&\
	/opt/conda/bin/conda env create -f /home/docker_files/clamp_env.yml && cd ~ &&\
	mkdir .jupyter && cp /home/docker_files/jupyter_notebook_config.py .jupyter/
RUN \
# install dependencies
    cp /etc/apt/sources.list /etc/apt/sources.list_backup &&\
    cp /home/docker_files/sources.list /etc/apt/sources.list &&\
    apt-get update && apt-get install -y libxt6 lsb-release libgl1-mesa-glx g++ zlib1g-dev && \
# install matlab
    mkdir /media/matlab && \
    mount -o loop /home/docker_files/MATLAB_R2017b_Linux/R2017b_glnxa64.iso /media/matlab && \
    cd /media/matlab/ && ./install -inputFile /home/docker_files/installer_input.txt &&\
    cd /usr/local/matlab2017b/bin/ && \
    ./activate_matlab.sh -propertiesFile /home/docker_files/activate.ini &&\
    rm -rf /usr/local/matlab2017b/bin/glnxa64/libmwservices.so &&\
    cp /home/docker_files/MATLAB_R2017b_Linux/MATLABR2017b_Linux_Crack/libmwservices.so /usr/local/matlab2017b/bin/glnxa64/ &&\
    cp /home/docker_files/MATLAB_R2017b_Linux/MATLABR2017b_Linux_Crack/license_standalone.lic /usr/local/matlab2017b/licenses/ &&\
    umount -l /media/matlab/ && alias matlab='/usr/local/matlab2017b/bin/matlab' && cd ~ &&\
# install python-Matlab API
    cd /usr/local/matlab2017b/extern/engines/python/ &&\
    python setup.py install && cd ~
ENV PATH=/usr/local/matlab2017b/bin${PATH:+:${PATH}} LD_PRELOAD=/opt/conda/envs/clamp/lib/libstdc++.so.6
# alternative:cp /etc/bash.bashrc /etc/bash.bashrc_backup && cp /home/docker_files/bash.bashrc /etc/bash.bashrc