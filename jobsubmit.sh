#!/bin/bash
appname=VNCView
workdir=/public1/home/sc40009/jobs/20191121
result="`sbatch ${workdir}/${appname}.sh`"
id="`echo $result|grep -o '[0-9]\+' | head -1`"
echo "jobid=$id"
