#!/bin/bash
set -e
pushd $(dirname $0)
APP_DIR=$PWD
popd

rm ./output -rf

nodeSdk=('2.0.0' '2.0.6' '2.0.8' '2.2.6')
#nodeSdk=('2.0.6')

for version in ${nodeSdk[@]}
do
	cd ${version}/
	if [ ! -d "node_modules" ]; then
        echo "installing $PWD"
        tnpm init -y
        tnpm i 'cos-nodejs-sdk-v5@'${version} --save
	fi
	echo "testing $PWD"
	outputPath='../../output/nodejs-v'${version}'.xml'
#	mocha
	mocha --reporter XUnit --reporter-options output=${outputPath}
	cd ../
done
cd ../