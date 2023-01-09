#!/bin/bash

# Usage:

NFS_DIR=${2:-/mnt/pspd-lds}
ALUNO=$1
HOME_DIR=$NFS_DIR/alunos/a$ALUNO

sudo adduser a$ALUNO --home $HOME_DIR -uid $ALUNO --ingroup alunos
if [ ! -d $HOME_DIR ]; then
	sudo cp /etc/skel/.* $HOME_DIR
	sudo chown -R $ALUNO $HOME_DIR
	sudo chmod 700 $HOME_DIR
fi
