#!/bin/bash

###########
#####
##       Dummypkg v0.1
#####
###########

## Script to install dummy packages in pacman

## Use at own risk!

function install(){
    if [ -d ~/.dummybuild-tmp/$PACKAGE ]; then
       rm -r ~/.dummybuild-tmp/$PACKAGE 
    fi
    
    mkdir -p ~/.dummybuild-tmp/$PACKAGE
    echo "pkgname=$PACKAGE" >> ~/.dummybuild-tmp/$PACKAGE/PKGBUILD
    echo "pkgver=$PKGVER" >> ~/.dummybuild-tmp/$PACKAGE/PKGBUILD
    echo "pkgrel=1" >> ~/.dummybuild-tmp/$PACKAGE/PKGBUILD
    echo "pkgdesc=\"Dummy package created by dummypkg\"" >> ~/.dummybuild-tmp/$PACKAGE/PKGBUILD
    echo "arch=('i686' 'x86_64')" >> ~/.dummybuild-tmp/$PACKAGE/PKGBUILD
    echo "url=""" >> ~/.dummybuild-tmp/$PACKAGE/PKGBUILD
    echo "license=\"GPL\"" >> ~/.dummybuild-tmp/$PACKAGE/PKGBUILD
    echo "depends=()" >> ~/.dummybuild-tmp/$PACKAGE/PKGBUILD
    echo "source=()" >> ~/.dummybuild-tmp/$PACKAGE/PKGBUILD
    echo "build(){" >> ~/.dummybuild-tmp/$PACKAGE/PKGBUILD
    echo "mkdir -p ~/.dummybuild-tmp/$PACKAGE/pkg/etc/dummy" >> ~/.dummybuild-tmp/$PACKAGE/PKGBUILD
    echo "echo >> \"Installed by dummypkg\" >> ~/.dummybuild-tmp/$PACKAGE/pkg/etc/dummy/$PACKAGE-$PKGVER" >> ~/.dummybuild-tmp/$PACKAGE/PKGBUILD
    echo "}" >> ~/.dummybuild-tmp/$PACKAGE/PKGBUILD
    
    cd ~/.dummybuild-tmp/$PACKAGE/
    makepkg || exit 1
    sudo pacman -U *pkg.tar.xz
    cd ~
    rm -r .dummybuild-tmp/
    exit 0
}

function remove(){
   if [ -e /etc/dummy/$RPACKAGE* ]; then
     sudo pacman -R $RPACKAGE
   else
     echo "This package is not installed by dummypkg ... Exiting"
     exit 1
   fi
   exit 0
}

function list(){
    for file in `ls /etc/dummy -1` 
    do
       
          echo ">>  $file"
       
    done
    exit 0
}

function usage(){
    echo "usage: info [[--install] [--list] [--help] [--remove] [--version]]"
    exit 0
}


INSTALL=0
REMOVE=0
LIST=0



if [ "$1" = "" ]; then
    usage ; exit 1
fi 
while [ "$1" != "" ]; do
    case $1 in
        -S | --install )    
            INSTALL=1 
            PACKAGE="$2"
            PKGVER="$3"
            if [ "$2" = "" ]; then
                echo "--install requires a package name"
                exit 1
            fi
            if [ "$3" = "" ]; then
                echo "--install requires a package version"
                exit 1
            fi
            shift
            shift
            ;;
        -R | --remove )    
                REMOVE=1 
                RPACKAGE="$2"
                if [ "$2" = "" ]; then
                    echo "--remove requires a package name"
                    exit 1
                fi
                shift 
                ;;
        -h | --help  )    usage; exit 0 ;;
        -l | --list   )    LIST=1 ;;
        * )               usage ; exit 1 
    esac
    shift
done



if [ $INSTALL = 1 ]; then
  install
fi
if [ $REMOVE = 1 ]; then
   remove
fi
if [ $LIST = 1 ]; then
   list
fi
