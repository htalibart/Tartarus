#!/bin/bash
#SBATCH --job-name=install_tartarus
#SBATCH --time=01:00:00 # hh:mm:ss
#
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=5120 # 5GB
#SBATCH --partition=batch
#
#SBATCH --mail-user=hugo.talibart@ulb.be
#SBATCH --mail-type=ALL
#
#SBATCH --output=/home/users/h/t/htalibar/logs/log_%x_%j.out


set -e


soft_dir=/CECI/home/ulb/3bio/htalibar/soft

cd ${soft_dir}

module load Python/3.11.3-GCCcore-12.3.0
module load CUDA/12.1.1
module load cuDNN/8.9.2.26-CUDA-12.1.1

pip install virtualenv

venv_dir=/CECI/home/ulb/3bio/htalibar/venv
venv_name=tartarus_env

virtualenv --system-site-packages ${venv_dir}/${venv_name}
source ${venv_dir}/${venv_name}/bin/activate

pip install torch torchvision torchaudio
pip install lightning
pip install rdkit

# install openbabel
obabel_install_dir=${soft_dir}/obabel
git clone https://github.com/openbabel/openbabel
cd openbabel
cmake ../openbabel-2.3.2 -DCMAKE_INSTALL_PREFIX=${obabel_install_dir} -DPYTHON_BINDINGS=ON
make && make install
pip install openbabel==3.1.1.1


# additional packages
pip install numpy
pip install pyscf morfeus-ml
pip install h5py scikit-learn geometric pyberny loguru wurlitzer sqlalchemy
pip install -i https://test.pypi.org/simple/ geodesic-interpolate
pip install git+https://github.com/kjelljorner/polanyi


# install chembed
pip install selfies pandas scikit-learn pyarrow fastparquet rdkit chembl_structure_pipeline
pip install /home/users/h/t/htalibar/chembed



# xtb
git clone https://github.com/grimme-lab/xtb-python
pip install cffi numpy meson ninja
meson setup build --prefix=$HOME/.local
ninja -C build install

#TODO environment variables
