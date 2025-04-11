#!/bin/bash
#SBATCH --job-name=create_conda_tartarus
#SBATCH --chdir=/home/genouest/ulb_3bio_bioinfo/htalibart/
#SBATCH --output=/home/genouest/ulb_3bio_bioinfo/htalibart/logs/log_%x.out
#SBATCH --ntasks=1
#SBATCH --time=60:00
#SBATCH --mem-per-cpu=10000

. /local/env/envconda.sh

conda env remove -n tartarus -y
conda create -n tartarus -y
conda activate tartarus


# install torch and chembed
conda install -y python=3.12
conda install nvidia/label/cuda-12.1.0::cuda-toolkit -c nvidia/label/cuda-12.1.0 -y
pip install torch torchvision torchaudio
conda install lightning -c conda-forge -y
pip install selfies pandas scikit-learn pyarrow fastparquet tensorboard rdkit chembl_structure_pipeline
pip install /home/genouest/ulb_3bio_bioinfo/htalibart/chembed



# tartarus stuff
conda install -c conda-forge rdkit openbabel -y

conda install -c conda-forge xtb-python -y
conda install -c conda-forge xtb==6.3.3 -y
conda install -c conda-forge crest -y
export XTBHOME=$CONDA_PREFIX
source $CONDA_PREFIX/share/xtb/config_env.bash

ENV_VARS_FILE=${CONDA_PREFIX}/etc/conda/activate.d/env_vars.sh
echo "export XTBHOME=\$CONDA_PREFIX" >> $ENV_VARS_FILE
echo "source \$CONDA_PREFIX/share/xtb/config_env.bash" >> $ENV_VARS_FILE
echo -e "export MKL_NUM_THREADS=1\nexport OMP_NUM_THREADS=1,1\nexport OMP_STACKSIZE=4G\nulimit -s unlimited" >> $ENV_VARS_FILE

pip install --upgrade pip
pip install numpy
pip install pyscf morfeus-ml


# tartarus
pip install /home/genouest/ulb_3bio_bioinfo/htalibart/Tartarus

# test cuda
python /home/genouest/ulb_3bio_bioinfo/htalibart/tests/tests_cuda/test_cuda.py

# test fitness
/home/genouest/ulb_3bio_bioinfo/htalibart/Tartarus/scripts/fitness_test.py
