#!/bin/bash

get_repo_path()
{
	
        R=$1
	R2=$(echo $R|sed s@\/@_@g)
        echo android_$R2
}

do_update_fork()
{
	echo "Updating ... $1"
	cd ../$1
	REPO=$(get_repo_path $1)
	git remote add $2 $3/$REPO
	git fetch $2
	git merge $2/$4
	cd -
}

CURR_DIR=`readlink -f .`
SCRIPT_DIR=$(readlink -f $(dirname ${BASH_SOURCE[0]}))

cd $SCRIPT_DIR
#update forked repos
echo updating forked repos...
TEAM_HYDRA_URL="https://github.com/Team-Hydra"
BASE_BRANCH="cm-10.2"
TEAM_HYDRA_NAME="TeamHydra"

CM_URL="https://github.com/CyanogenMod"
CM_NAME="cm"


do_update_fork "device/htc/pyramid" $TEAM_HYDRA_NAME $TEAM_HYDRA_URL $BASE_BRANCH
do_update_fork "device/htc/msm8660-common" $TEAM_HYDRA_NAME $TEAM_HYDRA_URL $BASE_BRANCH
do_update_fork "hardware/qcom/gps-legacy" $TEAM_HYDRA_NAME $TEAM_HYDRA_URL $BASE_BRANCH
do_update_fork "hardware/qcom/gps" $CM_NAME $CM_URL $BASE_BRANCH

cd $CURR_DIR
echo Update complete....


