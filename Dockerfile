FROM python:3.10-slim

COPY requirements.txt /
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache-dir -r /requirements.txt && \
    rm -rf /requirements.txt

ARG NB_USER=softbutterfly
ARG NB_UID=1000
ARG NB_GID=1000

ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

COPY --chown=${NB_UID}:${NB_GID} ./notebooks/ ${HOME}/notebooks/
COPY --chown=${NB_UID}:${NB_GID} ./assets/ ${HOME}/assets/
