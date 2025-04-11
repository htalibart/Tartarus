#!/bin/bash
#SBATCH --job-name=run_fitness_test_tartarus
#SBATCH --time=01:00:00 # hh:mm:ss
#
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=5120 # 5GB
#SBATCH --partition=gpu
#SBATCH --gres=gpu:v100:0
#
#SBATCH --mail-user=hugo.talibart@ulb.be
#SBATCH --mail-type=ALL
#
#SBATCH --output=logs/output_fitness_%x.out


module load CUDA/12.1.1
module load cuDNN/8.9.2.26-CUDA-12.1.1

main_dir=/CECI/home/users/h/t/htalibar/Tartarus

singularity exec ${main_dir}/tartarus_singularity.sif python /benchmark/scripts/fitness_test.py
singularity exec ${main_dir}/tartarus_singularity.sif python /benchmark/scripts/cuda_test.py

#python /CECI/home/users/h/t/htalibar/Tartarus/scripts/cuda_test.py 
