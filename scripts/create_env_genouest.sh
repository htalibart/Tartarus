#!/bin/bash
#SBATCH --job-name=create_conda_tartarus
#SBATCH --chdir=/home/genouest/ulb_3bio_bioinfo/htalibart/
#SBATCH --output=/home/genouest/ulb_3bio_bioinfo/htalibart/logs/create_conda_tartarus.out
#SBATCH --ntasks=1
#SBATCH --time=60:00
#SBATCH --mem-per-cpu=10000

. /local/env/envconda.sh

#eval "$(conda shell.bash hook)"
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
echo -e "export MKL_NUM_THREADS=1\nexport OMP_NUM_THREADS=1,1\nexport OMP_STACKSIZE=4G\nulimit -s unlimited" >> $ENV_VARS_FILE

pip install --upgrade pip
pip install numpy
pip install pyscf morfeus-ml


# chembed stuff
conda install lightning -c conda-forge -y
pip install selfies pandas scikit-learn pyarrow fastparquet rdkit chembl_structure_pipeline
pip install /home/genouest/ulb_3bio_bioinfo/htalibart/chembed

# tartarus
pip install /home/genouest/ulb_3bio_bioinfo/htalibart/Tartarus
