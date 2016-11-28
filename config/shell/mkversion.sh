#!/bin/bash
export SVN_VERSION
#function getsvnver()

#SRCROOT=$1
SVN_BIN=`which svn`
if [ "${SVN_BIN}" != "" ]; then
   #SVN_VERSION=`svn info ${SRCROOT} | awk -F ':' '{ if($1 ~ /^Revision$/)
   #{print $2} }' | tr -d " " `
   #SVN_VERSION=`svn list -v ${SRCROOT} | awk '{printf $1"\n"}' | head -1 \
   #| tr -d " " `
   SVN_VERSION=`svn list -v . | awk '{printf $1"\n"}' | head -1 \
       | tr -d " " `
fi
echo ${SVN_VERSION}

export VER_CP_PATH=/mnt/hgfs/ver/IPC/
export PRODUCT_TYPE=QV-IPC-$1
export PACKSHOP_DATE=$(date '+%Y%m%d')
export PACKSHOP_PRODUCT_NAME=${PRODUCT_TYPE}_ZX_V2.10.6.R${SVN_VERSION}.${PACKSHOP_DATE}* 
echo ${PACKSHOP_PRODUCT_NAME}

function printHelp()
{
    printf "mkversion.sh [PRODUCT_TYPE|6340|6620...]  [PATH]  [release|debug"
    printf " default-release]\n"
}

if [ $# -le 0 ];then
    printHelp
    exit -1
fi

ISDEBUG=release
BPATH=.
MKMOD=*


echo "$BPATH $1 $ISDEBUG $MKMOD"

case "$2" in
    mkdvr | mkapp | mkmod | mkbuild | mkver | mkall) 
        echo "Build path is ."
        MKMOD=$2
        BPATH=.;;
    release | debug | clean)
        MKMOD=*
        ISDEBUG=$2
        BPATH=.;;
    *)  BPATH=$2
        if [ -z $2 ]; then
            BPATH=.
        fi
        ;;
esac

case "$3" in          
    mkdvr | mkapp | mkmod | mkbuild | mkver | mkall) 
        echo "Build path is ."
        MKMOD=$3
        ISDEBUG=$4;;
    release | debug | clean)
        ISDEBUG=$3;;
       # MKMOD=*;;
    *) ;;
esac

export DEV_PATH=$BPATH
export ROOT_PATH=$(pwd)
export APP_PATH=$ROOT_PATH/$DEV_PATH/app/Make/$PRODUCT_TYPE/
export LIBDVR_PATH=$ROOT_PATH/$DEV_PATH/libdvr/Make/$PRODUCT_TYPE/
export MODULE_PATH=$ROOT_PATH/$DEV_PATH/modules/
export BUILD_PATH=$ROOT_PATH/$DEV_PATH/build/Make/$PRODUCT_TYPE/
export BUILD_VERSION_PATH=$ROOT_PATH/$DEV_PATH/build_version/XvrBuildVersion/make/$PRODUCT_TYPE/

export PATH_LOCALAPP=$ROOT_PATH/$DEV_PATH/build/AppLib/$PRODUCT_TYPE/
export PATH_LOCALDVR=$ROOT_PATH/$DEV_PATH/build/LibDvrLib/$PRODUCT_TYPE/
export PATH_LOCALBIN=$ROOT_PATH/$DEV_PATH/build/LibDvrBin/$PRODUCT_TYPE/
export PATH_LOCALMOD=$ROOT_PATH/$DEV_PATH/build/ModulesLib/
export PATH_GIVEOTHER=/netdisk/公共/01\ 嵌入式软件/版本发布/temp/IPC/songsong.bai/$1

# function
function mkdvr()
{
    if [[ $3 = debug ]];then
        make debug -C $LIBDVR_PATH -j5
    elif [[ $3 = clean ]];then
        make clean -C $LIBDVR_PATH -j5
    else
        make -C $LIBDVR_PATH
        if [ $? -ne 0 ];then
            echo "makedvr fail!!!!!!!!!!!!!!!!"
            exit -1
        else
            echo "makedvr OK!!!!!!!!!!!!!!!!!!!"
        fi
    fi
}


function mkapp()
{
    if [[ $3 = debug ]];then
        make debug -C $APP_PATH
    elif [[ $3 = clean ]];then
        make clean -C $APP_PATH -j5
    else
        make -C $APP_PATH
        if [ $? -ne 0 ];then
            echo "makeapp fail!!!!!!!!!!!!!!!!"
            exit -1
        else
            echo "makeapp OK!!!!!!!!!!!!!!!!!!!"
        fi
    fi
}

