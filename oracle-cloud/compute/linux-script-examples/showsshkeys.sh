#!/bin/bash
# NAME:
#   showsshkeys.sh
#
# DESC:
#   Example script to show how you can get the public keys for a instance
#   that have been promoted. Those keys can for example be used to create 
#   a new OS account with trusted keys. This is in a way the same as is 
#   done by the default Oracle templates who do create an "opc" account 
#   with the trusted keys for login which have been selected during the 
#   creation of the new instance. This is tested with Oracle Linux on
#   the Oracle Cloud.
#
# LOG:
# VERSION---DATE--------NAME-------------COMMENT
# 0.1       20SEP2016   Johan Louwers    Initial upload to github.com
#
# LICENSE:
# Copyright (C) 2015  Johan Louwers
#
# This code is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This code is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this code; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
# *
# */

# ccVmApiBaseUrl is used to access the root of the OPC API
 ccVmApiBaseUrl="http://192.0.0.192/"

# ccVmApiVersion is the main version of the OPC API used by the lib
 ccVmApiVersion="1.0"

# ccVmApiMaxWait is the max time (in seconds) the function will wait for a response from the api.
 ccVmApiMaxWait="5"

# The function ccVmGetNumOfPublicKeys will return the number of public keys
 function ccVmGetNumOfPublicKeys {
    ccVmNumOfPublicKeys="$(curl -m $ccVmApiMaxWait -f -s $ccVmApiBaseUrl$ccVmApiVersion/meta-data/public-keys/)"
    curlStatus=$?

    if [ "$curlStatus" -eq 0 ]; then
      echo $ccVMNumOfPublicKeys | wc -l
    else
        echo "ERROR"
    fi
 }

# The function ccVmGetPublicKeyType will return the public key type
 function ccVmGetPublicKeyType {
    ccVmPublicKeyType="$(curl -m $ccVmApiMaxWait -f -s $ccVmApiBaseUrl$ccVmApiVersion/meta-data/public-keys/$1)"
    curlStatus=$?

    if [ "$curlStatus" -eq 0 ]; then
      echo $ccVmPublicKeyType
    else
        echo "ERROR"
    fi
 }

# The function ccVmGetPublicSshKey will return the public key
 function ccVmGetPublicSshKey {
    ccVmPublicSshKey="$(curl -m $ccVmApiMaxWait -f -s $ccVmApiBaseUrl$ccVmApiVersion/meta-data/public-keys/$1/openssh-key)"
    curlStatus=$?

    if [ "$curlStatus" -eq 0 ]; then
      echo $ccVmPublicSshKey
    else
        echo "ERROR"
    fi
 }

 function runMain {
    # Get the number of keys available from the API. For this we will use the ccVmGetNumOfPublicKeys
    # function. 

    mainNumberOfKeys="$(ccVmGetNumOfPublicKeys)"

    # Loop through the number of keys found, check the type of the key and if the key type is correct
    # we will use it to add to the account so it can be used as a trusted key. The key type we are
    # looking for in this case is the openssh-key type to be used.

    i="0"
    while [ $i -lt $mainNumberOfKeys ]
     do
       pubKey="$(ccVmGetPublicKeyType $i)"
       if [ $pubKey = "openssh-key" ]
        then
         ccVmGetPublicSshKey $i
       fi
      i=$[$i+1]
     done
 }

runMain
