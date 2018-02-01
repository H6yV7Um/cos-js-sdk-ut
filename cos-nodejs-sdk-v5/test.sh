#!/bin/bash

pwd
rm ./output -rf

nodeSdk=('2.0.0' '2.0.6' '2.0.8' '2.2.6')

for version in ${nodeSdk[@]}
do
	cd ${version}/
	if [ ! -d "node_modules" ]; then
        echo "installing $PWD"
        tnpm init -y
        tnpm i 'cos-nodejs-sdk-v5@'${version} --save
	fi
	echo "testing ${version}"
	outputPath='../output/nodejs-v'${version}'.xml'
	mocha --reporter XUnit --reporter-options output=${outputPath} && echo ""
	cd ../
done

cd ../