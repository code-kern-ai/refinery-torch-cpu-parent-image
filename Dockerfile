FROM dhi.io/python:3.11.11-debian12-dev AS builder

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV VENV_PATH=/opt/venv
ENV PATH="${VENV_PATH}/bin:${PATH}"

RUN python -m venv "${VENV_PATH}"

COPY submodules/parent-images/requirements/torch-cpu-requirements.txt .

RUN pip install --no-cache-dir -r torch-cpu-requirements.txt

FROM dhi.io/python:3.11.11-debian12

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV VENV_PATH=/opt/venv
ENV PATH="${VENV_PATH}/bin:${PATH}"

COPY --from=builder --chown=65532:65532 ${VENV_PATH} ${VENV_PATH}

RUN ["/opt/venv/bin/python", "-c", "import torch; model = torch.nn.Linear(2, 1); model(torch.ones(1, 2))"]

USER 65532:65532
