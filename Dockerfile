FROM continuumio/anaconda3
COPY . /home/python
RUN /opt/conda/bin/conda env update -f /home/python/base_env.yml --prune \
	&& /opt/conda/bin/conda env create -f /home/python/r_env.yml \
	&& /opt/conda/bin/conda env create -f /home/python/web_env.yml
RUN /opt/conda/bin/conda env create -f /home/python/clamp_env.yml