#!/bin/bash

set -e
eval "$(conda shell.bash hook)"
conda create -n tartarus -y
conda activate tartarus

conda install python=3.8 -y

# tartarus stuff
conda install -c pytorch pytorch -y
conda install -c conda-forge rdkit openbabel -y

conda install -c conda-forge xtb-python -y
conda install xtb==6.3.3 -y
conda install -c conda-forge crest -y
export XTBHOME=$CONDA_PREFIX
source $CONDA_PREFIX/share/xtb/config_env.bash

ENV_VARS_FILE=${CONDA_PREFIX}/etc/conda/activate.d/env_vars.sh
echo "export XTBHOME=\$CONDA_PREFIX" >> $ENV_VARS_FILE
echo "source \$CONDA_PREFIX/share/xtb/config_env.bash" >> $ENV_VARS_FILE

pip install --upgrade pip
pip install numpy
pip install pyscf morfeus-ml


# chembed stuff
conda install lightning -c conda-forge -y
pip install selfies pandas scikit-learn pyarrow fastparquet rdkit chembl_structure_pipeline
cd /home/hugo/chembed
pip install .
cd -

pip install .
