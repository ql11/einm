#!/usr/bin/env bash
# created by paracloud @Thu Nov 21 14:36:48 CST 2019

#SBATCH --chdir=/public1/home/sc40009/jobs/20191121/output
#SBATCH --error=slurm-%j.out
#SBATCH --output=slurm-%j.out
#SBATCH --partition=v4_256
#SBATCH --ntasks=12
#SBATCH --job-name=20191121
#SBATCH --time=0
#SBATCH --nodes=1
#SBATCH --requeue
SLURM_USER=sc40009
.  ../env.sh

start_time=`date +%s`

function timestamp {
    date "+%y-%m-%d %H:%M:%S"
}

function elapse_time {
    date +%s --date="$start_time seconds ago"
}

function job_id {

   /usr/bin/squeue  -w $(hostname) |grep $(hostname) |  tr -s ' ' | cut -d ' ' -f2
}

#generate host file
first_node=$(scontrol show hostname | head -n 1 )
hostfile_dir=$HOME/hostlist
hostfile=$HOME/hostlist/hostlist.${first_node}.txt
mkdir -p ${hostfile_dir}
sinfo -h --format="%n:%c"  -n $SLURM_JOB_NODELIST  > ${hostfile}

export PATH=/public1/soft/vnc/bin:/public4/soft/vnc/bin:$PATH
vnc_conf=~/.vnc_conf/$RANDOM
mkdir -p $vnc_conf
export XDG_RUNTIME_DIR=$vnc_conf
#export XDG_RUNTIME_DIR=~
timeout=0
#pw=$(echo -n $USER  |md5sum | awk '{print $1}')
DISPLAY=:100
x_config_file=/public1/soft/vnc/etc/xorg.conf
rfb_port=5900
xdummy_path=`which Xdummy`
vnc_geometry='1280x720'

# clean *.lock files
find /tmp -maxdepth 1 -name ".X[0-9][0-9][0-9]-lock" | xargs /bin/rm -fr
rm  -rf /tmp/.X11-unix
max_number=`find /tmp -maxdepth 1 -name ".X[0-9][0-9][0-9]-lock" | sort -n  |tail -n 1 |grep -o "[0-9]\+"`
if [[ $max_number ]] ; then
    DISPLAY=":$((max_number+1))"
fi

# preventing gnome3’s initial setup
mkdir -p ~/.config
echo "yes" >> ~/.config/gnome-initial-setup-done


#Xdummy $DISPLAY  >xdummy.log  2>&1 &
#while [ -z `pgrep -f "Xorg.*\.bin.*${DISPLAY}"` ]
#do
#    sleep 5
#    Xdummy $DISPLAY  >>xdummy.log  2>&1 &
#done 

export DISPLAY=$DISPLAY
pw=$(echo -n $USER  |md5sum | awk '{print $1}')
#pw=paratera@2018
echo -e "${pw}\n${pw}" | vncpasswd
vncserver ${DISPLAY}



#disable power saving blank screen and screen saver
gsettings set org.gnome.settings-daemon.plugins.power sleep-display-ac 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-display-battery 0
gsettings set org.gnome.desktop.session idle-delay 0



# start gnome-shell
#gnome-shell --mode=classic -r >/dev/null 2>&1 &

# change X Window to http
#x11vnc -display $DISPLAY   -nonc  -passwd $pw  -shared -forever  -listen 0.0.0.0  -rfbport ${rfb_port}  > x11vnc.log 2>&1 &
n=0
until [ $n -ge 3 ]
do
    x11vnc -display $DISPLAY  -nomodtweak -nonc  -passwd  $pw  -shared -forever  -listen 0.0.0.0  -rfbport ${rfb_port}  > x11vnc.log 2>&1 &

    if [ -z `pgrep -x "x11vnc" ` ]; then       
        n=$[$n+1]   
        sleep 3
    else
        break
    fi
done



#ssh localhost "export DISPLAY=$DISPLAY ;gnome-session --session gnome-classic||true"
#gnome-session >/dev/null 2>&1 &
#n=0
#until [ $n -ge 3 ]
#do
#    export DISPLAY=$DISPLAY ; gnome-session  --session gnome-classic >/dev/null 2>&1 &
#    sleep 2
#    if [ -z `pgrep -af "gnome-session" ` ]; then       
#        n=$[$n+1]   
#    else
#        break
#    fi
#done





vncpid=`pgrep -s 0 x11vnc`
idle_counter=0
while ! [ -z `pgrep -x "x11vnc" ` ]
do
  client_count=`x11vnc -display $DISPLAY -query client_count |grep -oP 'aro=client_count:\K.*'`
  if [ "$client_count" = "0" ]; then
      idle_counter=$((idle_counter+5))
  else
      idle_counter=0
  fi

  echo "$(timestamp) $(job_id) $(hostname) $(elapse_time) $idle_counter"
  sleep 5;

  if [ "$timeout" -eq "0" ]; then
    # run forever
    true
  else
    # idle timeout, exit vncserver
    if [ "$idle_counter" -gt "$timeout" ]; then
        killall x11vnc
    fi
  fi
done

# print the last line
if [ "$idle_counter" -gt "$timeout" ]; then
   echo "$(timestamp) $(job_id) $(hostname) $(elapse_time) $idle_counter"
fi