function mkmod()
{
    LIBTYPE=`cat $1/libdvr/config.make | \
        awk  '{ if($1 ~ /^LIBTYPE$/) {print $3}}' | \
        tr -d " "`
    
    echo $LIBTYPE
    
    ARMTYPE=v7
    
    if [ $LIBTYPE = 3516A ];then
        ARMTYPE=v7
    elif [ $LIBTYPE = 3516C ];then
        ARMTYPE=v5
    elif [ $LIBTYPE = 3516CV200 ];then
        ARMTYPE=v5v300
    else
        printf "have not this armtype!"
    fi
    
    echo $ARMTYPE
    
    if [[ $3 = debug ]];then
        make arm$ARMTYPE"debug" -C $MODULE_PATH
    elif [[ $3 = clean ]];then
        make clean -C $MODULE_PATH -j5
    else
        make arm$ARMTYPE -C $MODULE_PATH
        if [ $? -ne 0 ];then
            echo "makemod fail!!!!!!!!!!!!!!!!"
            exit -1
        else
            echo "makemod OK!!!!!!!!!!!!!!!!!!!"
        fi
    fi
}



function mkbuild()
{
    if [[ $3 = debug ]];then
        make debug -C $BUILD_PATH
    elif [[ $3 = clean ]];then
        make clean -C $BUILD_PATH -j5
    else
        make -C $BUILD_PATH
        if [ $? -ne 0 ];then
            echo "makemod fail!!!!!!!!!!!!!!!!"
            exit -1
        else
            echo "makemod OK!!!!!!!!!!!!!!!!!!!"
        fi
    fi
}

function mkver()
{
if [[ $3 = debug ]];then
    make debug -C $BUILD_VERSION_PATH
elif [[ $3 = clean ]];then
    make clean -C $BUILD_VERSION_PATH
else
    make -C $BUILD_VERSION_PATH
fi

mkdir -p ${VER_CP_PATH}${PRODUCT_TYPE}
cp /tftpboot/${PACKSHOP_PRODUCT_NAME} -R ${VER_CP_PATH}${PRODUCT_TYPE}
}



# run


echo "$BPATH $1 $ISDEBUG $MKMOD"

case "$MKMOD" in
    mkdvr) 
        mkdvr $BPATH $1 $ISDEBUG
        echo "$PATH_GIVEOTHER/LIBDVR/"
        mkdir -p "$PATH_GIVEOTHER/LIBDVR/"
        cp -R $PATH_LOCALDVR "$PATH_GIVEOTHER/LIBDVR/"
        cp -R $PATH_LOCALBIN "$PATH_GIVEOTHER/LIBBIN/"
        ;;
    mkapp)
        mkapp $BPATH $1 $ISDEBUG
        echo "$PATH_GIVEOTHER/APP/"
        mkdir -p "$PATH_GIVEOTHER/AppLib/"
        cp -R $PATH_LOCALAPP "$PATH_GIVEOTHER/AppLib/"
        ;;
    mkmod) 
        mkdvr $BPATH $1 $ISDEBUG && mkmod $1 $ISDEBUG
        echo "$PATH_GIVEOTHER/ModulesLib"
        mkdir -p "$PATH_GIVEOTHER/ModulesLib"
        cp -R $PATH_LOCALMOD "$PATH_GIVEOTHER/ModulesLib"
        ;;
    mkbuild) mkbuild $BPATH $1 $ISDEBUG;;
    mkver) mkver $BPATH $1 $ISDEBUG;;
    mkall) echo "Start make all version!!!"
           # mkdvr $BPATH $1 $ISDEBUG
           # mkapp $BPATH $1 $ISDEBUG &
           # mkmod $BPATH $1 $ISDEBUG
           # wait
           # mkbuild $BPATH $1 $ISDEBUG;;
           mkdvr $BPATH $1 $ISDEBUG &&
           mkapp $BPATH $1 $ISDEBUG &&
           mkmod $BPATH $1 $ISDEBUG &&
           mkbuild $BPATH $1 $ISDEBUG;;
    *)     echo "Start make all and build version!!"
           mkdvr $BPATH $1 $ISDEBUG &&
           mkapp $BPATH $1 $ISDEBUG &&
           mkmod $BPATH $1 $ISDEBUG &&
           mkbuild $BPATH $1 $ISDEBUG &&
           mkver $BPATH $1 $ISDEBUG;;
esac


echo "version build OK!!"

