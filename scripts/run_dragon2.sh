#!/bin/bash
#SBATCH --job-name=run_fitness_test_tartarus
#SBATCH --time=01:00:00 # hh:mm:ss
#
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=5120 # 5GB
#SBATCH --partition=batch,long
#
#SBATCH --mail-user=hugo.talibart@ulb.be
#SBATCH --mail-type=ALL
#
#SBATCH --output=logs/output_fitness.out

singularity exec tartarus_singularity.sif python /benchmark/fitness_test.py
singularity exec tartarus_singularity.sif python /benchmark/cuda_test.py
