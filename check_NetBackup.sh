#!/bin/bash

#################################################################################################################
# Titulo:
#
# Descripcion:
#
# Detalle:
# COMANDO COLECTOR: /usr/openv/volmgr/bin/vmoprcmd | sed -n '/HOST STATUS/,/PENDING REQUESTS/p' | grep -v "Version\|=" | awk '$3 != "" {print $1 " " $3}'
#
# Autor: Martin Martos Simon - martinmartossimon@gmail.com
# MIT License
# 
# Copyright (c) 2021 Martin Martos Simon - martinmartossimon@gmail.com
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# #
#################################################################################################################

########################## DEBUG
#set -x

########################## PARAMETRIZACION
ESCALAMIENTO="Escalar con el equipo de NetBack para su revision"


########################## FUNCIONES



########################## MAIN
/usr/openv/volmgr/bin/vmoprcmd | sed -n '/HOST STATUS/,/PENDING REQUESTS/p' | grep -v "Version\|=" | awk '$3 != "" {print $1 " " $3}' | \
while read linea; do
	MEDIA_SERVER=$(echo "$linea" | awk '{print $1}')
	ESTADO=$(echo "$linea" | awk '{print $2}')
	if [[ "$ESTADO" == *"ACTIVE"* ]]; then
		echo "0 NetBackup_MediaServer_$MEDIA_SERVER - OK. El estado de este MediaServer es: $ESTADO - Fecha de chequeo: `date`"
	else
		echo "2 NetBackup_MediaServer_$MEDIA_SERVER - ERROR. El estado de este MediaServer es: $ESTADO (Distinto de *ACTIVE*) - Fecha de chequeo: `date`. $ESCALAMIENTO"
	fi
done

