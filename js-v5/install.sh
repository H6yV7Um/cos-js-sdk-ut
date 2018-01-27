#!/bin/bash

nodeSdk=('2.0.0' '2.0.6' '2.0.8' '2.2.6')
jsSdk=('0.3.7')

cd nodejs

for sdk in ${nodeSdk[@]}
do  
   if [ ! -d "${sdk}" ]; then
		mkdir ${sdk}
  		cd ${sdk}
		tnpm init -y
		tnpm i 'cos-nodejs-sdk-v5@'${sdk} --save || 1
		cd ../ 
	fi
done

cd ../js

for sdk in ${jsSdk[@]}
do  
   if [ ! -d "${sdk}" ]; then
		mkdir ${sdk}
  		cd ${sdk}
		tnpm init -y
		tnpm i 'cos-js-sdk-v5@'${sdk} --save || 1
		cd ../ 
	fi
done


