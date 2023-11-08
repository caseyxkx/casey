#!/bin/bash

#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 1               # Total # of nodes 
#SBATCH -n 17              # Total # of mpi tasks (17 * nnodes)
#SBATCH -t 02:00:00        # Run time (hh:mm:ss)

#SBATCH -J t1.g60a.g61p.mini	             # Job name
#SBATCH -o log/slurm-00000.out       # Name of stdout output file
export jobstep='00000'
#export prev_jobstep='00000'

#module load intel/16.0.3 impi namd/2.12

# Set environmental variables
export basename='t1'
export nsteps='10000'
export temp='310'

export basedir='output'
#export rstname=$basedir'/'$prev_jobstep'/'$prev_jobstep'.restart'
export rundir=$basedir'/'$jobstep
export output=$rundir'/'$jobstep

export firstjob='yes'

# Set up directories
mkdir -p $rundir

# Store the output trajectory file names
echo $PWD'/'$output'.dcd' >> $basedir'/run.stk'

# Run NAMD
#ibrun namd2 mini.conf +ppn 4 +pemap 0-51 +commap 52-67 > $basename'-'$jobstep'.log'
namd2 +p5 mini.conf > $basename'-'$jobstep'.log'
