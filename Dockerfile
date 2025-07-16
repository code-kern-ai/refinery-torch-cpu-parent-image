FROM registry.dev.kern.ai/code-kern-ai/refinery-parent-images:python-upgrade-common

COPY submodules/parent-images/requirements/torch-cpu-requirements.txt .

RUN apt-get update && apt-get install -y gcc --no-install-recommends

RUN pip3 install --no-cache-dir -r torch-cpu-requirements.txt