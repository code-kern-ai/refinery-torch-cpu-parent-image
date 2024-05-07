FROM registry.dev.kern.ai/code-kern-ai/refinery-parent-images:dev-common-arm64

COPY submodules/parent-images/requirements/torch-cpu-requirements.txt .

RUN pip3 install --no-cache-dir -r torch-cpu-requirements.txt