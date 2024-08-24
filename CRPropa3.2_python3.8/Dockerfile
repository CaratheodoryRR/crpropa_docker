FROM ubuntu:20.04

# change it if you want (use lower case)
ENV USERNAME=caratheodory

# install sudo
RUN apt -yq update && apt -yq install sudo

# create and switch to a user
RUN echo "caratheodory ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --no-log-init --home-dir /home/$USERNAME --create-home --shell /bin/bash $USERNAME
RUN adduser $USERNAME sudo
USER $USERNAME
WORKDIR /home/$USERNAME

# To avoid interactive timezone settings
RUN sudo DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt -y install tzdata

# install packages
RUN sudo apt install -y python3 vim tree wget python3-tk && \
    sudo apt install -y build-essential git cmake gfortran python3-dev libfftw3-dev libpcre3 libpcre3-dev && \
    sudo apt install -y zlib1g-dev libmuparser-dev libhdf5-dev pkg-config libgoogle-perftools-dev libomp-dev libgsl-dev libopenmpi-dev && \
    sudo apt install -y python3-numpy python3-setuptools python-setuptools libhdf5-serial-dev libomp5 libcfitsio-dev lcov && \
    sudo apt install -y python3-pip sqlite3

RUN sudo ln -sfn /usr/bin/python3 /usr/bin/python
RUN sudo python -m pip install numpy==1.24.4 pandas matplotlib scipy astropy
RUN sudo apt update && sudo apt upgrade -y

ENV HOME="/home/${USERNAME}/"
ENV EXTLIBS="${HOME}/external-libraries"
RUN mkdir -p ${EXTLIBS}

# Install swig-4.2.1
COPY ./install_swig.sh ${EXTLIBS}
RUN ${EXTLIBS}/install_swig.sh
# Install quimby for MHD fields
COPY ./install_quimby.sh ${EXTLIBS}
RUN ${EXTLIBS}/install_quimby.sh
# Install CRPropa3.2 for python 3.8
COPY ./install_crpropa3.sh ${EXTLIBS}
RUN ${EXTLIBS}/install_crpropa3.sh
RUN git clone https://github.com/CRPropa/CRPropa3-data.git ${EXTLIBS}/CRPropa3-data

RUN echo "export CRPROPA_DATA=${HOME}/CRPropa3-data/" >> ${HOME}/.bashrc
RUN echo export PYTHONPATH='/usr/local/lib/python3/dist-packages/:$PYTHONPATH' >> ${HOME}/.bashrc

# COPY ./dolag_B_54-186Mpc_440b.raw ${HOME}/
# COPY ./dolag_mass_54-186Mpc_440bins.raw ${HOME}/

# Extras
# Custom bash commands
ENV CUSTOM_COMMANDS="${HOME}/.custom_bash_commands"
RUN sudo echo "#!/bin/bash" >> ${CUSTOM_COMMANDS}
RUN sudo echo source ${CUSTOM_COMMANDS} >> ${HOME}/.bashrc
# Creating a jupyter kernel
RUN sudo python -m pip install tqdm PyYAML pathlib pydataclasses && \
    sudo python -m pip install --upgrade pip ipython ipykernel jupyter && \
    sudo echo "alias ipython='sudo python -m IPython'" >> ${CUSTOM_COMMANDS} && \
    sudo echo "alias jupyter_nb='sudo jupyter notebook --allow-root --ip 0.0.0.0 --port 8888'" >> ${CUSTOM_COMMANDS} && \
    sudo ipython kernel install --name crpropa3-kernel --user
# supython command (to avoid permission-related problems)
RUN sudo echo "alias supython='sudo -E PYTHONPATH=\${PYTHONPATH} python'" >> ${CUSTOM_COMMANDS}
RUN . ${HOME}/.bashrc
