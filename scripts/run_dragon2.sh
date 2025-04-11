#!/bin/bash
#SBATCH --job-name=run_fitness_test_tartarus
#SBATCH --time=01:00:00 # hh:mm:ss
#
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=5120 # 5GB
#SBATCH --partition=gpu
#SBATCH --gres="gpu:1"
#
#SBATCH --mail-user=hugo.talibart@ulb.be
#SBATCH --mail-type=ALL
#
#SBATCH --output=logs/output_fitness_%x.out

singularity exec tartarus_singularity.sif python /benchmark/scripts/fitness_test.py
singularity exec tartarus_singularity.sif python /benchmark/scripts/cuda_test.py
