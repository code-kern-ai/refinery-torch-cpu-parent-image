FROM kernai/refinery-parent-images:v1.7.0-common

COPY submodules/parent-images/requirements/torch-cpu-requirements.txt .

RUN pip3 install --no-cache-dir -r torch-cpu-requirements.txt