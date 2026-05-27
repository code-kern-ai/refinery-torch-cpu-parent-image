FROM dhi.io/python:3.11.11-debian12-dev@sha256:b9d90132fcace9841f22dd366d0732c03d62bb6bf4e4384a9a1b2d1c2aa73723 AS builder

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV VENV_PATH=/opt/venv
ENV PATH="${VENV_PATH}/bin:${PATH}"

RUN python -m venv "${VENV_PATH}"

COPY submodules/parent-images/requirements/torch-cpu-requirements.txt .

RUN pip install --no-cache-dir -r torch-cpu-requirements.txt

FROM dhi.io/python:3.11.11-debian12@sha256:ec7c44322e121c4052801511d91c1b489becec77474293f255167d836ee9f488

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV VENV_PATH=/opt/venv
ENV PATH="${VENV_PATH}/bin:${PATH}"

COPY --from=builder --chown=65532:65532 ${VENV_PATH} ${VENV_PATH}

RUN python -c "import torch; model = torch.nn.Linear(2, 1); model(torch.ones(1, 2))"

USER 65532:65532
