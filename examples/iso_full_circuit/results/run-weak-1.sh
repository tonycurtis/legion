#!/bin/tcsh
#cudatoolkit/7.5   3) gcc/4.8.2         4) openmpi/1.6.5

module load gcc/4.8.2 
module load openmpi/1.6.5 
module load cudatoolkit/7.5
module list 
limit
mkdir /lustre/scratch1/yellow/gshipman/legion-asplos/${SLURM_JOB_ID}
cd /lustre/scratch1/yellow/gshipman/legion-asplos/${SLURM_JOB_ID}
cp ../ckt_sim . 
date 
setenv GASNET_USE_XRC 0
setenv OMPI_MCA_mpi_paffinity_alone 0 
setenv OMPI_MCA_rmaps_base_loadbalance 1
setenv OMPI_MCA_btl "tcp,self"
setenv OMPI_MCA_mpi_warn_on_fork 0
setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:${HOME}/local/lib 
setenv GASNET_BACKTRACE 1  

#  537497856 2 nodes 
# 1003622400 4 nodes 
# 2001309696 8 nodes 
# 3006548224 12 nodes 
# 4059218944 16 nodes 
# 8117289216 32 nodes 

echo ${SLURM_JOB_ID}
#${HOME}/local/bin/gasnetrun_ibv -n 2  ./ckt_sim -npp 500000 -wpp 1000000 -p 4 -l 5 -pct 20 -ll:cpu 5 -ll:zsize 8192 -ll:fsize 4192 -ll:gpu 1 -ll:dma 5 -ll:ahandlers 10 -ll:rsize 8192

echo "running 2 nodes" 
${HOME}/local/bin/gasnetrun_ibv -n 2  ./ckt_sim -npp 250000 -wpp 500000 -p 2 -l 20  -ll:cpu 5 -ll:zsize 4192 -ll:fsize 4192 -ll:gpu 1 -ll:dma 5 -ll:ahandlers 5 -ll:rsize 1920 -ll:gsize 0
echo "running 4 nodes"  
${HOME}/local/bin/gasnetrun_ibv -n 4  ./ckt_sim -npp 250000 -wpp 500000 -p 4 -l 20  -ll:cpu 5 -ll:zsize 4192 -ll:fsize 4192 -ll:gpu 1 -ll:dma 5 -ll:ahandlers 5 -ll:rsize 1920  -ll:gsize 0 
echo "running 8 nodes" 
${HOME}/local/bin/gasnetrun_ibv -n 8  ./ckt_sim -npp 250000 -wpp 500000 -p 8 -l 20  -ll:cpu 5 -ll:zsize 4192 -ll:fsize 4192 -ll:gpu 1 -ll:dma 5 -ll:ahandlers 5 -ll:rsize 1920 -ll:gsize 0 
echo "running 16 nodes" 
${HOME}/local/bin/gasnetrun_ibv -n 16  ./ckt_sim -npp 250000 -wpp 500000 -p 16 -l 20  -ll:cpu 5 -ll:zsize 4192 -ll:fsize 4192 -ll:gpu 1 -ll:dma 5 -ll:ahandlers 5 -ll:rsize 1920 -ll:gsize 0 
echo "running 32 nodes" 
${HOME}/local/bin/gasnetrun_ibv -n 32  ./ckt_sim -npp 250000 -wpp 500000 -p 32 -l 20  -ll:cpu 5 -ll:zsize 4192 -ll:fsize 4192 -ll:gpu 1 -ll:dma 5 -ll:ahandlers 5 -ll:rsize 1920 -ll:gsize 0 



#${HOME}/local/bin/gasnetrun_ibv -n 4  ./tester_io -ll:cpu 4 -ll:dma 3 -ll:csize 20480 -n 1003622400 -s 256 -r 2 
#${HOME}/local/bin/gasnetrun_ibv -n 8  ./tester_io -ll:cpu 4 -ll:dma 3 -ll:csize 20480 -n 2001309696 -s 256 -r 2 
#${HOME}/local/bin/gasnetrun_ibv -n 12  ./tester_io -ll:cpu 4 -ll:dma 3 -ll:csize 20480 -n 3006548224 -s 256 -r 2 
#${HOME}/local/bin/gasnetrun_ibv -n 16  ./tester_io -ll:cpu 4 -ll:dma 3 -ll:csize 20480 -n 4059218944 -s 256 -r 2 
#${HOME}/local/bin/gasnetrun_ibv -n 32  ./tester_io -ll:cpu 4 -ll:dma 3 -ll:csize 20480 -n 8117289216 -s 256 -r 2 

#-n 4294836225 -s 225 -r 2 -ll:cpu 12  -ll:rsize 1024 -ll:ahandlers 3  -ll:dma 4 -ll:csize 20480
