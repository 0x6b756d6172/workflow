#currently using older base: https://hub.docker.com/r/pytorch/pytorch/
#alternatively, build from cuda/conda base: https://github.com/pytorch/pytorch/blob/master/docker/pytorch/Dockerfile
FROM pytorch/pytorch

#sudo for vscode + jupyter, python-opengl for opencv
RUN apt update && apt install sudo python-opengl -y 

#install latest, update
RUN conda install conda
RUN conda update --all

#pytorch: https://pytorch.org/get-started/locally/
RUN conda install pytorch torchvision cudatoolkit=10.0 -c pytorch

#fastai: https://github.com/fastai/fastai/blob/master/README.md#installation
RUN conda install -c fastai fastai

#jupyter: https://jupyterlab.readthedocs.io/en/stable/getting_started/installation.html
#fastai/extensions: https://docs.fast.ai/install.html
RUN conda install -c conda-forge jupyterlab
RUN conda install -c conda-forge jupyter_contrib_nbextensions

#tensorboard
RUN conda install -c conda-forge tensorboard
RUN pip install future
RUN pip install ipywidgets

#opencv, do last conda install due to number of packages
RUN conda install -c conda-forge opencv=4.1.1

#pillow-simd: https://docs.fast.ai/performance.html#faster-image-processing
#currently disabled due to version mismatch - Core version: 6.0.0.post0, Pillow version: 6.1.0
#RUN conda uninstall -y --force pillow pil jpeg libtiff libjpeg-turbo
#RUN pip uninstall -y pillow pil jpeg libtiff libjpeg-turbo
#RUN conda install -yc conda-forge libjpeg-turbo
#RUN CFLAGS="${CFLAGS} -mavx2" pip install --upgrade --no-cache-dir --force-reinstall --no-binary :all: --compile pillow-simd
#RUN conda install -y jpeg libtiff

#add non root user
#https://code.visualstudio.com/docs/remote/containers-advanced#_adding-a-nonroot-user-to-your-dev-container
ARG USERNAME=fastai
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

#add user to video group for opencv webcam access
RUN usermod -a -G video $USERNAME

#switch to non root user
USER $USERNAME
ENV HOME /home/$USERNAME
