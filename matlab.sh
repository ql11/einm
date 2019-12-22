#!/bin/bash
#SBATCH -p v4_256
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 32
#SBATCH -J long_20

export PATH=/public1/home/sc40009/QinLang/Matlab2018b_setup/install/bin:$PATH
export LANG="zh_CN.UTF-8"
matlab < Mainprogram.m > show.out
