FROM rocker/rstudio

RUN apt update && apt -y upgrade \
&& apt -y install build-essential wget curl \
  git \
  libopenblas-dev \
  libopencv-dev \
  python-dev \
  python-numpy \
  python-setuptools \
  wget

# Clone MXNet repo and move into it 
RUN cd /root && git clone --recursive https://github.com/dmlc/mxnet && cd mxnet && \
# Copy config.mk
cp make/config.mk config.mk && \
# Set OpenBLAS 
sed -i 's/USE_BLAS = atlas/USE_BLAS = openblas/g' config.mk && \
# Make 
make -j"$(nproc)" 

# Install Python package 
RUN cd /root/mxnet/python && python setup.py install

# Install R package
RUN cd /root/mxnet/setup-utils/ && chmod +x install-mxnet* && ./install-mxnet-ubuntu-r.sh


EXPOSE 8787
VOLUME /home/rstudio

CMD /init

