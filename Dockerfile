# FEniCS (legacy dolfin) + Jupyter for the continuum materials modelling lab
#
# Build:  docker build -t matmod-continuum .
# Run:    docker run -p 8888:8888 -v "$(pwd)":/work matmod-continuum
# Open:   http://localhost:8888  (no password)
#
# The quay.io/fenicsproject images are no longer maintained.
# conda-forge still ships the legacy dolfin-based FEniCS, keeping
# "from dolfin import *" working without any notebook changes.

FROM condaforge/mambaforge:latest

# Install legacy FEniCS and Jupyter in the base conda environment
RUN mamba install -y -c conda-forge \
        fenics \
        notebook \
        jupyter \
        matplotlib \
        scipy \
        ipywidgets \
    && mamba clean --all -y

# Jupyter: no token, bind to all interfaces
RUN jupyter notebook --generate-config && \
    echo "c.NotebookApp.token = ''"           >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.password = ''"        >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.ip = '0.0.0.0'"       >> /root/.jupyter/jupyter_notebook_config.py

WORKDIR /work

EXPOSE 8888

CMD ["jupyter", "notebook", "--allow-root"]
