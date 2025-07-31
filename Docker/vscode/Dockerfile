FROM codercom/code-server
# https://coder.com/docs/code-server/FAQ

USER root
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

USER coder
RUN python3 -m venv /home/coder/venv
RUN /home/coder/venv/bin/pip install numpy
RUN /home/coder/venv/bin/pip install pandas
RUN /home/coder/venv/bin/pip install dbt-core
RUN /home/coder/venv/bin/pip install dbt-duckdb
RUN /home/coder/venv/bin/pip install pandas
RUN /home/coder/venv/bin/pip install matplotlib

ENV PATH="/home/coder/venv/bin:$PATH"

COPY  --chown=coder:coder ./config.yaml /home/coder/.config/code-server/config.yaml
COPY  --chown=coder:coder ./settings.json /home/coder/.local/share/code-server/User/settings.json

RUN code-server --install-extension ms-python.python
RUN code-server --install-extension ms-toolsai.jupyter

# Code based on https://github.com/kjedrzejewski/podyplomowe_genai_public
# Well done Krzysztof!