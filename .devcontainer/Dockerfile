FROM ubuntu:22.04

# Customize bash prompt
RUN mv /etc/skel/.bashrc /etc/skel/.bashrc.original
ADD --chmod=644 bash-profile.sh /etc/skel/.bashrc

# Install Dependencies
RUN apt-get update && apt-get install -y curl git nano sudo python3 pip
RUN python3 -m pip install jupyterlab ipykernel matplotlib ipywidgets

# Adding a non-root user to prevent files that mounted from host
# into the container from being created as root.
#   See: https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user
ARG USER
ARG UID=1000
RUN groupadd -g ${UID} ${USER} \
    && useradd -m -g ${USER} -g sudo -u ${UID} ${USER} \
    && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER

# Perform following commands as ${USER}
USER ${USER}
ENV USER=${USER}
WORKDIR /home/${USER}

# Install Mojo
COPY .env /home/${USER}/.env
RUN . /home/${USER}/.env \
    && rm /home/${USER}/.env \
    && curl https://get.modular.com \
          | MODULAR_AUTH=$MODULAR_AUTH sh -
ENV MODULAR_HOME="/home/${USER}/.modular"
ENV PATH="/home/${USER}/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

RUN modular install mojo

# The directory /home/${USER}/.vscode-server is mounted to an anonymous volume so that
# extension/dotfiles are reinstalled on rebuild.
# By create this directory here we make sure ${USER} can access it.
RUN mkdir /home/${USER}/.vscode-server
