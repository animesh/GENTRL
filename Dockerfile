#Instruction from https://apps.sigma2.no/docs/custom-docker-image.html
#Image name from https://github.com/Uninett/helm-charts/blob/master/repos/stable/deep-learning-tools/values.yaml
FROM quay.io/uninett/deep-learning-tools:20190821-df15ac1
# Install system packages
USER root
RUN apt-get update && apt-get install -y apt-utils vim psmisc openssh-server git-core libpython-dev libblocksruntime-dev python3-pip parallel libomp-dev libopenblas-base libsndfile1 libxrender1 libxext6 libgl1-mesa-glx libegl1-mesa libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
RUN conda update -n base conda
RUN conda install -c conda-forge rdkit --yes
RUN pip install sklearn molsets ipyvolume
RUN jupyter nbextension enable --py --sys-prefix ipyvolume
RUN jupyter lab build
# install DNN-RL for MD from github
# RUN pip install git+https://github.com/animesh/GENTRL.git
# cleanup
RUN apt-get  -y autoremove
RUN apt-get  -y clean
#git clone https://github.com/insilicomedicine/GENTRL.git
#cp -rf GENTRL/examples/* GENTRL-ani/examples/.
#cd GENTRL
#python setup.py install --user
#rm -rf $HOME/.local/lib/python3.7/site-packages/torch*
#docker run -it --privileged <docker-id> /bin/bash
